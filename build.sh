#!/bin/bash
set -e

# Parse command line arguments
REGEN_CLAUDE_MD=false
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --regen-claude-md) REGEN_CLAUDE_MD=true ;;
        *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
    shift
done

echo "🚀 Starting MCP Central Hub build process..."

# Ensure src/specs exists (specs will always exist as it's in git)
mkdir -p src/specs

# Initialize Claude with agents only if CLAUDE.md doesn't exist or REGEN_CLAUDE_MD is true
if [ ! -f "CLAUDE.md" ] || [ "$REGEN_CLAUDE_MD" = true ]; then
    echo "🤖 Running /init to load agents..."
    claude --dangerously-skip-permissions -p "/init"
fi

# Generate fresh specs and documentation in src/specs
echo "📝 Generating fresh specs and documentation in src/specs..."
claude --dangerously-skip-permissions -p "Using sequential-thinking and filesystem agents, please:
1. Read and analyze all specification files in /specs
2. Generate enhanced, machine-optimized versions of these specs in ./src/specs
3. Add additional documentation files that will help other agents understand:
   - The system architecture
   - API contracts
   - Data models
   - Testing requirements
   - Integration points
Make sure the generated specs maintain all requirements from the original specs while being optimized for machine processing."

# Ensure specs were generated
if [ -z "$(ls -A ./src/specs 2>/dev/null)" ]; then
    echo "❌ Error: No specs were generated in ./src/specs. Please ensure there are specification files in /specs to work from."
    exit 1
fi

# Generate production code from specs
echo "🏗️ Starting Claude AutoBuilder (Spec Mode)..."

# Use multiple MCP servers in coordination:
# - filesystem: to read specs and write code
# - sequential-thinking: to break down the implementation steps
# - memory-bank: to maintain context across the build process
# - github: for code organization and PR creation
# - apidog: for API documentation and testing
# - supabase: for database schema management

# Run Claude in interactive mode to properly utilize agents
echo "Using filesystem to read specs and write code, sequential-thinking for planning, and memory-bank for context retention, please carefully read all markdown files in ./src/specs and use the following process to generate high-quality production code:

1. First, use backend-architect to design the overall system architecture, APIs, and database schemas based on the specs in ./src/specs.
2. Then, based on the architectural decisions and requirements, use appropriate language specialist agents (typescript-pro, python-pro, golang-pro, etc.) to implement the services in ./src following the design patterns in CLAUDE.md.
3. Use cloud-architect to create necessary Docker and infrastructure configurations in ./src.
4. Use test-automator to implement the testing pyramid (80% unit, 15% integration, 5% E2E) aiming for 90% coverage, writing tests in ./src.
5. Finally, use security-auditor to review all code in ./src for security best practices.

Important requirements:
- Follow the microservices architecture defined in CLAUDE.md
- Use supabase for implementing database schemas and validation
- Use apidog for API documentation and testing
- Use github for code organization and PR reviews
- Ensure proper error handling and logging
- Add comprehensive documentation
- Follow the testing pyramid strategy
- Implement all security requirements (OAuth 2.0, AES256 encryption)
- Write all code and configuration files in the ./src directory
- Read specifications only from ./src/specs directory
- Choose appropriate language specialist agents based on architectural decisions and requirements

Please proceed step by step, ensuring each component is properly implemented before moving to the next." | claude --dangerously-skip-permissions

echo "✅ Build process completed!"
