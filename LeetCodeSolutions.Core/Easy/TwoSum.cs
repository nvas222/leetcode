using LeetCodeSolutions.Core.Common;

namespace LeetCodeSolutions.Core.Easy;

/// <summary>
/// LeetCode Problem #1: Two Sum
/// Given an array of integers nums and an integer target, 
/// return indices of the two numbers such that they add up to target.
/// </summary>
public class TwoSum : ISolution
{
    /// <inheritdoc/>
    public int ProblemNumber => 1;
    
    /// <inheritdoc/>
    public string Title => "Two Sum";
    
    /// <inheritdoc/>
    public Difficulty Difficulty => Difficulty.Easy;
    
    /// <inheritdoc/>
    public string Description => "Use a hash map to store numbers and their indices for O(n) lookup";
    
    /// <inheritdoc/>
    public string TimeComplexity => "O(n)";
    
    /// <inheritdoc/>
    public string SpaceComplexity => "O(n)";

    /// <summary>
    /// Finds two numbers in the array that add up to the target.
    /// </summary>
    /// <param name="nums">Array of integers</param>
    /// <param name="target">Target sum</param>
    /// <returns>Array containing the indices of the two numbers</returns>
    public int[] TwoSumSolution(int[] nums, int target)
    {
        var numToIndex = new Dictionary<int, int>();
        
        for (int i = 0; i < nums.Length; i++)
        {
            int complement = target - nums[i];
            
            if (numToIndex.ContainsKey(complement))
            {
                return new int[] { numToIndex[complement], i };
            }
            
            numToIndex[nums[i]] = i;
        }
        
        throw new ArgumentException("No two sum solution");
    }
}