# Munero Init Specification

## Command
```bash
munero init [project-name] [options]
```

## Core Functionality

### 1. Project Structure Creation
```
[project-name]/
├── .claude/
│   └── agents/          # Claude agents directory
├── specs/               # Source specifications
│   └── .gitkeep
├── src/                # Generated code
│   └── .gitkeep
├── munero.config.js    # Project configuration
├── .gitignore
└── README.md
```

### 2. MCP Server Installation
Based on our setupmcp.sh, automatically install core MCP servers:

```typescript
const CORE_MCP_SERVERS = {
  // Core Functionality
  filesystem: {
    command: "npx -y @modelcontextprotocol/server-filesystem",
    required: true
  },
  "sequential-thinking": {
    command: "npx -y @modelcontextprotocol/server-sequential-thinking",
    required: true
  },
  "memory-bank": {
    command: "npx -y @modelcontextprotocol/server-memory-bank",
    required: true
  },

  // Browser & API Tools
  puppeteer: {
    command: "npx -y @modelcontextprotocol/server-puppeteer",
    required: false
  },
  fetch: {
    command: "npx -y @kazuph/mcp-fetch",
    required: false
  },
  "browser-tools": {
    command: "npx -y @agentdeskai/browser-tools-mcp@1.2.1",
    required: false
  },
  apidog: {
    command: "npx -y @apitoolkit/mcp-apidog",
    required: false
  },

  // Database & Version Control
  supabase: {
    command: "npx -y @supabase-community/mcp-supabase",
    required: false
  },
  github: {
    command: "npx -y @mcp/github",
    required: false
  },

  // Integration Platforms
  slack: {
    command: "npx -y @mcp/slack",
    required: false
  },
  notion: {
    command: "npx -y @mcp/notion",
    required: false
  },
  zapier: {
    command: "npx -y @mcp/zapier",
    required: false
  }
};
```

### 3. Default Configuration
Creates munero.config.js with:

```javascript
module.exports = {
  project: {
    name: "project-name",
    version: "0.1.0"
  },

  mcp: {
    // Core servers always installed
    required: [
      "filesystem",
      "sequential-thinking",
      "memory-bank"
    ],
    // Optional servers available
    optional: [
      "puppeteer",
      "fetch",
      "browser-tools",
      "apidog",
      "supabase",
      "github",
      "slack",
      "notion",
      "zapier"
    ],
    // Server-specific configurations
    config: {
      filesystem: {
        paths: ["./src", "./specs"]
      }
    }
  },

  build: {
    outputDir: "./src",
    timeout: 30,
    maxCost: 100,
    validation: "high"
  },

  agents: {
    directory: ".claude/agents",
    enabled: [
      "architect",
      "developer",
      "test-engineer",
      "security-auditor"
    ]
  }
};
```

### 4. Agent Setup
Initialize `.claude/agents` with our predefined agents:

```typescript
const DEFAULT_AGENTS = {
  architect: {
    role: "System architect focusing on design patterns and best practices",
    capabilities: [
      "architecture-design",
      "system-planning",
      "pattern-recognition"
    ]
  },
  developer: {
    role: "Senior developer with full-stack expertise",
    capabilities: [
      "code-generation",
      "refactoring",
      "optimization"
    ]
  },
  "test-engineer": {
    role: "Testing specialist focusing on comprehensive coverage",
    capabilities: [
      "test-generation",
      "coverage-analysis",
      "performance-testing"
    ]
  },
  "security-auditor": {
    role: "Security expert ensuring code safety",
    capabilities: [
      "vulnerability-scanning",
      "security-patterns",
      "compliance-checking"
    ]
  }
};
```

## Command Options

```bash
# Basic initialization
munero init my-project

# Initialize with specific MCP servers
munero init my-project --mcp "puppeteer,apidog,github"

# Initialize with all MCP servers
munero init my-project --mcp-all

# Initialize with specific agents
munero init my-project --agents "architect,developer"

# Initialize with template
munero init my-project --template react-app
```

## Interactive Mode

When run without options, provides interactive prompts:

```bash
$ munero init my-project

📦 Project Setup
? Choose project type › 
  ❯ Web Application
    API Service
    CLI Tool
    Library
    Full Stack App

🔌 MCP Servers
? Select additional MCP servers › 
  ✓ filesystem
  ✓ sequential-thinking
  ✓ memory-bank
  ❯ ◯ puppeteer
    ◯ fetch
    ◯ browser-tools
    ◯ apidog
    ◯ supabase

🤖 Agents
? Select agents to enable › 
  ✓ architect
  ✓ developer
  ❯ ◯ test-engineer
    ◯ security-auditor
```

## Post-Installation

After initialization:
1. Installs selected MCP servers
2. Sets up agent configurations
3. Creates project structure
4. Initializes git repository
5. Installs dependencies
6. Shows next steps

```bash
✅ Project initialized successfully!

Next steps:
1. cd my-project
2. Review munero.config.js
3. Add your specs in /specs
4. Run 'munero build' to start building

Available commands:
- munero build "Create a React app"
- munero build --specs ./specs
- munero dev --watch
```

## Error Handling

```typescript
interface InitError {
  type: "mcp" | "agent" | "config" | "filesystem";
  server?: string;
  message: string;
  resolution: string[];
}

// Example error handling
try {
  await initProject(options);
} catch (error: InitError) {
  if (error.type === "mcp") {
    console.error(`Failed to install MCP server: ${error.server}`);
    console.log("Resolution steps:");
    error.resolution.forEach(step => console.log(`- ${step}`));
  }
}
```

## Integration with Build Process

The init command ensures that when you run a build:
1. All necessary MCP servers are available
2. Agents are properly configured
3. Project structure is ready
4. Configuration is optimized for the project type

This means you can immediately run commands like:

```bash
# Build from prompt
munero build "Create a React calculator" 

# Build from specs
munero build --specs ./specs

# Start development mode
munero dev --watch
```

And the system will have all necessary MCP servers and agents ready to use. 