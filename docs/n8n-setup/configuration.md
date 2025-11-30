# n8n Configuration Guide

This guide covers how to configure n8n for your automation needs.

## Environment Variables

n8n uses environment variables for configuration. You can set these before starting n8n or in a `.env` file.

### Essential Configuration

```bash
# Basic Authentication
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=your_secure_password

# Host and Port
N8N_HOST=localhost
N8N_PORT=5678

# Protocol (http or https)
N8N_PROTOCOL=http

# Timezone
GENERIC_TIMEZONE=America/Chicago
```

### Security Settings

```bash
# Encryption key for credentials (generate a random string)
N8N_ENCRYPTION_KEY=your_random_encryption_key

# Disable public API
N8N_PUBLIC_API_DISABLED=false

# IP addresses allowed to access the editor (comma-separated)
# N8N_EDITOR_ALLOWED_IPS=127.0.0.1,192.168.1.100
```

### Database Configuration

By default, n8n uses SQLite. For production, consider PostgreSQL:

```bash
# PostgreSQL Configuration
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=localhost
DB_POSTGRESDB_PORT=5432
DB_POSTGRESDB_DATABASE=n8n
DB_POSTGRESDB_USER=n8n
DB_POSTGRESDB_PASSWORD=your_password
```

## Connecting to AI Services

### OpenAI Integration

To use OpenAI in your n8n workflows:

1. **Get your API key** from [platform.openai.com](https://platform.openai.com/)

2. **Add credentials in n8n:**
   - Go to Settings → Credentials
   - Click "Add Credential"
   - Search for "OpenAI"
   - Enter your API key

3. **Use in workflows:**
   - Add an "OpenAI" node to your workflow
   - Select your credential
   - Configure the model and prompts

### Azure OpenAI Integration

For Azure OpenAI:

1. Create an OpenAI resource in Azure Portal
2. Get your endpoint and API key
3. Add Azure OpenAI credentials in n8n
4. Configure with your deployment name

## Workflow Settings

### Execution Settings

```bash
# Maximum execution time (in seconds)
EXECUTIONS_TIMEOUT=3600

# Maximum data per execution
EXECUTIONS_DATA_MAX_AGE=336

# Save execution data
EXECUTIONS_DATA_SAVE_ON_ERROR=all
EXECUTIONS_DATA_SAVE_ON_SUCCESS=all
EXECUTIONS_DATA_SAVE_MANUAL_EXECUTIONS=true
```

### Webhook Configuration

If using webhooks:

```bash
# Webhook URL (for production)
WEBHOOK_URL=https://your-domain.com/

# Webhook tunnel (for development)
N8N_TUNNEL_ENABLED=true
```

## Local Development Tips

### Starting n8n with Environment Variables

**Using npm:**
```bash
export N8N_BASIC_AUTH_ACTIVE=true
export N8N_BASIC_AUTH_USER=admin
export N8N_BASIC_AUTH_PASSWORD=password
n8n start
```

**Using a .env file:**

Create a `.env` file in your n8n directory:
```bash
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=password
```

### Development Mode

For development with automatic reload:
```bash
n8n start --tunnel
```

## Importing Workflows

To import workflow JSON files (like our Daily Handoff example):

1. Open n8n in your browser
2. Click on the "Workflows" menu
3. Click "Import from File"
4. Select the JSON workflow file
5. The workflow will be imported and ready to configure

Our n8n workflow examples are located in:
- [code-samples/n8n/](../../code-samples/n8n/)
- [Daily Handoff Project](../../code-samples/n8n/daily-handoff/)

## Troubleshooting

### Common Issues

**Port already in use:**
```bash
n8n start --port 5679
```

**Database connection errors:**
- Verify database credentials
- Ensure the database server is running
- Check network connectivity

**Credential errors:**
- Verify API keys are correct
- Check for trailing whitespace in credentials
- Ensure service accounts have proper permissions

## Next Steps

1. Explore the [n8n workflow examples](../../code-samples/n8n/)
2. Try the [Daily Handoff project](../../code-samples/n8n/daily-handoff/)
3. Visit the [n8n Community](https://community.n8n.io/) for more examples

## Additional Resources

- [n8n Environment Variables Reference](https://docs.n8n.io/hosting/configuration/environment-variables/)
- [n8n Credentials Documentation](https://docs.n8n.io/credentials/)
- [n8n Community Nodes](https://docs.n8n.io/integrations/community-nodes/)
