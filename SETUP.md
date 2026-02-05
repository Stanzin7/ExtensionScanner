# ExtensionAudit Setup Guide

This guide will help you get ExtensionAudit running locally or via Docker.

---

## Prerequisites

### For Docker (Recommended)
- Docker Desktop or Docker Engine
- Docker Compose

### For Local Development
- **Python 3.11+** (Python 3.11.13 recommended)
- **Node.js 18+** (for React frontend)
- **uv** (Python package installer) - Install: `curl -LsSf https://astral.sh/uv/install.sh | sh`

---

## Installation Methods

### Option 1: Docker (Fastest)

**Step 1: Clone and Configure**
```bash
git clone <your-repo-url>
cd ExtensionAudit

# Copy and configure environment
cp env.production.template .env
```

**Step 2: Edit `.env` File**
```bash
# Required: Add your OpenAI API key
LLM_PROVIDER=openai
OPENAI_API_KEY=sk-your-key-here

# Optional: VirusTotal API key for threat intelligence
VIRUSTOTAL_API_KEY=your-vt-key-here
```

**Step 3: Build and Run**
```bash
docker compose up --build
```

**Step 4: Access the Application**
- Frontend: http://localhost:8007
- API Docs: http://localhost:8007/docs

**Managing Docker:**
```bash
# Stop the container
docker compose down

# View logs
docker compose logs -f

# Rebuild after code changes
docker compose up --build
```

---

### Option 2: Local Development

**Step 1: Install uv (Python Package Manager)**
```bash
# macOS/Linux
curl -LsSf https://astral.sh/uv/install.sh | sh

# Or via pip
pip install uv
```

**Step 2: Clone and Setup Backend**
```bash
git clone <your-repo-url>
cd ExtensionAudit

# Install Python dependencies
make install
# or manually: uv sync
```

**Step 3: Setup Frontend**
```bash
cd frontend
npm install
cd ..
```

**Step 4: Configure Environment**
```bash
# Copy template
cp env.production.template .env

# Edit .env and add your API keys
LLM_PROVIDER=openai
OPENAI_API_KEY=sk-your-key-here
VIRUSTOTAL_API_KEY=optional-vt-key
```

**Step 5: Start the Application (Two Terminals)**

Terminal 1 - Backend API:
```bash
make api
# Access at: http://localhost:8007
# API Docs: http://localhost:8007/docs
```

Terminal 2 - Frontend:
```bash
make frontend
# Access at: http://localhost:5173
```

---

## Environment Variables Reference

### Required Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `LLM_PROVIDER` | LLM provider (openai, watsonx, ollama, rits) | `openai` |
| `OPENAI_API_KEY` | OpenAI API key (if using OpenAI) | `sk-...` |

### Optional Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `VIRUSTOTAL_API_KEY` | VirusTotal API key for threat intel | None |
| `CORS_ORIGINS` | Allowed CORS origins (production) | `*` |
| `WATSONX_API_KEY` | IBM WatsonX API key | None |
| `WATSONX_API_ENDPOINT` | IBM WatsonX endpoint URL | None |
| `WATSONX_PROJECT_ID` | IBM WatsonX project ID | None |
| `OLLAMA_BASE_URL` | Ollama server URL | `http://localhost:11434` |

---

## Using the Application

### Web Interface

1. Open http://localhost:8007 (Docker) or http://localhost:5173 (local dev)
2. Choose analysis method:
   - **URL**: Paste a Chrome Web Store URL
   - **Upload**: Upload a `.crx` or `.zip` extension file
3. Click "Analyze Extension"
4. View results with:
   - Security score and risk assessment
   - Permissions analysis
   - SAST findings
   - Governance verdict (ALLOW/BLOCK/NEEDS_REVIEW)
   - AI-generated summary

### CLI Tool

**Analyze from Chrome Web Store:**
```bash
make analyze URL=https://chromewebstore.google.com/detail/extension-name/abcdefghijklmnop
```

**Analyze Local File:**
```bash
make analyze-file FILE=/path/to/extension.crx
```

**Save Results to JSON:**
```bash
make analyze URL=<url> OUTPUT=results.json
```

**Direct uv Commands:**
```bash
# From URL
uv run extension-shield analyze --url <chrome_web_store_url>

# From file
uv run extension-shield analyze --file /path/to/extension.crx

# With output file
uv run extension-shield analyze --url <url> --output results.json
```

### API Endpoints

Access the interactive API documentation at:
- **Swagger UI**: http://localhost:8007/docs
- **ReDoc**: http://localhost:8007/redoc

**Key Endpoints:**

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/scan/trigger` | POST | Trigger extension scan from URL |
| `/api/scan/upload` | POST | Upload and scan CRX/ZIP file |
| `/api/scan/status/{id}` | GET | Check scan status |
| `/api/scan/results/{id}` | GET | Get complete results |
| `/api/scan/report/{id}` | GET | Generate PDF report |

### Claude Desktop Integration (MCP)

**Step 1: Install Extension in Claude Desktop Config**

Edit `~/Library/Application Support/Claude/claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "ExtensionAudit": {
      "command": "uv",
      "args": [
        "--directory",
        "/absolute/path/to/ExtensionAudit",
        "run",
        "python",
        "-m",
        "extension_shield.mcp_server.main"
      ]
    }
  }
}
```

**Step 2: Restart Claude Desktop**

**Step 3: Use in Claude**
```
Ask Claude: "Analyze this Chrome extension: https://chromewebstore.google.com/detail/..."
```

---

## Development Workflow

### Code Quality

```bash
# Format code
make format

# Run linter
make lint

# Run tests
make test

# Run pre-commit hooks
make precommit
```

### Project Structure

```
ExtensionAudit/
├── src/extension_shield/       # Backend Python code
│   ├── api/                     # FastAPI endpoints
│   ├── cli/                     # CLI commands
│   ├── core/analyzers/          # Security analyzers
│   ├── governance/              # Governance engine
│   ├── llm/                     # LLM integration
│   ├── mcp_server/              # Claude Desktop MCP
│   └── workflow/                # LangGraph workflows
├── frontend/                    # React frontend
│   ├── src/
│   │   ├── components/          # React components
│   │   ├── pages/               # Page components
│   │   ├── services/            # API services
│   │   └── utils/               # Utilities
│   └── public/                  # Static assets
├── tests/                       # Test suite
├── docs/                        # Documentation
├── contracts/                   # API contracts
├── Dockerfile                   # Docker configuration
├── docker-compose.yml           # Docker Compose setup
├── pyproject.toml               # Python dependencies
└── Makefile                     # Development commands
```

---

## Troubleshooting

### Common Issues

**1. "uv: command not found"**
```bash
# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Add to PATH (if needed)
export PATH="$HOME/.cargo/bin:$PATH"
```

**2. "Port 8007 already in use"**
```bash
# Find and kill the process
lsof -ti:8007 | xargs kill -9

# Or use a different port
# Edit docker-compose.yml or API startup command
```

**3. "OpenAI API key not found"**
```bash
# Make sure .env file exists and contains:
OPENAI_API_KEY=sk-your-key-here

# For Docker, rebuild:
docker compose down
docker compose up --build
```

**4. "Semgrep not found"**
```bash
# Semgrep is included in dependencies
# Reinstall:
uv sync --reinstall
```

**5. Frontend won't start**
```bash
cd frontend
rm -rf node_modules package-lock.json
npm install
npm run dev
```

**6. Database errors**
```bash
# Delete and recreate database
rm -f extension-shield.db
# Restart API - database will be recreated
```

---

## LLM Provider Setup

### OpenAI (Recommended)

```bash
# .env
LLM_PROVIDER=openai
OPENAI_API_KEY=sk-your-key-here
```

Get API key: https://platform.openai.com/api-keys

### Ollama (Local/Free)

**Step 1: Install Ollama**
```bash
# macOS
brew install ollama

# Linux
curl -fsSL https://ollama.com/install.sh | sh
```

**Step 2: Download Model**
```bash
ollama pull llama3
```

**Step 3: Configure**
```bash
# .env
LLM_PROVIDER=ollama
OLLAMA_BASE_URL=http://localhost:11434
```

### WatsonX (IBM)

```bash
# .env
LLM_PROVIDER=watsonx
WATSONX_API_KEY=your-key
WATSONX_API_ENDPOINT=https://us-south.ml.cloud.ibm.com
WATSONX_PROJECT_ID=your-project-id
```

---

## Next Steps

1. **Analyze Your First Extension**
   - Start the application
   - Paste a Chrome Web Store URL
   - Review the security analysis

2. **Explore the Documentation**
   - [docs/PROJECT_SPEC.md](docs/PROJECT_SPEC.md) - Features and API reference
   - [RELATIONSHIP_TO_EXTENSIONSHIELD.md](RELATIONSHIP_TO_EXTENSIONSHIELD.md) - Project history

3. **Contribute**
   - See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines
   - Check open issues on GitHub
   - Submit bug reports or feature requests

---

## Support

**Questions or issues?**
- 📧 Email: snorzang65@gmail.com
- 💬 GitHub Issues: [Create an issue](https://github.com/your-org/ExtensionAudit/issues)

**For Google Summer of Code (GSoC) inquiries:**
This project welcomes GSoC contributors. See the documentation for potential project ideas.

---

**Happy extension auditing! 🛡️**

