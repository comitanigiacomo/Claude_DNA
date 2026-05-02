---
name: leet2obsidian
description: Create detailed Obsidian notes from LeetCode solutions with multiple approaches, complexity analysis, patterns, and interview prep. Use when converting LeetCode problems to searchable second brain notes.
---

# LeetCode to Obsidian

Convert LeetCode solutions into rich, queryable Obsidian notes.

## Quick Start: Create a Note from Problem

```markdown
---
type: leetcode
difficulty: Medium
patterns:
  - Two Pointers
  - Sliding Window
status: Reviewed
date_solved: 2024-01-15
---

# 3. Longest Substring Without Repeating Characters

## Problem

Given a string `s`, find the length of the **longest substring** without repeating characters.

**Example**:
```
Input: s = "abcabcbb"
Output: 3
Explanation: The answer is "abc", with length 3.
```

## Approach 1: Sliding Window + HashSet

```python
def lengthOfLongestSubstring(s: str) -> int:
    char_set = set()
    left = 0
    result = 0
    
    for right in range(len(s)):
        while s[right] in char_set:
            char_set.remove(s[left])
            left += 1
        char_set.add(s[right])
        result = max(result, right - left + 1)
    
    return result
```

### Complexity
- **Time**: O(n) — single pass
- **Space**: O(min(m, n)) — set size bounded by charset

### Key Insight
Use sliding window: expand right, shrink left when duplicate found.

## Approach 2: HashMap (Optimized)

```python
def lengthOfLongestSubstring(s: str) -> int:
    char_index = {}
    left = 0
    result = 0
    
    for right, char in enumerate(s):
        if char in char_index and char_index[char] >= left:
            left = char_index[char] + 1
        char_index[char] = right
        result = max(result, right - left + 1)
    
    return result
```

### Complexity
- **Time**: O(n)
- **Space**: O(min(m, n))

## Follow-up Questions

1. How would you handle Unicode characters?
2. What if input is extremely large (streaming)?
3. Can you return the actual substring, not just length?

## Related Problems

- [[424. Longest Repeating Character Replacement]]
- [[76. Minimum Window Substring]]
- [[159. Longest Substring with At Most Two Distinct Characters]]

## Interview Notes

- Mention sliding window pattern early
- Ask about character set assumptions (ASCII vs Unicode)
- Edge cases: empty string, all same chars, length 1
```

## Workflows

### Processing a New Problem

1. **Extract from code**: Read solution file, identify problem number/name
2. **Determine difficulty**: Easy/Medium/Hard from LeetCode
3. **Identify patterns**: DFS, BFS, DP, Sliding Window, etc.
4. **Analyze complexity**: Calculate time/space for each approach
5. **Write note**: Use template above, enrich with insights
6. **Link**: Connect to related problems via `[[]]`

**Checklist**:
- [ ] Problem number + title in filename and H1
- [ ] Difficulty tag in frontmatter
- [ ] At least one working code solution
- [ ] Time/space complexity for each approach
- [ ] Key insight or gotcha
- [ ] Related problems linked

### Batch Processing

For multiple problems:
1. Find all solution files in repo
2. Sort by difficulty or pattern
3. Generate notes with consistent frontmatter
4. Create index note linking all problems

### Enriching Existing Notes

If note exists but is minimal:
- Add multiple approaches if missing
- Calculate precise complexity
- Add follow-up questions section
- Link related problems
- Add interview context

## Frontmatter Fields

| Field | Type | Description |
|-------|------|-------------|
| `type` | string | Always `leetcode` |
| `difficulty` | string | Easy, Medium, Hard |
| `patterns` | list | Algorithm patterns used |
| `status` | string | New, Learning, Reviewed |
| `date_solved` | date | YYYY-MM-DD |
| `topics` | list | Data structures involved |

## What to Avoid

- ❌ Copy only code without analysis
- ❌ Forget time/space complexity
- ❌ No links to related problems
- ❌ Generic descriptions without problem-specific insights
- ❌ Missing edge cases

## Advanced Features

See [REFERENCE.md](REFERENCE.md) for:
- Dataview queries for filtering by pattern/difficulty
- Obsidian canvas visualization of problem relationships
- Auto-tagging strategies
- Spaced repetition integration