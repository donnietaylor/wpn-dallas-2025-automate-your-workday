# Daily Handoff

This folder contains the n8n workflow for the Daily Handoff automation project.

## Overview

The Daily Handoff workflow automates the process of creating and sharing daily team handoff reports and status updates.

## Files

- **[dailyhandoff.json](./dailyhandoff.json)** - The main n8n workflow file

### Workflow Details

The workflow includes the following integrations:

- **GitHub** - Fetches repositories, issues, and pull requests
- **Microsoft Outlook** - Retrieves calendar events and email messages
- **Azure RSS Feed** - Monitors Azure release communications
- **OpenAI** - Uses GPT-4.1-mini to summarize and prioritize daily items

The workflow runs on a schedule trigger (default: 8 AM) and aggregates data from all sources, then uses an AI summarization chain to create a focused daily briefing with the most important items to address.

## Setup Instructions

1. **Install n8n** - Follow the [Installation Guide](../../../docs/n8n-setup/installation.md)
2. **Configure n8n** - See the [Configuration Guide](../../../docs/n8n-setup/configuration.md)
3. **Import the workflow** - Import the `dailyhandoff.json` file into your n8n instance
4. **Configure credentials** - Add the following API credentials:
   - GitHub API (Personal Access Token)
   - Microsoft Outlook OAuth2
   - OpenAI API Key
5. **Customize settings** - Adjust the workflow to match your team's needs

## How to Import

1. Open n8n at `http://localhost:5678`
2. Navigate to Workflows
3. Click "Import from File"
4. Select the `dailyhandoff.json` file from this folder
5. Configure your credentials and settings

## Contributing

To update this workflow:

1. Make changes in n8n
2. Test thoroughly
3. Export as JSON
4. Replace the file in this folder
5. Update this README if needed
