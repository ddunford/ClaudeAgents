# Claude Build Manager Project Specification

## Overview
A TypeScript-based build manager that uses Claude's SDK to automate the process of analyzing requirements (either from a prompt or /specs directory), generating enhanced specifications, and building applications using Claude agents and MCP servers.

## Build Flow

### 1. MCP Server Setup
Required servers (from previous setupmcp.sh):
- **Core Functionality**
  - filesystem: File operations
  - sequential-thinking: Process planning
  - memory-bank: Context retention

- **Browser & API Tools**
  - puppeteer: Browser automation
  - fetch: HTTP requests
  - browser-tools: Web tools
  - apidog: API documentation

- **Database & Version Control**
  - supabase: Database operations
  - github: Code organization

- **Integration Platforms**
  - slack: Slack integration
  - notion: Notion integration
  - zapier: Automation integration

### 2. Specification Generation
Two possible paths:

a) **From Prompt**:
   - Take user's prompt as input
   - Use sequential-thinking to analyze requirements
   - Generate comprehensive specs in ./src/specs
   - Include:
     * System architecture
     * API contracts
     * Data models
     * Testing requirements
     * Integration points

b) **From /specs Directory**:
   - Read existing specs from /specs
   - Analyze and enhance specs
   - Generate machine-optimized versions in ./src/specs
   - Add necessary documentation

### 3. Build Process
Following the pattern from our previous build.sh:

1. **Architecture Design**
   - System architecture
   - API contracts
   - Database schemas
   - Service boundaries
   - Integration points

2. **Code Implementation**
   - Use appropriate language specialists
   - Follow CLAUDE.md patterns
   - Implement services/endpoints
   - Add error handling
   - Generate documentation

3. **Infrastructure Setup**
   - Docker configurations
   - CI/CD pipelines
   - Development environments
   - Monitoring/logging
   - Deployment scripts

4. **Testing**
   - Unit tests (80%)
   - Integration tests (15%)
   - E2E tests (5%)
   - Test automation
   - Performance tests

5. **Security Audit**
   - Vulnerability checks
   - Encryption verification
   - Auth/auth audit
   - Dependency review
   - Security documentation

## Implementation Requirements

### SDK Integration
```typescript
interface BuildOptions {
  // Either prompt or specsDir must be provided
  prompt?: string;
  specsDir?: string;
  forceRestart?: boolean;
  regenClaudeMd?: boolean;
  maxCost?: number;
  timeout?: number;
}

class BuildManager {
  constructor(config: BuildConfig);
  
  // Main build method
  async runBuild(options: BuildOptions): Promise<BuildResult>;
  
  // Core processes
  private async ensureMcpServers(): Promise<void>;
  private async generateSpecs(source: string | string[]): Promise<void>;
  private async buildFromSpecs(): Promise<void>;
}
```

### MCP Server Management
```typescript
interface McpServerConfig {
  name: string;
  command: string;
  args: string[];
  required: boolean;
}

class McpServerManager {
  async installServer(config: McpServerConfig): Promise<void>;
  async verifyInstallation(name: string): Promise<boolean>;
  async ensureRequired(): Promise<void>;
}
```

### Specification Management
```typescript
interface SpecGenerator {
  generateFromPrompt(prompt: string): Promise<void>;
  generateFromSpecs(specsDir: string): Promise<void>;
  validateSpecs(): Promise<boolean>;
}
```

## Usage Examples

```typescript
// Build from prompt
const builder = new BuildManager();
await builder.runBuild({
  prompt: "Create a secure Express.js API with user authentication",
});

// Build from existing specs
await builder.runBuild({
  specsDir: "./specs",
});
```

## Directory Structure
```
.
├── .claude/
│   └── agents/          # Claude agents
├── specs/               # Source specifications
├── src/
│   └── specs/          # Generated specifications
│   └── ...            # Generated application code
├── CLAUDE.md           # Project documentation
└── build/              # Build manager implementation
```

## Key Features

1. **Intelligent Spec Generation**
   - Comprehensive analysis
   - Machine-optimized output
   - Consistent structure

2. **MCP Server Integration**
   - Automatic installation
   - Health checking
   - Proper error handling

3. **Agent Coordination**
   - Specialist agent selection
   - Context maintenance
   - Progress tracking

4. **Build Process**
   - Phase management
   - Resource monitoring
   - Error recovery

5. **Output Management**
   - Structured code organization
   - Documentation generation
   - Test coverage

## Success Criteria

1. **Specification Quality**
   - Complete coverage
   - Clear structure
   - Implementation details

2. **Code Quality**
   - Best practices
   - Error handling
   - Documentation
   - Test coverage

3. **Build Process**
   - Reliability
   - Error handling
   - Progress tracking
   - Resource efficiency 