# PowerShell Module Requirements
# For AI automation samples in this repository
#
# This file documents the requirements for running the PowerShell examples.
# Unlike Python (pip) or Node.js (npm), PowerShell dependencies are typically
# system requirements or modules installed via PowerShellGet.

# =============================================================================
# POWERSHELL VERSION REQUIREMENTS
# =============================================================================
#
# IMPORTANT: Use PowerShell 7+ (pwsh), NOT Windows PowerShell 5.1 (powershell)
#
# PowerShell 7+ (pwsh) provides:
# - Cross-platform support (Windows, macOS, Linux)
# - Modern .NET runtime
# - Better performance
# - Improved compatibility with REST APIs
# - Pipeline parallelization
# - Ternary operators and null coalescing
#
# To install PowerShell 7:
#   Windows:  winget install Microsoft.PowerShell
#   macOS:    brew install powershell
#   Linux:    See https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-linux
#
# Verify your version:
#   pwsh -v
#
# Minimum required version: 7.0.0
# Recommended version: 7.4.0 or later

# =============================================================================
# REQUIRED MODULES
# =============================================================================

# No additional modules required for basic examples
# The scripts use built-in cmdlets:
# - Invoke-RestMethod (for API calls)
# - ConvertTo-Json / ConvertFrom-Json (for JSON handling)
# - Test-Path, Get-Content (for file operations)

# =============================================================================
# OPTIONAL MODULES (for extended functionality)
# =============================================================================

# Microsoft.PowerShell.SecretManagement - For secure credential storage
# Install: Install-Module -Name Microsoft.PowerShell.SecretManagement -Scope CurrentUser

# Microsoft.PowerShell.SecretStore - Secret vault provider
# Install: Install-Module -Name Microsoft.PowerShell.SecretStore -Scope CurrentUser

# PSReadLine - Enhanced command-line editing (usually pre-installed in PS7)
# Install: Install-Module -Name PSReadLine -Scope CurrentUser -Force

# =============================================================================
# ENVIRONMENT SETUP
# =============================================================================

# Create a .env file in the same directory as your script:
#
# OPENAI_API_KEY=your-api-key-here
# AZURE_OPENAI_KEY=your-azure-key-here
# AZURE_OPENAI_ENDPOINT=https://your-resource.openai.azure.com/

# =============================================================================
# EXECUTION POLICY (Windows)
# =============================================================================

# You may need to adjust the execution policy to run scripts:
#   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# =============================================================================
# QUICK START
# =============================================================================

# 1. Install PowerShell 7+ (see instructions above)
# 2. Create .env file with your API key
# 3. Run: pwsh AI-MeetingScheduler.ps1
