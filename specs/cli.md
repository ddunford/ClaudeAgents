# Munero CLI Specification

## Command Structure

```bash
munero <command> [options]
```

## Core Commands

### Build Commands
```bash
# Build from prompt
munero build "Create a React calculator with dark mode"

# Build from specs directory
munero build --specs ./specs

# Build with specific configuration
munero build --specs ./specs --config munero.config.js

# Resume previous build
munero build --resume <session-id>

# Force restart a build
munero build --force-restart "Create an Express.js API"
```

### Project Commands
```bash
# Initialize a new project
munero init [project-name]

# Add MCP servers
munero mcp add <server-name>

# List installed MCP servers
munero mcp list

# Remove MCP server
munero mcp remove <server-name>
```

### Development Commands
```bash
# Start development mode (watches specs and rebuilds)
munero dev --specs ./specs

# Run tests on generated code
munero test

# Run security audit
munero audit

# Format generated code
munero format
```

### Session Management
```bash
# List active sessions
munero sessions list

# Show session details
munero sessions show <session-id>

# Resume specific session
munero sessions resume <session-id>

# Clean up old sessions
munero sessions clean
```

### Validation Commands
```bash
# Validate specs
munero validate specs ./specs

# Validate generated code
munero validate code ./src

# Run full validation suite
munero validate all
```

## Global Options

```bash
# Common options available for most commands
--verbose               # Detailed output
--silent               # Minimal output
--output-format json   # JSON output format
--log-level <level>    # Set logging level
--config <path>        # Custom config file
--no-color            # Disable colored output
```

## Build Options

```bash
# Specific options for build command
--specs <path>         # Specs directory path
--output <path>        # Output directory (default: ./src)
--force-restart        # Force restart build
--resume <session-id>  # Resume specific session
--timeout <minutes>    # Build timeout
--max-cost <number>    # Maximum cost limit
--agents <list>        # Specific agents to use
--validation <level>   # Validation level (low|medium|high)
```

## Development Options

```bash
# Options for development mode
--watch                # Watch for changes
--hot-reload          # Hot reload generated code
--port <number>        # Dev server port
--host <host>         # Dev server host
```

## Configuration File (munero.config.js)

```javascript
module.exports = {
  // Project settings
  project: {
    name: "my-app",
    version: "1.0.0"
  },

  // Build configuration
  build: {
    outputDir: "./src",
    timeout: 30, // minutes
    maxCost: 100,
    validation: "high"
  },

  // Agent configuration
  agents: {
    enabled: ["test-engineer", "security-auditor"],
    config: {
      "test-engineer": {
        coverage: 90
      }
    }
  },

  // MCP server configuration
  mcp: {
    servers: ["filesystem", "sequential-thinking"],
    config: {
      filesystem: {
        paths: ["./src", "./specs"]
      }
    }
  },

  // Validation rules
  validation: {
    specs: {
      required: ["README.md", "api.md"],
      schema: "./spec-schema.json"
    },
    code: {
      coverage: 90,
      complexity: 20,
      duplication: 5
    }
  },

  // Development settings
  dev: {
    port: 3000,
    hot: true,
    watch: ["./specs/**/*"]
  }
};
```

## SDK Integration Features

### Hooks System
```typescript
// Register build hooks
munero.on('build:start', (context) => {
  // Pre-build tasks
});

munero.on('build:complete', (result) => {
  // Post-build tasks
});

// Custom validation hooks
munero.on('validate:code', (code) => {
  // Custom validation
});
```

### Progress Events
```typescript
// Real-time build progress
munero.on('progress', (progress) => {
  console.log(`${progress.phase}: ${progress.percentage}%`);
});

// Cost tracking
munero.on('cost:update', (cost) => {
  console.log(`Current cost: $${cost}`);
});
```

### Agent Communication
```typescript
// Interact with specific agents
munero.agent('test-engineer').suggest({
  type: 'test',
  component: 'Calculator',
  coverage: 'edge-cases'
});

// Get agent feedback
munero.agent('security-auditor').audit({
  files: ['./src/auth.ts'],
  level: 'deep'
});
```

### Build Pipelines
```typescript
// Define custom build pipeline
munero.pipeline([
  {
    name: 'analyze',
    agent: 'architect',
    task: 'design-system'
  },
  {
    name: 'implement',
    agent: 'developer',
    task: 'code-generation'
  },
  {
    name: 'test',
    agent: 'test-engineer',
    task: 'full-coverage'
  }
]);
```

### Workspace Integration
```typescript
// IDE integration
munero.workspace.onSave((file) => {
  // Trigger partial rebuild
});

munero.workspace.suggest((code) => {
  // Get real-time suggestions
});
```

### Learning System
```typescript
// Train on successful builds
munero.learn({
  type: 'pattern',
  context: 'api-design',
  example: successfulBuild
});

// Get recommendations
const suggestions = await munero.suggest({
  type: 'architecture',
  context: currentBuild
});
```

## Examples

### Basic Build
```bash
# Build a calculator app
munero build "Create a React calculator with TypeScript, tests, and documentation"
```

### Advanced Build
```bash
# Build with specific requirements
munero build \
  --specs ./specs \
  --output ./src \
  --validation high \
  --agents "architect,developer,tester" \
  --config custom.config.js
```

### Development Mode
```bash
# Start dev mode with hot reload
munero dev --specs ./specs --hot-reload --port 3000
```

### Validation
```bash
# Full validation suite
munero validate all \
  --specs ./specs \
  --code ./src \
  --coverage 90 \
  --complexity 20
``` 