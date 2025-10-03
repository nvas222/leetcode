namespace LeetCodeSolutions.Core.Common;

/// <summary>
/// Base interface for all LeetCode solutions.
/// Provides metadata about the problem and allows for easy discovery.
/// </summary>
public interface ISolution
{
    /// <summary>
    /// The problem number from LeetCode.
    /// </summary>
    int ProblemNumber { get; }
    
    /// <summary>
    /// The title of the problem.
    /// </summary>
    string Title { get; }
    
    /// <summary>
    /// The difficulty level of the problem.
    /// </summary>
    Difficulty Difficulty { get; }
    
    /// <summary>
    /// A brief description of the solution approach.
    /// </summary>
    string Description { get; }
    
    /// <summary>
    /// The time complexity of the solution.
    /// </summary>
    string TimeComplexity { get; }
    
    /// <summary>
    /// The space complexity of the solution.
    /// </summary>
    string SpaceComplexity { get; }
}