# AGENTS.md

## Context Target: **PICO-8 (Lua)**  Goals: small code, low token usage, fast
iteration, simple patterns, clean implementation.

## Core rules
- Prefer **simple tables + functions** over OOP or abstractions.
- Avoid metatables, inheritance, or frameworks unless explicitly needed.
- Keep identifiers short but readable.
- Minimize token-heavy patterns; favor simpler equivalents.
- Preserve behavior; make minimal changes.

## Token strategy
- Be mindful of the **8192 token limit**.
- Prefer concise patterns over generic/expandable ones.
- Organize project using multiple files, where pixiepixie.p8 is the entrance
  point (and uses include).

## PICO-8 specifics
- Sprite ids (0–255) index the sprite sheet (16x16 tiles of 8x8).
- Use `pal()` for recoloring and `palt()` for transparency.
- Reset palette with `pal()` after drawing unless intentional.

## Code style
- Keep globals at top of files, alphabetized. Keep functions within a file
  alphabetized.
- Prefer function names in `{verb}_{actor}` form. When the actor is a common
  global like `m`, `q`, or `t`, prefer the one-letter actor form such as
  `init_m`, `upd_m`, `draw_t`, `add_q`, and `pop_q`.
- Keep update/draw loops straightforward.
- Favor small reusable helpers over deep indirection.
- Do not add comments to code files; keep documentation in `DOCS.md` instead.
- Always update `DOCS.md` when variables, controls, systems, or file
  responsibilities change.

## DOCS
- New or changes to existing file globals, functions, or otherwise code should
  be documented in `DOCS.md`, in lieu of code comments. Keep
  descriptions/comments concise and accurate, describing input variables,
  equations, and output variables in human understandable terms. Group globals,
  functions, and finally other variables/information; alphabetizing each
  sub-section.

## Versioning
- When asked to bump the version, increment `ver` in
  `pixiepixie.p8`. Take note of all changes and summarize
  as an entry in `CHANGELOG.md`. Keep concise and
  general. No need to get into deep details.
