# TRUEFAM Contribution Tracker - Docker Configuration
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apk add --no-cache \
    git \
    bash \
    curl \
    python3 \
    make \
    g++

# Install global dependencies
RUN npm install -g @expo/cli eas-cli

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy source code
COPY . .

# Create non-root user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S truefam -u 1001

# Change ownership
RUN chown -R truefam:nodejs /app
USER truefam

# Expose port
EXPOSE 19000 19001 19002

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:19000 || exit 1

# Start command
CMD ["expo", "start", "--tunnel"]
