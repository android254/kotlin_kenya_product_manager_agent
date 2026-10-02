# MVP for January testing

Last updated 2026-10-02. Status: **draft for organizer review**.

## The bet
By January, a Nairobi chapter member can sign in, find the next meetup, RSVP, get in at the door, and submit a talk. Sponsors are visible on the events they back and can list jobs. Everything else in the designs waits for a later phase. It isn't dropped.

## Constraints
- **Team:** about 4 engineers, building Nov–Dec 2026. That's about 7 working weeks after Jamhuri Day and Christmas, or roughly 140 engineer-days. Take off about 30% for setup, reviews, bugs and store releases, which leaves **about 100 days of feature work**.
- **Stack:**
  - App: Kotlin Multiplatform with Compose Multiplatform, for Android and iOS.
  - Backend: Supabase (Postgres, Auth, Storage, Edge Functions).
- **Testers (Jan–Feb):** the co-organizing team, chapter members, and anyone who signs up. Open sign-up means public test tracks (Play open or closed testing, plus a TestFlight public link). TestFlight's beta review takes a few days, so the build has to be ready in the first week of January.
- **No organizer web platform in the MVP.** Organizers manage events, talks, sponsors and jobs in Supabase Studio, following a short runbook. The web platform (public and organizer) comes after we decide its shape (see `docs/decisions.md`).

## Who gets what in January
| Group | Value in the MVP |
|---|---|
| Community members | Find meetups, RSVP, get a ticket, see the agenda and speakers, browse jobs |
| Speakers | Submit a talk from the phone and see its status (submitted, accepted, declined) |
| Sponsors | Their logo on the events they back, a sponsors page, and their jobs on the job board. From day one we record RSVPs, check-ins and event page views, so the impact report can be built later from real data |
| Organizers | Check people in at the door from the app. Run everything else from Studio |

## In the MVP
Sizes are rough (S = under a day, M = 1–3 days, L = 3–5 days). The task-scoper breaks each one down in `docs/scopes/mvp-january.md`.

| # | Feature | What's in | Cut from the design for now |
|---|---|---|---|
| 1 | **Foundation** | KMP project, CI, theme and design tokens (light and dark), the core components the MVP screens use, four root tabs, Supabase project, schema and row-level security, crash reporting, analytics events, store test tracks | Motion choreographies, celebrations, all 127 components (we build only what MVP screens use) |
| 2 | **Sign in and onboarding** | Welcome, then Continue with GitHub (plus Sign in with Apple on iOS, which Apple requires). Three interest steps. Interests are saved to the profile | The A/B test (it needs about 1,000 installs per variant, more than testing will bring), guest mode and merging guest picks into an account, personalised titles |
| 3 | **Home** | Greeting, the next meetup card, shortcuts to what exists (Jobs, Submit a talk), and a call for speakers (CFP) promo while it's open. Loading, empty and error states | Chapter switcher, Quick connect and People tiles, sponsored challenge promo |
| 4 | **Events** | Events list with the week/month calendar, Event detail (date, venue to Maps, seats, agenda), Session detail (speaker, abstract), RSVP and cancel with capacity and "Full", add to calendar, sponsor row on Event detail | Waitlist, saved sessions, live polls, sponsor polls |
| 5 | **Ticket and check-in** | A QR ticket after RSVP. An organizer-only scanner with checked in, already checked in, and not on the list. Online only | Offline ticket and offline check-in queue, walk-ins, Apple and Google Wallet, event-day Home mode (Wi-Fi, now and next) |
| 6 | **Submit a talk** | The three-step form with draft saving, submitted state, and "Your talks" status on Profile. Organizers review in Studio | Review step before submitting, speaking history card, mentor matching |
| 7 | **Profile and settings** | Own profile (from GitHub, editable bio, topics, links), my RSVPs, my talks. Settings: theme follows the system, sign out, **delete account** (required by both stores), privacy policy and code of conduct links | Public profile and share card, Open to work, achievements, Member profile, the full privacy controls |
| 8 | **Jobs** | The Jobs tab: job list and Job detail with an external apply link. Organizers post jobs in Studio. Featured and sponsor badge | Roles matching your topics, company pages, job poster stats, job alerts |
| 9 | **Sponsors** | `SponsorRow` on Event detail, an "Our sponsors" list and a simple Sponsor detail (logo, about, link, open roles). Events record views, RSVPs and check-ins for the future report | Impact report, booth leads, challenges and badges, sponsor polls, `SponsorMarquee`, automatic logo plates |
| 10 | **Push reminders** *(should have)* | A reminder the day before an RSVP'd event. A notice when a talk's status changes | The Notifications screen and its list, notification settings |

**Community tab in the MVP:** only Jobs ships. The Content tab is a list of external links (articles on Medium), which is cheap, so it goes in if there's time. People ships later. If Jobs is the only tab, we show it on its own, with no tab row.

**Accessibility is part of the MVP, not extra work.** Everything the a11y notes mark "Must implement" for the screens above is part of each feature's acceptance criteria, including 200% text and 48dp/44pt touch targets.

## Later (planned, not in January)
Roughly in the order I'd pick them up after testing, subject to what testers tell us:
1. **Post-event loop:** rate the meetup and speaker feedback. Testing runs through real meetups, so this is the first thing we'd want.
2. **People directory and full privacy controls** (they ship together, because the directory needs the privacy controls)
3. Notifications screen and notification settings
4. Event-day Home mode, offline ticket and check-in, Wallet passes
5. Sponsor impact report (by then the MVP has collected the data it needs), sponsor polls and live polls
6. Quick connect and consented booth leads
7. Public profile, share card and Open to work, roles matching your topics, company pages
8. Mentorship
9. Shareable meetup posters
10. Multi-city chapters
11. Kiswahili
12. Onboarding A/B test (once installs are high enough), guest mode
13. Achievements, celebrations, sponsored challenges, motion polish
14. The web platform (public and organizer), once its shape is decided

## What could break the plan
- **Native iOS chrome.** The designs use native iOS 26 chrome (`TabView`, native navigation bars, sheets) with shared content. Building that properly roughly doubles the shell work. **Proposal:** in January, ship shared Compose UI on iOS too, adding native pieces only where a platform requires them (Sign in with Apple, share sheet, calendar, camera permission). Native chrome comes after. Engineering and design need to agree to this.
- **Organizer tooling.** Studio works for a few organizers who are comfortable with tables. If that's not true of our organizers, we need a thin admin early, and it takes capacity from the list above.
- **Store reviews and the app's name.** Play requires closed testing with 12 or more testers for 14 days before production. TestFlight's public link needs beta review. Both need privacy policies and account deletion. Start the store setup in November, not December.
- **Data and privacy.** We store GitHub profiles, RSVPs and check-ins. We need a privacy policy, and a decision on what sponsors may see, before testers sign up. Kenya's Data Protection Act applies.

## Decisions needed
| Question | Who decides |
|---|---|
| Is this the right cut for January (the table above)? | Product owner and organizers |
| Shared Compose UI on iOS for January, native chrome later? | Engineering and design |
| Is Supabase Studio enough as the organizer tool until the web platform? | Organizers |
| Is GitHub (plus Apple) sign-in enough, or do we need email sign-in for members without GitHub? | Product owner |
| Who owns the store accounts, privacy policy and app name? | Organizers |
| Which meetups fall in the Jan–Feb testing window, so we can test RSVP and check-in for real? | Organizers |
