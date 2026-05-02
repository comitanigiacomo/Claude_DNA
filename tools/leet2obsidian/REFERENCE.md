# LeetCode to Obsidian - Reference

## Dataview Queries

### All Medium problems
```javascript
```dataview
TABLE difficulty, patterns, date_solved
FROM "leetcode"
WHERE difficulty = "Medium"
SORT date_solved DESC
```

### Problems by Pattern
```javascript
```dataview
LIST
FROM "leetcode"
WHERE contains(patterns, "Two Pointers")
SORT difficulty ASC
```

### Unreviewed problems
```javascript
```dataview
LIST
FROM "leetcode"
WHERE status != "Reviewed"
```

## Pattern Categories

### Core Patterns
- **Two Pointers**: Pair problems, sorted arrays, palindromes
- **Sliding Window**: Substring/subarray problems
- **Fast & Slow Pointers**: Cycle detection, middle of list
- **BFS**: Level-order traversal, shortest path
- **DFS**: Tree/graph traversal, combinations
- **Dynamic Programming**: Optimization problems, climbing stairs
- **Binary Search**: Search in sorted space
- **Backtracking**: Permutations, combinations
- **Hash Map**: Frequency counting, anagrams

### Frequency per Difficulty
| Pattern | Easy | Medium | Hard |
|---------|------|--------|------|
| Two Pointers | 15% | 25% | 20% |
| Sliding Window | 10% | 20% | 15% |
| Hash Map | 25% | 20% | 10% |
| BFS/DFS | 5% | 25% | 35% |
| DP | 0% | 20% | 30% |
| Binary Search | 10% | 15% | 20% |

## Note Structure by Difficulty

### Easy
- Single approach sufficient
- Focus on clarity
- Common pitfalls section
- Simple time/space

### Medium
- Two approaches (brute + optimized)
- Trade-offs discussion
- Follow-up questions
- Related problems (2-3 links)

### Hard
- Multiple approaches (3+)
- Detailed mathematical proof
- Advanced variations
- Many related problems
- Time-critical edge cases

## Edge Case Checklist

Always consider:
- Empty input (`""`, `[]`, `null`)
- Single element
- Already sorted/reversed
- All same values
- Maximum size input
- Negative numbers (if applicable)
- Duplicate handling

## File Naming

Use: `NNN. title-kebab-case.md`

Example: `015. 3sum.md`, `042. trapping-rain-water.md`

## Topic Tags

Add to frontmatter:
- `topics`: ["Array", "Hash Table", "String", "Tree", "DP", "Math"]

Common topics:
- Array, Hash Table, String, Dynamic Programming
- Math, Sorting, Greedy, Depth-First Search
- Binary Search, Breadth-First Search
- Tree, Matrix, Two Pointers, Stack
- Heap, Graph, Linked List, Recursion
- Backtracking, Sliding Window

## Interview Preparation

Add section:
```markdown
## Interview Context

- **Company asked**: Meta, Google, Amazon...
- **Round**: Phone, Onsite, OA
- **Follow-ups received**: ...
- **Time limit**: 30 min
- **Result**: Passed/Failed
```

## Obsidian Canvas

Create `canvas/leetcode-relationships.canvas`:
- Node per pattern
- Edge = "appears in"
- Group by difficulty
- Color by status