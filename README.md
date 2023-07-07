

# OWASP Demo CFML Application

A simple demo application used to show using Flyway for DB development.

### Database Setup

It is using Flyway for database migrations and currently works with MS SQL server. Here is an example of running a SQL server with Docker.

```
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=YourS3cureP@ss0rdH3re" -p 1433:1433 --name mssql -d mcr.microsoft.com/mssql/server:2019-latest
```

Then you can connect and create the database like this.

```
docker exec -it mssql bash

mssql@d653475c96de:/$ /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P YourS3cureP@ss0rdH3re
1> create database RecipeBox;
2> GO
```

## Getting Started with Flyway

1. [Download](https://flywaydb.org/download) the Flyway CLI and install it
2. Copy the `flyway.conf.example` file to `flyway.conf` and add your connection info

### Run the migration scripts

```
flyway migrate
```

### Drop all objects and rerun the migrations

```
flyway clean migrate
```