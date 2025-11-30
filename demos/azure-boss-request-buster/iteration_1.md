Build a full-stack “Boss-Request Buster for Azure” app for an overworked Azure admin. The app turns vague, time-sucking manager emails into one-click, accurate reports and optional guarded actions so I can stay focused on real work. Generate a production-ready codebase with tests, seed data, CI, and clear docs. Let Spark choose the stack. Prefer read-only operations by default.

Problem to solve

Managers send “urgent” asks that require hours of ad-hoc ARM/ARG queries, KQL, exports, and slideware. I want a tool where I paste the email (or pick a template), and it auto-maps the ask to a playbook that pulls data across subscriptions, assembles a polished deliverable, and can schedule recurring updates.

Example manager emails this app should handle out-of-the-box

“By EOD, show all public endpoints (RDP/SSH/HTTP) across prod subscriptions and who owns them.”

“Give me cost spike analysis for last 7 days by subscription/RG/service with a forecast.”

“List untagged resources (missing owner, env, costcenter) and propose fixes.”

“Which Azure Policies are non-compliant? Summarize by initiative and top offenders.”

“Inventory all VMs: OS, size, region, power state; flag stopped-but-allocated and idle VMs.”

“Find orphaned disks/NICs/public IPs/snapshots and the monthly waste they cause.”

“Which Storage Accounts allow public access or don’t require secure transfer?”

“Show Defender for Cloud high-severity recommendations by resource type and aging.”

“Summarize Backup success/fail rates and unprotected VMs/SQL for this month.”

“Status of Site Recovery: replication health, RPO breaches, and failover readiness.”

“Which AKS clusters are behind on version or have node pools without autoscale?”

“List Key Vault secrets/certs expiring in 30/60/90 days and who owns the apps.”

“Any Resource Health/Service Health incidents impacting our prod regions today?”

“Which App Services lack HTTPS-only or have TLS < 1.2?”

“Top Advisor cost/security/reliability recommendations and estimated savings.”

“Show diagnostic settings coverage: which resource types aren’t sending to Log Analytics.”

“Provide a 3-slide Ops Pack: cost trend, risk/compliance, top actions with owners.”

Capabilities

Input flow: Paste email → NLP/heuristics detect intent → choose a playbook → auto-populate parameters (subs, tags, date range) → preview → export/send.

Data connectors (read-first):

Azure Resource Graph (inventory, relationships, tag compliance).

Azure Monitor (Activity Log, metrics, Service Health, Resource Health).

Azure Policy (policyStates, initiative compliance).

Cost Management (actuals, forecast, amortized, savings plans/RI where available).

Defender for Cloud (assessments/recommendations/secure score).

Azure Advisor (recommendations).

Azure Backup & Site Recovery (job status, protection coverage).

Log Analytics (KQL query API).

(Optional, behind a flag) Entra ID role assignments/PIM for owner lookups.

Playbooks: Versioned recipes combining queries + joins + transforms + visuals for each common ask. Users can save custom playbooks.

Outputs:

Email-ready HTML summary.

CSV/XLSX exports.

PDF report with charts/tables.

Optional PPTX (3–5 slides) for execs.

Shareable tokenized snapshot links.

Automation:

Schedule any playbook (daily/weekly/monthly) to a distro list.

One-click rerun with last parameters.

Caching + delta refresh for speed.

Guardrails:

Default read-only. Any write actions (e.g., apply tags, stop dev VMs, enable diag settings) require explicit confirmation and show a dry-run preview.

Connector health page and least-privilege RBAC guidance.

UX:

“Paste email” landing page → intent → parameters → preview → export.

Template library grouped by Cost, Inventory, Security/Defender, Policy/Compliance, Monitoring/Health, Backup/DR.

Parameter chips (subs, MGs, regions, tags, date range) and quick filters.

Progress panel showing running queries and connector errors.

Keyboard shortcuts, dark mode, command palette.

Deliverables

Full repo, docs, seed data, CI workflow (lint/test/build), runnable dev environment.

Playbook library implementing at least 12 of the example emails above.

Config guide for Azure RBAC scopes and required permissions per connector (read-only minimums).

Tests: unit for parsers/transforms; e2e that runs a sample email → playbook → generates CSV/PDF/PPTX.

Non-goals (v1)

Not a CMDB or infra orchestrator.

No broad destructive changes; any write operations remain optional and gated.

Build the app end-to-end. If unspecified, choose sensible defaults and document them.
