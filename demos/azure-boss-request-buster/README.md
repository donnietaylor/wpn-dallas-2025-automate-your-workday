# Azure Boss Request Buster

An iterated GitHub Spark app that uses multiple prompt iterations to help automate and streamline boss requests for Azure administrators.

## Spark App

*Link to published Spark app will be added here*

## About This Demo

This demo showcases an **iterative prompt approach** to building an AI-powered application. Instead of one comprehensive prompt, the application evolves through multiple iterations, each refining and expanding functionality.

## Prompts and Iterations

This app uses an iterative approach with multiple prompts. Each iteration refines the output.

### [Iteration 1](./iteration_1.md) - Foundation

The initial prompt establishes the core application:

**Problem Solved:** Managers send "urgent" asks that require hours of ad-hoc ARM/ARG queries, KQL, exports, and slideware. This app turns those vague emails into actionable playbooks.

**Key Features:**
- **Email Parser** - Paste manager emails to auto-detect intent and map to playbooks
- **17 Sample Scenarios** - Pre-built templates covering cost analysis, security audits, compliance, backup status, and more
- **Multi-Connector Architecture** - Integrates with Azure Resource Graph, Azure Monitor, Cost Management, Defender for Cloud, Azure Advisor, Azure Backup, Log Analytics, and optionally Entra ID
- **Multiple Output Formats** - Email-ready HTML, CSV/XLSX exports, PDF reports, and executive PPTX slides
- **Automation & Scheduling** - Schedule playbooks daily/weekly/monthly with caching and delta refresh
- **Guardrails** - Default read-only with explicit confirmation for any write actions

### [Iteration 2](./iteration_2.md) - Enhanced UX

Builds on iteration 1 with UX improvements:
- Add common email templates to the email parser tab
- Auto-display reports when a runbook is selected
- Add new playbooks matching the email parser scenarios

### [Iteration 3](./iteration_3.md) - Bug Fixes & Settings

Focuses on stability and real-world usability:
- Fix all reported errors
- Populate the settings function and button for production use

## How the Iteration Process Works

1. **Iteration 1** - Comprehensive initial prompt defining the full application scope
2. **Iteration 2** - Targeted refinements based on usage feedback
3. **Iteration 3** - Bug fixes and production-readiness improvements

This approach demonstrates how to:
- Start with a solid foundation
- Iterate based on real needs
- Polish the application for production use

## How to Use

1. Access the published Spark app using the link above
2. Paste a manager email or select from template scenarios
3. Review the detected intent and selected playbook
4. Adjust parameters (subscriptions, tags, date range)
5. Generate and export your report

## Target Audience

Azure administrators who need to quickly respond to ad-hoc management requests for:
- Cost analysis and forecasting
- Security and compliance audits
- Resource inventory and health checks
- Backup and disaster recovery status
- Policy compliance reporting
