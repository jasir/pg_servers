# CHANGELOG - pgctl PostgreSQL Multi-Version Manager

Všechny změny v tomto projektu jsou zdokumentovány v tomto souboru.

Formát této dokumentace je založen na [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
a tento projekt se řídí [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2025-09-16

### Přidané
- **Kompletní sada PostgreSQL wrapperů** - Automatické wrappery pro všechny CLI nástroje:
  - `pg_restore` - pro obnovu backupů
  - `pg_dumpall` - pro backup všech databází
  - `createdb` / `dropdb` - správa databází
  - `createuser` / `dropuser` - správa uživatelů
  - `vacuumdb` - optimalizace databází
  - `pg_isready` - kontrola dostupnosti
  - `pg_config` - informace o konfiguraci
- **Generický wrapper systém** - Nová architektura pro snadné přidávání dalších nástrojů
- **Dynamická správa verzí** - Wrappery automaticky používají aktuálně nastavenou verzi
- **Automatické symlinkování** - Všechny wrappery jsou dostupné v systémovém PATH
- **Speciální případy podpory** - Optimalizované volání pro `pg_config` a `pg_isready`

### Změněné
- **Refaktorována create_wrappers funkce** - Přechod na generický systém pro všechny nástroje
- **Vylepšený pgctl use** - Nyní vytváří wrappery pro všechny nástroje najednou
- **Aktualizovaná dokumentace** - Rozšířeno README.md o nové wrappery a funkce

### Odstraněné
- **Systémový psql klient** - Odebrán konfliktní systémový PostgreSQL klient
- **Duplicitní kód** - Zjednodušena implementace wrapperů

### Opravené
- **Problém s přepínáním verzí** - Wrappery nyní spolehlivě používají aktuální verzi
- **Chyby v symlinkování** - Opraveny problémy s vytvářením symbolických odkazů

## [1.1.0] - 2025-09-15

### Přidané
- **Základní wrappery** - Implementovány wrappery pro `psql` a `pg_dump`
- **Dynamické verze** - Wrappery automaticky používají nastavenou verzi PostgreSQL
- **Automatická správa symlinků** - Vytváření symbolických odkazů v ~/scripts-ai/
- **Environment proměnné** - Automatické nastavení PGHOST, PGPORT, PGUSER při `pgctl use`

### Změněné
- **Vylepšený pgctl use** - Přidána podpora pro vytváření wrapperů

## [1.0.0] - 2025-09-14

### Přidané
- **Základní pgctl funkcionalita** - Správa PostgreSQL kontejnerů
- **Podpora verzí 9.5, 9.6, 12, 15, 16** - Kompletní pokrytí požadovaných verzí
- **Docker Compose konfigurace** - Izolované kontejnery pro každou verzi
- **Status monitoring** - Přehled běžících kontejnerů a aktivní verze
- **Port mapping** - Každá verze na vlastním portu (5432-5437)
- **Persistentní data** - Data a konfigurace uložena na host systému
- **.pgpass integrace** - Centralizovaná správa hesel
- **Základní CLI příkazy** - start, stop, restart, use, status, list, logs

---

## Formát changelogu

Příspěvky do changelogu se očekávají v následujícím formátu:

```
## [X.Y.Z] - RRRR-MM-DD

### Přidané
- Nová funkce
- Další nová funkce

### Změněné
- Změněná funkce
- Další změněná funkce

### Odstraněné
- Odstraněná funkce

### Opravené
- Oprava chyby
- Další oprava

### Bezpečnostní
- Bezpečnostní oprava
```

### Typy změn
- **Přidané** pro nové funkce
- **Změněné** pro změny stávajících funkcí
- **Odstraněné** pro odstraněné funkce
- **Opravené** pro bug opravy
- **Bezpečnostní** pro bezpečnostní opravy