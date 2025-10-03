param(
    [Parameter(Mandatory=$true)]
    [int]$ProblemNumber,
    
    [Parameter(Mandatory=$true)]
    [string]$Title,
    
    [Parameter(Mandatory=$true)]
    [ValidateSet("Easy", "Medium", "Hard")]
    [string]$Difficulty
)

# Convert title to PascalCase class name
$ClassName = ($Title -replace '\W', '') -replace '\s+', ''
$SafeTitle = $Title -replace '[^\w\s]', ''

# Determine the folder path based on difficulty
$SolutionFolder = "LeetCodeSolutions.Core\$Difficulty"
$TestFolder = "LeetCodeSolutions.Tests\$Difficulty"

# Create solution file content
$SolutionContent = @"
using LeetCodeSolutions.Core.Common;

namespace LeetCodeSolutions.Core.$Difficulty;

/// <summary>
/// LeetCode Problem #$ProblemNumber`: $SafeTitle
/// TODO: Add problem description here
/// </summary>
public class $ClassName : ISolution
{
    /// <inheritdoc/>
    public int ProblemNumber => $ProblemNumber;
    
    /// <inheritdoc/>
    public string Title => "$SafeTitle";
    
    /// <inheritdoc/>
    public Difficulty Difficulty => Difficulty.$Difficulty;
    
    /// <inheritdoc/>
    public string Description => "TODO: Add solution approach description";
    
    /// <inheritdoc/>
    public string TimeComplexity => "TODO: Add time complexity";
    
    /// <inheritdoc/>
    public string SpaceComplexity => "TODO: Add space complexity";

    /// <summary>
    /// TODO: Add method description
    /// </summary>
    /// <param name="input">TODO: Describe parameter</param>
    /// <returns>TODO: Describe return value</returns>
    public object SolutionMethod(object input)
    {
        // TODO: Implement solution
        throw new NotImplementedException();
    }
}
"@

# Create test file content
$TestContent = @"
using LeetCodeSolutions.Core.$Difficulty;

namespace LeetCodeSolutions.Tests.$Difficulty;

public class $($ClassName)Tests
{
    private readonly $ClassName _solution;

    public $($ClassName)Tests()
    {
        _solution = new $ClassName();
    }

    [Fact]
    public void SolutionMethod_ValidInput_ReturnsExpected()
    {
        // Arrange
        // TODO: Set up test data
        
        // Act
        // TODO: Call the method under test
        
        // Assert
        // TODO: Verify the result
        Assert.True(false, "TODO: Implement test");
    }

    [Fact]
    public void SolutionMetadata_ReturnsCorrectValues()
    {
        // Assert
        Assert.Equal($ProblemNumber, _solution.ProblemNumber);
        Assert.Equal("$SafeTitle", _solution.Title);
        Assert.Equal(LeetCodeSolutions.Core.Common.Difficulty.$Difficulty, _solution.Difficulty);
        Assert.NotEmpty(_solution.Description);
        Assert.NotEmpty(_solution.TimeComplexity);
        Assert.NotEmpty(_solution.SpaceComplexity);
    }
}
"@

# Create the files
$SolutionFilePath = "$SolutionFolder\$ClassName.cs"
$TestFilePath = "$TestFolder\$($ClassName)Tests.cs"

try {
    # Ensure directories exist
    if (!(Test-Path $SolutionFolder)) {
        New-Item -Path $SolutionFolder -ItemType Directory -Force | Out-Null
    }
    if (!(Test-Path $TestFolder)) {
        New-Item -Path $TestFolder -ItemType Directory -Force | Out-Null
    }

    # Create files
    Set-Content -Path $SolutionFilePath -Value $SolutionContent -Encoding UTF8
    Set-Content -Path $TestFilePath -Value $TestContent -Encoding UTF8

    Write-Host "✅ Created solution template:" -ForegroundColor Green
    Write-Host "   📄 $SolutionFilePath" -ForegroundColor Gray
    Write-Host "   🧪 $TestFilePath" -ForegroundColor Gray
    Write-Host ""
    Write-Host "📝 Next steps:" -ForegroundColor Yellow
    Write-Host "   1. Implement the solution method in $ClassName.cs"
    Write-Host "   2. Add comprehensive tests in $($ClassName)Tests.cs"
    Write-Host "   3. Update the README.md progress section"
    Write-Host "   4. Commit your changes to Git"
}
catch {
    Write-Error "❌ Failed to create files: $_"
}
"@