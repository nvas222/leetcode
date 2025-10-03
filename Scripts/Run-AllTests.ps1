param(
    [switch]$Coverage
)

Write-Host "Running LeetCode Solutions Test Suite" -ForegroundColor Cyan
Write-Host "==============================================="

# Build the solution first
Write-Host "Building solution..." -ForegroundColor Yellow
$buildResult = dotnet build --configuration Release --verbosity quiet
if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed!" -ForegroundColor Red
    exit 1
}
Write-Host "Build successful" -ForegroundColor Green

# Run tests
Write-Host ""
Write-Host "Running tests..." -ForegroundColor Yellow

if ($Coverage) {
    Write-Host "Collecting code coverage..." -ForegroundColor Blue
    dotnet test --configuration Release --collect:"XPlat Code Coverage" --logger "console;verbosity=detailed"
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "Coverage report generated in TestResults folder" -ForegroundColor Green
    }
} else {
    dotnet test --configuration Release --logger "console;verbosity=detailed"
}

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "All tests passed!" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "Some tests failed!" -ForegroundColor Red
    exit 1
}

# Display test summary
Write-Host ""
Write-Host "Test Summary:" -ForegroundColor Cyan
$easyTests = Get-ChildItem -Path "LeetCodeSolutions.Tests\Easy\*.cs" -ErrorAction SilentlyContinue | Measure-Object | Select-Object -ExpandProperty Count
$mediumTests = Get-ChildItem -Path "LeetCodeSolutions.Tests\Medium\*.cs" -ErrorAction SilentlyContinue | Measure-Object | Select-Object -ExpandProperty Count
$hardTests = Get-ChildItem -Path "LeetCodeSolutions.Tests\Hard\*.cs" -ErrorAction SilentlyContinue | Measure-Object | Select-Object -ExpandProperty Count

Write-Host "   - Easy problems tested: $easyTests"
Write-Host "   - Medium problems tested: $mediumTests"
Write-Host "   - Hard problems tested: $hardTests"