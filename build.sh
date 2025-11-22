#!/usr/bin/env bash

# Wychodzi natychmiast, jeśli dowolne polecenie zwróci błąd
set -o errexit
 
# 1. Instalacja zależności
# Zapewnia, że wszystkie pakiety są gotowe
pip install -r requirements.txt
 
# 3. Opcjonalnie: Zbieranie plików statycznych (dla produkcji)
# Jeśli używasz plików statycznych, Render tego potrzebuje
python manage.py collectstatic --no-input
 
# Koniec skryptu budowania

# 2. Wykonanie Migracji
# TO JEST KLUCZOWY KROK NAPRAWIAJĄCY BŁĄD 'no such table'
python manage.py migrate
 
# 1. Zdefiniuj zmienne środowiskowe
export DJANGO_SUPERUSER_USERNAME="admin"
export DJANGO_SUPERUSER_EMAIL="admin@example.com"
export DJANGO_SUPERUSER_PASSWORD="admin1"
 
# 2. Uruchom polecenie Basha
python manage.py shell -c "
from django.contrib.auth import get_user_model
import os
 
User = get_user_model()
username = os.environ.get('DJANGO_SUPERUSER_USERNAME')
email = os.environ.get('DJANGO_SUPERUSER_EMAIL')
password = os.environ.get('DJANGO_SUPERUSER_PASSWORD')
 
if not User.objects.filter(username=username).exists():
    user = User.objects.create_superuser(username=username, email=email)
    user.set_password(password)
    user.save()
    print('Superużytkownik utworzony pomyślnie.')
else:
    print(f'Superużytkownik {username} już istnieje. Pomijanie.')
"

