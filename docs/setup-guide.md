# Setup Guide

This guide will help you set up your development environment for AI automation projects covered in the "Automate Your Workday with AI" session.

## Prerequisites

### System Requirements
- **Operating System**: Windows 10+, macOS 10.15+, or Linux
- **Memory**: 8GB RAM minimum (16GB recommended)
- **Storage**: 10GB free space
- **Network**: Stable internet connection for AI API calls

### Required Software
1. **Python 3.8+** or **Node.js 16+**
2. **Git** for version control
3. **Code Editor** (VS Code recommended)
4. **Package Manager** (pip for Python, npm for Node.js)

## Step 1: Install Python

### Windows
```bash
# Download from python.org or use Windows Store
# Verify installation
python --version
pip --version
```

### macOS
```bash
# Using Homebrew (recommended)
brew install python

# Verify installation
python3 --version
pip3 --version
```

### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install python3 python3-pip
python3 --version
pip3 --version
```

## Step 2: Install Node.js (Alternative)

### All Platforms
1. Download from [nodejs.org](https://nodejs.org/)
2. Install the LTS version
3. Verify installation:
```bash
node --version
npm --version
```

## Step 3: Code Editor Setup

### Visual Studio Code
1. Download from [code.visualstudio.com](https://code.visualstudio.com/)
2. Install recommended extensions:
   - Python (if using Python)
   - JavaScript (if using Node.js)
   - REST Client (for API testing)
   - GitLens (for Git integration)

### Extension Setup
```bash
# Python extensions
code --install-extension ms-python.python
code --install-extension ms-python.pylint

# General productivity
code --install-extension ms-vscode.vscode-json
code --install-extension davidanson.vscode-markdownlint
```

## Step 4: Virtual Environment

### Python Virtual Environment
```bash
# Create virtual environment
python -m venv ai-automation-env

# Activate environment
# Windows
ai-automation-env\Scripts\activate
# macOS/Linux
source ai-automation-env/bin/activate

# Verify activation
which python
```

### Node.js Project Setup
```bash
# Create new project
mkdir ai-automation-project
cd ai-automation-project
npm init -y

# Install common dependencies
npm install axios dotenv
npm install -D nodemon
```

## Step 5: AI Service Setup

### OpenAI API
1. Create account at [platform.openai.com](https://platform.openai.com/)
2. Generate API key
3. Set up environment variables:

```bash
# Create .env file
echo "OPENAI_API_KEY=your_api_key_here" > .env
```

### Azure OpenAI (Alternative)
1. Create Azure account
2. Create OpenAI resource
3. Configure environment:

```bash
echo "AZURE_OPENAI_API_KEY=your_key" >> .env
echo "AZURE_OPENAI_ENDPOINT=your_endpoint" >> .env
```

## Step 6: Install Common Dependencies

### Python Dependencies
```bash
# Install essential packages
pip install openai python-dotenv requests pandas

# Install additional AI libraries
pip install transformers langchain streamlit

# Save requirements
pip freeze > requirements.txt
```

### Node.js Dependencies
```bash
# Install AI and utility packages
npm install openai dotenv axios express

# Install development tools
npm install -D jest eslint prettier
```

## Step 7: Test Your Setup

### Python Test
Create `test_setup.py`:
```python
import os
from dotenv import load_dotenv
import openai

load_dotenv()

# Test environment variable
api_key = os.getenv('OPENAI_API_KEY')
if api_key:
    print("✅ Environment variables loaded")
else:
    print("❌ API key not found")

# Test API connection (optional)
try:
    client = openai.OpenAI()
    response = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=[{"role": "user", "content": "Hello, World!"}],
        max_tokens=10
    )
    print("✅ API connection successful")
except Exception as e:
    print(f"❌ API connection failed: {e}")
```

### Node.js Test
Create `test-setup.js`:
```javascript
require('dotenv').config();
const OpenAI = require('openai');

// Test environment variable
const apiKey = process.env.OPENAI_API_KEY;
if (apiKey) {
    console.log('✅ Environment variables loaded');
} else {
    console.log('❌ API key not found');
}

// Test API connection (optional)
async function testAPI() {
    try {
        const openai = new OpenAI();
        const response = await openai.chat.completions.create({
            model: 'gpt-3.5-turbo',
            messages: [{ role: 'user', content: 'Hello, World!' }],
            max_tokens: 10
        });
        console.log('✅ API connection successful');
    } catch (error) {
        console.log(`❌ API connection failed: ${error.message}`);
    }
}

testAPI();
```

## Step 8: Security Best Practices

### Environment Variables
- Never commit API keys to version control
- Use `.env` files for local development
- Use environment variables in production
- Add `.env` to `.gitignore`

### API Key Management
```bash
# Add to .gitignore
echo ".env" >> .gitignore
echo "__pycache__/" >> .gitignore
echo "node_modules/" >> .gitignore
```

## Troubleshooting

### Common Issues

**Python not found**
- Ensure Python is in your PATH
- Try `python3` instead of `python`

**Permission errors**
- Use virtual environments
- On macOS/Linux, may need `sudo` for global installs

**API connection fails**
- Check API key format
- Verify internet connection
- Check service status pages

**Import errors**
- Ensure virtual environment is activated
- Reinstall packages if needed

### Getting Help
- Check error messages carefully
- Search documentation for specific errors
- Use community forums and Stack Overflow
- Ask questions during the conference session

## Next Steps

With your environment set up, you're ready to:
1. Explore the code samples in this repository
2. Run the demo applications
3. Build your own automation projects
4. Experiment with different AI services

## Additional Resources

- [Python Virtual Environments Guide](https://docs.python.org/3/tutorial/venv.html)
- [Node.js Best Practices](https://nodejs.dev/en/learn/)
- [VS Code Python Tutorial](https://code.visualstudio.com/docs/python/python-tutorial)
- [OpenAI API Documentation](https://platform.openai.com/docs)