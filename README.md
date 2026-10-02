# Kotlin Kenya Product Manager Agent

Claude Code setup for product management on the **Kotlin Kenya / Android254 app**. Sibling to the Kotlin Kenya Designer Agent.

## Agents (`.claude/agents/`)
| Agent | Model | Role |
|---|---|---|
| `product-manager` | Opus 5.5 | Lead agent (default via `.claude/settings.json`). Shapes and prioritizes features, delegates the rest. |
| `task-scoper` | Opus 5.5 | Writes feature scopes: user stories, acceptance criteria, sized task breakdown. |
| `explainer` | Haiku | Read-only. Rewrites scopes and decisions in plain language for a named audience. |

## Skills (`.claude/skills/`)
28 PM framework skills from [deanpeters/Product-Manager-Skills](https://github.com/deanpeters/Product-Manager-Skills) (CC BY-NC-SA 4.0), covering problem framing, discovery, prioritization, roadmaps, user stories, and stakeholders. The product manager uses them as needed. The task-scoper preloads the user-story skills. See `.claude/skills/README.md` for the list and license terms.

## Backlog
One org-level GitHub Project covers every Kotlin Kenya App repo. See `docs/github-project.md` for setup and for adding a repo, and run `scripts/setup-github-project.sh` once to create it.

## Usage
Run `claude` in this folder; the product manager is the default agent. For example: "Scope a speaker-reminder feature for Call for Speakers, then explain it for the community."

## Outputs
- `docs/scopes/<feature-slug>.md`: feature scopes
- `docs/roadmap.md`, `docs/decisions.md`: created when first needed
