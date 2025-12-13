FROM python:3.12-slim

# Empêche Python de buffer la sortie (meilleur affichage terminal)
ENV PYTHONUNBUFFERED=1

# Dossier de travail
WORKDIR /app

# Installer la seule dépendance nécessaire
RUN pip install --no-cache-dir requests

# Copier le script
COPY peers42.py .

# Lancer le script
CMD ["python", "peers42.py"]

