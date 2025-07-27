# Agent Integration Specification

## Overview
Since the SDK runs Claude instances in the workspace, we maintain full access to `.claude/agents`. This means we can continue using agents as before, just through the SDK interface.

## Agent Usage with SDK

### Initialization
```typescript
class BuildManager {
  private async initializeAgents(): Promise<void> {
    // Still runs /init as before, just through SDK
    await query({
      prompt: "/init",
      options: {
        outputFormat: "json"
      }
    });
  }
}
```

### Build Process
```typescript
class BuildManager {
  async runBuild(options: BuildOptions): Promise<void> {
    // First ensure agents are initialized
    if (this.needsInit()) {
      await this.initializeAgents();
    }

    // Run build with agents - they're already available in the Claude instance
    for await (const message of query({
      prompt: options.prompt,
      options: {
        outputFormat: "json",
        maxTurns: 100
      }
    })) {
      // Handle messages
    }
  }
}
```

## Key Points

1. **Agent Availability**
   - `.claude/agents` is still accessible to Claude
   - No need for complex agent state management
   - Agents work as they did in the shell script

2. **SDK Integration**
   - Use SDK's query function instead of shell commands
   - Better error handling and type safety
   - Structured message handling

3. **Session Management**
   - SDK handles Claude sessions
   - Agents persist through the session
   - No need for manual agent state tracking

## Example Usage

```typescript
// Simple build with agents
const buildManager = new BuildManager();

await buildManager.runBuild({
  prompt: `Using backend-architect and security-auditor agents, 
          create a secure Express.js API with proper architecture`
});
```

## Migration Notes

1. **From Shell Script**
   - Replace `claude` CLI calls with SDK `query`
   - Keep same agent-related prompts
   - Maintain `.claude/agents` directory

2. **Advantages**
   - Type safety
   - Better error handling
   - Structured responses
   - Progress tracking
   - Cost monitoring

3. **No Changes Needed For**
   - Agent directory structure
   - Agent initialization
   - Agent commands and usage
   - Agent interactions 