# GitHub Project: Kotlin Kenya App

One project board at the android254 org level holds the backlog for every Kotlin Kenya App repo. Each repo keeps its own issues; the board pulls them together.

- **Board:** `https://github.com/orgs/android254/projects/<number>` (add the number once it's created)
- **Setup script:** `scripts/setup-github-project.sh`

## Repos on the board
| Repo | Local path (sibling folders) | What goes in its issues |
|---|---|---|
| `android254/kotlin_kenya_product_manager_agent` | `./` | Scopes, roadmap and product decisions |
| `android254/kotlin-kenya-designer-agent` | `../kotlin-kenya-designer-agent` | Figma design work and handoff notes |

The app's code repo isn't on the board yet. Add it when it's ready (see "Onboarding a new repo" below).

## Fields
| Field | Values | Notes |
|---|---|---|
| Status | Inbox, Scoping, Ready, In progress, Review, Done | Built-in field. Its options have to be renamed by hand (see setup step 2) |
| Feature area | Onboarding, Home, Events, Call for Speakers, Community, Profile, Cross-cutting | Same areas as the Figma pages |
| Platform | Android, iOS, Shared/KMP, Backend, Design, Content | Same areas the task-scoper uses for tasks |
| Size | S, M, L | S = under a day, M = 1–3 days, L = 3–5 days. Split anything bigger |
| Phase | Phase 1, Phase 2, Later | |
| Scope doc | text | Path such as `docs/scopes/<slug>.md` |
| Target date | date | Only for date-bound work, such as an event |

## Labels (the same in every repo)
- **Priority:** `must fix`, `should fix`, `nice to have`
- **Who it helps:** `member value`, `sponsor value`, `organizer value`
- **Kind of work:** `design`, `engineering`, `scope`, `accessibility`, `documentation`

The designer repo already uses the priority labels and the `member value` / `sponsor value` labels. The script adds the rest and leaves the existing ones as they are.

## One-time setup
You need to be an android254 org member who can create projects.

1. Run the script:
   ```bash
   gh auth refresh -s project,read:org
   scripts/setup-github-project.sh
   ```
   It creates the board and its fields, links both repos, and syncs the labels. Put the project number it prints at the top of this doc.
2. **Status options** (the API can't do this): open the board → ⋯ → Settings → Status. Rename and add options until the list reads Inbox, Scoping, Ready, In progress, Review, Done.
3. **Views** (also no API), from the board:
   - **Board:** group by Status, filter `-status:Done`
   - **Roadmap:** roadmap layout on Target date, group by Phase
   - **By area:** table grouped by Feature area, showing Platform, Size and Labels
   - **Design queue:** table filtered to `repo:android254/kotlin-kenya-designer-agent is:open`
4. **Workflows** (⋯ → Workflows):
   - Turn on *Auto-add to project* for each linked repo, using the filter `is:issue,pr is:open`. On the free plan this is limited to one auto-add workflow, so add the other repos' issues by hand or with `gh project item-add`.
   - Turn on *Item closed → Done* and *Pull request merged → Done*.
   - Set *Item added → Inbox*.
5. Make the board visible to the community: Settings → Visibility → Public, if the organizers agree.

## Onboarding a new repo
1. Add the repo to `REPOS` in `scripts/setup-github-project.sh`.
2. Run `PROJECT_NUMBER=<n> scripts/setup-github-project.sh`. It links the repo and syncs the labels. Running it again does no harm.
3. Add an auto-add workflow for the repo, or add its open issues once:
   ```bash
   gh issue list --repo android254/<repo> --state open --json url --jq '.[].url' \
     | xargs -n1 gh project item-add <n> --owner android254 --url
   ```
4. Add a row to the "Repos on the board" table above, and clone the repo as a sibling folder next to this one.

## How the PM agent uses the board
- A new idea goes in as an issue in this repo with the `scope` label, and starts in **Inbox**.
- When the task-scoper writes `docs/scopes/<slug>.md`, the issue moves to **Scoping**, with the Scope doc field set.
- Once the scope is reviewed, it's split into design issues (designer repo) and engineering issues (app repo), each with its Size, Platform and Phase. The parent issue tracks them as sub-issues.
- This session can create and edit issues in attached repos, but has no tool for board fields or Status. Those get set by the board's workflows or by hand.
