[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
Write-Host "Updating LeetCode Progress Statistics" -ForegroundColor Cyan
Write-Host ("=" * 45)

try {
    # Count solutions by difficulty
    $easySolutions = @(Get-ChildItem -Path "LeetCodeSolutions.Core\Easy\*.cs" -ErrorAction SilentlyContinue | Where-Object { $_.BaseName -notmatch '^(ISolution|Difficulty)$' })
    $mediumSolutions = @(Get-ChildItem -Path "LeetCodeSolutions.Core\Medium\*.cs" -ErrorAction SilentlyContinue | Where-Object { $_.BaseName -notmatch '^(ISolution|Difficulty)$' })
    $hardSolutions = @(Get-ChildItem -Path "LeetCodeSolutions.Core\Hard\*.cs" -ErrorAction SilentlyContinue | Where-Object { $_.BaseName -notmatch '^(ISolution|Difficulty)$' })

    $easyCount = $easySolutions.Count
    $mediumCount = $mediumSolutions.Count
    $hardCount = $hardSolutions.Count
    $totalCount = $easyCount + $mediumCount + $hardCount

    Write-Host "Current Statistics:" -ForegroundColor Green
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

    # Read with correct encoding
    $readmeContent = Get-Content $readmePath -Raw -Encoding UTF8

    # Update statistics section
    $statisticsPattern = '(?s)### Statistics\s*?\r?\n.*?(?=\r?\n###|$)'
    $newStatistics = @"
### Statistics
- **Total Solved**: $totalCount
- **Easy**: $easyCount/1963 ($([math]::Round($easyCount/1963*100, 2))%)
- **Medium**: $mediumCount/1569 ($([math]::Round($mediumCount/1569*100, 2))%)
- **Hard**: $hardCount/665 ($([math]::Round($hardCount/665*100, 2))%)
"@

    # Update content
    $updatedContent = $readmeContent -replace $statisticsPattern, $newStatistics

    # Update the last updated date
    $datePattern = '\*Last Updated:.*?\*'
    $newDate = "*Last Updated: $(Get-Date -Format 'MMMM d, yyyy')*"
    $updatedContent = $updatedContent -replace $datePattern, $newDate

    # Write back to README with UTF8 encoding
    [System.IO.File]::WriteAllText($readmePath, $updatedContent, [System.Text.Encoding]::UTF8)

    Write-Host "README.md updated successfully!" -ForegroundColor Green
    Write-Host "Remember to commit your changes to Git" -ForegroundColor Yellow
}
catch {
    $errorMessage = $_ | Format-List * | Out-String
    Write-Error "Failed to update progress: $_"
    Write-Error "Error Details: $errorMessage"
    exit 1
}