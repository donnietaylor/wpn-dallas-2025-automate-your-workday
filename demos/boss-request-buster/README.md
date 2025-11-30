# Boss Request Buster

A non-iterated GitHub Spark app that uses a single comprehensive prompt to help automate and streamline boss requests.

## Spark App

https://boss-request-buster--donnietaylor.github.app

## About This Demo

This demo showcases a **single-prompt approach** to building an AI-powered application. The entire application is generated from one comprehensive prompt that defines the complete user experience, AI behavior, and output formats.

## What the Prompt Does

The [`prompt.md`](./prompt.md) file contains instructions that tell GitHub Spark to build an application with:

### Three-Panel Layout
1. **Boss Inbox (Left)** - Where users paste vague boss requests with urgency levels and tech surface selections
2. **AI Interpretation & Plan (Middle)** - Displays the AI's analysis including request classification, goals, systems, risks, and step-by-step execution plan
3. **Generated Automation Kit (Right)** - Contains ready-to-use PowerShell scripts, KQL queries, Graph API examples, and status messages to send back to the boss

### Key Features Defined in the Prompt
- **Request Classification** - Categorizes requests into types: Reporting, Investigation, Change, Compliance, or Communication
- **Automation Blueprint** - Extracts structured data including goals, systems, data sources, constraints, and risk flags
- **Artifact Generation** - Produces PowerShell scripts, KQL queries, REST examples, and status messages
- **History Tracking** - Saves all "busted" requests for future reference
- **Sample Requests** - Pre-built examples for quick demos

### Target Audience
IT professionals and sysadmins working in Microsoft-centric environments (Entra ID, Intune, Azure, Exchange Online, Windows Server, on-prem AD, VMware, etc.)

## How to Use

1. Access the published Spark app using the link above
2. Paste a vague boss request or click a sample request
3. Select the urgency level and relevant tech surfaces
4. Click "Bust this request"
5. Review the AI interpretation, execution plan, and generated scripts
6. Copy and customize the generated artifacts for your environment

## Safety Notes

- All scripts are **suggestions only** - they are not automatically executed
- Scripts should be reviewed and tested before running in production
- The app defaults to read-only/listing commands; destructive actions are clearly marked
