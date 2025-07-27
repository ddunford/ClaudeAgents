# Claude AutoBuilder

A powerful automation system that uses Claude and MCP servers to generate production-ready code from specifications.

## Prerequisites

- Node.js and npm installed
- Claude CLI installed and configured
- Git installed

## Project Structure

```
.
├── specs/          # Your source specifications (add your specs here)
├── src/           # Generated code and enhanced specifications
│   └── specs/     # Machine-optimized specs generated from /specs
├── .claude/       # Claude configuration and agents
└── CLAUDE.md      # Project documentation (auto-generated)
```

## Getting Started

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd <repository-name>
   ```

2. **Add your specifications:**
   - Place your specification files in the `/specs` directory
   - Use markdown format (`.md`) for best results
   - Include requirements, architecture details, and technical specifications

3. **Run the build process:**
   ```bash
   ./build.sh
   ```
   This will:
   - Install required MCP servers (first run only)
   - Initialize Claude agents
   - Generate enhanced specs in `src/specs`
   - Generate production code in `src`

## Available Commands

### Build Script Options

- **Standard build:**
  ```bash
  ./build.sh
  ```

- **Regenerate CLAUDE.md:**
  ```bash
  ./build.sh --regen-claude-md
  ```

- **Force restart build:**
  ```bash
  ./build.sh --force-restart
  ```

### Build Progress and Resume

The build process is split into phases that are tracked in `.build-progress.json`:

1. **MCP Setup**: Installation of required MCP servers
2. **Init Claude**: Initialization of Claude agents
3. **Generate Specs**: Creation of enhanced specifications
4. **Architecture Design**: System architecture and API design
5. **Code Implementation**: Service implementation
6. **Infrastructure Setup**: Docker and deployment configuration
7. **Testing**: Implementation of test suite
8. **Security Audit**: Security review and documentation

Each phase is tracked and can be resumed if the build is interrupted. The build script will:
- Automatically detect the last completed phase
- Resume from the next incomplete phase
- Skip completed phases unless forced to restart
- Show progress summary after completion

**Progress File**: `.build-progress.json`
```json
{
    "steps": {
        "mcp_setup": false,
        "init_claude": false,
        "generate_specs": false,
        "architecture_design": false,
        "code_implementation": false,
        "infrastructure_setup": false,
        "testing": false,
        "security_audit": false
    },
    "last_updated": "",
    "current_step": ""
}
```

To force a complete rebuild:
```bash
./build.sh --force-restart
```

### Manual MCP Server Installation

If you need to manually install/reinstall MCP servers:
```bash
./setupmcp.sh
```

## MCP Servers Used

The system uses several MCP servers for different functionalities:

- **Core:**
  - `filesystem`: File operations
  - `sequential-thinking`: Process planning
  - `memory-bank`: Context retention

- **Browser & API:**
  - `puppeteer`: Browser automation
  - `fetch`: HTTP requests
  - `browser-tools`: Web tools
  - `apidog`: API documentation

- **Database & Version Control:**
  - `supabase`: Database operations
  - `github`: Code organization

- **Integration:**
  - `slack`: Slack integration
  - `notion`: Notion integration
  - `zapier`: Automation integration

## Development Process

1. **Specification Phase:**
   - Write your specifications in `/specs`
   - Use clear, detailed markdown files
   - Include all requirements and constraints

2. **Build Phase:**
   - The system generates enhanced specs in `src/specs`
   - Agents analyze and optimize the specifications
   - Additional documentation is generated

3. **Code Generation:**
   - Architecture is designed based on specs
   - Code is implemented using specialist agents
   - Infrastructure configurations are created
   - Tests are generated following the pyramid strategy
   - Security audit is performed

4. **Output:**
   - All generated code is placed in `./src`
   - Documentation is updated in `CLAUDE.md`
   - Tests are included with the code

## Testing Strategy

The system follows a testing pyramid approach:
- 80% Unit tests
- 15% Integration tests
- 5% End-to-end tests
- Aims for 90% code coverage

## Best Practices

1. **Specifications:**
   - Be detailed and explicit
   - Include edge cases and constraints
   - Define clear acceptance criteria

2. **Version Control:**
   - Keep specifications in version control
   - Review generated code before committing
   - Use feature branches for major changes

3. **Documentation:**
   - Review generated `CLAUDE.md`
   - Keep specifications up to date
   - Document any manual modifications

## Troubleshooting

- If build fails, check:
  1. Specification files exist in `/specs`
  2. MCP servers are installed properly
  3. Claude CLI is configured correctly

- To reinstall MCP servers:
  1. Delete `.mcp_installed` directory
  2. Run `./build.sh` again

## Security Notes

- API keys and secrets should be managed through environment variables
- Security audit is performed on generated code
- OAuth 2.0 and AES256 encryption are implemented where required

