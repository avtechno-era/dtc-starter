#!/bin/sh
cd apps/backend

echo "Running database migrations..."
pnpm medusa db:migrate

echo "Seeding database..."
cd ../../

pnpm backend:seed || echo "Seeding failed, continuing..."


echo "Starting Medusa server..."
pnpm start