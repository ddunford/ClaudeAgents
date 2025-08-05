# CLAUDE.md

This file provides structured guidance to Claude Code (claude.ai/code) when working with code in this repository. It establishes development conventions, architectural expectations, and automation protocols to ensure high-quality, maintainable, and testable software across all projects.

---

## 🧭 Purpose

This document is consumed by Claude Code to:

* Understand project structure, services, and critical conventions
* Automate development tasks consistently across contributors
* Enforce architectural, security, and quality standards
* Facilitate multi-agent interaction using Model Context Protocol (MCP)

---

## 🗂️ Required Project Files

### PROMPT\_CONTINUE.md

* Session handover file with:

  * Development state
  * Recent tasks
  * Architecture decisions
  * Testing status
  * Next steps (prioritised)
  * Command reference

### TASKS.md

* Project task tracker using TDD structure:

  * ✅ Completed
  * 🔄 In Progress
  * ⏳ Pending
  * Coverage status, implementation notes

### SESSION\_SUMMARY\_\*.md

* Timestamped technical logs per working session.
* Used for debugging, traceability, and asynchronous collaboration.

---

## ⚙️ Development Commands

### Docker-Based Development

```bash
# Start in dev mode
BUILD_TARGET=dev docker compose up --build

# Start in production mode
BUILD_TARGET=prod docker compose up --build

# Run tests
BUILD_TARGET=test docker compose run --rm <service-name>
```

### Proto Generation

```bash
# Generate protobuf files (example: recommended method)
docker compose run --rm proto-generator

# Manual method (if proto-generator unavailable)
cd src/proto && ./generate.sh
```

### Shell Access

```bash
docker compose exec <service-name> /bin/bash
```

---

## 🚨 Critical Development Rules

### 🔒 AUTHENTICATION ENFORCEMENT

* Internal services must NEVER expose REST endpoints to the public.
* API Gateway (or equivalent) must be the sole REST entrypoint.
* All service-to-service communication must use gRPC.
* All services must trust the context forwarded by the gateway.

### 📦 DEPENDENCY MANAGEMENT

* ALL dependencies MUST be declared:

  * Python: `requirements.txt`
  * JS/TS: `package.json`
  * Go: `go.mod`, `go.sum`
* NEVER install packages ad hoc.
* Container rebuilds MUST succeed without manual intervention.

### 🧪 TESTING STRATEGY

* Use `./run-tests.sh` or similar wrapper to run tests in Docker.
* Two-tier strategy:

  1. **Critical Tests**: Fast, essential (run on commit/deploy)
  2. **Comprehensive Tests**: Full coverage, run nightly/CI

### ✅ TDD REQUIRED

* Follow Red → Green → Refactor.
* 90%+ coverage mandatory (enforced in CI).
* Use test pyramids:

  * 70% unit
  * 20% integration
  * 10% e2e
* No production code without tests.

### 🔄 MULTI-STAGE DOCKERFILES ONLY

* One Dockerfile per service.
* No dev/test variants.
* Test runner must be part of the main Dockerfile.

### 🧾 DOCUMENTATION

* DO NOT generate new docs unless explicitly requested.
* Maintain only: `CLAUDE.md`, `PROMPT_CONTINUE.md`, `TASKS.md`, `SESSION_SUMMARY_*.md`

---

## 🧠 AI & MCP Integration

### Serena MCP (for code operations)

* Use ONLY Serena for:

  * File reads/writes
  * Regex/code changes
  * Symbol navigation

### Context7 MCP (for external libraries)

* Use to fetch latest docs for packages and frameworks.
* DO NOT assume API shapes or version details.

### Playwright MCP (for E2E testing)

* Mandatory for all browser-based tests.
* Prefer over Puppeteer or manual scripts.

### Other MCP Servers (if applicable)

* Use `SequentialThinking` for complex reasoning.
* Use `BrowserTools` for visual/UI validation.
* Use `WebSearch` for real-time info (only when necessary).

---

## 📐 Architecture Principles (Project Agnostic)

* **Strict Service Isolation**: No shared business logic across services.
* **Centralised Contracts**: gRPC proto files in a shared `src/proto` folder.
* **Volume Mounting**: Proto files must be mounted, never copied.
* **Database Isolation**: One schema per service.
* **gRPC Everywhere**: All internal comms via proto-based gRPC.

---

## 🔎 Testing Conventions

### Naming

```python
# Good
 def test_login_returns_jwt():

# Bad
 def test_simple():
```

### Mocking

```python
@patch("external.dependency")
def test_logic(mock_dep):
    # assert behaviour
```

### File Naming

* `test_<module>_<feature>.py`
* Avoid generic names like `test_simple.py`

---

## 🔐 Security Practices

* NEVER hardcode secrets
* ALWAYS use env vars or secret management systems
* DO NOT bypass authentication, even in test mode
* Enforce HTTPS, CORS, JWT validation at gateway layer

---

## 💥 Failure Recovery

* Always log with structured fields (timestamp, request ID, user ID)
* Use retries with exponential backoff for non-critical operations
* DO NOT suppress errors silently — raise or log explicitly

---

## 🧼 Style & Format

* Use formatter + linter in all languages:

  * Python: `black`, `ruff`
  * JS/TS: `eslint`, `prettier`
  * Go: `golangci-lint`
* Integrate linting into CI/CD
* Do NOT commit unformatted code

---

## 🌐 Environment Configuration

* Use `.env` or secret managers
* Use `PLATFORM=local|cloud|gpu` to adapt behaviour
* NEVER commit secrets or hardcoded credentials

---

## ⛔ Prohibited Practices

* No auth bypass
* No test skips without comment
* No commented-out production code
* No creating .proto files outside of `src/proto`
* No Dockerfile variants (test/dev)
* No local-only hacks

---

## ✅ Final Notes

* Claude Code should follow these instructions precisely.
* If confused or uncertain, STOP and ask the user.
* Prioritise simplicity, correctness, and traceability.
* NEVER take shortcuts that compromise testability or security.
