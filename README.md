# Munero

An autonomous build system using Claude SDK that provides continuous feedback and improvement loops for your projects. It can analyze requirements, generate specifications, and build complete applications while continuously testing, validating, and improving the codebase.

## Features

- 🤖 **Autonomous Building**: Analyzes requirements and builds complete applications
- 🔄 **Continuous Feedback**: Tests, validates, and improves code in real-time
- 🧪 **Comprehensive Testing**: Implements full test pyramid with coverage analysis
- 🛡️ **Security First**: Continuous security auditing and vulnerability checks
- 📈 **Learning System**: Improves over time by learning from build patterns
- 🔌 **MCP Integration**: Seamless integration with Model Context Protocol servers
- 🎯 **Spec Generation**: Creates enhanced, machine-optimized specifications
- 📊 **Quality Monitoring**: Continuous code quality and performance tracking

## Installation

```bash
npm install munero
```

## Quick Start

```typescript
import { BuildManager } from 'munero';

// Initialize the build manager
const builder = new BuildManager({
  project: {
    name: "my-project",
    version: "1.0.0"
  }
});

// Build from a prompt
await builder.runBuild({
  prompt: "Create a secure Express.js API with user authentication"
});

// Or build from existing specs
await builder.runBuild({
  specsDir: "./specs"
});
```

## Documentation

### Build Process

The system follows an autonomous agent loop:

1. **Plan**: Analyzes requirements and creates build plan
2. **Execute**: Implements code and runs tests
3. **Observe**: Monitors results and quality
4. **Reflect**: Analyzes outcomes and suggests improvements
5. **Re-plan**: Updates build plan based on feedback

### Configuration

```typescript
const config = {
  build: {
    maxIterations: 10,
    timeout: 3600000,
    costLimit: 100
  },
  validation: {
    security: "high",
    performance: "medium",
    coverage: 90
  }
};

const builder = new BuildManager(config);
```

### MCP Servers

Required MCP servers are automatically installed and managed:

- filesystem: File operations
- sequential-thinking: Process planning
- memory-bank: Context retention
- puppeteer: Browser automation
- apidog: API documentation
- supabase: Database operations
- github: Code organization

### Feedback Loop

```typescript
const feedbackLoop = new FeedbackLoopManager({
  validation: {
    functional: functionalCriteria,
    quality: qualityCriteria,
    performance: performanceCriteria,
    security: securityCriteria
  }
});

builder.attachFeedbackLoop(feedbackLoop);
```

## Advanced Usage

### Custom Validation

```typescript
const validation = {
  rules: [
    {
      type: "security",
      check: async (code) => {
        // Custom security validation
      }
    }
  ],
  thresholds: {
    coverage: 90,
    performance: 95
  }
};

await builder.runBuild({
  prompt: "Create a microservice",
  validation
});
```

### Agent Configuration

```typescript
const agents = {
  enabled: [
    "test-engineer",
    "code-reviewer",
    "security-auditor"
  ],
  configurations: {
    "test-engineer": {
      coverage: 90,
      testTypes: ["unit", "integration", "e2e"]
    }
  }
};

const builder = new BuildManager({ agents });
```

## Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Development Setup

```bash
# Clone the repository
git clone https://github.com/yourusername/munero.git

# Install dependencies
npm install

# Run tests
npm test

# Build
npm run build
```

## License

MIT - see [LICENSE](LICENSE) for details.

## Security

See [SECURITY.md](SECURITY.md) for security policy and reporting vulnerabilities.

## Support

- 📚 [Documentation](https://yourusername.github.io/munero)
- 🐛 [Issue Tracker](https://github.com/yourusername/munero/issues)
- 💬 [Discussions](https://github.com/yourusername/munero/discussions)

## Roadmap

See our [project roadmap](https://github.com/yourusername/munero/projects/1) for upcoming features and improvements. 