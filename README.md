# pgctl - PostgreSQL Multi-Version Manager

🚀 **pgctl** is a tool for managing multiple PostgreSQL versions on a single system using Docker containers. It allows easy switching between different PostgreSQL versions for development, testing, and production.

## ✨ Features

- 🔄 **Multi-version management** - PostgreSQL 9.5, 9.6, 12, 15, 16
- 🐳 **Docker containers** - Isolated environments for each version
- 🔀 **Easy switching** - `pgctl use <version>` to change active version
- 📊 **Status monitoring** - Overview of running containers
- 💾 **Persistent data** - Data and configuration stored on host system
- 🔐 **.pgpass integration** - Centralized password management
- 🌐 **Different ports** - Each version on its own port
- 🔧 **PostgreSQL wrappers** - Automatic wrappers for all CLI tools
- 🚀 **Global availability** - All tools available in system PATH
- 📋 **Complete toolset** - psql, pg_dump, pg_restore, pg_dumpall, createdb, dropdb, createuser, dropuser, vacuumdb, pg_isready, pg_config

## 📋 Supported Versions

| Version | Port | Description |
|---------|------|-------------|
| 9.5     | 5432 | Legacy version with Windows data |
| 9.6     | 5433 | Stable version |
| 12      | 5434 | LTS version |
| 15      | 5435 | Modern version |
| 16      | 5437 | Latest version |

## 🚀 Installation

### Quick Setup (Recommended)

1. **Clone the repository:**
   ```bash
   cd ~/pg_servers
   git clone <repo-url>
   ```

2. **Run the setup script:**
   ```bash
   cd ~/pg_servers
   ./scripts/pgctl up
   ```

This script will:
- Check Docker installation
- Create directory structure
- Build custom PostgreSQL 9.5 image with Czech locale support
- Start all containers
- Create symlinks for all PostgreSQL tools

### Manual Setup

If you prefer manual setup:

1. **Clone the repository:**
   ```bash
   cd ~/pg_servers
   git clone <repo-url>
   ```

2. **Create symbolic link for pgctl:**
   ```bash
   ln -s ~/pg_servers/scripts/pgctl ~/scripts-ai/pgctl
   ```

3. **Set permissions:**
   ```bash
   chmod +x ~/pg_servers/scripts/pgctl
   ```

## 🎮 Usage

### Basic Commands

```bash
# Show help
pgctl help

# Quick setup (first time only)
pgctl up

# List available versions
pgctl list

# Start specific version
pgctl start 9.6
pgctl start 12
pgctl start 15

# Stop version
pgctl stop 9.6

# Restart version
pgctl restart 12

# Set active version
pgctl use 15

# Show status of all containers
pgctl status

# Show current version
pgctl current

# Show logs
pgctl logs 16
```

### PostgreSQL Wrappers

After running `pgctl use <version>`, wrappers are automatically created for all PostgreSQL tools:

```bash
# Basic tools (work with active version)
psql --version                    # Show active PostgreSQL version
pg_dump -h localhost -U postgres  # Database backup
pg_restore -h localhost -U postgres # Restore backup
pg_dumpall -h localhost -U postgres # Backup all databases

# Database management
createdb test_db                  # Create database
dropdb test_db                    # Delete database
createuser new_user               # Create user
dropuser old_user                 # Delete user
vacuumdb -d test_db -v            # Database optimization

# Monitoring tools
pg_isready                        # Check availability
pg_config --version               # Configuration information

# All wrappers automatically use:
# - Correct port based on active version
# - Correct container (pg95, pg96, pg12, pg15, pg16)
# - Standard credentials (postgres)
```

### Switching Between Versions

```bash
# Switch to PostgreSQL 12
pgctl use 12

# Switch to PostgreSQL 16
pgctl use 16

# Verify active version
pgctl current
```

## 📁 Project Structure

```
~/pg_servers/
├── README.md                 # This file
├── .current_version          # Currently active version
├── .env                      # Environment variables
├── .pgpass                   # Passwords for all versions
├── docker/                   # Docker configuration
│   ├── docker-compose.yml    # Main configuration
│   └── Dockerfile.*          # Custom Docker images
├── versions/                 # Data for each version
│   ├── 9.5/
│   │   ├── data/            # Database data
│   │   ├── config/          # Configuration files
│   │   └── logs/            # Log files
│   ├── 9.6/
│   ├── 12/
│   ├── 15/
│   └── 16/
├── scripts/                  # Control scripts
│   ├── pgctl               # Main control script
│   └── pgctl_up            # Setup script (build + start)
├── wrappers/                # PostgreSQL tool wrappers
│   ├── psql-wrapper        # psql wrapper
│   ├── pg_dump-wrapper     # pg_dump wrapper
│   ├── pg_restore-wrapper  # pg_restore wrapper
│   ├── pg_dumpall-wrapper  # pg_dumpall wrapper
│   ├── createdb-wrapper    # createdb wrapper
│   ├── dropdb-wrapper      # dropdb wrapper
│   ├── createuser-wrapper  # createuser wrapper
│   ├── dropuser-wrapper    # dropuser wrapper
│   ├── vacuumdb-wrapper    # vacuumdb wrapper
│   ├── pg_isready-wrapper  # pg_isready wrapper
│   └── pg_config-wrapper  # pg_config wrapper
└── backups/                  # Backups

### 📁 Symlinks in PATH

```
~/scripts-ai/                      # Directory in PATH
├── pgctl -> ~/pg_servers/scripts/pgctl
├── psql -> ~/pg_servers/wrappers/psql-wrapper
├── pg_dump -> ~/pg_servers/wrappers/pg_dump-wrapper
├── pg_restore -> ~/pg_servers/wrappers/pg_restore-wrapper
├── pg_dumpall -> ~/pg_servers/wrappers/pg_dumpall-wrapper
├── createdb -> ~/pg_servers/wrappers/createdb-wrapper
├── dropdb -> ~/pg_servers/wrappers/dropdb-wrapper
├── createuser -> ~/pg_servers/wrappers/createuser-wrapper
├── dropuser -> ~/pg_servers/wrappers/dropuser-wrapper
├── vacuumdb -> ~/pg_servers/wrappers/vacuumdb-wrapper
├── pg_isready -> ~/pg_servers/wrappers/pg_isready-wrapper
└── pg_config -> ~/pg_servers/wrappers/pg_config-wrapper
```

## 🔧 Configuration

### Environment Variables

The `~/.pg_servers/.env` file contains:
```bash
# Passwords for individual versions
POSTGRES_PASSWORD_95=your_password_95
POSTGRES_PASSWORD_96=your_password_96
POSTGRES_PASSWORD_12=your_password_12
POSTGRES_PASSWORD_15=your_password_15
POSTGRES_PASSWORD_16=your_password_16
```

### .pgpass File

For automatic login:
```
localhost:5432:*:postgres:password_95
localhost:5433:*:postgres:password_96
localhost:5434:*:postgres:password_12
localhost:5435:*:postgres:password_15
localhost:5437:*:postgres:password_16
```

## 🐳 Docker Configuration

Each version has its own container with:
- Own port
- Persistent data storage
- Health check
- Automatic restart

### Custom Ports

- **PostgreSQL 9.5**: `5432` (default)
- **PostgreSQL 9.6**: `5433`
- **PostgreSQL 12**: `5434`
- **PostgreSQL 15**: `5435`
- **PostgreSQL 16**: `5437`

## 🌐 Database Connections

### Using PostgreSQL Wrappers (Recommended)

```bash
# Set version and automatic wrappers
pgctl use 12

# Connect to active version using wrapper
psql -U postgres                    # Automatically uses port 5434

# Connect with different user/database
psql -U myuser -d mydb

# All wrappers work the same:
pg_dump -U postgres > backup.sql
pg_restore -U postgres -d mydb backup.sql
createdb -U postgres my_database
```

### Direct Connection (Manual Port Specification)

```bash
# Connect to specific version
psql -h localhost -p 5434 -U postgres  # PostgreSQL 12
psql -h localhost -p 5437 -U postgres  # PostgreSQL 16
```

### Using pgctl

```bash
# Set version and connect
pgctl use 12
psql -h localhost -U postgres        # Port is set automatically
```

## 📊 Monitoring

### Container Status

```bash
pgctl status
```

Output:
```
📊 PostgreSQL Container Status:

  PostgreSQL 9.5 (port 5432): 🟢 Running
  PostgreSQL 9.6 (port 5433): 🟢 Running
  PostgreSQL 12  (port 5434): 🟢 Running
  PostgreSQL 15  (port 5435): 🟢 Running
  PostgreSQL 16  (port 5437): 🟢 Running

🎯 Active CLI version: 12
```

### Logs

```bash
# Show logs for version
pgctl logs 15

# Follow logs in real time
pgctl logs 16
```

## 🔧 Troubleshooting

### Common Issues

1. **Container not running:**
   ```bash
   pgctl status
   pgctl restart <version>
   ```

2. **Port issues:**
   ```bash
   # Check occupied ports
   netstat -tlnp | grep 543
   ```

3. **Connection problems:**
   ```bash
   # Check .pgpass file
   cat ~/.pgpass

   # Check active version
   pgctl current
   ```

### Cleanup

```bash
# Stop all containers
cd ~/pg_servers/docker
docker compose down

# Remove containers and volumes
docker compose down -v

# Show Docker images
docker images | grep postgres
```

## 🔄 Data Migration

### From Windows

If migrating data from Windows PostgreSQL:

1. **Backup data on Windows:**
   ```bash
   pg_dump -h localhost -p 5432 -U postgres database_name > backup.sql
   ```

2. **Restore on Linux:**
   ```bash
   pgctl use 9.5
   createdb -h localhost -p 5432 -U postgres database_name
   psql -h localhost -p 5432 -U postgres database_name < backup.sql
   ```

## 🛠️ Development and Maintenance

### Adding New Version

1. **Create directory structure:**
   ```bash
   mkdir -p ~/pg_servers/versions/X.Y/{config,data,logs}
   ```

2. **Update docker-compose.yml**
3. **Update pgctl script**
4. **Test new version**

### Updating pgctl

1. **Edit file:**
   ```bash
   nano ~/scripts-ai/pgctl
   ```

2. **Test changes:**
   ```bash
   pgctl list
   pgctl status
   ```

## 📝 Requirements

- **Docker** and **Docker Compose**
- **bash** shell
- **PATH** containing `~/scripts-ai/`
- User in `docker` group
- System **psql** client should not be installed (wrappers are used)

## 🚀 Quick Start

For first-time setup, simply run:

```bash
cd ~/pg_servers
./scripts/pgctl_up
```

This will:
- Check Docker installation
- Create all necessary directories
- Build custom PostgreSQL 9.5 image with Czech locale support
- Start all PostgreSQL containers
- Create symlinks for all PostgreSQL tools
- Set up environment files

After setup, use `pgctl use <version>` to set your active PostgreSQL version.

## 🤝 Contributing

1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Create Pull Request

## 📄 License

This project is available under the MIT license.

## 🙏 Acknowledgments

This tool was inspired by the need for simple management of multiple PostgreSQL versions for development and testing environments.

---

🚀 **Happy PostgreSQL managing!** 🐘