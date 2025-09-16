# pgctl - PostgreSQL Multi-Version Manager

🚀 **pgctl** je nástroj pro správu více verzí PostgreSQL na jednom systému pomocí Docker kontejnerů. Umožňuje snadné přepínání mezi různými verzemi PostgreSQL pro vývoj, testování a produkci.

## ✨ Funkce

- 🔄 **Správa více verzí** - PostgreSQL 9.5, 9.6, 12, 15, 16
- 🐳 **Docker kontejnery** - Izolované prostředí pro každou verzi
- 🔀 **Snadné přepínání** - `pgctl use <verze>` pro změnu aktivní verze
- 📊 **Status monitoring** - Přehled běžících kontejnerů
- 💾 **Persistentní data** - Data a konfigurace uloženy na host systému
- 🔐 **.pgpass integrace** - Centralizovaná správa hesel
- 🌐 **Různé porty** - Každá verze na vlastním portu

## 📋 Podporované verze

| Verze | Port | Popis |
|-------|------|--------|
| 9.5   | 5432 | Legacy verze s Windows daty |
| 9.6   | 5433 | Stabilní verze |
| 12    | 5434 | LTS verze |
| 15    | 5435 | Moderní verze |
| 16    | 5437 | Nejnovější verze |

## 🚀 Instalace

1. **Klonování repozitáře:**
   ```bash
   cd ~/pg_servers
   git clone <repo-url>
   ```

2. **Symbolický odkaz na pgctl:**
   ```bash
   ln -s ~/pg_servers/scripts-ai/pgctl ~/scripts-ai/pgctl
   ```

3. **Nastavení práv:**
   ```bash
   chmod +x ~/scripts-ai/pgctl
   ```

## 🎮 Použití

### Základní příkazy

```bash
# Zobrazení nápovědy
pgctl help

# Seznam dostupných verzí
pgctl list

# Spuštění konkrétní verze
pgctl start 9.6
pgctl start 12
pgctl start 15

# Zastavení verze
pgctl stop 9.6

# Restart verze
pgctl restart 12

# Nastavení aktivní verze
pgctl use 15

# Zobrazení stavu všech kontejnerů
pgctl status

# Zobrazení aktuální verze
pgctl current

# Zobrazení logů
pgctl logs 16
```

### Přepínání mezi verzemi

```bash
# Přepnutí na PostgreSQL 12
pgctl use 12

# Přepnutí na PostgreSQL 16
pgctl use 16

# Ověření aktivní verze
pgctl current
```

## 📁 Struktura projektu

```
~/pg_servers/
├── README.md                 # Tento soubor
├── .current_version          # Aktuálně aktivní verze
├── .env                      # Environment proměnné
├── .pgpass                   # Hesla pro všechny verze
├── docker/                   # Docker konfigurace
│   ├── docker-compose.yml    # Hlavní konfigurace
│   └── Dockerfile.*          # Custom Docker images
├── versions/                 # Data pro každou verzi
│   ├── 9.5/
│   │   ├── data/            # Databázová data
│   │   ├── config/          # Konfigurační soubory
│   │   └── logs/            # Log soubory
│   ├── 9.6/
│   ├── 12/
│   ├── 15/
│   └── 16/
├── scripts/                  # Skripty a utility
└── backups/                  # Zálohy
```

## 🔧 Konfigurace

### Environment proměnné

Soubor `~/.pg_servers/.env` obsahuje:
```bash
# Hesla pro jednotlivé verze
POSTGRES_PASSWORD_95=your_password_95
POSTGRES_PASSWORD_96=your_password_96
POSTGRES_PASSWORD_12=your_password_12
POSTGRES_PASSWORD_15=your_password_15
POSTGRES_PASSWORD_16=your_password_16
```

### .pgpass soubor

Pro automatické přihlašování:
```
localhost:5432:*:postgres:password_95
localhost:5433:*:postgres:password_96
localhost:5434:*:postgres:password_12
localhost:5435:*:postgres:password_15
localhost:5437:*:postgres:password_16
```

## 🐳 Docker konfigurace

Každá verze má svůj vlastní kontejner s:
- Vlastním portem
- Persistentním úložištěm dat
- Health checkem
- Automatickým restartem

### Vlastní porty

- **PostgreSQL 9.5**: `5432` (výchozí)
- **PostgreSQL 9.6**: `5433`
- **PostgreSQL 12**: `5434`
- **PostgreSQL 15**: `5435`
- **PostgreSQL 16**: `5437`

## 🌐 Připojení k databázím

### Pomocí psql

```bash
# Připojení k aktivní verzi
psql -h localhost -p $PGPORT -U postgres

# Připojení ke konkrétní verzi
psql -h localhost -p 5434 -U postgres  # PostgreSQL 12
psql -h localhost -p 5437 -U postgres  # PostgreSQL 16
```

### Pomocí pgctl

```bash
# Nastavení verze a připojení
pgctl use 12
psql -h localhost -U postgres
```

## 📊 Monitoring

### Status kontejnerů

```bash
pgctl status
```

Výstup:
```
📊 Status PostgreSQL kontejnerů:

  PostgreSQL 9.5 (port 5432): 🟢 Běží
  PostgreSQL 9.6 (port 5433): 🟢 Běží
  PostgreSQL 12  (port 5434): 🟢 Běží
  PostgreSQL 15  (port 5435): 🟢 Běží
  PostgreSQL 16  (port 5437): 🟢 Běží

🎯 Aktivní verze pro CLI: 12
```

### Logy

```bash
# Zobrazení logů pro verzi
pgctl logs 15

# Sledování logů v reálném čase
pgctl logs 16
```

## 🔧 Troubleshooting

### Běžné problémy

1. **Kontejner neběží:**
   ```bash
   pgctl status
   pgctl restart <verze>
   ```

2. **Problém s porty:**
   ```bash
   # Zkontroluj obsazené porty
   netstat -tlnp | grep 543
   ```

3. **Problém s připojením:**
   ```bash
   # Ověř .pgpass soubor
   cat ~/.pgpass

   # Ověř aktivní verzi
   pgctl current
   ```

### Čištění

```bash
# Zastavení všech kontejnerů
cd ~/pg_servers/docker
docker compose down

# Odstranění kontejnerů a volumes
docker compose down -v

# Zobrazení Docker images
docker images | grep postgres
```

## 🔄 Migration dat

### Z Windows

Pokud migrujete data z Windows PostgreSQL:

1. **Záloha dat na Windows:**
   ```bash
   pg_dump -h localhost -p 5432 -U postgres database_name > backup.sql
   ```

2. **Obnovení na Linux:**
   ```bash
   pgctl use 9.5
   createdb -h localhost -p 5432 -U postgres database_name
   psql -h localhost -p 5432 -U postgres database_name < backup.sql
   ```

## 🛠️ Vývoj a údržba

### Přidání nové verze

1. **Vytvoření adresářové struktury:**
   ```bash
   mkdir -p ~/pg_servers/versions/X.Y/{config,data,logs}
   ```

2. **Aktualizace docker-compose.yml**
3. **Aktualizace pgctl skriptu**
4. **Testování nové verze**

### Aktualizace pgctl

1. **Editace souboru:**
   ```bash
   nano ~/scripts-ai/pgctl
   ```

2. **Testování změn:**
   ```bash
   pgctl list
   pgctl status
   ```

## 📝 Požadavky

- **Docker** a **Docker Compose**
- **bash** shell
- **psql** klient
- Uživatel ve `docker` skupině

## 🤝 Contributing

1. Fork repozitáře
2. Vytvoř feature branch
3. Commit změny
4. Push na branch
5. Vytvoř Pull Request

## 📄 Licence

Tento projekt je dostupný pod MIT licencí.

## 🙏 Poděkování

Tento nástroj byl inspirován potřebou jednoduché správy více PostgreSQL verzí pro vývojové a testovací prostředí.

---

🚀 **Happy PostgreSQL managing!** 🐘