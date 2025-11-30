# GitHub Copilot Instructions

This file provides GitHub Copilot with context about this repository to help it generate more relevant and accurate code suggestions.

## Repository Overview

This is the "Automate Your Workday with AI" repository for the WorkPlace Ninja US 2025 conference in Dallas. The repository contains code samples, demos, documentation, and resources for implementing AI automation in daily workflows.

## Project Structure

- `demos/` - Live demonstration code and scripts
- `code-samples/` - Reusable code snippets and examples (Python, JavaScript, PowerShell, n8n workflows)
- `docs/` - Detailed documentation and guides
- `resources/` - External links, tools, and references

## Coding Guidelines

### General Principles

- Write clear, self-documenting code with descriptive variable and function names
- Include comprehensive error handling in all examples
- Add inline comments explaining complex logic or AI-specific concepts
- Follow the principle of keeping examples simple and educational

### Python Code

- Use Python 3.8+ syntax and features
- Follow PEP 8 style guidelines
- Use type hints for function parameters and return values
- Prefer `python-dotenv` for environment variable management
- Use `openai` library for OpenAI API integration

### JavaScript Code

- Use modern ES6+ syntax (const/let, arrow functions, async/await)
- Use CommonJS (`require`) for Node.js examples unless specified otherwise
- Include JSDoc comments for functions
- Use `dotenv` for environment variable management

### PowerShell Code

- **Use PowerShell 7+ (`pwsh`) instead of Windows PowerShell 5.1 (`powershell`)**
- Follow PowerShell naming conventions (Verb-Noun for functions, PascalCase)
- Use approved verbs from `Get-Verb` for function names
- Include comment-based help (`.SYNOPSIS`, `.DESCRIPTION`, `.PARAMETER`, `.EXAMPLE`)
- Use `Invoke-RestMethod` for REST API calls (not `Invoke-WebRequest`)
- Load environment variables from `.env` files using custom function or module
- Use `[CmdletBinding()]` for advanced functions
- Prefer splatting for cmdlet parameters with many arguments
- Use `$ErrorActionPreference = 'Stop'` for strict error handling when appropriate

### API Integration

- Never hardcode API keys or secrets in examples
- Always demonstrate loading credentials from environment variables
- Include error handling for API failures
- Add rate limiting considerations in documentation

### Documentation

- Use clear, step-by-step instructions
- Include prerequisites and requirements
- Provide expected output examples
- Add troubleshooting sections for common issues

## Security Considerations

- Emphasize security best practices in all examples
- Demonstrate proper `.env` file usage
- Remind users to add sensitive files to `.gitignore`
- Include input validation in user-facing examples

## AI Services Focus

This repository primarily focuses on:

- OpenAI API (GPT models, chat completions)
- Azure OpenAI Service
- n8n workflow automation
- Integration patterns for workplace automation

## Example Response Formats

When generating code suggestions for this repository, prefer:

- Complete, runnable examples over code fragments
- Examples that can be tested with minimal setup
- Code that follows the existing patterns in the repository
