<h1 align="center">ExtensionAudit</h1>

<p align="center">
  <strong>Enterprise Chrome Extension Security & Governance Platform</strong>
</p>

<p align="center">
  <em>Open Source Documentation & Configuration</em>
</p>

---

## 🎉 What is ExtensionAudit?

**ExtensionAudit** is an enterprise Chrome extension security and governance platform that provides:

- ✅ **Security Analysis** - Static analysis, permissions auditing, and risk scoring
- ✅ **Governance Engine** - Policy-based decisions (ALLOW/BLOCK/NEEDS_REVIEW)
- ✅ **Multiple Interfaces** - Web UI, REST API, CLI, and Claude Desktop (MCP)
- ✅ **LLM Integration** - AI-powered security summaries
- ✅ **Enterprise Ready** - Docker deployment and audit trails

This repository provides the **documentation, configuration, and deployment setup** for the ExtensionAudit platform.

---

## 📋 Repository Contents

This repository includes:

- 📚 **Documentation** - Setup guides, architecture, and contribution guidelines
- 🐳 **Docker Configuration** - Production-ready containerization
- ⚙️ **Build Configuration** - Makefile, environment templates, deployment configs
- 🎨 **Frontend Configuration** - React + Vite setup (package.json, configs)
- 🖼️ **Assets** - Images and branding materials

**Note:** The source code (backend, frontend, and tests) will be added in future releases.

---

## 🚀 Quick Start

### Prerequisites

- Docker Desktop or Docker Engine
- Docker Compose

### Setup

```bash
# 1. Clone the repository
git clone https://github.com/Stanzin7/ExtensionAudit.git
cd ExtensionAudit

# 2. Configure environment
cp env.production.template .env
# Edit .env and add your OPENAI_API_KEY

# 3. Wait for source code release
# The backend and frontend source code will be added soon
```

---

## 📖 Documentation

| Document | Description |
|----------|-------------|
| [SETUP.md](SETUP.md) | Detailed setup and installation guide |
| [CONTRIBUTING.md](CONTRIBUTING.md) | How to contribute to the project |
| [RELATIONSHIP_TO_EXTENSIONSHIELD.md](RELATIONSHIP_TO_EXTENSIONSHIELD.md) | Project history and evolution |
| [ACKNOWLEDGMENTS.md](ACKNOWLEDGMENTS.md) | Credits and attribution |
| [docs/](docs/) | Technical documentation |

---

## 🛠️ Planned Features

### 🔍 Security Analysis Pipeline
- **Permissions Analysis** — Risk assessment of manifest permissions
- **SAST Engine** — Custom Semgrep rules with MITRE ATT&CK mappings
- **Entropy Detection** — Identifies obfuscated/packed code
- **VirusTotal Integration** — Cross-references with antivirus engines
- **Chrome Web Store Metadata** — Extract ratings and developer info

### ⚖️ Governance Engine
- **Deterministic Verdicts** — Consistent security decisions
- **Policy Rulepacks** — YAML-based enterprise governance rules
- **Evidence Chain** — Links decisions to specific code findings
- **Enforcement Bundles** — Complete audit trail exports

### 🎨 Modern Web Interface
- **React + Vite** frontend with real-time scan progress
- **Detailed Results** — Permissions, SAST findings, governance decisions
- **File Explorer** — Browse and inspect extension source code
- **PDF Reports** — Downloadable security reports

### 🔌 Multiple Interfaces
- **Web UI** - Full-featured React dashboard
- **REST API** - Programmatic access to all features
- **CLI Tool** - Command-line interface for automation
- **Claude Desktop (MCP)** - Natural language extension analysis

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      ExtensionAudit                         │
├─────────────────────────────────────────────────────────────┤
│  Interfaces                                                 │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐        │
│  │   CLI   │  │ Web UI  │  │   API   │  │   MCP   │        │
│  └────┬────┘  └────┬────┘  └────┬────┘  └────┬────┘        │
│       └────────────┴────────────┴────────────┘             │
│                         │                                   │
│  ┌──────────────────────▼──────────────────────┐           │
│  │         LangGraph Workflow Pipeline         │           │
│  │  Ingest → Parse → Analyze → Govern → Report │           │
│  └──────────────────────┬──────────────────────┘           │
│                         │                                   │
│  ┌──────────────────────▼──────────────────────┐           │
│  │              Security Analyzers             │           │
│  │  ┌────────────┐ ┌────────────┐ ┌──────────┐ │           │
│  │  │Permissions │ │   SAST     │ │ WebStore │ │           │
│  │  └────────────┘ └────────────┘ └──────────┘ │           │
│  │  ┌────────────┐ ┌────────────┐              │           │
│  │  │VirusTotal  │ │  Entropy   │              │           │
│  │  └────────────┘ └────────────┘              │           │
│  └──────────────────────┬──────────────────────┘           │
│                         │                                   │
│  ┌──────────────────────▼──────────────────────┐           │
│  │          Governance Engine (DSL)            │           │
│  │  Facts → Signals → Rules → Decision         │           │
│  └──────────────────────┬──────────────────────┘           │
│                         │                                   │
│  ┌──────────────────────▼──────────────────────┐           │
│  │       LLM Summary Generation                │           │
│  │    (OpenAI / WatsonX / Ollama)              │           │
│  └─────────────────────────────────────────────┘           │
└─────────────────────────────────────────────────────────────┘
```

---

## 🤝 Contributing

We welcome contributions! This is an open-source project under the MIT license.

### Areas for Contribution
- 🌐 **Cross-browser support** (Firefox, Safari, Edge)
- 🤖 **ML-based malware classification**
- 📊 **Enhanced visualization and reporting**
- 🔒 **Additional security rules and patterns**
- 🧪 **Test coverage improvements**
- 📚 **Documentation enhancements**

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed contribution guidelines.

---

## 🙏 Acknowledgments

**ExtensionAudit** builds upon the **[ThreatXtension](https://github.com/barvhaim/ThreatXtension)** foundation by Bar Haim and Itzik Chanan.

I have built custom rulesets and a governance engine for enterprise deployment. This project makes the analysis framework and findings available to the security community.

See [ACKNOWLEDGMENTS.md](ACKNOWLEDGMENTS.md) for detailed attribution.

---

## 📄 License

MIT License — see [LICENSE](LICENSE) for details.

---

## 📧 Contact

**Questions or collaboration opportunities?**  
📧 snorzang65@gmail.com

**For Google Summer of Code (GSoC) inquiries:**  
This project welcomes GSoC contributors. See the documentation for potential project ideas.

---

## 🔮 Roadmap

### Phase 1: Foundation (Current)
- ✅ Documentation and configuration
- ✅ Docker setup
- ✅ Build configuration
- 🔄 Source code release (coming soon)

### Phase 2: Core Release
- 📦 Backend source code
- 📦 Frontend source code
- 📦 Test suite
- 📦 CLI and API implementation

### Phase 3: Enhancement
- 🌐 Firefox support
- 🤖 ML classification
- 📊 Enhanced reporting
- 🔒 Additional security rules

---

<p align="center">
  <strong>Built with ❤️ for the open-source security community</strong>
</p>
