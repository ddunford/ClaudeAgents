# Claude AutoBuilder

## How to Use

1. **Install MCP servers:**
   ```bash
   ./setupmcp.sh
   ```

2. **Run the build from `specs/`:**
   ```bash
   ./build.sh
   ```

## Notes
- All MCP servers like `context7`, `memory`, `playwright` etc. are installed once using a flag.
- All Claude-generated code will be placed in `./src`
- Sub-agents are loaded from `.claude/agents/`
- Pyramid testing strategy is followed (unit tests first)

