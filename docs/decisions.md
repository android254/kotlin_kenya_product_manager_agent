# Decisions

## 2026-10-08: Team meeting outcomes — legal route, app scope accepted, web timing firmed up, app build starts with domain models + design system

**Source:** product owner's recap of a team meeting held 2026-10-07/08. Captured here because it touches four separate open items across this file, `docs/mvp.md` and `docs/meeting-brief-2026-10-07.md`. Where the recap doesn't name specifics (who, exact dates), this entry says so rather than guessing.

### 1. Legal review route for sensitive documents — partly resolved
**Decision:** a named person on the team (not yet specified to this agent) will consult a legal professional for sponsorship terms, Terms of Service, Privacy Policy, and any other sensitive document. This agent continues to **design and build the scaffolding** for those documents now — page structure, sections, placeholders, where they live on web vs. app — and drops the real legal text in once it's delivered, rather than waiting idle.

This answers part of `docs/meeting-brief-2026-10-07.md` Decision #2 ("in-house, hired, or AI-assisted?"): the route is **professional review**, not AI-assisted or purely in-house. It does **not** answer the rest of that decision:
- **Who** owns it, by name.
- Whether the **~Nov 20** deadline (needed so the Privacy Policy can clear Play's 14-day closed-testing window before January) is achievable with an outside professional's turnaround time.
- The fallback if the review slips (`docs/meeting-brief-2026-10-07.md` #11, #12) is still unanswered.

**What this means now:** W1's scope (`docs/scopes/web-platform-w1-public-pages.md`) already treats legal review as an unsized, unowned dependency. That doesn't change — it's now "unsized, owned by someone unnamed, route = professional." The scaffolding work (page shells, CMS/markdown structure, placeholder copy marked clearly as non-final) can proceed in parallel and is not blocked on the lawyer.

### 2. App scope of work — accepted
**Decision:** the team is comfortable with the app's scope of work as currently written. Taken as confirming `docs/mvp.md`'s 11-feature cut and answering its own "Is this the right cut for January?" row in that file's Decisions needed table.

**Not covered by this:** the Oct 7 meeting-brief's other open items — the Open Collective field split (#1), who owns W1 and which thinner versions pay for it (#3), the React framework/hosting pick (#4), the sponsor speaking-slot mechanism (#5), sponsor tier thresholds (#6), and the rest (#7–#12) — were not mentioned in this recap. Treating them as **still open** until confirmed otherwise.

### 3. Web platform: public pages first, then Call for Speakers/Sponsors — both before January
**Decision:** the site starts with the public-facing pages (W1), then moves to Call for Speakers and Call for Sponsors (part of W2), and the team wants **all of it live before January 2027**, alongside the app.

**Why this needs a flag, not a quiet yes:** this is firmer than anything on record. `docs/web-platform-brief.md` and the Oct 7 meeting brief both treat W2 as **not yet scoped** (blocked on the Open Collective decision) and the Nov–Dec Android plan as already ~8.5–16 engineer-days over budget from W1 alone, on the same 4 engineers. Committing W2 to "before January" without having sized it is a scope decision made ahead of the estimate. One team member's read that Call for Speakers/Sponsors "can be done with AI easily" is **an optimistic assumption, not a size** — it hasn't been tested against this app's actual stack (Supabase RLS, the `talk_submissions` table shared with the app, sign-in, the ledger) the way W1 was. Recommend sizing W2 for real (task-scoper) before the January commitment is treated as fixed, the same way W1 went from assumption to a real ~7.5-day number that turned out to land on the two busiest Android sprints.

**Open:** does "before January" include Call for Donations too, or only Speakers/Sponsors as stated? The recap named only the latter two.

### 4. App build order: domain models and the design system come first, before feature work splits
**Decision:** the Nov–Dec app build starts with two reusable foundations, built in parallel, ahead of any feature screen:
1. **Domain models** — extract the actual domain classes the app needs from the designs (Event, Session, Speaker, Sponsor, Job, Profile, Talk/submission, Ticket/RSVP, etc.), with each field marked **nullable or non-nullable**, matching what each screen in the Figma file actually shows and what the Supabase schema has to hold.
2. **Reusable components and the design system** — the shared UI kit (tokens, core components) the MVP screens draw on.

Once both exist, feature work (the local data source, the remote data source, the repository, the UI — per the 2026-10-02 clean-architecture decision below) can be split across engineers without anyone blocking on anyone else.

**Relationship to existing decisions:** this doesn't introduce a new architecture — it's the concrete, sequenced version of the 2026-10-02 "clean architecture, modular, offline first" decision's "domain layer is defined first for each feature" line. What's new is treating domain-model extraction as its own named, scoped, Figma-sourced task rather than something each feature scope does for itself, and explicitly tying it to the already-decided thinner version **T1** (stock M3 components, not the full 127-component library) so the design-system half doesn't quietly re-expand scope.

**Action:** scoped as its own task breakdown — see `docs/scopes/foundation-domain-models-design-system.md` (in progress).

**Still open:**
- Who on the team owns the legal consult, and whether the ~Nov 20 deadline holds with a professional's turnaround (item 1).
- The Oct 7 meeting-brief's items #1, #3–#12 — not addressed in this recap.
- Whether "before January" for the web platform is a hard commitment or a target the team will revisit once W2 is actually sized.

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
- Should the designer repo's README point its work queue at Linear? It can't until the Linear workspace exists.

## 2026-10-02: Scope covers the app and a web platform (resolved 2026-10-04, see below)
**What we know:** Besides the Compose Multiplatform app, we're building a web platform. It serves two groups: the public, and organizers. It could be two separate products, or one product where organizer features are switched on only for organizers.

**Status:** resolved — see "2026-10-04: Web platform shape decided" below. This entry stays for history.

## 2026-10-04: Web platform shape decided, built Nov–Dec by the same team, split into two sub-phases
**Decision (product owner):** one web product, not two. Default role is `member`; a small set of accounts get `organizer`, which unlocks extra routes (reviewing Call for Speakers / Call for Sponsors / Call for Donations submissions, a financial status ledger, granting the organizer role). Same Supabase Auth and design system as the app. Full detail in `docs/web-platform-brief.md`.

**App vs. web split (the product owner's framing, adopted as the working rule):** the app is the daily driver — anything offline, anything with state you come back to (tickets, drafts, check-in) stays there. The web platform is for walk-ins — people without the app doing a one-shot action (submit a form, read a page). Call for Speakers, Call for Sponsors and Call for Donations are the first three web surfaces because they're exactly that: one-shot public submissions. The door check-in scanner stays in the app — "organizer controls purely on web" was the product owner's first instinct, walked back the same day as "a bit optimistic"; it's a default for *new* organizer tooling, not a rule that moves already-decided features.

**Also decided 2026-10-04, captured in `docs/web-platform-brief.md`:**
- Call for Sponsors ("expects something in return": a speaking slot, booth, logo placement — a repeatable list, not a fixed dropdown) and Call for Donations ("no strings attached") are two distinct forms. Money for both likely flows through an existing **Open Collective account**; whether that needs one shared field or two separate ones is still a team decision (see "Still open").
- Organizer financials are a **status ledger** (e.g. "pledged → invoiced → paid"), manually updated — not a read-only view, and explicitly not full accounting/reconciliation.
- Web sign-in adds **Google** alongside GitHub (sponsor/donor contacts in finance or marketing mostly won't have GitHub). Apple sign-in stays iOS-app-only.
- The Call for X forms require sign-in to submit — no anonymous submissions.
- The web Call for Speakers writes to the same `talk_submissions` table the app uses — one CFP, two entry points, not two pots.
- Granting the `organizer` role happens only on the web (manually in Supabase for the MVP, or a small admin screen later) — never in the app.
- Sponsor tiers are a **hybrid model**: some tiers at a fixed money threshold, plus custom tiers for in-kind contributions (e.g. a venue host) that an organizer defines case by case. Exact thresholds and custom-tier names are still open.
- The web platform also hosts: Terms of Service (net new, needs legal review), the Privacy Policy and the account-deletion request page (both already planned as `docs/mvp.md` tasks F0-04/F0-05 — this is their home instead of a one-off static page), an About Us page, and a sponsor "what's in it for you" pitch.
- **Public pages ship first and separately.** The product owner confirmed this "100%": ToS, Privacy Policy, About Us, the sponsor pitch and the tier list can go live before any Call for X form exists. This is now **sub-phase W1**; the forms, auth, ledger and role-gating are **sub-phase W2**.

**Resourcing — decided, with a named risk:** built in **Nov–Dec 2026, by the same 4 engineers building Android**, not deferred to the Feb–Apr "Next" bucket `docs/mvp.md` assumed ("don't worry about us, we have enough coffee to spare"). `docs/mvp.md` and `docs/scopes/mvp-january.md` are **not changed** by this entry — the Android feature list and the ~100 engineer-day budget stand as written, which was already running ~8.5 days over before this additional scope. The accepted risk is that something gives: the Android list shrinks further, the January date slips, or the team sustains a harder pace than planned. Splitting into W1 (cheap, content-only) and W2 (the real engineering cost) is the mitigation on record — see `docs/web-platform-brief.md` §6.

**Update 2026-10-04 — W1 scoped, and the mitigation above only half holds.** `task-scoper` sized W1 at `docs/scopes/web-platform-w1-public-pages.md`: about 7.5 engineering days, 3 design days, 8 content/ops days (5.5 of them new), plus an **unsized legal review with no owner**. W1 is cheap, as expected. **It is not well-timed:** the privacy policy and deletion page must be live by about Nov 27 so Play closed testing (F0-08) can start and clear its 14-day window before January, which pulls about 6 of the 7.5 engineering days into S1–S2 — the two busiest Android sprints — and puts the unowned legal review on the Android critical path (it needs to finish by about Nov 20). "Cheap and separable" turns out to mean the Android plan is now about **16 engineer-days over**, not 8.5, with the gap concentrated at the start of the build rather than spread out. The reserve thinner versions (≈14.5 days) can close most of it, but that's now a real trade, not a cushion.

**Update 2026-10-04 (same day, later) — two of those resolved:**
- **Sponsors can ask for a speaking slot.** "They can have a speaking slot" — precedent: Huawei sponsored last year and provided a speaker. This resolves the conflict in the sponsor's favor, but **only half of it**: it reopens `sponsors-handoff-notes.md` decision #26 ("sponsors back whole events, never sessions," "sessions are curated through the open CFP only," the `SessionCard` "Sponsored" label removed) without saying which part of #26 still holds. **Not yet decided:** does the slot bypass CFP curation entirely, or does the sponsor's nominee still go through the normal review (sponsorship buys consideration, not the seat)? That decides whether decision #26 needs an actual follow-up and whether the deprecated "Sponsored" session label comes back. Pitch copy and the W2 form are written provisionally until this lands — see `docs/web-platform-brief.md` §9 question 4 and the scope's OQ-W7.
- **Web stack: React**, confirmed by the product owner. Not yet decided: which React framework/meta-framework — the acceptance criteria already written for W1 (full content with JS off, no client-side fetch, link-preview meta tags) require one that pre-renders (static export or SSR — e.g. Next.js, Remix, Astro, Gatsby); a plain client-rendered SPA would fail them. Hosting is also still open. Flagged in the scope's W1-01/OQ-W4.
- **Still unassigned:** which engineer owns W1, and which reserve thinner version(s) pay for its ~7.5 days (OQ-W10) — the product owner confirmed this is undecided as of this conversation.

**Still open (carried over, unchanged):**
- Whether Call for Sponsors and Call for Donations need one Open Collective field or two — pending a team meeting the product owner has already called. **This blocks W2**, not W1.
- The actual sponsor tier thresholds and custom-tier names.
- Legal review route/owner for the ToS and Privacy Policy, and the W1 engineer/thinner-version assignment (OQ-W10).

Full open-questions list and reasoning: `docs/web-platform-brief.md` and `docs/scopes/web-platform-w1-public-pages.md`.

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
