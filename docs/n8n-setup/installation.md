# n8n Installation Guide

This guide walks you through installing n8n on your local machine.

## Installation Methods

n8n can be installed in several ways:

1. [npm (Node.js)](#npm-installation) - Recommended for developers
2. [Docker](#docker-installation) - Recommended for production/isolated environments
3. [Desktop App](#desktop-app) - Easiest for beginners

---

## npm Installation

### Prerequisites

- Node.js 18 or newer
- npm (comes with Node.js)

### Steps

1. **Install n8n globally:**

```bash
npm install n8n -g
```

2. **Start n8n:**

```bash
n8n start
```

3. **Access n8n:**

Open your browser and navigate to: `http://localhost:5678`

### Troubleshooting npm Installation

**Permission errors on macOS/Linux:**
```bash
sudo npm install n8n -g
```

Or better, configure npm to use a different directory:
```bash
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
npm install n8n -g
```

---

## Docker Installation

### Prerequisites

- Docker installed and running
- Docker Compose (optional, but recommended)

### Quick Start with Docker

```bash
docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n \
  docker.n8n.io/n8nio/n8n
```

### Docker Compose Setup

Create a `docker-compose.yml` file:

```yaml
version: '3.8'

services:
  n8n:
    image: docker.n8n.io/n8nio/n8n
    container_name: n8n
    ports:
      - "5678:5678"
    environment:
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=changeme
    volumes:
      - n8n_data:/home/node/.n8n
    restart: unless-stopped

volumes:
  n8n_data:
```

Start the container:

```bash
docker-compose up -d
```

Access n8n at: `http://localhost:5678`

---

## Desktop App

For the easiest installation experience, download the n8n Desktop App:

1. Visit [n8n.io/get-started](https://n8n.io/get-started)
2. Download the version for your operating system
3. Install and run the application
4. n8n will open in your default browser

---

## Verifying Installation

After installation, verify n8n is running:

1. Open `http://localhost:5678` in your browser
2. You should see the n8n welcome screen
3. Create an account to get started

## Next Steps

Once n8n is installed:

1. Read the [Configuration Guide](configuration.md) to customize your setup
2. Explore our [n8n workflow examples](../../code-samples/n8n/)
3. Check out the [Daily Handoff project](../../code-samples/n8n/daily-handoff/)

## Additional Resources

- [n8n Official Documentation](https://docs.n8n.io/)
- [n8n Installation Docs](https://docs.n8n.io/hosting/)
- [n8n Community Forum](https://community.n8n.io/)
