#!/bin/bash
echo "🔧 Running setupmcp.sh ..."

# Create directory for tracking installed servers
INSTALL_FLAGS_DIR=".claude/installed_servers"
mkdir -p "$INSTALL_FLAGS_DIR"

# Function to check if MCP server is already installed in Claude
check_mcp_installed() {
    local name=$1
    if claude mcp list | grep -q "^$name"; then
        return 0  # Server is installed
    else
        return 1  # Server is not installed
    fi
}

# Function to install an MCP server
install_mcp() {
    local name=$1
    local command=$2
    local flag_file="$INSTALL_FLAGS_DIR/$name"

    # Check if already installed in Claude
    if check_mcp_installed "$name"; then
        echo "✅ MCP server already installed: $name"
        touch "$flag_file"  # Update our local tracking
        return 0
    fi

    # Not installed, proceed with installation
    echo "📦 Installing MCP server: $name"
    if eval "$command"; then
        if check_mcp_installed "$name"; then
            touch "$flag_file"
            echo "✅ Successfully installed $name"
        else
            echo "⚠️ Installation command succeeded but server not found in claude mcp list"
            return 1
        fi
    else
        echo "⚠️ Failed to install $name - check the error message above"
        return 1
    fi
}

# Function to ensure all required MCP servers are installed
ensure_mcp_servers() {
    local failed=0

    echo "📦 Installing MCP servers..."

    # Core functionality servers
    install_mcp "filesystem" "claude mcp add filesystem -s user -- npx -y @modelcontextprotocol/server-filesystem ~/Documents ~/Projects" || failed=1
    install_mcp "sequential-thinking" "claude mcp add sequential-thinking -s user -- npx -y @modelcontextprotocol/server-sequential-thinking" || failed=1
    install_mcp "memory-bank" "claude mcp add memory-bank -s user -- npx -y @modelcontextprotocol/server-memory-bank" || failed=1

    # Browser and API tools
    install_mcp "puppeteer" "claude mcp add puppeteer -s user -- npx -y @modelcontextprotocol/server-puppeteer" || failed=1
    install_mcp "fetch" "claude mcp add fetch -s user -- npx -y @kazuph/mcp-fetch" || failed=1
    install_mcp "browser-tools" "claude mcp add browser-tools -s user -- npx -y @agentdeskai/browser-tools-mcp@1.2.1" || failed=1
    install_mcp "apidog" "claude mcp add apidog -s user -- npx -y @apitoolkit/mcp-apidog" || failed=1

    # Database and version control
    install_mcp "supabase" "claude mcp add supabase -s user -- npx -y @supabase-community/mcp-supabase" || failed=1
    install_mcp "github" "claude mcp add github -s user -- npx -y @mcp/github" || failed=1

    # Integration platforms
    install_mcp "slack" "claude mcp add slack -s user -- npx -y @mcp/slack" || failed=1
    install_mcp "notion" "claude mcp add notion -s user -- npx -y @mcp/notion" || failed=1
    install_mcp "zapier" "claude mcp add zapier -s user -- npx -y @mcp/zapier" || failed=1

    if [ $failed -eq 1 ]; then
        echo "⚠️ Some MCP servers failed to install. Check the errors above."
        return 1
    else
        echo "🎉 All MCP servers installed successfully!"
        return 0
    fi
}

# Run the installation process
ensure_mcp_servers
