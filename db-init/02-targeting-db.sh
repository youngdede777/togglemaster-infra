#!/bin/bash
# Roda automaticamente no primeiro boot do container postgres-core.
# O container já cria o banco "flags_db" (POSTGRES_DB) e já roda
# 01-flags-init.sql contra ele. Aqui criamos o segundo banco,
# "targeting_db", e aplicamos o init.sql do targeting-service nele.
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "CREATE DATABASE targeting_db;"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "targeting_db" -f /docker-entrypoint-initdb.d/extra/targeting-init.sql
