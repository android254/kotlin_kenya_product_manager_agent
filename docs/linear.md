# Linear: Kotlin Kenya App

How we plan in Linear during the private build phase. At the open-source release the backlog moves to GitHub (`docs/github-project.md`). See `docs/decisions.md` (2026-10-02).

- **Workspace:** `kotlin-kenya-and-android254`
- **Team:** Kotlin Kenya & Android254, key `KOT` (issues are `KOT-1`, `KOT-2`, …)
- Scopes and decisions stay as markdown in this repo. Linear holds the work items and links to the docs.

## Projects (one per roadmap phase)
| Project | Dates | What goes in it |
|---|---|---|
| Onboarding & scoping (Oct 2026) | Oct 2 – Oct 30 | Open questions (label `decision`), scope work, workspace setup |
| MVP build (Nov–Dec 2026) | Nov 2 – Dec 23 | F0–F9 tasks from `docs/scopes/mvp-january.md` |
| January tester update (push + ratings) | Jan 11 – Jan 29 2027 | F10 push reminders, F11 post-event ratings |
| Testing (Jan–Feb 2027) | Jan 4 – Feb 28 2027 | Tester bugs and feedback, meetup-day runs, release blockers |
| Open-source release | after testing | Making the repo public and moving the backlog to GitHub |

**MVP build milestones (= sprints):** S1 Nov 13 · S2 Nov 27 · S3 Dec 11 · S4 Dec 23 · Release to testers Jan 8 2027.

## Labels
| Group | Values | GitHub equivalent |
|---|---|---|
| Team | `Product`, `Mobile`, `Backend`, `Web` (one per issue) | none yet (decide at release) |
| Feature area | Foundation, Onboarding, Home, Events, Ticket & check-in, Call for Speakers, Profile & settings, Community & jobs, Sponsors, Push reminders, Post-event ratings | Feature area field |
| Layer | Domain, Local data, Remote data, Repository & sync, UI, Core module, Build & release | Platform field (closest match) |
| Kind of work | `engineering`, `design`, `ops`, `scope`, `decision`, `accessibility`, `documentation` | same labels |
| Who it helps | `member value`, `sponsor value`, `organizer value` | same labels |
| Priority | `must fix`, `should fix`, `nice to have` | same labels |

Linear's built-in **Priority** (Urgent/High/Medium/Low) is for ordering work this sprint. The `must fix` / `should fix` / `nice to have` labels carry over to GitHub.

## Teams and views
We keep one Linear team (`KOT`) and split the work by the **Team** label, not by Linear sub-teams. That way, adding a person only means giving them a view, and all issues keep their `KOT-` keys. Every issue gets exactly one Team label. Work that crosses teams is split into one issue per team, linked with *blocked by*.

| Team label | Who | What goes there | View |
|---|---|---|---|
| Product | Design + PM | Figma work, scopes, decisions, roadmap, Linear/ops setup, organizer and tester comms | [Product](https://linear.app/kotlin-kenya-and-android254/view/81fc5e36-7b2c-414a-94e7-3c230ba916e9) |
| Mobile | App engineers | The Compose Multiplatform app (Android, iOS): UI, local data, sync, app builds, store releases | [Mobile](https://linear.app/kotlin-kenya-and-android254/view/5d4b8cfb-2b2b-4e63-80e2-6fe1e58e55cb) |
| Backend | Backend engineers | Supabase schema, RLS, edge functions, push delivery, data shared by app and web | [Backend](https://linear.app/kotlin-kenya-and-android254/view/8477637c-53ad-4d69-8aff-2e45162770cf) |
| Web | Web engineers | The web platform for the public and organizers | [Web](https://linear.app/kotlin-kenya-and-android254/view/287ec465-7e16-40d0-9341-25b7c6d79d6f) |

The views are shared with the team and filtered on `Labels include <Team>`. To add someone, invite them to the workspace and have them favourite their team's view. When a Layer label is `Remote data`, the Team is usually Backend. `UI`, `Local data` and `Repository & sync` usually go to Mobile.

## Fields
- **Estimate:** T-shirt sizes. S = 1 (under a day), M = 2 (1–3 days), L = 3 (3–5 days). Split anything bigger.
- **Cycles:** 2 weeks from Mon Nov 2 2026, lined up with S1–S4.
- **Phase:** the project.
- **Scope doc:** a path in the issue description, e.g. `docs/scopes/mvp-january.md`.
- **Due date:** only for date-bound work.

## Issue conventions
- Build tasks start with their scope ID: `F4-03 RSVP and cancel functions`.
- "Depends on" from the scope becomes Linear's *blocked by* relation.
- No private details in issue text (sponsor terms, member data, internal links), so issues can be copied to public GitHub as they are.

## GitHub sync (check this)
On 2026-10-02 the team's GitHub Issues sync was already on and pointed at `android254/kotlin-kenya-designer-agent`. Every new KOT issue is mirrored there (KOT-5 to KOT-17 became #28 to #40). That repo is private, but this puts PM and organizer issues in the design repo. See the open question in `docs/decisions.md`.

## Manual setup (KOT-5, KOT-6)
The API can't change team settings. These are done by hand: estimates, cycles, triage, the GitHub and Figma integrations.
