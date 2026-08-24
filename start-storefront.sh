#!/bin/sh
cd apps/storefront

echo "Building Medusa Storefront"
pnpm build

echo "Starting Medusa Storefront server..."
pnpm start