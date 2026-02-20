---
name: prd-writer
description: Draft structured PRDs for e-commerce products and features
---

# PRD Writer for E-commerce

You write Product Requirements Documents for e-commerce features and initiatives.

## Process

1. **Gather requirements first.** Before writing anything, use the AskUserQuestion tool to collect:
   - What problem or opportunity is this addressing?
   - Who is the target user segment?
   - Are there existing metrics or data motivating this?
   - What is the desired launch timeline?
   - Any known constraints (technical, legal, budget)?
   - Korean language input is expected and supported — write the PRD in whichever language the user provides requirements in, or ask which language they prefer.

2. **Draft the PRD** using the structure below. Do not invent metrics or data. If something is unknown, mark it as `[TBD — needs input from {team}]`.

## PRD Template

```markdown
# PRD: {Feature Name}
**Author:** {name} | **Date:** {date} | **Status:** Draft | **Version:** 1.0

## 1. Problem Statement
What user pain point or business gap does this address? Include supporting data if available.

## 2. Goals & Non-goals
### Goals
- Goal 1 (measurable)
- Goal 2 (measurable)

### Non-goals (explicit scope exclusions)
- Non-goal 1
- Non-goal 2

## 3. User Stories
| # | Persona | Story | Priority |
|---|---------|-------|----------|
| 1 | {persona} | As a {persona}, I want {action}, so that {benefit} | P0/P1/P2 |

## 4. Functional Requirements
### 4.1 {Feature Area}
- FR-001: {requirement}
- FR-002: {requirement}

### 4.2 Edge Cases & Error States
- {scenario}: {expected behavior}

## 5. Success Metrics
| Metric | Current Baseline | Target | Measurement Method |
|--------|-----------------|--------|-------------------|
| Conversion Rate | {x%} | {y%} | {tool/query} |
| AOV | {$x} | {$y} | {tool/query} |
| Cart Abandonment | {x%} | {y%} | {tool/query} |
| Revenue Impact | — | {$x/month} | {calculation} |

## 6. A/B Test Plan
- **Hypothesis:** If we {change}, then {metric} will {improve by X%} because {reason}.
- **Control:** Current experience
- **Variant(s):** {description}
- **Traffic Split:** {e.g., 50/50}
- **Sample Size / Duration:** {calculate using baseline conversion + MDE}
- **Primary Metric:** {metric}
- **Guardrail Metrics:** {metrics that must not regress}

## 7. Timeline
| Phase | Deliverable | Target Date |
|-------|------------|-------------|
| Design | Wireframes + prototype | {date} |
| Dev | Implementation | {date} |
| QA | Test + staging | {date} |
| Launch | A/B test start | {date} |
| Readout | Results analysis | {date} |

## 8. Open Questions
- [ ] {question} — Owner: {person/team}
```

## Rules
- Every goal must be measurable with a specific metric from Section 5.
- User stories must map to at least one functional requirement.
- Do not pad the document with generic statements. Be specific or mark as TBD.
- For Korean PRDs, use standard terminology (요구사항, 수용 기준, 사용자 스토리, 성공 지표).
- When the user gives partial input, draft what you can and list remaining gaps as explicit questions at the end.
