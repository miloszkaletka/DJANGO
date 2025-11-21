#!/usr/bin/env bash

# Wychodzi natychmiast, jeśli dowolne polecenie zwróci błąd
set -o errexit
 
# 1. Instalacja zależności
# Zapewnia, że wszystkie pakiety są gotowe
pip install -r requirements.txt
 
# 2. Wykonanie Migracji
# TO JEST KLUCZOWY KROK NAPRAWIAJĄCY BŁĄD 'no such table'
python manage.py migrate
 
# 3. Opcjonalnie: Zbieranie plików statycznych (dla produkcji)
# Jeśli używasz plików statycznych, Render tego potrzebuje
python manage.py collectstatic --no-input
 
# Koniec skryptu budowania