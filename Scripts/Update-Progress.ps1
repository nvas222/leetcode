Write-Host "📊 Updating LeetCode Progress Statistics" -ForegroundColor Cyan
Write-Host "=" * 45

try {
    # Count solutions by difficulty
    $easySolutions = @(Get-ChildItem -Path "LeetCodeSolutions.Core\Easy\*.cs" -Exclude "*ISolution*", "*Difficulty*" | Where-Object { $_.BaseName -ne "ISolution" -and $_.BaseName -ne "Difficulty" })
    $mediumSolutions = @(Get-ChildItem -Path "LeetCodeSolutions.Core\Medium\*.cs" -ErrorAction SilentlyContinue)
    $hardSolutions = @(Get-ChildItem -Path "LeetCodeSolutions.Core\Hard\*.cs" -ErrorAction SilentlyContinue)

    $easyCount = $easySolutions.Count
    $mediumCount = $mediumSolutions.Count
    $hardCount = $hardSolutions.Count
    $totalCount = $easyCount + $mediumCount + $hardCount

    Write-Host "📈 Current Statistics:" -ForegroundColor Green
    Write-Host "   Easy: $easyCount solved"
    Write-Host "   Medium: $mediumCount solved" 
    Write-Host "   Hard: $hardCount solved"
    Write-Host "   Total: $totalCount solved"

    # Read current README
    $readmePath = "README.md"
    if (!(Test-Path $readmePath)) {
        Write-Error "README.md not found!"
        exit 1
    }

    $readmeContent = Get-Content $readmePath -Raw

    # Update statistics section
    $statisticsPattern = "### Statistics.*?(?=### |\z)"
    $newStatistics = @"
### Statistics
- **Total Solved**: $totalCount
- **Easy**: $easyCount/1963 ($([math]::Round($easyCount/1963*100, 2))%)
- **Medium**: $mediumCount/1569 ($([math]::Round($mediumCount/1569*100, 2))%)
- **Hard**: $hardCount/665 ($([math]::Round($hardCount/665*100, 2))%)
"@

    $updatedContent = $readmeContent -replace $statisticsPattern, $newStatistics, "Singleline"

    # Update the last updated date
    $datePattern = "\*Last Updated:.*?\*"
    $newDate = "*Last Updated: $(Get-Date -Format 'MMMM d, yyyy')*"
    $updatedContent = $updatedContent -replace $datePattern, $newDate

    # Write back to README
    Set-Content -Path $readmePath -Value $updatedContent -Encoding UTF8

    Write-Host "✅ README.md updated successfully!" -ForegroundColor Green
    Write-Host "📝 Remember to commit your changes to Git" -ForegroundColor Yellow
}
catch {
    Write-Error "❌ Failed to update progress: $_"
    exit 1
}
"@