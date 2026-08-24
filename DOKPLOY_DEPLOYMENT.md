# Dokploy Configuration Guide for DTC Starter

## Environment Variables

Create a `.env` file or set these in your Dokploy environment:

### Database Configuration
```
DB_NAME=medusa-store
DB_USER=postgres
DB_PASSWORD=your-secure-password-here
POSTGRES_PORT=5432
```

### Redis Configuration
```
REDIS_PORT=6379
```

### Application Ports
```
MEDUSA_PORT=9000
ADMIN_PORT=5173
STOREFRONT_PORT=8000
```

### Medusa Backend Configuration
```
NODE_ENV=production
STORE_CORS=https://yourdomain.com
ADMIN_CORS=https://yourdomain.com:5173,https://yourdomain.com:9000
AUTH_CORS=https://yourdomain.com:5173,https://yourdomain.com:9000
JWT_SECRET=your-unique-jwt-secret-key-min-32-chars
COOKIE_SECRET=your-unique-cookie-secret-key-min-32-chars
DEBUG=false
```

### Storefront Configuration
```
NEXT_PUBLIC_MEDUSA_PUBLISHABLE_KEY=your-publishable-key
NEXT_PUBLIC_MEDUSA_BACKEND_URL=https://yourdomain.com:9000
NEXT_PUBLIC_BASE_URL=https://yourdomain.com
NEXT_PUBLIC_DEFAULT_REGION=us
NEXT_PUBLIC_STRIPE_KEY=your-stripe-key-optional
MEDUSA_CLOUD_S3_HOSTNAME=optional-s3-hostname
MEDUSA_CLOUD_S3_PATHNAME=optional-s3-pathname
```

## Deployment Steps

1. **Set Environment Variables**: Configure all the above variables in your Dokploy dashboard

2. **Deploy Services**:
   - PostgreSQL will automatically initialize with the provided credentials
   - Redis will persist data with AOF (Append Only File)
   - Medusa will run migrations on startup
   - Storefront will build and start after Medusa is healthy

3. **Health Checks**: Each service includes health checks:
   - PostgreSQL: `pg_isready` every 10s
   - Redis: `redis-cli ping` every 10s
   - Medusa: HTTP GET `/health` every 30s
   - Storefront: HTTP GET on port 3000 every 30s

4. **Networking**: All services communicate via the `medusa_network` bridge network

## Important Notes

- **Persistent Storage**: PostgreSQL data is stored in the `postgres_data` volume
- **Node Modules Exclusion**: `node_modules` are excluded from bind mounts to prevent conflicts between host and container
- **Production Mode**: Set `NODE_ENV=production` in production deployments
- **SSL/TLS**: Configure reverse proxy (Nginx, Caddy, etc.) in Dokploy for HTTPS
- **Database Migrations**: Run automatically on Medusa startup. Monitor logs if issues occur.
- **Seeding**: Initial data seeding is attempted on startup but failures are non-blocking

## Troubleshooting

### Services won't start
- Check all required environment variables are set
- Verify database credentials are correct
- Review container logs in Dokploy dashboard

### Database connection errors
- Ensure `DATABASE_URL` environment variable is properly formatted
- Wait for PostgreSQL health check to pass (10-20 seconds)
- Verify DB credentials match `DB_USER` and `DB_PASSWORD`

### Storefront can't connect to backend
- Verify `NEXT_PUBLIC_MEDUSA_BACKEND_URL` points to correct Medusa service URL
- Check network connectivity between containers
- Review CORS settings on Medusa backend

### Memory/Resource issues
- Increase container resource limits in Dokploy
- Consider using separate database server for production
- Monitor Redis memory usage
