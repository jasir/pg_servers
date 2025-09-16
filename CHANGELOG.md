# CHANGELOG - pgctl PostgreSQL Multi-Version Manager

All changes to this project are documented in this file.

The format of this document is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2025-09-16

### Added
- **Complete PostgreSQL wrapper set** - Automatic wrappers for all CLI tools:
  - `pg_restore` - for backup restoration
  - `pg_dumpall` - for backing up all databases
  - `createdb` / `dropdb` - database management
  - `createuser` / `dropuser` - user management
  - `vacuumdb` - database optimization
  - `pg_isready` - availability checking
  - `pg_config` - configuration information
- **Generic wrapper system** - New architecture for easy addition of more tools
- **Dynamic version management** - Wrappers automatically use currently set version
- **Automatic symlinking** - All wrappers available in system PATH
- **Special case support** - Optimized calls for `pg_config` and `pg_isready`

### Changed
- **Refactored create_wrappers function** - Transitioned to generic system for all tools
- **Enhanced pgctl use** - Now creates wrappers for all tools at once
- **Updated documentation** - Expanded README.md with new wrappers and features

### Removed
- **System psql client** - Removed conflicting system PostgreSQL client
- **Duplicate code** - Simplified wrapper implementation

### Fixed
- **Version switching issues** - Wrappers now reliably use current version
- **Symlinking errors** - Fixed problems with symbolic link creation

## [1.1.0] - 2025-09-15

### Added
- **Basic wrappers** - Implemented wrappers for `psql` and `pg_dump`
- **Dynamic versions** - Wrappers automatically use set PostgreSQL version
- **Automatic symlink management** - Creating symbolic links in ~/scripts-ai/
- **Environment variables** - Automatic setting of PGHOST, PGPORT, PGUSER with `pgctl use`

### Changed
- **Enhanced pgctl use** - Added support for wrapper creation

## [1.0.0] - 2025-09-14

### Added
- **Basic pgctl functionality** - PostgreSQL container management
- **Version support 9.5, 9.6, 12, 15, 16** - Complete coverage of required versions
- **Docker Compose configuration** - Isolated containers for each version
- **Status monitoring** - Overview of running containers and active version
- **Port mapping** - Each version on its own port (5432-5437)
- **Persistent data** - Data and configuration stored on host system
- **.pgpass integration** - Centralized password management
- **Basic CLI commands** - start, stop, restart, use, status, list, logs

---

## Changelog Format

Contributions to changelog are expected in the following format:

```
## [X.Y.Z] - YYYY-MM-DD

### Added
- New feature
- Another new feature

### Changed
- Changed feature
- Another changed feature

### Removed
- Removed feature

### Fixed
- Bug fix
- Another fix

### Security
- Security fix
```

### Types of Changes
- **Added** for new features
- **Changed** for changes to existing features
- **Removed** for removed features
- **Fixed** for bug fixes
- **Security** for security fixes