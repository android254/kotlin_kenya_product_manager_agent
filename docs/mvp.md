# MVP for January testing

Last updated 2026-10-02. Status: **draft for organizer review**. The product owner confirmed the borderline items on 2026-10-02: check-in scanner, push reminders and post-event ratings are in. The Content tab was briefly added, then removed the same day as non-crucial (it's in Later).

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
| 10 | **Push reminders** | A reminder the day before an RSVP'd event. A notice when a talk's status changes | The Notifications screen and its list, notification settings |

| 11 | **Post-event ratings** | After an RSVP'd and checked-in event, members rate the meetup and give each session a quick rating, with an optional comment for organizers only. Speakers see their aggregated feedback in Your talks. Home shows "After the meetup" | Recordings, recap card, sponsor poll results, anonymous comment screening tools (organizers use Studio) |

**Community tab in the MVP:** Jobs only, shown without a tab row. Content and People come later.

**Accessibility is part of the MVP, not extra work.** Everything the a11y notes mark "Must implement" for the screens above is part of each feature's acceptance criteria, including 200% text and 48dp/44pt touch targets.

## After January
Three buckets (agreed 2026-10-02):
- **Next:** planned for Feb–Apr 2027, after testing. What testers tell us can reorder it.
- **Later:** planned, but no date yet.
- **Not planned:** designed and kept in Figma, but parked until we have evidence or demand. We'll bring them back with a reason.

### Next (Feb–Apr 2027)
1. **Organizer web platform v1:** create and edit events, review talks, manage sponsors and jobs. It replaces Studio. (Its shape is still to be decided; see `docs/decisions.md`.)
2. **Public web event pages:** shareable links and link previews for events.
3. **People directory, with the full privacy controls** (they ship together).
4. **Event day:** event-day Home mode (Wi-Fi, now and next), offline ticket and check-in, walk-ins, waitlist.
5. **Notifications screen and notification settings.**
6. **Sponsor impact report** (built from MVP data), sponsor polls and live polls.
7. **Native iOS chrome** (if the January build ships shared UI on iOS).

### Later (planned, no date)
- Content tab (articles and newsletter as links out). It's cheap, but not crucial for testing
- Quick connect and consented booth leads
- Public profile, share card, Open to work
- Roles matching your topics, company pages, job poster stats
- Multi-city chapters and the chapter switcher
- Apple and Google Wallet passes
- Onboarding A/B test and guest mode (once installs are high enough)
- Recordings and the post-event recap
- Achievements, celebrations, motion polish

### Not planned (parked until there's evidence)
| Feature | Why it's parked | What would bring it back |
|---|---|---|
| Mentorship flow | Needs active mentors and moderation, and mentoring is already informal | Testers or organizers asking for it, and enough mentors volunteering |
| Kiswahili | The copy guide and layout test are done, but it doubles the copy work in every phase | Testers asking for it, or a chapter where it's the main language |
| Shareable meetup posters | Nice for visibility, but posters can be made outside the app for now | Sponsors asking for it, or organizers spending a lot of time on posters |
| Sponsored challenges and badges | Needs judging and prize logistics | A sponsor ready to run one |
| `SponsorMarquee` (auto-scrolling sponsor row) | Only needed once there are many sponsors | More than about 6 sponsors on one event |
| Job alerts | Needs notification settings and matching | Job seekers asking for it, once roles matching topics ships |

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
