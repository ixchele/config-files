import requests
import os
import sys

# ==========================
# CONFIG / SECRETS
# ==========================
UID = os.getenv("FT_UID") or "u-s4t2ud-602be593fbc00add3623297653badd96edd6a8d98ff56c2d43e05f1fc32eea56"
SECRET = os.getenv("FT_SECRET") or "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"

if not UID or not SECRET:
	print("Missing API credentials (FT_UID / FT_SECRET)")
	sys.exit(1)

BASE_API = "https://api.intra.42.fr/"

# ==========================
# COLORS
# ==========================
class Colors:
	HEADER = '\033[95m'
	BLUE = '\033[94m'
	GREEN = '\033[92m'
	WARNING = '\033[93m'
	FAIL = '\033[91m'
	ENDC = '\033[0m'
	BOLD = '\033[1m'

# ==========================
# AUTH
# ==========================
def get_token():
	r = requests.post(
		f"{BASE_API}oauth/token",
		data={
			'grant_type': 'client_credentials',
			'client_id': UID,
			'client_secret': SECRET,
		}
	)
	return r.json().get("access_token")

token = get_token()
headers = {'Authorization': f'Bearer {token}'}

# ==========================
# CAMPUS
# ==========================
campuses = {
	"1": ("Khouribga", 16),
	"2": ("Benguerir", 21),
	"3": ("Tétouan", 55)
}

def select_campus():
	print(Colors.BOLD + Colors.GREEN + "Choose your campus:" + Colors.ENDC)
	for k, v in campuses.items():
		print(f"{k}: {v[0]}")
	choice = input("> ")
	if choice in campuses:
		return campuses[choice][1]
	print(Colors.WARNING + "Invalid choice")
	return select_campus()

# ==========================
# PROJECTS
# ==========================
def select_project():
	project_mapping = {
		"1": ["libft", "42cursus-libft"],
		"2": ["get_next_line", "42cursus-get_next_line"],
		"3": ["ft_printf", "42cursus-ft_printf"],
		"4": ["born2beroot", "born2beroot"],
		"5": ["so_long", "so_long"],
		"6": ["fdf", "42cursus-fdf"],
		"7": ["fract-ol", "42cursus-fract-ol"],
		"8": ["minitalk", "minitalk"],
		"9": ["pipex", "pipex"],
		"10": ["push_swap", "42cursus-push_swap"],
		"11": ["minishell", "42cursus-minishell"],
		"12": ["philosophers", "42cursus-philosophers"],
		"13": ["cub3d", "cub3d"],
		"14": ["miniRT", "miniRT"],
		"15": ["netpractice", "netpractice"],
		"16": ["CPP", "CPP"],
		"17": ["webserv", "webserv"],
		"18": ["ft_irc", "ft_irc"],
		"19": ["inception", "inception"],
		"20": ["ft_transcendence", "ft_transcendence"],
		"25": ["PYTHON", "PYTHON"]
	}

	print(Colors.BOLD + Colors.GREEN + "Choose your project:" + Colors.ENDC)
	for k, v in project_mapping.items():
		print(f"{k}: {v[0]}")
	choice = input("> ")
	if choice in project_mapping:
		return project_mapping[choice][1]
	print(Colors.WARNING + "Invalid choice")
	return select_project()

# ==========================
# MODULES (CPP / PYTHON)
# ==========================
def select_module(language):
	print(Colors.BOLD + Colors.GREEN + f"Choose your {language.lower()} module:" + Colors.ENDC)
	for i in range(10):
		print(f"{i}: {language.lower()}{i:02}")
	choice = input("> ")
	if choice.isdigit() and 0 <= int(choice) <= 9:
		return f"{language.lower()}-module-{int(choice):02}"
	print(Colors.WARNING + "Invalid choice")
	return select_module(language)

# ==========================
# YEAR
# ==========================
def get_year():
	print(Colors.BOLD + Colors.GREEN + "Choose the year:" + Colors.ENDC)
	years = {
		"0": "2019",
		"1": "2021",
		"2": "2022",
		"3": "2023",
		"4": "2024",
		"5": "2025"
	}
	for k, v in years.items():
		print(f"{k}: {v}")
	choice = input("> ")
	if choice in years:
		return years[choice]
	print(Colors.WARNING + "Invalid choice")
	return get_year()

# ==========================
# STATUS
# ==========================
def select_status():
	print(Colors.BOLD + Colors.GREEN + "Choose your status:" + Colors.ENDC)
	statuses = {
		"1": "waiting_for_correction",
		"2": "in_progress",
		"3": "finished"
	}
	for k, v in statuses.items():
		print(f"{k}: {v}")
	choice = input("> ")
	if choice in statuses:
		return statuses[choice]
	print(Colors.WARNING + "Invalid choice")
	return select_status()

# ==========================
# FILTER
# ==========================
def filter_by_year(data, year):
	return [
		e for e in data
		if e.get("user", {}).get("pool_year") == year
	]

# ==========================
# MAIN
# ==========================
os.system("clear")

campus_filter = select_campus()
os.system("clear")

project = select_project()
os.system("clear")

if project == "CPP":
	project = select_module("CPP")
elif project == "PYTHON":
	project = select_module("PYTHON")

os.system("clear")

year = get_year()
os.system("clear")

status = select_status()
os.system("clear")

endpoint = f"{BASE_API}v2/projects/{project}/projects_users"

params = {
	'filter[campus]': campus_filter,
	'filter[status]': status
}

r = requests.get(endpoint, headers=headers, params=params)

if r.status_code != 200:
	print(Colors.FAIL + f"API error {r.status_code}" + Colors.ENDC)
	sys.exit(1)

data = filter_by_year(r.json(), year)

print(
	Colors.GREEN +
	f"----- Peers {status} on {project} ({year}) -----\n" +
	Colors.ENDC
)

for e in data:
	login = e["user"]["login"]
	print(Colors.BLUE + f"- https://profile.intra.42.fr/users/{login}" + Colors.ENDC)

print(f"\nTotal: {len(data)}")
