# PostgreSQL Servers

Správa více verzí PostgreSQL pomocí Docker kontejnerů.

## Instalace

```bash
git clone <repository>
cd pg_servers
./scripts/pgctl up
```

## Použití

### Základní příkazy

```bash
# Spustit PostgreSQL verzi
pgctl start 15

# Zastavit PostgreSQL verzi
pgctl stop 15

# Restartovat PostgreSQL verzi
pgctl restart 15

# Zobrazit status všech kontejnerů
pgctl status

# Seznam dostupných verzí
pgctl list

# Zobrazit logy kontejneru
pgctl logs 15

# První spuštění (build + start)
pgctl up
```

### Dostupné verze

- **PostgreSQL 9.5** - port 5432
- **PostgreSQL 9.6** - port 5433
- **PostgreSQL 12** - port 5434
- **PostgreSQL 15** - port 5435
- **PostgreSQL 16** - port 5437

### Připojení k databázi

```bash
# Připojení k PostgreSQL 15
psql -h localhost -p 5435 -U postgres

# Připojení k PostgreSQL 12
psql -h localhost -p 5434 -U postgres
```

## Struktura projektu

```
pg_servers/
├── docker/
│   ├── docker-compose.yml     # Docker Compose konfigurace
│   └── postgres/              # Dockerfiles pro různé verze
├── scripts/
│   ├── pgctl                  # Hlavní nástroj pro správu
│   └── pgctl_up              # Script pro první spuštění
└── README.md                  # Tato dokumentace
```

## Vývojářské poznámky

Všechny kontejnery používají:
- Uživatel: `postgres`
- Heslo: `postgres`
- Databáze: `postgres`

Kontejnery jsou persistentní a data se uchovávají v Docker volumes.