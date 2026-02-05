# ExtensionScanner Setup Guide

Quick setup guide for ExtensionScanner. For core analysis engine documentation, see [ThreatXtension docs](https://github.com/barvhaim/ThreatXtension).

---

## Prerequisites

**Docker:**
- Docker Desktop or Docker Engine
- Docker Compose

**Local Development:**
- Python 3.11+
- Node.js 18+
- uv: `curl -LsSf https://astral.sh/uv/install.sh | sh`

---

## Docker Setup (Recommended)

```bash
git clone https://github.com/Stanzin7/ExtensionScanner.git
cd ExtensionScanner

cp env.production.template .env
# Edit .env and add your OPENAI_API_KEY

docker compose up --build
```

Access at: http://localhost:8007

---

## Local Development Setup

```bash
git clone https://github.com/Stanzin7/ExtensionScanner.git
cd ExtensionScanner

# Backend
make install
cp env.production.template .env
# Edit .env and add your OPENAI_API_KEY

# Frontend
cd frontend && npm install && cd ..

# Start (requires 2 terminals)
make api       # Terminal 1: http://localhost:8007
make frontend  # Terminal 2: http://localhost:5173
```

---

## Environment Variables

**Required:**
```bash
LLM_PROVIDER=openai
OPENAI_API_KEY=sk-your-key-here
```

**Optional:**
```bash
VIRUSTOTAL_API_KEY=your-vt-key
CORS_ORIGINS=https://yourdomain.com
```

**Alternative LLM Providers:**
```bash
# Ollama (Local)
LLM_PROVIDER=ollama
OLLAMA_BASE_URL=http://localhost:11434

# WatsonX (IBM)
LLM_PROVIDER=watsonx
WATSONX_API_KEY=your-key
WATSONX_API_ENDPOINT=https://us-south.ml.cloud.ibm.com
WATSONX_PROJECT_ID=your-project-id
```

---

## Usage

### Web Interface
Open http://localhost:8007 → Paste Chrome Web Store URL or upload .crx/.zip → Analyze

### CLI
```bash
# From URL
make analyze URL=https://chromewebstore.google.com/detail/extension-id/abcdef

# From file
make analyze-file FILE=/path/to/extension.crx

# Save to JSON
make analyze URL=<url> OUTPUT=results.json

# Direct command
uv run extension-scanner analyze --url <chrome_web_store_url>
uv run extension-scanner analyze --file /path/to/extension.crx
```

### API
- Swagger UI: http://localhost:8007/docs
- ReDoc: http://localhost:8007/redoc

**Endpoints:**
- `POST /api/scan/trigger` - Scan from URL
- `POST /api/scan/upload` - Upload and scan
- `GET /api/scan/status/{id}` - Check status
- `GET /api/scan/results/{id}` - Get results
- `GET /api/scan/report/{id}` - PDF report

### Claude Desktop (MCP)

Edit `~/Library/Application Support/Claude/claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "ExtensionScanner": {
      "command": "uv",
      "args": [
        "--directory",
        "/absolute/path/to/ExtensionScanner",
        "run",
        "python",
        "-m",
        "extension_shield.mcp_server.main"
      ]
    }
  }
}
```

Restart Claude Desktop. Ask: "Analyze this Chrome extension: https://chromewebstore.google.com/detail/..."

---

## Development Commands

```bash
make help           # Show all commands
make format         # Format code
make lint           # Run linter
make test           # Run tests
make precommit      # Run pre-commit hooks
make docker-build   # Build Docker image
make docker-down    # Stop containers
make docker-logs    # View logs
```

---

## Project Structure

```
ExtensionScanner/
├── src/extension_shield/    # Backend (Python)
│   ├── api/                  # FastAPI endpoints
│   ├── cli/                  # CLI commands
│   ├── core/analyzers/       # Security analyzers
│   ├── governance/           # Governance engine
│   ├── llm/                  # LLM integration
│   └── workflow/             # LangGraph workflows
├── frontend/                 # React UI
├── tests/                    # Test suite
├── docs/                     # Documentation
├── Dockerfile
├── docker-compose.yml
└── Makefile
```

---

## Troubleshooting

**uv not found:**
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.cargo/bin:$PATH"
```

**Port 8007 in use:**
```bash
lsof -ti:8007 | xargs kill -9
```

**API key issues:**
```bash
# Verify .env file exists with OPENAI_API_KEY
docker compose down && docker compose up --build
```

**Frontend errors:**
```bash
cd frontend && rm -rf node_modules && npm install
```

**Database reset:**
```bash
rm -f extension-scanner.db
```

---

## Documentation & References

- **ThreatXtension Docs**: https://github.com/barvhaim/ThreatXtension
- **Core Analysis Engine**: Based on ThreatXtension architecture
- **Custom Rulesets**: Enterprise governance extensions built on top of ThreatXtension
- **Project Spec**: [docs/PROJECT_SPEC.md](docs/PROJECT_SPEC.md)
- **Contributing**: [CONTRIBUTING.md](CONTRIBUTING.md)

---

## Support

📧 snorzang65@gmail.com  
💬 [GitHub Issues](https://github.com/Stanzin7/ExtensionScanner/issues)

---

**Happy extension auditing! 🛡️**
