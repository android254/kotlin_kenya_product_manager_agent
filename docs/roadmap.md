# Roadmap

Last updated 2026-10-02. Dates are targets, not promises.

| When | Phase | Goal | Where we plan |
|---|---|---|---|
| Oct 2026 | Onboarding and scoping | PM and design agents set up. Linear and Figma connected. Phase 1 scopes written and sized | Linear |
| Nov–Dec 2026 | Build, moving fast | **Android** app built for testing (KMP, iOS later). No public contributions yet | Linear |
| Jan–Feb 2027 | Testing | The app in testers' hands. Fix what blocks a public release | Linear |
| After testing | Open-source release | Repo made public. Backlog moves to GitHub Issues (`docs/github-project.md`). Public contributions open | GitHub |

## What this means for scoping
- **Nov–Dec is about 8 weeks.** At one to two weeks per scope, that's room for about 4–6 scopes if they run one after another, or more if design and engineering work in parallel. Phase 1 has to fit that, and everything else waits.
- **Testing starts in January,** so phase 1 should cover the flows testers need end to end: getting in (onboarding), finding an event, and showing up to it. That's a proposal, still to be agreed.
- **The designs already cover far more than 8 weeks of build** (sponsors, mentorship, posters, Kiswahili, event-day mode and more). Most of it will be cut from phase 1 on purpose. Cutting it doesn't mean it's dropped.
- **The app build opens with two reusable foundations, not a feature.** Domain models (extracted from the designs, nullable vs. non-nullable per field) and the design system / reusable components come first, in parallel, so the nine MVP features can then be split across engineers without blocking on each other. Decided 2026-10-08, see `docs/decisions.md`; scoped at `docs/scopes/foundation-domain-models-design-system.md`.
- **The web platform** is one product (decided 2026-10-04): public pages first (W1), then Call for Speakers / Call for Sponsors (part of W2). The team wants both **live before January 2027**, same 4 engineers as the app (decided 2026-10-08). This is firmer than the estimate behind it — W2 isn't sized yet, and W1 alone already pushed the Android plan over budget. See `docs/decisions.md` (2026-10-08) and `docs/web-platform-brief.md`.

## Answered (2026-10-02)
- **Testers:** the co-organizing team, Nairobi chapter members, and anyone who signs up. Open sign-up means public test tracks.
- **Builders:** about 4 engineers in Nov–Dec, so about 100 engineer-days of feature work. The MVP cut is in `docs/mvp.md`; the tasks and sprint plan are in `docs/scopes/mvp-january.md`.
- **Backend:** Supabase for the MVP.
