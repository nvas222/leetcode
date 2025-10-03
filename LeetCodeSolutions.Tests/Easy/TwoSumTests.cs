using LeetCodeSolutions.Core.Easy;

namespace LeetCodeSolutions.Tests.Easy;

public class TwoSumTests
{
    private readonly TwoSum _solution;

    public TwoSumTests()
    {
        _solution = new TwoSum();
    }

    [Theory]
    [InlineData(new int[] { 2, 7, 11, 15 }, 9, new int[] { 0, 1 })]
    [InlineData(new int[] { 3, 2, 4 }, 6, new int[] { 1, 2 })]
    [InlineData(new int[] { 3, 3 }, 6, new int[] { 0, 1 })]
    public void TwoSumSolution_ValidInput_ReturnsCorrectIndices(int[] nums, int target, int[] expected)
    {
        // Act
        var result = _solution.TwoSumSolution(nums, target);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void TwoSumSolution_NoSolution_ThrowsArgumentException()
    {
        // Arrange
        var nums = new int[] { 1, 2, 3 };
        var target = 10;

        // Act & Assert
        Assert.Throws<ArgumentException>(() => _solution.TwoSumSolution(nums, target));
    }

    [Fact]
    public void SolutionMetadata_ReturnsCorrectValues()
    {
        // Assert
        Assert.Equal(1, _solution.ProblemNumber);
        Assert.Equal("Two Sum", _solution.Title);
        Assert.Equal(LeetCodeSolutions.Core.Common.Difficulty.Easy, _solution.Difficulty);
        Assert.Equal("O(n)", _solution.TimeComplexity);
        Assert.Equal("O(n)", _solution.SpaceComplexity);
        Assert.NotEmpty(_solution.Description);
    }
}