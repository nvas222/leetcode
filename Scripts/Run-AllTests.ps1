param(
    [switch]$Coverage
)

Write-Host "🧪 Running LeetCode Solutions Test Suite" -ForegroundColor Cyan
Write-Host "=" * 50

# Build the solution first
Write-Host "🔨 Building solution..." -ForegroundColor Yellow
$buildResult = dotnet build --configuration Release --verbosity quiet
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Build failed!" -ForegroundColor Red
    exit 1
}
Write-Host "✅ Build successful" -ForegroundColor Green

# Run tests
Write-Host "`n🏃 Running tests..." -ForegroundColor Yellow

if ($Coverage) {
    Write-Host "📊 Collecting code coverage..." -ForegroundColor Blue
    dotnet test --configuration Release --collect:"XPlat Code Coverage" --logger "console;verbosity=detailed"
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "`n📈 Coverage report generated in TestResults folder" -ForegroundColor Green
    }
} else {
    dotnet test --configuration Release --logger "console;verbosity=detailed"
}

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n✅ All tests passed!" -ForegroundColor Green
} else {
    Write-Host "`n❌ Some tests failed!" -ForegroundColor Red
    exit 1
}

# Display test summary
Write-Host "`n📊 Test Summary:" -ForegroundColor Cyan
Write-Host "   - Easy problems tested: $(Get-ChildItem -Path "LeetCodeSolutions.Tests\Easy\*.cs" | Measure-Object | Select-Object -ExpandProperty Count)"
Write-Host "   - Medium problems tested: $(Get-ChildItem -Path "LeetCodeSolutions.Tests\Medium\*.cs" | Measure-Object | Select-Object -ExpandProperty Count)"
Write-Host "   - Hard problems tested: $(Get-ChildItem -Path "LeetCodeSolutions.Tests\Hard\*.cs" | Measure-Object | Select-Object -ExpandProperty Count)"