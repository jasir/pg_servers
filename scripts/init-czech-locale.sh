#!/bin/bash

# Init script pro ověření Czech locale v PostgreSQL kontejneru
echo "🇨🇿 Kontroluji dostupné locales..."

# Výpis dostupných locales
echo "📋 Dostupné locales v kontejneru:"
locale -a | head -10

# Test připojení k databázi
echo "🔍 Testování připojení k databázi..."
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    SELECT version();
    \l
EOSQL

echo "✅ PostgreSQL 16 inicializace dokončena!"