# Munero Init Specification

## Command
```bash
munero init [options]
```

## Core Functionality

### 1. Directory Structure Creation
```
.munero/                # Munero workspace (hidden)
├── agents/            # Pre-configured Claude agents (source)
├── specs/            # Generated enhanced specifications
├── feedback/         # Feedback loop data
├── state/           # Build state and history
├── cache/           # Build cache
└── logs/            # Build and agent logs

.claude/              # Claude workspace (hidden)
└── agents/          # Copied agents for Claude to use

CLAUDE.md            # Project documentation for Claude
```

### 2. Agent Setup
1. Define agents in `.munero/agents`
2. Copy agents to `.claude/agents` for Claude to use
3. Initialize CLAUDE.md with project documentation

```typescript
const DEFAULT_AGENTS = {
  'test-engineer': {
    role: 'Testing and Quality Assurance',
    capabilities: [
      'test generation',
      'coverage analysis',
      'bug detection'
    ]
  },
  'code-reviewer': {
    role: 'Code Quality and Standards',
    capabilities: [
      'pattern recognition',
      'code smell detection',
      'style enforcement'
    ]
  },
  'security-auditor': {
    role: 'Security Analysis',
    capabilities: [
      'vulnerability scanning',
      'dependency audit',
      'compliance checking'
    ]
  },
  'performance-analyst': {
    role: 'Performance Optimization',
    capabilities: [
      'bottleneck detection',
      'resource analysis',
      'optimization suggestions'
    ]
  },
  'documentation-writer': {
    role: 'Documentation Generation',
    capabilities: [
      'api documentation',
      'usage guides',
      'architecture diagrams'
    ]
  }
};

// Copy agents to .claude/agents
async function setupAgents(): Promise<void> {
  // Create directories
  await fs.mkdir('.munero/agents', { recursive: true });
  await fs.mkdir('.claude/agents', { recursive: true });
  
  // Write agent definitions to .munero/agents
  for (const [name, agent] of Object.entries(DEFAULT_AGENTS)) {
    await fs.writeFile(
      `.munero/agents/${name}.json`,
      JSON.stringify(agent, null, 2)
    );
  }
  
  // Copy agents to .claude/agents
  await fs.cp('.munero/agents', '.claude/agents', { recursive: true });
}
```

### 3. CLAUDE.md Generation
```typescript
async function generateClaudeMd(): Promise<void> {
  const content = `# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

### Build Commands
\`\`\`bash
# Build from prompt
munero build "Create a React calculator with dark mode"

# Build from specs directory
munero build --specs ./my-specs
\`\`\`

## Architecture Overview

This project uses Munero, an autonomous build system that uses Claude's SDK to continuously analyze, build, test, and improve applications until they fully meet specifications.

### Project Structure
\`\`\`
.munero/                # Munero workspace
├── specs/            # Generated specifications
├── feedback/         # Feedback loop data
└── state/           # Build state

.claude/              # Claude workspace
└── agents/          # Specialized agents
\`\`\`

### Core Components
1. Build Manager: Orchestrates the build process
2. Feedback Loop: Implements Plan-Execute-Observe-Reflect-Replan cycle
3. Agent System: Specialized agents for different aspects
4. Validation System: Ensures code meets all criteria

### Agent Integration
The system uses agents in .claude/agents for:
- Test engineering
- Code review
- Security auditing
- Performance analysis
- Documentation generation

### Build States
1. analyze_requirements: Read and understand requirements
2. generate_specs: Create enhanced specifications
3. implement_code: Write the implementation
4. run_tests: Validate functionality
5. security_audit: Check for vulnerabilities
6. optimize: Improve performance
7. document: Generate documentation

### Success Criteria
- All tests passing
- >90% test coverage
- No security vulnerabilities
- Performance requirements met
- Documentation complete
\`\`\``;

  await fs.writeFile('CLAUDE.md', content);
}
```

### 4. MCP Server Installation
```typescript
const CORE_MCP_SERVERS = [
  'filesystem',
  'sequential-thinking',
  'memory-bank',
  'puppeteer',
  'fetch',
  'browser-tools',
  'apidog',
  'supabase',
  'github',
  'slack',
  'notion',
  'zapier'
];
```

### 5. Default Configuration
```javascript
// .munero/config.js
module.exports = {
  build: {
    maxIterations: 10,
    minCoverage: 90,
    maxCriticalIssues: 0,
    timeout: 60
  },

  feedback: {
    autoRetry: true,
    maxRetries: 3,
    metrics: ['coverage', 'issues', 'performance'],
    learningEnabled: true
  },

  mcp: {
    servers: CORE_MCP_SERVERS,
    timeout: 5000,
    retries: 3
  },

  agents: {
    default: [
      'test-engineer',
      'code-reviewer',
      'security-auditor',
      'performance-analyst',
      'documentation-writer'
    ],
    config: {
      'test-engineer': {
        coverage: 90,
        testTypes: ['unit', 'integration', 'e2e']
      },
      'security-auditor': {
        scanLevel: 'deep',
        compliance: ['owasp-top-10']
      }
    }
  },

  validation: {
    continuous: true,
    criteria: {
      coverage: 90,
      issues: {
        critical: 0,
        major: 5
      },
      performance: {
        lighthouse: 90
      }
    }
  }
};
```

## Command Options
```bash
# Basic initialization
munero init

# Custom configuration
munero init --config custom.config.js

# Specify MCP servers
munero init --mcp filesystem,sequential-thinking

# Custom agent selection
munero init --agents test-engineer,security-auditor

# Interactive mode
munero init --interactive

# Skip certain setup steps
munero init --skip-mcp --skip-agents
```

## Interactive Mode
1. MCP Server Selection
   - Choose from available servers
   - Configure server options
   - Test connections

2. Agent Configuration
   - Select active agents
   - Configure agent settings
   - Set up collaboration rules

3. Build Configuration
   - Set iteration limits
   - Define success criteria
   - Configure timeouts
   - Set up validation rules

4. Feedback Loop Setup
   - Configure metrics collection
   - Set up learning system
   - Define improvement criteria
   - Configure progress tracking

## Post-Installation Steps
1. Initialize Claude
   ```bash
   claude --dangerously-skip-permissions -p "/init"
   ```

2. MCP Server Verification
   ```bash
   munero mcp verify
   ```

3. Agent Verification
   ```bash
   munero agents verify
   ```

4. Initial Test
   ```bash
   munero validate
   ```

## Error Handling

### Installation Errors
```typescript
type InstallError =
  | MCPServerError
  | AgentSetupError
  | ConfigurationError
  | DependencyError;
```

### Recovery Strategies
1. Automatic retry for network issues
2. Fallback configurations
3. Skip problematic components
4. Manual intervention prompts

## Integration with Build Process

### State Initialization
```typescript
interface BuildState {
  mcp: MCPServerStatus[];
  agents: AgentStatus[];
  feedback: FeedbackLoopConfig;
  metrics: MetricsConfig;
}
```

### Progress Tracking
```typescript
interface ProgressTracker {
  currentPhase: string;
  completedSteps: string[];
  errors: Error[];
  metrics: BuildMetrics;
}
```

### Feedback Loop Integration
```typescript
interface FeedbackLoop {
  metrics: string[];
  thresholds: Record<string, number>;
  learning: LearningConfig;
  validation: ValidationConfig;
}
```

## File Templates

### README.md
```markdown
# Project Name

## Overview
[Project description]

## Getting Started
1. Installation
2. Configuration
3. Usage

## Development
- Build Process
- Testing
- Deployment

## Documentation
- API Reference
- Architecture
- Contributing
```

### .gitignore
```
node_modules/
dist/
.munero/state/
*.log
```

### package.json
```json
{
  "name": "project-name",
  "version": "0.1.0",
  "scripts": {
    "build": "munero build",
    "dev": "munero dev",
    "test": "munero test"
  }
}
``` 