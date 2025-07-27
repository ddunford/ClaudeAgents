#!/bin/bash
echo "🔧 Running setupmcp.sh ..."

# Create directory for tracking installed servers
INSTALL_FLAGS_DIR=".claude/installed_servers"
mkdir -p "$INSTALL_FLAGS_DIR"

# Function to install an MCP server
install_mcp() {
    local name=$1
    local command=$2
    local flag_file="$INSTALL_FLAGS_DIR/$name"

    # Skip if already installed
    if [ -f "$flag_file" ]; then
        echo "✅ MCP server already installed: $name"
        return 0
    fi

    echo "📦 Installing MCP server: $name"
    if eval "$command"; then
        touch "$flag_file"
        echo "✅ Successfully installed $name"
    else
        echo "⚠️ Failed to install $name - check the error message above"
        return 1
    fi
}

# Install each MCP server with its specific command
echo "📦 Installing MCP servers..."

# Core functionality servers
install_mcp "filesystem" "claude mcp add filesystem -s user -- npx -y @modelcontextprotocol/server-filesystem ~/Documents ~/Projects"
install_mcp "sequential-thinking" "claude mcp add sequential-thinking -s user -- npx -y @modelcontextprotocol/server-sequential-thinking"
install_mcp "memory-bank" "claude mcp add memory-bank -s user -- npx -y @modelcontextprotocol/server-memory-bank"

# Browser and API tools
install_mcp "puppeteer" "claude mcp add puppeteer -s user -- npx -y @modelcontextprotocol/server-puppeteer"
install_mcp "fetch" "claude mcp add fetch -s user -- npx -y @kazuph/mcp-fetch"
install_mcp "browser-tools" "claude mcp add browser-tools -s user -- npx -y @agentdeskai/browser-tools-mcp@1.2.1"
install_mcp "apidog" "claude mcp add apidog -s user -- npx -y @apitoolkit/mcp-apidog"

# Database and version control
install_mcp "supabase" "claude mcp add supabase -s user -- npx -y @supabase-community/mcp-supabase"
install_mcp "github" "claude mcp add github -s user -- npx -y @mcp/github"

# Integration platforms
install_mcp "slack" "claude mcp add slack -s user -- npx -y @mcp/slack"
install_mcp "notion" "claude mcp add notion -s user -- npx -y @mcp/notion"
install_mcp "zapier" "claude mcp add zapier -s user -- npx -y @mcp/zapier"

echo "🎉 MCP server installation complete!"
