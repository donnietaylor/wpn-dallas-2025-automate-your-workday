#!/usr/bin/env pwsh
<#
.SYNOPSIS
    AI Meeting Scheduler

.DESCRIPTION
    This script demonstrates how to use AI to automatically analyze meeting requests
    and suggest optimal scheduling based on context and availability patterns.

.NOTES
    Requirements:
    - PowerShell 7.0 or later (pwsh)
    - OpenAI API key

.EXAMPLE
    pwsh AI-MeetingScheduler.ps1
#>

#Requires -Version 7.0

using namespace System.Collections.Generic

# Load environment variables from .env file
function Import-DotEnv {
    <#
    .SYNOPSIS
        Load environment variables from a .env file
    #>
    param(
        [string]$Path = ".env"
    )
    
    if (Test-Path $Path) {
        Get-Content $Path | ForEach-Object {
            if ($_ -match '^\s*([^#][^=]+)=(.*)$') {
                $key = $matches[1].Trim()
                $value = $matches[2].Trim().Trim('"').Trim("'")
                [Environment]::SetEnvironmentVariable($key, $value, "Process")
            }
        }
    }
}

class MeetingScheduler {
    <#
    .SYNOPSIS
        AI-powered meeting scheduling assistant
    #>
    
    [string]$ApiKey
    [string]$BaseUrl
    [hashtable]$PriorityLevels
    
    MeetingScheduler([string]$apiKey = $null) {
        # Load from environment if not provided
        Import-DotEnv
        $this.ApiKey = if ($apiKey) { $apiKey } else { $env:OPENAI_API_KEY }
        $this.BaseUrl = "https://api.openai.com/v1/chat/completions"
        
        # Define priority levels for scheduling
        $this.PriorityLevels = @{
            "urgent"    = 1
            "high"      = 2
            "normal"    = 3
            "low"       = 4
            "flexible"  = 5
        }
    }
    
    [hashtable] AnalyzeMeetingRequest([string]$requestText, [string]$currentSchedule) {
        <#
        .SYNOPSIS
            Analyze a meeting request and suggest scheduling options
        .PARAMETER requestText
            The meeting request text to analyze
        .PARAMETER currentSchedule
            Current schedule context for optimal suggestions
        #>
        
        try {
            $prompt = $this.CreateAnalysisPrompt($requestText, $currentSchedule)
            
            $body = @{
                model = "gpt-3.5-turbo"
                messages = @(
                    @{
                        role = "system"
                        content = "You are an expert meeting scheduler and time management assistant."
                    }
                    @{
                        role = "user"
                        content = $prompt
                    }
                )
                max_tokens = 300
                temperature = 0.3
            } | ConvertTo-Json -Depth 10
            
            $headers = @{
                "Authorization" = "Bearer $($this.ApiKey)"
                "Content-Type" = "application/json"
            }
            
            $response = Invoke-RestMethod -Uri $this.BaseUrl -Method Post -Headers $headers -Body $body
            $analysis = $response.choices[0].message.content.Trim()
            
            return $this.ParseAnalysisResponse($analysis)
        }
        catch {
            return @{
                Success = $false
                Error = $_.Exception.Message
                Priority = "unknown"
                Duration = "unknown"
                SuggestedTimes = @()
                Reasoning = "Analysis failed due to error"
            }
        }
    }
    
    hidden [string] CreateAnalysisPrompt([string]$requestText, [string]$currentSchedule) {
        $prompt = @"
Please analyze the following meeting request and suggest optimal scheduling:

Meeting Request:
$requestText

Current Schedule Context:
$currentSchedule

Respond in the following format:
Priority: [urgent/high/normal/low/flexible]
Estimated Duration: [duration in minutes]
Suggested Times: [comma-separated time slots]
Participants Needed: [key participants]
Preparation Required: [any prep work needed]
Reasoning: [brief explanation]
"@
        return $prompt
    }
    
    hidden [hashtable] ParseAnalysisResponse([string]$response) {
        try {
            $lines = $response -split "`n"
            $result = @{
                Success = $true
                Priority = "normal"
                Duration = "30"
                SuggestedTimes = @()
                Participants = @()
                Preparation = ""
                Reasoning = ""
            }
            
            foreach ($line in $lines) {
                if ($line -match '^Priority:\s*(.+)$') {
                    $result.Priority = $matches[1].Trim().ToLower()
                }
                elseif ($line -match '^Estimated Duration:\s*(.+)$') {
                    $result.Duration = $matches[1].Trim()
                }
                elseif ($line -match '^Suggested Times:\s*(.+)$') {
                    $result.SuggestedTimes = ($matches[1] -split ',') | ForEach-Object { $_.Trim() }
                }
                elseif ($line -match '^Participants Needed:\s*(.+)$') {
                    $result.Participants = ($matches[1] -split ',') | ForEach-Object { $_.Trim() }
                }
                elseif ($line -match '^Preparation Required:\s*(.+)$') {
                    $result.Preparation = $matches[1].Trim()
                }
                elseif ($line -match '^Reasoning:\s*(.+)$') {
                    $result.Reasoning = $matches[1].Trim()
                }
            }
            
            return $result
        }
        catch {
            return @{
                Success = $false
                Error = "Failed to parse response: $($_.Exception.Message)"
                Priority = "unknown"
                Duration = "unknown"
                SuggestedTimes = @()
                Reasoning = "Response parsing failed"
            }
        }
    }
    
    [List[hashtable]] AnalyzeBatch([array]$meetingRequests, [string]$currentSchedule) {
        <#
        .SYNOPSIS
            Analyze multiple meeting requests in batch
        .PARAMETER meetingRequests
            Array of meeting request strings
        .PARAMETER currentSchedule
            Current schedule context
        #>
        
        $results = [List[hashtable]]::new()
        
        foreach ($request in $meetingRequests) {
            $result = $this.AnalyzeMeetingRequest($request, $currentSchedule)
            $result.OriginalRequest = $request.Substring(0, [Math]::Min(50, $request.Length)) + "..."
            $results.Add($result)
            
            # Small delay to avoid rate limiting
            Start-Sleep -Milliseconds 500
        }
        
        return $results
    }
    
    [hashtable] SuggestOptimalTime([array]$meetings, [string]$preferences) {
        <#
        .SYNOPSIS
            Suggest optimal meeting times based on analyzed meetings and preferences
        #>
        
        try {
            $meetingsJson = $meetings | ConvertTo-Json -Compress
            
            $prompt = @"
Based on the following analyzed meetings and user preferences, suggest an optimal schedule:

Meetings to Schedule:
$meetingsJson

User Preferences:
$preferences

Provide:
1. Optimal order for meetings
2. Suggested time blocks
3. Buffer time recommendations
4. Conflict resolution suggestions
"@
            
            $body = @{
                model = "gpt-3.5-turbo"
                messages = @(
                    @{
                        role = "system"
                        content = "You are an expert calendar optimizer."
                    }
                    @{
                        role = "user"
                        content = $prompt
                    }
                )
                max_tokens = 400
                temperature = 0.4
            } | ConvertTo-Json -Depth 10
            
            $headers = @{
                "Authorization" = "Bearer $($this.ApiKey)"
                "Content-Type" = "application/json"
            }
            
            $response = Invoke-RestMethod -Uri $this.BaseUrl -Method Post -Headers $headers -Body $body
            
            return @{
                Success = $true
                Recommendations = $response.choices[0].message.content.Trim()
            }
        }
        catch {
            return @{
                Success = $false
                Error = $_.Exception.Message
                Recommendations = ""
            }
        }
    }
}

function Main {
    <#
    .SYNOPSIS
        Example usage of the MeetingScheduler
    #>
    
    Write-Host "🤖 AI Meeting Scheduler Demo" -ForegroundColor Cyan
    Write-Host ("=" * 50)
    
    # Sample meeting requests for demonstration
    $sampleMeetings = @(
        "URGENT: Need to discuss the production outage with the DevOps team. System is down and customers are affected. Need all hands on deck.",
        "Hi, I'd like to schedule a 1:1 to discuss my career development and upcoming goals for Q2. Flexible on timing.",
        "Project kickoff meeting needed for the new mobile app. Need product, design, and engineering leads. About 2 hours for planning.",
        "Quick sync needed with marketing team about the upcoming product launch messaging. 30 minutes should be enough."
    )
    
    $currentSchedule = @"
Monday: Team standup 9-9:30 AM, Lunch 12-1 PM
Tuesday: Product review 2-3 PM
Wednesday: All-hands meeting 10-11 AM
Thursday: Open
Friday: Sprint planning 11 AM-12 PM, No meetings after 3 PM
"@
    
    # Initialize scheduler
    $scheduler = [MeetingScheduler]::new()
    
    Write-Host "`n📅 Analyzing meeting requests..." -ForegroundColor Yellow
    Write-Host ("-" * 50)
    
    # Analyze each meeting
    $index = 1
    foreach ($meeting in $sampleMeetings) {
        Write-Host "`n📧 Meeting Request $index`:" -ForegroundColor Green
        Write-Host "Request: $($meeting.Substring(0, [Math]::Min(80, $meeting.Length)))..."
        
        $result = $scheduler.AnalyzeMeetingRequest($meeting, $currentSchedule)
        
        if ($result.Success) {
            Write-Host "✅ Priority: $($result.Priority)" -ForegroundColor White
            Write-Host "⏱️  Duration: $($result.Duration)" -ForegroundColor White
            Write-Host "📍 Suggested Times: $($result.SuggestedTimes -join ', ')" -ForegroundColor White
            Write-Host "👥 Participants: $($result.Participants -join ', ')" -ForegroundColor White
            Write-Host "💭 Reasoning: $($result.Reasoning)" -ForegroundColor Gray
        }
        else {
            Write-Host "❌ Error: $($result.Error)" -ForegroundColor Red
        }
        
        Write-Host ("-" * 50)
        $index++
    }
    
    # Batch analysis example
    Write-Host "`n🔄 Batch Analysis Complete" -ForegroundColor Cyan
    $batchResults = $scheduler.AnalyzeBatch($sampleMeetings, $currentSchedule)
    
    Write-Host "`n📊 Summary by Priority:" -ForegroundColor Yellow
    $batchResults | Group-Object { $_.Priority } | ForEach-Object {
        Write-Host "  $($_.Name): $($_.Count) meeting(s)"
    }
    
    # Optimization suggestions
    Write-Host "`n🎯 Getting optimization suggestions..." -ForegroundColor Yellow
    $preferences = "Prefer morning meetings, need 15-min breaks between meetings, no back-to-back urgent meetings"
    
    $optimization = $scheduler.SuggestOptimalTime($batchResults, $preferences)
    
    if ($optimization.Success) {
        Write-Host "`n📋 Schedule Optimization Recommendations:" -ForegroundColor Green
        Write-Host $optimization.Recommendations
    }
    else {
        Write-Host "❌ Optimization failed: $($optimization.Error)" -ForegroundColor Red
    }
}

# Run the demo if script is executed directly
if ($MyInvocation.InvocationName -ne '.') {
    Main
}
