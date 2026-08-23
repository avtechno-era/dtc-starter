#!/bin/sh
cd apps/backend

echo "Running database migrations..."
#pnpm medusa db:migrate

echo "Seeding database..."
cd ../../
pnpm backend:seed || echo "Seeding failed, continuing..."

cd apps/backend

echo "Migrating bullshit"
pnpm medusa db:migrate

echo "Starting Medusa server..."
pnpm start