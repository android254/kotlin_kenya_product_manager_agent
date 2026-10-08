# Decisions

## 2026-10-02: Linear while we build, GitHub Issues once we open source
**Decision:** The core team plans in Linear during the private build phase. When the app is released as open source, the backlog moves to GitHub Issues and the org-level GitHub Project (`docs/github-project.md`).

**Why:** Until release, a small core team does the planning, and Linear's triage, cycles and roadmaps work better for that. After release, the backlog has to be public and sit where contributors already are, and that's GitHub.

**What this means now:**
- Planning (ideas, triage, cycles, roadmap) happens in Linear.
- Scopes and decisions stay as markdown in this repo (`docs/scopes/`, `docs/decisions.md`), not in Linear. That way they move over at release without being rewritten.
- The GitHub Project setup (`docs/github-project.md`, `scripts/setup-github-project.sh`) is on hold until release. Don't create the board yet.
- The designer repo already tracks its work in GitHub issues (25 issues, all closed). Its future design work moves into Linear too, unless design decides otherwise.

**To keep the move cheap later:**
- Connect Linear's GitHub integration from day one, so pull requests and branches link to Linear issues.
- Use the same labels in Linear as on GitHub: priority (`must fix` / `should fix` / `nice to have`), who it helps (`member value` / `sponsor value` / `organizer value`), and kind of work (`design`, `engineering`, `scope`, `accessibility`, `documentation`). Also use the same fields: Feature area, Platform, Size, Phase.
- Keep issue text free of private details (sponsor terms, member data, internal links). That way issues can be copied to the public repos as they are.

**When we release:**
1. Run `scripts/setup-github-project.sh` and finish the manual steps in `docs/github-project.md`.
2. Move only the open, relevant issues to GitHub. Closed history stays in Linear.
3. Add a "good first issue" label and contributor docs before we announce.
4. Archive the Linear team, or keep it for organizer-only work such as sponsors and venues.

**Answered (2026-10-02, from the product owner):**
- "Released to open source" means the first public release, when the app repo is made public. The app hasn't been built yet.
- Design work moves into Linear now, not at release. The designer repo's GitHub issues become history. New design work is filed in Linear.
- Sponsor and venue work stays private "to some extent". This depends on how the web platform is split between the public and organizers (see the next decision).
- The product owner will connect Linear and Figma to this agent when the time comes.

**Still open:**
- Which parts of the organizer and sponsor work stay private in Linear after the release? This depends on the web platform split.
- Should the designer repo's README point its work queue at Linear? The workspace now exists; tracked as KOT-7.

## 2026-10-02: Scope covers the app and a web platform (still open)
**What we know:** Besides the Compose Multiplatform app, we're building a web platform. It serves two groups: the public, and organizers. It could be two separate products, or one product where organizer features are switched on only for organizers.

**Status:** not decided. The product owner will go through it during onboarding. Until then, scopes cover the app only. Any scope that needs an organizer tool (event setup, check-in, sponsor reports) flags that need instead of assuming where the tool lives.

**Needs an answer:** one web platform with organizer features switched on per user, or two separate platforms? Who uses each one? Which parts ship before the January testing window?

## 2026-10-02: Stack for the MVP
**Decision:** The app is Kotlin Multiplatform with Compose Multiplatform, for Android and iOS. The backend is Supabase (Postgres, Auth, Storage, Edge Functions) for the MVP.

**Why:** It's quick to go from idea to production with Supabase, and it works well with AI agents. That fits a 4-engineer team with about 7 weeks of build time.

**Follow-ups:**
- Organizers use Supabase Studio as the admin tool until the web platform exists. Organizers need to confirm this works for them; see `docs/mvp.md`.
- Every table needs row-level security from day one, because the app talks to Supabase directly.
- Review after the open-source release: do we stay on Supabase or move? Contributors will need a local Supabase setup and seed data.

## 2026-10-02: The MVP is a trimmed set of the designs (draft)
**Decision (draft until organizers review it):** January testing covers 10 features: foundation, sign-in and onboarding, Home, Events, ticket and check-in, Submit a talk, Profile and settings, Jobs, Sponsors, and push reminders (should have). Everything else is planned for later, in the order listed in `docs/mvp.md`.

**Why:** Each feature has to give members, speakers or sponsors something they use right away, and the whole set has to fit about 100 engineer-days.

## 2026-10-02: Fit the MVP to 4 engineers by moving ratings and push to a January update
**Decision (product owner):** Stay at 4 engineers. **Post-event ratings (F11)** and **push reminders (F10)** ship in a tester update around mid-January, not in the first January build. The first build has the other 9 features.

**Why:** At full size the MVP is about 148.5 engineer-days against about 100 (`docs/scopes/mvp-january.md`, Totals). Ratings only matter after the first meetup, and reminders matter just before it. A mid-January update covers both if the first meetup is late enough.

**Depends on:**
- Engineers being available in early to mid January (OQ-7).
- The date of the first testing meetup (OQ-6). If it's before about Jan 20, reminders need to come forward.
- Which thinner versions are accepted. The product owner is reviewing them one by one.

## 2026-10-02: Android only for January testing; iOS later
**Decision (product owner):** January testing is Android only. The code stays Kotlin Multiplatform, so iOS can follow without a rewrite.

**Why:** It cuts scope and risk. The iOS-only work comes out of the first build:
- iOS CI and TestFlight
- Sign in with Apple
- iOS add to calendar
- the iOS scanner and brightness handling
- APNs
- the VoiceOver pass
- App Store Connect and its beta review

The iOS chrome question (shared Compose UI or native) is set aside until we do iOS.

**Rules so iOS stays cheap later:**
- Business logic, data, view models and UI stay in `commonMain`. Android-only APIs sit behind `expect`/`actual` or interfaces, never directly in shared code.
- CI keeps the shared modules compiling for the iOS targets. A weekly macOS job is enough. Then iOS can't break quietly.
- The iOS designs stay in Figma. Nobody deletes them.

**Cost:**
- Testers on iPhones can't join. Most developers in Kenya use Android, but some organizers, sponsor staff and speakers use iPhones.
- Sponsors see the app through Android testers or screenshots until iOS ships.
- Sign-in is GitHub only for now. Sign in with Apple comes back with iOS.

**When iOS comes back:** a decision for after testing, alongside the native-chrome question. The task list for it is the deferred iOS tasks in `docs/scopes/mvp-january.md`.

## 2026-10-02: Thinner versions T1, T2, T4 and T13 accepted
**Decision (product owner):**
- **T1:** stock M3 components themed with our tokens.
- **T2:** no drawer. Its links move to Profile and Settings.
- **T4:** the Events tab is a month-grouped list, without the calendar.
- **T13:** no Sponsor detail screen. Logos open the sponsor's website, and the Our sponsors list stays.

Together they save about 10 days. The other thinner versions (T3, T5, T8–T12, T15, T16) aren't taken for now. They stay in reserve if the estimates grow. T6, T7 and T14 no longer apply, since we're Android only.

**Design follow-up:** the designer agent marks these four in Figma as "MVP version", without deleting the full designs.

## 2026-10-02: Architecture: clean architecture, modular, offline first
**Direction (product owner):**
- **Clean architecture.** The domain layer (models, repository interfaces, use cases) is defined first for each feature. After that, the local data source, the remote data source (Supabase), the repository and the UI can be built in parallel by different engineers.
- **Modular.** Core modules (design system, UI kit, database, network, sync, analytics) are shared, and each feature is its own module. Common patterns are written once and reused.
- **Offline first.** The local database is the source of truth, and the network syncs into it.

**What "offline first" covers in the MVP (PM boundary):**
- **Read offline (everything a member has viewed):** events, sessions and speakers, the member's own ticket, jobs, sponsors, the profile, Your talks. When offline, the app shows cached data with a "last updated" note.
- **Write offline and sync later:**
  - **door check-ins** (venue networks are unreliable, and this is where offline matters most);
  - **talk drafts**;
  - **ratings** (in the January update).
- **Online only, clearly marked:** RSVP and cancelling (seat counts have to be checked live), sign-in, account deletion.

**Trade-offs:**
- The domain-first contracts make work parallel, which shortens the critical path and cuts waiting. They don't reduce the total engineer-days.
- Offline first adds groundwork up front: the local database, the sync and outbox engine, and conflict rules. Reusable modules pay that back across features.
- The net effect is being re-estimated in `docs/scopes/mvp-january.md`.
- Offline tickets, which the MVP had cut, become cheap on this foundation.

## 2026-10-02: Linear set up with one project per phase
**Decision (PM, product owner asked to finish the groundwork):** Linear projects follow the roadmap phases, not feature areas. MVP sprints are milestones in the build project. Feature areas are labels. Details are in `docs/linear.md`.

**Why:** Phases have dates and a clear "done", so Linear's project progress and roadmap views show whether January is on track. Feature areas cut across phases, so labels fit them better. The Layer labels (Domain, Local data and so on) make the clean-architecture split visible, so tasks can run in parallel.

**What was created:**
- Projects: Onboarding & scoping (Oct 2026), MVP build (Nov–Dec 2026), January tester update (push + ratings), Testing (Jan–Feb 2027), Open-source release.
- Milestones S1–S4 and Release to testers in the MVP build project.
- Labels: priority (`must fix` / `should fix` / `nice to have`) and `documentation`. Sponsors, Push reminders and Post-event ratings were added to Feature area.
- Issues KOT-5 to KOT-17: manual setup, the re-estimate, the import, and the open questions (OQ-3 to OQ-17, plus the web platform).
- Linear's sample issues KOT-1 to KOT-4 were cancelled or marked as duplicates.

**Not done yet, on purpose:** the MVP tasks aren't imported as issues. The scope is being re-estimated for offline-first (KOT-8). Importing now would mean redoing about 100 issues. The import is KOT-9, after KOT-8.

**Open (product owner):** the team's GitHub Issues sync is on and points at the designer repo. Every KOT issue is now mirrored there (#28 to #40). Keep that, move it to a PM or app repo, or turn it off? The repo is private, so nothing has leaked. But organizer and PM questions are landing in design's queue.

## 2026-10-08: Team views in Linear use labels, not sub-teams
**Decision:** We stay on one Linear team (`KOT`). Product, Mobile, Backend and Web are a single-select **Team** label, and each has a shared saved view. Setup and links are in `docs/linear.md` under "Teams and views".

**Why labels and not sub-teams:**
- **One build rhythm.** Sprints S1–S4 are feature slices that cut across Mobile and Backend (e.g. F4 RSVP is a Supabase function plus a screen). Separate teams would mean separate cycles, and one feature's tasks would be spread across them.
- **The Linear Free plan caps teams.** The workspace shows "Free plan", which allows only a couple of teams. Four sub-teams would push us onto a paid plan before anyone has joined.
- **The move to GitHub stays cheap.** One team means one `KOT-` key, one GitHub sync and one set of labels to carry over at release. The Team label maps straight to a GitHub label or field.
- **Adding people is easy.** A new member only needs their team's view, with no team membership or permissions to set up.

**Look at this again if:** a team needs its own cycle length, workflow states or triage rota; a team grows past about 5 regular contributors; or we move to a paid plan for other reasons. Moving to sub-teams then means moving issues across, which changes their keys. So do it at a phase boundary (for example between Testing and the Open-source release), not mid-sprint.

**Also decided:**
- KOT-43 (offline check-in and ticket caching) stays with **Mobile**. If it becomes a server-side ticket-checking task, that part gets its own Backend issue linked as *blocked by*.
- Team leads and issue assignment wait until everyone has joined Linear. Until then, unassigned issues stay unassigned. The team views are where people find their work.
