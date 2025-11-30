# GitHub Copilot Repository Instructions

This guide explains how to add custom repository instructions to help GitHub Copilot generate more accurate and contextually relevant code suggestions for your projects.

## What are Repository Instructions?

Repository instructions (also called custom instructions) are guidelines you provide to GitHub Copilot about your codebase. These instructions help Copilot understand:

- Your project's coding conventions
- Preferred libraries and frameworks
- Security requirements
- Documentation standards
- Any project-specific patterns

## Benefits of Repository Instructions

- **Consistent Code**: Copilot generates code that matches your project's style
- **Better Context**: AI understands your project structure and requirements
- **Reduced Edits**: Less time spent fixing suggestions to match conventions
- **Team Alignment**: All team members get consistent Copilot suggestions
- **Improved Accuracy**: More relevant suggestions for your specific use cases

## Quick Start

### Step 1: Create the Instructions File

Create a file named `copilot-instructions.md` in the `.github` directory at the root of your repository:

```
your-repository/
├── .github/
│   └── copilot-instructions.md    <-- Create this file
├── src/
├── docs/
└── README.md
```

### Step 2: Add Content to the File

Write your instructions in Markdown format. Here's a minimal example:

```markdown
# Repository Instructions

## Overview
This is a Python web application using FastAPI.

## Coding Conventions
- Use Python 3.10+ features
- Follow PEP 8 style guidelines
- Use type hints for all functions

## Preferred Libraries
- FastAPI for web framework
- SQLAlchemy for database ORM
- Pydantic for data validation
```

### Step 3: Commit and Push

Commit the file to your repository:

```bash
git add .github/copilot-instructions.md
git commit -m "Add GitHub Copilot repository instructions"
git push
```

That's it! GitHub Copilot will now use these instructions when generating suggestions for your repository.

## Writing Effective Instructions

### What to Include

#### 1. Repository Overview
Briefly describe what your project does and its main purpose:

```markdown
## Repository Overview
This is an e-commerce platform built with React and Node.js,
targeting small businesses with inventory management needs.
```

#### 2. Project Structure
Explain how your codebase is organized:

```markdown
## Project Structure
- `src/components/` - React UI components
- `src/api/` - Backend API endpoints
- `src/utils/` - Shared utility functions
- `tests/` - Unit and integration tests
```

#### 3. Coding Standards
Define your coding conventions:

```markdown
## Coding Standards

### JavaScript/TypeScript
- Use TypeScript for all new code
- Prefer functional components with hooks
- Use async/await instead of promises chains
- Always include error handling

### Naming Conventions
- Components: PascalCase (UserProfile.tsx)
- Functions: camelCase (getUserData)
- Constants: UPPER_SNAKE_CASE (MAX_RETRIES)
```

#### 4. Preferred Tools and Libraries
List the libraries Copilot should suggest:

```markdown
## Preferred Libraries
- State management: Redux Toolkit
- HTTP client: Axios
- Testing: Jest + React Testing Library
- Styling: Tailwind CSS
- Date handling: date-fns
```

#### 5. Security Guidelines
Include security requirements:

```markdown
## Security Guidelines
- Never hardcode secrets or API keys
- Validate all user inputs
- Use parameterized queries for database operations
- Implement proper error handling without exposing internals
```

#### 6. Testing Requirements
Specify testing expectations:

```markdown
## Testing Requirements
- Write unit tests for all utility functions
- Include integration tests for API endpoints
- Maintain minimum 80% code coverage
- Use descriptive test names
```

### What to Avoid

- **Don't include secrets**: No API keys, passwords, or sensitive data
- **Keep it concise**: Focus on important guidelines, not every detail
- **Avoid contradictions**: Ensure instructions don't conflict with each other
- **Skip obvious rules**: Don't include basic programming best practices

## Sample Instructions File

See the [sample copilot-instructions.md](../../.github/copilot-instructions.md) in this repository for a complete example.

## Requirements and Limitations

### Requirements
- GitHub Copilot subscription (Individual, Business, or Enterprise)
- Instructions file must be named exactly `copilot-instructions.md`
- File must be located in the `.github` directory
- File should be written in Markdown format

### Limitations
- Maximum file size is approximately 8KB of text
- Instructions apply to the entire repository
- Copilot uses instructions as guidance, not strict rules
- Instructions are visible to anyone with repository access

## Verifying Instructions Work

To verify your instructions are being used:

1. Open a file in VS Code or GitHub.com
2. Start typing code relevant to your instructions
3. Check if Copilot suggestions match your specified conventions
4. If suggestions don't match, review your instructions for clarity

## Troubleshooting

### Instructions Not Working

1. **Check file location**: Must be `.github/copilot-instructions.md`
2. **Check file name**: Exactly `copilot-instructions.md` (lowercase)
3. **Verify Copilot access**: Ensure Copilot is enabled for the repository
4. **Wait for sync**: Changes may take a few minutes to propagate

### Suggestions Still Off-Target

- Make instructions more specific
- Include examples of preferred patterns
- Remove conflicting or ambiguous guidelines

## Additional Resources

- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [Configure Custom Instructions](https://docs.github.com/en/copilot/how-tos/configure-custom-instructions/add-repository-instructions)
- [Copilot Best Practices](https://docs.github.com/en/copilot/best-practices-for-using-copilot)

## Related Topics

- [OpenAI Quickstart](../openai-quickstart/README.md) - Get started with AI automation
- [n8n Setup](../n8n-setup/README.md) - Workflow automation with n8n
