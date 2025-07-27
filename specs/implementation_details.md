# Implementation Details

## Prompt Templates

### Direct Build Prompt
```typescript
interface BuildPrompt {
  type: "build";
  description: string;
  requirements?: {
    technology?: string[];
    features?: string[];
    constraints?: string[];
  };
  preferences?: {
    architecture?: string;
    patterns?: string[];
    style?: string[];
  };
}

// Example:
const prompt = {
  type: "build",
  description: "Create a secure Express.js API for user management",
  requirements: {
    technology: ["Express.js", "TypeScript", "PostgreSQL"],
    features: ["User CRUD", "Authentication", "Role-based access"],
    constraints: ["GDPR compliant", "Rate limited", "Audit logged"]
  },
  preferences: {
    architecture: "Clean Architecture",
    patterns: ["Repository", "CQRS"],
    style: ["Functional", "Immutable"]
  }
};
```

### Enhancement Prompt
```typescript
interface EnhancementPrompt {
  type: "enhance";
  target: string;
  improvements: string[];
  constraints?: string[];
  preserveFeatures?: string[];
}

// Example:
const prompt = {
  type: "enhance",
  target: "./src/auth",
  improvements: ["Add 2FA", "Implement session management"],
  constraints: ["Backward compatible", "No new dependencies"],
  preserveFeatures: ["Current login flow", "Password policies"]
};
```

## MCP Server Usage Patterns

### Filesystem Operations
```typescript
interface FileSystemPattern {
  operation: "read" | "write" | "update" | "delete";
  validation?: (content: string) => boolean;
  formatting?: (content: string) => string;
  backupStrategy?: "none" | "before" | "after";
}

const patterns = {
  specUpdate: {
    operation: "update",
    validation: (content) => validateSpecFormat(content),
    formatting: (content) => formatSpecification(content),
    backupStrategy: "before"
  },
  codeGeneration: {
    operation: "write",
    validation: (content) => validateSyntax(content),
    formatting: (content) => formatCode(content),
    backupStrategy: "none"
  }
};
```

### Sequential Thinking
```typescript
interface ThinkingStep {
  type: "analyze" | "plan" | "verify";
  input: any;
  expectations: any[];
  validation: (result: any) => boolean;
}

const buildAnalysis = {
  steps: [
    {
      type: "analyze",
      input: "requirements",
      expectations: ["components", "dependencies", "constraints"],
      validation: validateRequirements
    },
    {
      type: "plan",
      input: "analysis",
      expectations: ["tasks", "order", "estimates"],
      validation: validatePlan
    }
  ]
};
```

## Agent Communication Protocol

### Message Format
```typescript
interface AgentMessage {
  type: "request" | "response" | "event" | "error";
  source: string;
  target: string;
  priority: number;
  payload: any;
  metadata: {
    timestamp: number;
    correlationId: string;
    sessionId: string;
  };
}
```

### Communication Patterns
```typescript
interface CommunicationPattern {
  type: "broadcast" | "direct" | "publish-subscribe";
  reliability: "at-least-once" | "exactly-once" | "best-effort";
  ordering: "ordered" | "unordered";
  acknowledgment: boolean;
}

const patterns = {
  buildUpdates: {
    type: "broadcast",
    reliability: "at-least-once",
    ordering: "ordered",
    acknowledgment: true
  },
  agentCoordination: {
    type: "publish-subscribe",
    reliability: "exactly-once",
    ordering: "ordered",
    acknowledgment: true
  }
};
```

## Build Artifacts

### Artifact Types
```typescript
interface BuildArtifact {
  type: "code" | "spec" | "test" | "doc" | "config";
  format: string;
  location: string;
  validation: (artifact: any) => boolean;
  metadata: {
    version: string;
    timestamp: number;
    author: string;
    dependencies?: string[];
  };
}
```

### Artifact Management
```typescript
interface ArtifactManager {
  store(artifact: BuildArtifact): Promise<void>;
  retrieve(id: string): Promise<BuildArtifact>;
  validate(artifact: BuildArtifact): Promise<boolean>;
  track(artifact: BuildArtifact): Promise<void>;
}
```

## Configuration Schema

### Build Configuration
```typescript
interface BuildConfig {
  project: {
    name: string;
    version: string;
    description: string;
  };
  build: {
    maxIterations: number;
    timeout: number;
    costLimit: number;
  };
  agents: {
    enabled: string[];
    configurations: Record<string, AgentConfig>;
  };
  mcp: {
    servers: McpServerConfig[];
    timeout: number;
    retryStrategy: RetryConfig;
  };
  validation: {
    rules: ValidationRule[];
    thresholds: Record<string, number>;
  };
  feedback: {
    loop: FeedbackLoopConfig;
    learning: LearningConfig;
  };
}
```

### Environment Configuration
```typescript
interface EnvConfig {
  NODE_ENV: "development" | "production" | "test";
  LOG_LEVEL: "debug" | "info" | "warn" | "error";
  CLAUDE_API_KEY: string;
  MCP_CONFIG: string;
  BUILD_TIMEOUT: number;
  MAX_COST: number;
  ENABLE_LEARNING: boolean;
}
```

## Integration Points

### Version Control
```typescript
interface VCSIntegration {
  type: "git" | "svn" | "mercurial";
  operations: {
    commit: CommitConfig;
    branch: BranchConfig;
    pr: PRConfig;
  };
  hooks: {
    pre: HookConfig[];
    post: HookConfig[];
  };
}
```

### CI/CD
```typescript
interface CIConfig {
  triggers: TriggerConfig[];
  stages: StageConfig[];
  environments: EnvConfig[];
  notifications: NotificationConfig[];
}
```

### Monitoring
```typescript
interface MonitoringConfig {
  metrics: MetricConfig[];
  alerts: AlertConfig[];
  dashboards: DashboardConfig[];
  logging: LogConfig[];
}
```

## Usage Examples

### Basic Build
```typescript
const builder = new BuildManager({
  project: {
    name: "user-api",
    version: "1.0.0"
  },
  build: {
    maxIterations: 10,
    timeout: 3600000
  }
});

await builder.runBuild({
  prompt: "Create a TypeScript Express.js API with user authentication"
});
```

### Enhanced Build with Feedback
```typescript
const builder = new BuildManager({
  // ... config ...
});

const feedbackLoop = new FeedbackLoopManager({
  // ... config ...
});

builder.attachFeedbackLoop(feedbackLoop);

await builder.runBuild({
  prompt: "Create a secure microservice",
  validation: {
    security: "high",
    performance: "medium",
    coverage: 90
  }
});
``` 