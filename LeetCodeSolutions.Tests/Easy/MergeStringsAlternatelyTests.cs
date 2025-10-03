using LeetCodeSolutions.Core.Easy;

namespace LeetCodeSolutions.Tests.Easy;

public class MergeStringsAlternatelyTests
{
    private readonly MergeStringsAlternately _solution;

    public MergeStringsAlternatelyTests()
    {
        _solution = new MergeStringsAlternately();
    }
    [Theory]
    [InlineData("abc", "pqr", "apbqcr")]
    [InlineData("ab", "pqrs", "apbqrs")]
    [InlineData("abcd", "pq", "apbqcd")]
    public void MergeAlternately_ValidInput_ReturnsMergedString(string word1, string word2, string expected)
    {
        // Act
        var result = _solution.MergeStringsAlternatelySolution(word1, word2);
        // Assert
        Assert.Equal(expected, result);
    }
    [Fact]
    public void SolutionMethod_ValidInput_ReturnsExpected()
    {
        // Arrange
        var input = new { Word1= "abc", Word2 = "pqr" };
        var expected = "apbqcr";

        // Act
        var result = _solution.MergeStringsAlternatelySolution(input.Word1, input.Word2);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void SolutionMetadata_ReturnsCorrectValues()
    {
        // Assert
        Assert.Equal(1768, _solution.ProblemNumber);
        Assert.Equal("MergeStringsAlternately", _solution.Title);
        Assert.Equal(LeetCodeSolutions.Core.Common.Difficulty.Easy, _solution.Difficulty);
        Assert.NotEmpty(_solution.Description);
        Assert.NotEmpty(_solution.TimeComplexity);
        Assert.NotEmpty(_solution.SpaceComplexity);
    }
}
