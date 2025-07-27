#!/bin/bash
echo "🔧 Running setupmcp.sh ..."

# Create directory for tracking installed servers
INSTALL_FLAGS_DIR=".claude/installed_servers"
mkdir -p "$INSTALL_FLAGS_DIR"

# Function to safely run claude commands
run_claude_command() {
    local cmd="$1"
    # Redirect stderr to capture potential errors
    output=$(eval "$cmd" 2>&1)
    local status=$?
    if [ $status -ne 0 ]; then
        if echo "$output" | grep -q "EPIPE"; then
            echo "⚠️ Lost connection to Claude. Waiting 5 seconds before retry..."
            sleep 5
            output=$(eval "$cmd" 2>&1)
            status=$?
        fi
    fi
    echo "$output"
    return $status
}

# Get the list of installed MCP servers once
echo "📋 Checking currently installed MCP servers..."
INSTALLED_SERVERS=$(run_claude_command "claude mcp list")
if [ $? -ne 0 ]; then
    echo "❌ Failed to get list of installed servers. Aborting."
    exit 1
fi

# Function to check if MCP server is already installed in Claude
check_mcp_installed() {
    local name=$1
    if echo "$INSTALLED_SERVERS" | grep -q "^$name"; then
        return 0  # Server is installed
    else
        return 1  # Server is not installed
    fi
}

# Function to refresh the installed servers list
refresh_mcp_list() {
    INSTALLED_SERVERS=$(run_claude_command "claude mcp list")
    return $?
}

# Function to install an MCP server
install_mcp() {
    local name=$1
    local command=$2
    local flag_file="$INSTALL_FLAGS_DIR/$name"
    local max_retries=3
    local retry_count=0

    # Check if already installed in Claude
    if check_mcp_installed "$name"; then
        echo "✅ MCP server already installed: $name"
        touch "$flag_file"  # Update our local tracking
        return 0
    fi

    # Not installed, proceed with installation
    echo "📦 Installing MCP server: $name"
    
    while [ $retry_count -lt $max_retries ]; do
        if run_claude_command "$command"; then
            # Refresh the server list after installation
            if ! refresh_mcp_list; then
                echo "⚠️ Failed to refresh MCP server list"
                return 1
            fi
            
            if check_mcp_installed "$name"; then
                touch "$flag_file"
                echo "✅ Successfully installed $name"
                return 0
            else
                echo "⚠️ Installation command succeeded but server not found in claude mcp list"
                retry_count=$((retry_count + 1))
                if [ $retry_count -lt $max_retries ]; then
                    echo "Retrying in 5 seconds... (Attempt $((retry_count + 1)) of $max_retries)"
                    sleep 5
                    continue
                fi
            fi
        else
            echo "⚠️ Failed to install $name - check the error message above"
            return 1
        fi
    done

    echo "❌ Failed to install $name after $max_retries attempts"
    return 1
}

# Function to ensure all required MCP servers are installed
ensure_mcp_servers() {
    local failed=0

    echo "📦 Installing MCP servers..."

    # Core functionality servers
    install_mcp "filesystem" "claude mcp add filesystem -s user -- npx -y @modelcontextprotocol/server-filesystem ~/Documents ~/Projects" || failed=1
    if [ $failed -eq 1 ]; then
        echo "❌ Failed to install core MCP server. Aborting remaining installations."
        return 1
    fi

    install_mcp "sequential-thinking" "claude mcp add sequential-thinking -s user -- npx -y @modelcontextprotocol/server-sequential-thinking" || failed=1
    install_mcp "memory-bank" "claude mcp add memory-bank -s user -- npx -y @modelcontextprotocol/server-memory-bank" || failed=1

    # Only continue with other installations if core servers succeeded
    if [ $failed -eq 0 ]; then
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
    fi

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
