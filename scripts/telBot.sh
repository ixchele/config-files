#!/bin/bash

# --------------------------
# CONFIGURATION
# --------------------------
TOKEN="8556080023:AAHKKvFpqhaeDKx8F1FWMRNmaqqcjfbn4AA"
CHAT_ID="6738733709"
API_URL="https://api.telegram.org/bot$TOKEN"
OFFSET=0
FT_LOCK_NAME="ft_lock"

last_update=$(curl -s "$API_URL/getUpdates" | jq 'if .result|length>0 then .result[-1].update_id + 1 else 0 end')
curl -s "$API_URL/getUpdates?offset=$last_update" >/dev/null
OFFSET=$last_update

# --------------------------
# FONCTIONS
# --------------------------
send_message() {
    curl -s -X POST "$API_URL/sendMessage" \
        -d chat_id="$CHAT_ID" \
        --data-urlencode "text=$1" >/dev/null
}

is_ft_lock_running() {
    pgrep -x "$FT_LOCK_NAME" > /dev/null 2>&1
}

start_ft_lock() {
    if is_ft_lock_running; then
        return 1
    fi
    nohup "$FT_LOCK_NAME" >/dev/null 2>&1 &
    sleep 0.3
    is_ft_lock_running
}

stop_ft_lock() {
    if ! is_ft_lock_running; then
        return 2
    fi

    # Try SIGTERM
    pkill -TERM -x "$FT_LOCK_NAME" 2>/dev/null
    for i in {1..8}; do
        sleep 0.25
        if ! is_ft_lock_running; then
            return 0
        fi
    done

    # Force kill
    pkill -9 -x "$FT_LOCK_NAME" 2>/dev/null
    sleep 0.2
    is_ft_lock_running && return 1 || return 0
}

send_message "Bot started..."

while true; do
    updates=$(curl -s "$API_URL/getUpdates?timeout=20&offset=$OFFSET")
    count=$(echo "$updates" | jq '.result | length')
    if [ "$count" -eq 0 ]; then
        sleep 1
        continue
    fi

    mapfile -t messages < <(echo "$updates" | jq -c '.result[]')

    for msg in "${messages[@]}"; do
        update_id=$(echo "$msg" | jq '.update_id')
        OFFSET=$((update_id + 1))

        chat_id_msg=$(echo "$msg" | jq -r '.message.chat.id')
        text=$(echo "$msg" | jq -r '.message.text')

        # Vérification sécurité
        if [ "$chat_id_msg" != "$CHAT_ID" ]; then
            send_message "Accès refusé ❌"
            continue
        fi

        # --------------------------
        # COMMANDES
        # --------------------------
        handled=false

        case "$text" in
            "/start")
                send_message "run shell commands or commandes ft_lock: /lock /unlock /status"
                handled=true
                ;;
            "/lock")
                if start_ft_lock; then
                    send_message "🔒 ft_lock démarré"
                else
                    send_message "ℹ️ ft_lock est déjà en cours"
                fi
                handled=true
                ;;
            "/unlock")
                stop_ft_lock
                code=$?
                if [[ $code -eq 0 ]]; then
                    send_message "🔓 ft_lock stop"
                elif [[ $code -eq 2 ]]; then
                    send_message "ℹ️ no ft_lock run"
                else
                    send_message "cant stop ft_lock"
                fi
                handled=true
                ;;
            "/status")
                if is_ft_lock_running; then
                    send_message "🟢 ft_lock in run"
                else
                    send_message "🔴 ft_lock stoped"
                fi
                handled=true
                ;;
        esac

        if [ "$handled" = false ]; then
            output=$(bash -c "$text" 2>&1)
            send_message ">> $output"
        fi

    done
done
