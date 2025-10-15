param(
    [Parameter(Mandatory = $false)]
    [string]$ArtifactsInput
)

Write-Host "🔧 Processing artifact IDs..." -ForegroundColor Cyan

$formattedArtifacts = ""

if (-not [string]::IsNullOrWhiteSpace($ArtifactsInput)) {
    Write-Host "📦 Input received: $ArtifactsInput" -ForegroundColor Yellow
    
    # Check if input is JSON array format
    try {
        $jsonTest = $ArtifactsInput | ConvertFrom-Json -ErrorAction Stop
        if ($jsonTest -is [array]) {
            Write-Host "✅ Detected JSON array format" -ForegroundColor Green
            # Process JSON array - convert to formatted list
            $formattedArtifacts = ($jsonTest | ForEach-Object { "• $_" }) -join "`n"
        } else {
            throw "Not an array"
        }
    } catch {
        Write-Host "📦 Not JSON array format, trying other formats..." -ForegroundColor Yellow
        
        # Fallback: treat as single string or comma-delimited
        if ($ArtifactsInput.Contains(",")) {
            Write-Host "✅ Detected comma-delimited format" -ForegroundColor Green
            # Comma-delimited - convert to list format
            $artifactArray = $ArtifactsInput -split "," | ForEach-Object { $_.Trim() }
            $formattedArtifacts = ($artifactArray | ForEach-Object { "• $_" }) -join "`n"
        } else {
            Write-Host "✅ Detected single artifact format" -ForegroundColor Green
            # Single artifact
            $formattedArtifacts = "• $ArtifactsInput"
        }
    }
    
    Write-Host "📋 Formatted artifacts:" -ForegroundColor Cyan
    Write-Host $formattedArtifacts -ForegroundColor White
} else {
    Write-Host "ℹ️ No artifacts provided" -ForegroundColor Yellow
}

# Output for GitHub Actions
if ($env:GITHUB_OUTPUT) {
    $outputContent = @"
artifacts-formatted<<EOF
$formattedArtifacts
EOF
"@
    Add-Content -Path $env:GITHUB_OUTPUT -Value $outputContent
    Write-Host "✅ Output written to GITHUB_OUTPUT" -ForegroundColor Green
} else {
    Write-Host "⚠️ GITHUB_OUTPUT not set, running in test mode" -ForegroundColor Yellow
    Write-Host "Output would be:" -ForegroundColor Cyan
    Write-Host $formattedArtifacts -ForegroundColor White
}

Write-Host "✅ Artifact processing completed" -ForegroundColor Green