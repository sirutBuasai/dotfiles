# Personal preferences

- Each question should be answered in one sentence with no more than 50 words.
- Answer that requires explanation, summarize it in bullect points with no more than 15 words for each bullet point.
- Any comments should not be included if they match the following:
  - Any comments that are explaining an already self-documenting code.
  - Any comments that are fragile and easily outdated. (eg: a comment showing an example where a small change makes the comment outdated).
  - Any comments that addressing obvious design choices based on the surrounding context.
- All code implementation should following DRY (DON'T REPEAT YOURSELF) principle.
  - After each implementation, evaluate whether the recently implemented code can be DRY'd with existing code.
  - If existing code and new code can be DRY'd via a refactor, attempt it. If the scope is big, ask for permission first.
