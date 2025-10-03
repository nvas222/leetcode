using LeetCodeSolutions.Core.Common;

namespace LeetCodeSolutions.Core.Easy;

/// <summary>
/// LeetCode Problem #1768: MergeStringsAlternately
/// Merge the strings by adding letters in alternating order, starting with word1. 
/// If a string is longer than the other, append the additional letters onto the end of the merged string.
/// </summary>
public class MergeStringsAlternately : ISolution
{
    /// <inheritdoc/>
    public int ProblemNumber => 1768;
    
    /// <inheritdoc/>
    public string Title => "MergeStringsAlternately";
    
    /// <inheritdoc/>
    public Difficulty Difficulty => Difficulty.Easy;
    
    /// <inheritdoc/>
    public string Description => "Merge two strings alternately.";
    
    /// <inheritdoc/>
    public string TimeComplexity => "O(n)";
    
    /// <inheritdoc/>
    public string SpaceComplexity => "O(n)";

    /// <summary>
    /// Merges two strings alternately.
    /// </summary>
    /// <param name="word1">The first string to merge.</param>
    /// <param name="word2">The second string to merge.</param>
    /// <returns>The merged string.</returns>
    public string MergeStringsAlternatelySolution(string word1, string word2)
    {
        string resultat = "";
        int maxLength = Math.Max(word1.Length, word2.Length);
        int minLength = Math.Min(word1.Length, word2.Length);
        for (int i = 0; i < minLength; i++)
        {
            resultat += word1[i];
            resultat += word2[i];
        }
        for (int j = minLength; j < maxLength; j++)
        {
            if (word1.Length > word2.Length)
                resultat += word1[j];
            else
                resultat += word2[j];
        }
        return resultat;
    }
}
