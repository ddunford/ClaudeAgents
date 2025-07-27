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

# Build with specific iteration limit
munero build --max-iterations 5

# Build with specific success criteria
munero build --min-coverage 90 --max-critical-issues 0
```

### Iteration Control
```bash
# Pause current build
munero pause

# Resume paused build
munero resume

# Skip current iteration
munero next

# Restart current iteration
munero retry

# Force complete current build
munero complete
```

### Progress Monitoring
```bash
# Show build status
munero status

# Show detailed metrics
munero metrics

# Watch build progress
munero watch

# Show iteration history
munero history

# Export build report
munero report
```

### Project Commands
```bash
# Initialize new project
munero init [project-name]

# Add MCP server
munero mcp add <server>

# List MCP servers
munero mcp list

# Remove MCP server
munero mcp remove <server>
```

### Development Commands
```bash
# Start development mode
munero dev

# Run tests
munero test

# Validate specs
munero validate

# Clean build artifacts
munero clean
```

### Session Commands
```bash
# List active sessions
munero sessions list

# Resume specific session
munero sessions resume <id>

# Clean old sessions
munero sessions clean
```

## Global Options

### Build Control
```bash
--verbose               # Enable verbose output
--quiet                # Suppress non-essential output
--debug                # Enable debug mode
--config <path>        # Use specific config file
--no-color            # Disable colored output
```

### Build Options
```bash
--specs <path>         # Path to specs directory
--max-iterations      # Maximum iterations allowed
--min-coverage        # Minimum test coverage required
--max-critical-issues # Maximum critical issues allowed
--timeout            # Build timeout in minutes
--force              # Force rebuild
```

### Development Options
```bash
--watch               # Watch for changes
--hot                # Enable hot reload
--port <number>      # Development server port
--host <host>        # Development server host
```

## Configuration File
```javascript
// munero.config.js
module.exports = {
  // Build Configuration
  build: {
    maxIterations: 10,
    minCoverage: 90,
    maxCriticalIssues: 0,
    timeout: 60,
    specs: './specs'
  },

  // Iteration Control
  iteration: {
    autoRetry: true,
    maxRetries: 3,
    retryDelay: 1000
  },

  // Progress Tracking
  progress: {
    metrics: ['coverage', 'issues', 'performance'],
    reportFormat: 'html',
    watchInterval: 1000
  },

  // MCP Servers
  mcp: {
    servers: ['filesystem', 'sequential-thinking'],
    timeout: 5000,
    retries: 3
  },

  // Development
  dev: {
    port: 3000,
    host: 'localhost',
    hot: true,
    watch: true
  },

  // Testing
  test: {
    coverage: true,
    watch: false,
    updateSnapshots: false
  }
};
```

## SDK Integration Features

### Build Events
```typescript
munero.on('build:start', (options) => {});
munero.on('build:progress', (progress) => {});
munero.on('build:complete', (result) => {});
munero.on('build:error', (error) => {});
```

### Iteration Events
```typescript
munero.on('iteration:start', (number) => {});
munero.on('iteration:progress', (status) => {});
munero.on('iteration:complete', (result) => {});
```

### Progress Events
```typescript
munero.on('metrics:update', (metrics) => {});
munero.on('status:change', (status) => {});
munero.on('report:generate', (report) => {});
```

## Examples

### Basic Build
```bash
# Build from prompt
munero build "Create a React app with authentication"

# Build from specs with options
munero build --specs ./specs --max-iterations 5 --min-coverage 90
```

### Progress Monitoring
```bash
# Watch build progress with metrics
munero watch --metrics

# Generate detailed report
munero report --format html --output ./report
```

### Development Flow
```bash
# Initialize project
munero init my-project

# Start development mode
munero dev --watch --hot

# Run tests with coverage
munero test --coverage
```

### Session Management
```bash
# List and resume session
munero sessions list
munero sessions resume abc123

# Clean old sessions
munero sessions clean --older-than 7d
``` 