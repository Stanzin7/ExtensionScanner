# ExtensionScanner Dockerfile
# Multi-stage build: Node.js for frontend, Python for backend

# Stage 1: Build React Frontend
FROM node:20-alpine AS frontend-builder

WORKDIR /app/frontend

RUN apk add --no-cache python3 make g++

COPY frontend/package*.json ./

ENV NODE_OPTIONS="--max-old-space-size=4096"
RUN npm ci

COPY frontend/ ./
RUN npm run build

# Stage 2: Python Backend with Frontend Static Files
FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    UV_SYSTEM_PYTHON=1

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

COPY pyproject.toml uv.lock README.md ./
COPY src/ ./src/

RUN uv sync --frozen --no-dev

ENV PATH="/app/.venv/bin:$PATH"

COPY --from=frontend-builder /app/frontend/dist ./static

RUN mkdir -p extensions_storage data

ENV EXTENSION_STORAGE_PATH=/app/extensions_storage \
    DATABASE_PATH=/app/data/extension-scanner.db \
    LLM_PROVIDER=openai \
    PORT=8007

EXPOSE 8007

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=5 \
    CMD curl -f http://localhost:${PORT:-8007}/health || exit 1

CMD ["sh", "-c", "uvicorn extension_shield.api.main:app --host 0.0.0.0 --port ${PORT:-8007}"]
