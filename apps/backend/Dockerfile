FROM node:20-alpine

WORKDIR /app

RUN npm install -g pnpm@10.11.1

# Workspace manifests
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml turbo.json .npmrc ./

# App manifests
COPY apps/backend/package.json ./apps/backend/package.json
COPY apps/storefront/package.json ./apps/storefront/package.json

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy source
COPY apps/backend ./apps/backend
COPY node_modules ./node_modules
COPY start.sh ./

RUN chmod +x start.sh

EXPOSE 9000 5173

ENTRYPOINT ["./start.sh"]