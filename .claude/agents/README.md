---
# Claude Code Agents

A collection of specialized AI agents for Claude Code that enhance development workflows with domain-specific expertise.

## Overview

This directory contains specialized agents that extend Claude Code's capabilities. Each agent is an expert in a specific domain and is automatically invoked based on context or can be explicitly called when needed.

## Available Agents

### Architecture & System Design
- **[backend-architect](backend-architect.md)** - Design scalable service architectures, APIs, and data models
- **[cloud-architect](cloud-architect.md)** - Design and implement cloud infrastructure and platform services
- **[graphql-architect](graphql-architect.md)** - Design GraphQL schemas, resolvers, and federation
- **[architect-review](architect-review.md)** - Reviews code changes for architectural consistency and patterns

### Frontend Development
- **[react-expert](react-expert.md)** - Expert in React development, patterns, and performance
- **[css-expert](css-expert.md)** - Expert in modern CSS, styling systems, and responsive design
- **[ux-expert](ux-expert.md)** - Expert in user experience design and accessibility
- **[mobile-developer](mobile-developer.md)** - Develop React Native or Flutter apps with native integrations

### Backend Development
- **[database-expert](database-expert.md)** - Expert in database development, optimization, and operations
- **[grpc-expert](grpc-expert.md)** - Expert in gRPC service design and implementation
- **[fastapi-pro](fastapi-pro.md)** - Expert in FastAPI development and async patterns
- **[echo-pro](echo-pro.md)** - Expert in Go Echo framework development
- **[kafka-expert](kafka-expert.md)** - Expert in Kafka configuration and event patterns

### Language Specialists
- **[typescript-pro](typescript-pro.md)** - Expert in TypeScript with advanced type systems
- **[rust-pro](rust-pro.md)** - Expert in Rust development and systems programming
- **[python-pro](python-pro.md)** - Expert in Python development and best practices
- **[golang-pro](golang-pro.md)** - Expert in Go development with concurrency patterns
- **[php-pro](php-pro.md)** - Expert in modern PHP development
- **[laravel-pro](laravel-pro.md)** - Expert in Laravel ecosystem and patterns

### Data & AI
- **[data-scientist](data-scientist.md)** - Expert in analytics, statistical modeling, and machine learning
- **[data-engineer](data-engineer.md)** - Expert in data infrastructure and pipeline development
- **[ai-engineer](ai-engineer.md)** - Expert in LLM applications and generative AI systems
- **[ml-engineer](ml-engineer.md)** - Expert in production machine learning systems
- **[prompt-engineer](prompt-engineer.md)** - Expert in prompt design and optimization

### Operations & Security
- **[incident-responder](incident-responder.md)** - Expert in incident response and technical debugging
- **[deployment-engineer](deployment-engineer.md)** - Expert in CI/CD pipelines and deployments
- **[docker-expert](docker-expert.md)** - Expert in container technologies and orchestration
- **[security-auditor](security-auditor.md)** - Expert in security review and OWASP compliance
- **[performance-engineer](performance-engineer.md)** - Expert in performance optimization

### Quality & Testing
- **[code-reviewer](code-reviewer.md)** - Expert code review for quality and maintainability
- **[test-automator](test-automator.md)** - Expert in comprehensive test automation
- **[dx-optimizer](dx-optimizer.md)** - Expert in developer experience optimization

### Specialized Domains
- **[api-documenter](api-documenter.md)** - Expert in API documentation and specifications
- **[payment-integration](payment-integration.md)** - Expert in payment system integration
- **[quant-analyst](quant-analyst.md)** - Expert in financial modeling and analysis
- **[legacy-modernizer](legacy-modernizer.md)** - Expert in legacy system modernization
- **[context-manager](context-manager.md)** - Expert in managing context across agents

## Agent Format

Each agent follows this structure:
```markdown
---
name: agent-name
description: Clear description of when this agent should be used, with PROACTIVELY note for primary use cases
---

You are [role] specializing in [domain].

## Focus Areas
- Key capabilities and specialties
- Listed in bullet points

## Approach
1. Numbered steps for methodology
2. How the agent tackles problems
3. Key principles and practices

## Output
- What the agent produces
- Specific deliverables
- Expected results

Additional notes or special considerations.
```

## Usage

### Automatic Invocation
Claude Code will automatically delegate to the appropriate agent based on the task context and the agent's description.

### Explicit Invocation
You can mention the agent by name in your request:
```
"Use the code-reviewer to check my recent changes"
"Have the security-auditor scan for vulnerabilities"
"Get the performance-engineer to optimize this bottleneck"
```

## Agent Orchestration

Claude Code automatically coordinates agents using these patterns:

### Sequential Workflows
```
User Request → Agent A → Agent B → Agent C → Result

Example: "Build a new API feature"
backend-architect → database-expert → test-automator → security-auditor
```

### Parallel Execution
```
User Request → Agent A + Agent B (simultaneously) → Merge Results

Example: "Optimize application performance" 
performance-engineer + database-expert → Combined recommendations
```

### Review & Validation
```
Primary Agent → Review Agent → Final Result

Example: "Implement payment processing"
payment-integration → security-auditor → Validated implementation
```

## Best Practices

### 🎯 Task Delegation
1. Let Claude Code delegate automatically - The system analyzes context and selects optimal agents
2. Be specific about requirements - Include constraints, tech stack, and quality requirements
3. Trust agent expertise - Each agent is optimized for their domain

### 🔄 Multi-Agent Workflows
1. Start with high-level requests - Let agents coordinate complex multi-step tasks
2. Provide context between agents - Ensure agents have necessary background information
3. Review integration points - Check how different agents' outputs work together

### 🎛️ Explicit Control
1. Use explicit invocation for specific needs - When you want a particular expert's perspective
2. Combine multiple agents strategically - Different specialists can validate each other's work
3. Request specific review patterns - "Have security-auditor review backend-architect's API design"

## Troubleshooting

### Common Issues

**Agent not being invoked automatically:**
- Ensure your request clearly indicates the domain (e.g., "performance issue" → performance-engineer)
- Be specific about the task type (e.g., "review code" → code-reviewer)

**Unexpected agent selection:**
- Provide more context about your tech stack and requirements
- Use explicit invocation if you need a specific agent

**Multiple agents producing conflicting advice:**
- This is normal - different specialists may have different priorities
- Ask for clarification: "Reconcile the recommendations from security-auditor and performance-engineer"

**Agent seems to lack context:**
- Provide background information in your request
- Reference previous conversations or established patterns