# Personal preferences

- Each question should be answered in one sentence with no more than 50 words.
- Answer that requires explanation, summarize it in bullect points with no more than 15 words for each bullet point.
- Any comments should not be included if they match the following:
  - Any comments that are explaining an already self-documenting code.
  - Any comments that are fragile and easily outdated. (eg: a comment showing an example where a small change makes the comment outdated).
  - Any comments that addressing obvious design choices based on the surrounding context.
  - Any comments narrating the change itself (what moved, what it replaced, what it used to do) — that belongs in the commit message.
- A comment should only be included if they match the following in one or two sentences: 
  - A bug that was actually hit, and what breaks if the code is "simplified" back.
  - A non-obvious invariant or ordering constraint.
  - A contract the caller cannot see: units, what null means, what it raises.
  - Comment style is terse and plain, never verbose.
    - Say WHY. Never restate the code on the line below it.
    - Module and function headers are a sentence or two, never multi-paragraph essays.
    - No specific literals in prose as they become outdated the moment the value changes. If an example is genuinely needed, make it generic.
- All code implementation should following DRY (DON'T REPEAT YOURSELF) principle.
  - After each implementation, evaluate whether the recently implemented code can be DRY'd with existing code.
  - If existing code and new code can be DRY'd via a refactor, attempt it. If the scope is big, ask for permission first.
