# Demos

This folder contains live demonstration code and scripts used during the "Automate Your Workday with AI" session.

## Demo Structure

Each demo is organized in its own subdirectory with:
- **README.md** - Setup instructions and documentation
- **Prompt files** - The AI prompts used to generate the application
- Sample data (where applicable)
- Requirements and dependencies

## Available Demos

### [Boss Request Buster](./boss-request-buster/)
A **non-iterated** GitHub Spark app that uses a single comprehensive prompt to transform vague "boss requests" into actionable automation plans with ready-to-run scripts (PowerShell, KQL, Graph API). The prompt defines a three-panel UI that interprets requests, generates execution plans, and produces automation artifacts for IT pros working in Microsoft-centric environments.

### [Azure Boss Request Buster](./azure-boss-request-buster/)
An **iterated** GitHub Spark app built through multiple prompt refinements. This demo shows how to evolve an AI-generated application through iterations, starting with a full-stack app for Azure administrators that turns manager emails into automated reports and playbooks, then refining it with additional features and bug fixes.

## Running the Demos

1. Navigate to the specific demo folder
2. Follow the setup instructions in each demo's README
3. Access the published Spark app links provided
4. Use the sample requests to see the AI in action

## Understanding the Prompts

Each demo includes the prompts used to generate the application:
- **Single prompt demos** (like Boss Request Buster) contain one comprehensive `prompt.md` file
- **Iterated demos** (like Azure Boss Request Buster) contain multiple `iteration_*.md` files showing the evolution

## Support

If you encounter issues with any demo, please check the troubleshooting section in each demo's documentation or create an issue in this repository.