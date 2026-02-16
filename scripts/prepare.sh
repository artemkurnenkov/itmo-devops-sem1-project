#!/bin/bash

set -e

PG_HOST="localhost"
PG_PORT=5432
DB_NAME="project-sem-1"
PG_USER="validator"
PG_PASSWORD="val1dat0r"
DEFAULT_PG_USER="postgres"
TABLE_NAME="prices"

export PG_HOST PG_PORT DB_NAME PG_USER PG_PASSWORD DEFAULT_PG_USER

if ! PGPASSWORD=$PG_PASSWORD psql -h "$PG_HOST" -p "$PG_PORT" -U "$PG_USER" -d "$DB_NAME" -c "\\q" &> /dev/null; then

    echo "DB project-sem-1 is not ready."

    echo "Creating a user and database for working with PostgreSQL"

    psql <<-EOSQL
    DO \$\$
    BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_user WHERE usename = '$PG_USER') THEN
        CREATE USER $PG_USER WITH PASSWORD '$PG_PASSWORD';
    END IF;
    END
    \$\$;

    DROP DATABASE IF EXISTS "$DB_NAME";
    CREATE DATABASE "$DB_NAME" OWNER $PG_USER;

    GRANT ALL PRIVILEGES ON DATABASE "$DB_NAME" TO $PG_USER;
EOSQL

else
    echo "DB project-sem-1 is ready."
fi

echo "Creating table - prices"

PGPASSWORD=$PG_PASSWORD psql -U $PG_USER -h $PG_HOST -p $PG_PORT -d "$DB_NAME" <<-EOSQL
CREATE TABLE IF NOT EXISTS $TABLE_NAME (
    id SERIAL PRIMARY KEY,
    product_id INT NOT NULL,
    created_at TIMESTAMP NOT NULL,
    name TEXT NOT NULL,
    category TEXT NOT NULL,
    price NUMERIC(10, 2) NOT NULL
);
EOSQL
