#!/bin/bash
set -e

# Parse command line arguments
REGEN_CLAUDE_MD=false
FORCE_RESTART=false
SESSION_FILE=".claude-session"
TEST_PROMPT=""

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --regen-claude-md) REGEN_CLAUDE_MD=true ;;
        --force-restart) FORCE_RESTART=true ;;
        --prompt) 
            shift
            TEST_PROMPT="$1"
            ;;
        *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
    shift
done

echo "🚀 Starting MCP Central Hub build process..."

# Run setupmcp.sh if MCP servers haven't been installed
if [ ! -d ".mcp_installed" ] || [ -z "$(ls -A .mcp_installed 2>/dev/null)" ]; then
    echo "🔧 First run detected - installing MCP servers..."
    ./setupmcp.sh
fi

# Ensure src/specs exists (specs will always exist as it's in git)
mkdir -p src/specs

# Run /init if needed
if [ ! -f "CLAUDE.md" ] || [ "$REGEN_CLAUDE_MD" = true ]; then
    echo "🤖 Running /init to load agents..."
    claude --dangerously-skip-permissions -p "/init"
fi

# Create the build instructions
if [ -n "$TEST_PROMPT" ]; then
    echo "🧪 Using test prompt instead of /specs..."
    cat > build_instructions.txt << EOL
Welcome! You'll be working on a test prompt instead of reading from /specs.

Test Prompt:
$TEST_PROMPT

You have access to several MCP servers that you should use:
- filesystem: Use for writing generated code to ./src
- sequential-thinking: Use for planning and breaking down complex tasks
- memory-bank: Use for maintaining context across the build process
- puppeteer & browser-tools: Use for any web-related tasks
- fetch: Use for making HTTP requests
- apidog: Use for API documentation and testing
- supabase: Use for database operations and schema management
- github: Use for code organization and PR management
- slack, notion, zapier: Use for any required integrations

Please actively use these MCP servers rather than simulating their functionality. They provide real capabilities that will make the implementation more effective.

Important Requirements:
- Write all code in ./src
- Use appropriate MCP servers for implementation
- Add proper error handling
- Add comprehensive documentation
- Follow best practices for the chosen technology
- Choose appropriate specialist agents

Please proceed with implementing the test prompt. Use the appropriate MCP servers - they provide real functionality that will make the implementation more effective.
EOL
else
    cat > build_instructions.txt << 'EOL'
Welcome! You'll be coordinating the build process for this project. Here are your tasks.

You have access to several MCP servers that you should use throughout the build process:
- filesystem: Use for reading specs from /specs and writing generated code to ./src
- sequential-thinking: Use for planning and breaking down complex tasks
- memory-bank: Use for maintaining context across the build process
- puppeteer & browser-tools: Use for any web-related tasks
- fetch: Use for making HTTP requests
- apidog: Use for API documentation and testing
- supabase: Use for database operations and schema management
- github: Use for code organization and PR management
- slack, notion, zapier: Use for any required integrations

Please actively use these MCP servers rather than simulating their functionality. They provide real capabilities that will make the build process more effective.

Tasks:

Generate Enhanced Specs:
1. Use filesystem to read specification files from /specs
2. Use sequential-thinking to analyze and break down the specs
3. Use filesystem to write enhanced versions to ./src/specs
4. Add documentation for:
   * System architecture
   * API contracts
   * Data models
   * Testing requirements
   * Integration points

Architecture Design:
1. Use sequential-thinking to design system architecture
2. Use apidog for API contract design
3. Use supabase for database schema planning
4. Use memory-bank to maintain consistent design decisions
5. Use filesystem to output designs to ./src/architecture/

Code Implementation:
1. Use filesystem for all code reading/writing
2. Use github for code organization
3. Use supabase for database implementations
4. Use apidog for API implementations
5. Use memory-bank to maintain context across components

Infrastructure Setup:
1. Use filesystem to write Docker configurations
2. Use github for CI/CD pipeline setup
3. Use sequential-thinking for environment planning
4. Use appropriate MCP servers for each integration
5. Store all configs in ./src/infrastructure

Testing:
1. Use apidog for API testing
2. Use filesystem to write test files
3. Use sequential-thinking for test planning
4. Use puppeteer for end-to-end tests
5. Use memory-bank to maintain test context

Security Audit:
1. Use sequential-thinking for security analysis
2. Use github for dependency review
3. Use filesystem to write security documentation
4. Use memory-bank to track security context
5. Document all findings in ./src/security

Important Requirements:
- Follow microservices architecture from CLAUDE.md
- Use supabase for database operations
- Use apidog for API documentation
- Use github for code organization
- Ensure proper error handling
- Add comprehensive documentation
- Follow testing pyramid strategy
- Implement security requirements
- Write all code in ./src
- Read specs from /specs
- Choose appropriate specialist agents
- Actively use MCP servers for their intended purposes

Please proceed through these tasks in order. Use the appropriate MCP servers for each task - they provide real functionality that will make the build process more effective. Keep track of your progress and report status as you go.
EOL
fi

# Check if we should resume a session
if [ -f "$SESSION_FILE" ] && [ "$FORCE_RESTART" = false ]; then
    SESSION_ID=$(cat "$SESSION_FILE")
    echo "🔄 Resuming previous session: $SESSION_ID"
    cat build_instructions.txt | claude --dangerously-skip-permissions -r "$SESSION_ID"
else
    # Start new interactive Claude session and capture session ID
    echo "🤖 Starting new interactive Claude session for build process..."
    # Use verbose mode to capture session ID from the output
    SESSION_OUTPUT=$(cat build_instructions.txt | claude --dangerously-skip-permissions --verbose 2>&1)
    
    # Extract session ID from verbose output (assuming it's in the format "Session ID: <id>")
    if echo "$SESSION_OUTPUT" | grep -q "Session ID:"; then
        SESSION_ID=$(echo "$SESSION_OUTPUT" | grep "Session ID:" | sed 's/.*Session ID: \([^ ]*\).*/\1/')
        echo "$SESSION_ID" > "$SESSION_FILE"
        echo "📝 Saved session ID: $SESSION_ID"
    fi
fi

# Cleanup
rm build_instructions.txt

echo "✅ Build process completed!"
echo "💡 To resume this session later, run: claude -r \"$(cat "$SESSION_FILE" 2>/dev/null || echo '<session-id>')\""
