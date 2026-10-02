# MVP for January testing: task breakdown

Last updated 2026-10-02. Status: **draft for product owner, organizer and engineering review.**
Source of truth for what is in and what is cut: `docs/mvp.md`. Designs: `kotlin-kenya-designer-agent` (Figma file + `docs/*-handoff-notes.md`). This scope covers the whole MVP as one phase (Nov 2 – Dec 23 2026, release to testers Jan 4–8 2027). Each feature gets its own detailed scope later; this file is the plan and the sizing.

---

## Problem
Nairobi chapter members have no single place to find the next meetup, RSVP, get in at the door and submit a talk. Organizers run RSVPs, check-in, talks, sponsors and jobs by hand. We want one app, Android and iOS, in testers' hands in the first week of January 2027, so real Jan–Feb meetups can run through it.

## Users
| Who | What they need from January |
|---|---|
| Community members (Nairobi chapter, open sign-up testers) | Sign in, find meetups, RSVP, show a ticket, see agenda and speakers, browse jobs |
| Speakers | Submit a talk from the phone and see its status |
| Sponsors (indirect, they don't use the app as sponsors) | Logo on the events they back, a sponsors list and page, jobs on the board. Views, RSVPs and check-ins recorded for a later report |
| Organizers | Check people in at the door from the app. Everything else in Supabase Studio, following a runbook |

## Success signal
Proposed targets for the end of testing (28 Feb 2027). The product owner confirms the numbers.
- At least one real meetup run end to end in the app: RSVPs taken in the app and **at least 70% of attendees checked in with the scanner**.
- **At least 100 testers signed in**, and at least 40% of them RSVP to a meetup.
- **At least 10 talks submitted** through the app while a CFP is open.
- **Crash-free sessions at 99% or higher** on both platforms.
- Organizers run the events, talks, sponsors and jobs for a meetup from Studio without engineering help.
- No store or beta review is rejected for privacy or account deletion.

---

## User stories
One to three stories per feature. Each feature's detailed scope adds the rest.

### Feature 1: Foundation
- **US-1.1:** As a **chapter member joining the test**, I want to install the app from the Play test track or the TestFlight link and move between Home, Events, Community and Profile so that I can try everything on the phone I already use.
- **US-1.2:** As an **organizer running the test**, I want crashes and key actions reported without personal data so that we can fix what blocks a public release.

### Feature 2: Sign in and onboarding
- **US-2.1:** As a **new member**, I want to continue with GitHub (or Sign in with Apple on iOS) so that I can join without creating another password.
- **US-2.2:** As a **new member**, I want to pick the topics I care about in three short steps so that the app knows what I'm interested in, and I can change them later in Profile.

### Feature 3: Home
- **US-3.1:** As a **member**, I want to see the next meetup as soon as I open the app so that I know what's coming without searching.
- **US-3.2:** As a **member who might speak**, I want to see when the call for speakers is open so that I don't miss the deadline.

### Feature 4: Events
- **US-4.1:** As a **member**, I want to browse upcoming meetups and workshops and open one so that I can see the date, venue, seats and agenda.
- **US-4.2:** As a **member**, I want to RSVP to an event and cancel if my plans change so that I have a seat and the organizers know who's coming.
- **US-4.3:** As a **member deciding whether to attend**, I want to read a session's speaker and abstract so that I know whether the talk is for me.

### Feature 5: Ticket and check-in
- **US-5.1:** As a **member with an RSVP**, I want to show a QR ticket at the door so that I get in quickly.
- **US-5.2:** As an **organizer at the door**, I want to scan a ticket and see at once whether the person is checked in, already checked in or not on the list so that the queue keeps moving and the attendance numbers are real.

### Feature 6: Submit a talk
- **US-6.1:** As a **speaker**, I want to submit a talk in three steps, with my draft saved as I go, so that I can do it on my phone in more than one sitting.
- **US-6.2:** As a **speaker**, I want to see whether my talk is submitted, accepted or declined so that I don't need to chase the organizers.

### Feature 7: Profile and settings
- **US-7.1:** As a **member**, I want to edit my bio, topics and links on top of my GitHub profile so that my profile says what I work on.
- **US-7.2:** As a **member**, I want to see my RSVPs and talks in one place so that I can find my ticket and my submissions.
- **US-7.3:** As a **member leaving the community**, I want to delete my account from the app so that my personal data is removed.

### Feature 8: Jobs
- **US-8.1:** As a **member looking for work**, I want to browse open roles and open the company's application page so that I can apply for roles from the community.

### Feature 9: Sponsors
- **US-9.1:** As a **member**, I want to see who supports an event and learn about them so that I know which companies back the community and have open roles.
- **US-9.2:** As a **sponsor**, I want our event page views, RSVPs and check-ins recorded from day one so that a later impact report can use real numbers. (Recording only. The report is cut.)

### Feature 10: Push reminders (should have)
- **US-10.1:** As a **member with an RSVP**, I want a reminder the day before so that I don't forget to come, or I free my seat.
- **US-10.2:** As a **speaker**, I want a notification when my talk's status changes so that I hear the decision without opening the app.

---

## Acceptance criteria
Only key behaviour and the states that matter. Everything the a11y handoff notes mark "Must implement" for these screens is part of each feature's acceptance (including 200% text, 48dp/44pt targets, headings, live regions and merged card semantics). The notes are listed under each feature.

### Global states (apply to every screen with remote data)
- **Loading:** **Given** data is being fetched **When** the screen opens **Then** a skeleton shows with one spoken description ("Loading events"), and "… loaded" is announced when content arrives.
- **Error:** **Given** a request fails **When** the screen can't load **Then** the Error StateMessage shows with "Try again". Its title is a polite live region, and focus moves to "Try again" after a failed retry.
- **Offline:** **Given** the device has no connection **When** a screen needs data it doesn't have **Then** the Offline StateMessage shows with "Try again". Actions (RSVP, submit, save) fail with a snackbar and keep the member's input. There is no offline cache in the MVP.
- **Theme:** **Given** the system is in dark mode **When** the app opens **Then** it uses the dark theme (it follows the system, and there is no picker).

### F1 Foundation
- **Given** I'm on the Events tab, scrolled down **When** I switch to Profile and back **Then** Events keeps its scroll position and back stack. Reselecting the tab scrolls to the top.
- **Given** the font scale is 200% **When** I open any MVP screen **Then** no information text is clipped or ellipsized, nav labels are capped at 14sp and the app bar title at 1.5× (`a11y-font-scale-2026-10-02.md`).
- **Given** the app crashes **When** it is next opened **Then** the crash appears in the crash tool with symbols for both platforms and no personal data.

### F2 Sign in and onboarding (variant B only; `onboarding-handoff-notes.md`, `onboarding-ab-test.md` analytics without `variant`)
- **Sign in:** **Given** I'm on Welcome **When** I complete GitHub sign-in **Then** my profile is created from GitHub (name, handle, avatar) and I land on Step 1 of 3.
- **Apple (iOS):** **Given** I'm on iOS **When** Welcome shows **Then** the system Sign in with Apple button sits above "Continue with GitHub", at the same size.
- **Failure:** **Given** sign-in fails or I'm offline **When** I return to the app **Then** a long snackbar "Couldn't sign you in" with Retry shows above the buttons, and focus returns to "Continue with GitHub". If I cancel, I'm back on Welcome with no error.
- **Interests:** **Given** I'm on a step with nothing selected **When** I look at Continue **Then** it is disabled with the reason "Select at least one topic". The count ("3 topics selected") is announced after each toggle.
- **Saved:** **Given** I finish Step 3 or tap "Skip for now" **When** I reach Home **Then** my picks (possibly none) are saved to my profile, and next launch skips onboarding.

### F3 Home (`home-screen-handoff-notes.md`, minus chapter switcher, People/Quick connect tiles, sponsored promo, journey stats)
- **Next meetup:** **Given** a published upcoming event exists **When** I open Home **Then** the Featured EventCard shows the next event I've RSVP'd to, or else the next upcoming event, with "View event".
- **Empty:** **Given** no upcoming event is published **When** I open Home **Then** an empty state says there's no meetup scheduled yet, with a link to Events.
- **CFP promo:** **Given** a CFP is open **When** I open Home **Then** the CFP PromoCard shows with its close date and "Submit a talk". When the CFP has closed, the card is not shown.

### F4 Events (`events-handoff-notes.md`, `notifications-session-handoff-notes.md` session part)
- **Browse:** **Given** events are published **When** I open Events **Then** I see upcoming events (calendar week/month view, or a month-grouped list if cut C1 is taken). Each EventCard opens Event detail. **Empty:** "No events on Mon, 25 Jan" (calendar) or "No upcoming events" (list).
- **RSVP:** **Given** seats remain **When** I tap "RSVP for free" **Then** the RSVP is saved, "You're RSVP'd" is announced, focus moves to "Add to calendar", and "Show my ticket" appears.
- **Few seats / Full:** **Given** fewer than 15% of seats remain **Then** the seats tile uses the Warning tone with text. **Given** 0 seats remain **Then** the badge reads "Full" and RSVP is disabled with the reason. There's no waitlist.
- **Race:** **Given** two members RSVP for the last seat at the same moment **When** both requests reach the server **Then** exactly one succeeds, and the other sees "This event just filled up".
- **Cancel:** **Given** I'm RSVP'd **When** I tap Cancel RSVP and confirm "Cancel your RSVP?" **Then** my seat is released and "RSVP cancelled" is announced. "Keep RSVP" changes nothing.
- **Venue:** **When** I tap the venue row **Then** the maps app opens at the venue ("Open in Maps").
- **Session:** **Given** an agenda item **When** I open it **Then** I see title, time (EAT), room, speaker (name, role, photo or initials) and abstract.
- **Offline RSVP:** **Given** I'm offline **When** I tap RSVP **Then** a snackbar says I'm offline, and the button stays in its previous state.

### F5 Ticket and check-in (`event-day-handoff-notes.md` ticket and scanner only, online only)
- **Ticket:** **Given** I'm RSVP'd **When** I open "Show my ticket" **Then** the QR shows on a white plate in both themes, with my name, the event and the ticket ID. Brightness goes to full and the screen stays on until I leave. The QR has the description "Ticket QR code for {event}, ticket {id}".
- **Ticket offline:** **Given** I'm offline **When** I open the ticket **Then** I see "Connect to the internet to show your ticket" with Try again. Offline tickets are cut.
- **Scanner entry:** **Given** I'm an organizer **When** I open Event detail **Then** the overflow has "Check-in scanner". Members never see it.
- **Checked in:** **Given** a valid ticket for this event that hasn't been scanned **When** I scan it **Then** I see "Checked in · 9:21 AM" and "Attendee 142 of 180", with a light haptic. The result is announced assertively and dismisses after 2 s.
- **Already checked in:** **Given** a ticket that was already scanned **When** I scan it **Then** I see "Already checked in · {time}", who scanned it, and a double buzz.
- **Not on the list:** **Given** a QR that isn't a valid ticket for this event (another event, a cancelled RSVP, a forged code) **When** I scan it **Then** I see "Not on the RSVP list" with "Scan again", and a double buzz.
- **Offline scanner:** **Given** the scanner has no connection **When** I scan **Then** a blocking error says check-in needs a connection, and nothing is recorded.
- **Camera denied:** **Given** I denied camera access **When** I open the scanner **Then** the rationale and "Open settings" show.

### F6 Submit a talk (`submit-a-talk-handoff-notes.md`, minus mentor card and review step)
- **Validation:** **Given** the title is empty or longer than 65 characters **When** I tap Continue **Then** focus moves to the title, with "Enter a talk title, up to 65 characters".
- **Tracks:** **Given** 3 tracks are selected **Then** the others are disabled and "Maximum 3 tracks" is announced.
- **Draft:** **Given** I've entered a title **When** I go back from Step 1 or leave the app **Then** the draft is saved, "Draft saved · Undo" shows, and the draft appears in "Your talks" to resume.
- **Submit:** **Given** steps 1 and 2 are valid **When** I tap "Submit talk" **Then** the talk's status is Submitted, the Submitted screen shows with Close (no back), and "Talk submitted" is announced.
- **Closed CFP:** **Given** no CFP is open **When** I try to submit from any entry point **Then** I see "The call for speakers is closed", and existing drafts are read-only.
- **Status:** **Given** an organizer changes my talk's status in Studio **When** I open Profile **Then** "Your talks" shows Accepted or Declined as text in a status badge (colour is never the only signal).
- **Offline submit:** **Given** I'm offline **When** I tap Submit **Then** I see a snackbar saying I'm offline, and nothing I entered is lost.

### F7 Profile and settings (`job-member-editprofile-handoff-notes.md` edit part, `settings-handoff-notes.md` trimmed)
- **Edit:** **Given** I edit my bio, topics or links **When** I tap Save **Then** the changes persist, "Profile updated" shows and focus returns to "Edit profile". The GitHub handle is read-only. Invalid links show an inline error and get focus.
- **Discard:** **Given** I have unsaved edits **When** I tap Close or system Back **Then** "Discard changes?" offers Keep editing / Discard.
- **My RSVPs:** **Given** I've RSVP'd **When** I open Profile **Then** upcoming RSVPs are listed first, each opening Event detail. **Empty:** "No RSVPs yet" with a link to Events.
- **Delete account:** **Given** I confirm "Delete account" (in error colour, focus on the dialog title) **When** deletion succeeds **Then** my auth user, profile, topics, drafts and device tokens are deleted, my RSVPs and check-ins are anonymised (pending OQ-8), I'm signed out and I see Welcome. **Offline:** the dialog shows an error and nothing is deleted.
- **Sign out:** **When** I tap "Sign out" on Profile **Then** my session and local data are cleared and I see Welcome.

### F8 Jobs (`community-handoff-notes.md` job board, `job-member-editprofile-handoff-notes.md` job detail, `sponsors-handoff-notes.md` #5)
- **List:** **Given** open jobs exist **When** I open the Community tab **Then** I see Jobs on its own, with no tab row. At most 2 featured roles are pinned on top, labelled "Featured · Community sponsor". The rest are newest first. **Empty:** "No open roles right now".
- **Apply:** **When** I tap "Apply on company site" **Then** the link opens in the in-app browser, announced as "opens in browser".
- **Closed:** **Given** the closing date has passed **Then** Apply is disabled but still focusable, and reads "unavailable, applications closed".

### F9 Sponsors (`sponsors-handoff-notes.md` #3 and simple #4, no SponsorMarquee, no automatic plates)
- **Attribution:** **Given** an event has sponsors **When** I open Event detail **Then** a labelled SponsorRow sits after the RSVP block (One: name and tier, opens Sponsor detail; Few: 2–3 logos; Many: 2 + "+N", opens Our sponsors). It is the screen's only sponsor surface, and each logo reads "Supported by {name}, {tier}".
- **Sponsor detail:** **When** I open a sponsor **Then** I see logo, name, about, "Visit website" (external), open roles (if any) and "Sponsors see total page views, never who viewed this page". **No roles:** that section is hidden.
- **Recording:** **Given** I open Event detail, Sponsor detail or Job detail **Then** one view per entity per app session is recorded server-side. Clients can't read the views.

### F10 Push reminders (should have)
- **Reminder:** **Given** I'm RSVP'd and allowed notifications **When** it is 18:00 EAT the day before the event **Then** I get one reminder. Tapping it opens Event detail. No reminder is sent if I cancelled.
- **Permission:** **Given** I haven't been asked yet **When** my first RSVP succeeds **Then** the app asks for notification permission (Android 13+ and iOS). There's no in-app settings screen.
- **Talk status:** **Given** my talk changes to Accepted or Declined **Then** I get one notification that opens "Your talks".

---

## Out of scope
Everything in the "Cut from the design for now" column of `docs/mvp.md`, and in particular:
- **Onboarding:** the A/B test (variant B only), guest mode and merging guest picks, personalised step titles, Step 0 chapter picker, the celebration.
- **Home:** chapter switcher, Quick connect and People tiles, sponsored challenge promo, journey stats and achievements, trending topics, event-day Home mode, the notifications bell.
- **Events:** waitlist, saved sessions and bookmarks, live polls, sponsor polls, the recording alert, post-event rating and recap.
- **Ticket and check-in:** offline ticket, offline check-in queue, walk-ins, undo check-in (organizers fix it in Studio), Apple and Google Wallet.
- **Submit a talk:** review step, speaking history card, mentor matching (the mentor card is removed), editing a talk after submission.
- **Profile and settings:** public and member profiles, share card, Open to work, achievements, privacy controls, notification settings, theme and language pickers, download my data, changing the profile photo (the GitHub avatar is used).
- **Jobs:** roles matching your topics, search and filters, saved jobs, company pages, poster stats, job alerts, People tab. **The Content tab is a should-have** (tasks F8-06 to F8-08), not committed.
- **Sponsors:** impact report, booth leads, challenges and badges, sponsor polls, `SponsorMarquee`, automatic logo plate detection (a manual plate field in Studio is in).
- **Push:** the Notifications screen and list, notification settings.
- **Platform:** native iOS chrome (assumed; see OQ-2), the web platform (public and organizer), organizer screens in the app other than the scanner, Kiswahili, multi-city, tablets beyond a content-width cap, email sign-in.
- **Share event** (`docs/mvp.md` mentions the share sheet as a native piece, but feature 4 doesn't list sharing; see OQ-12).

---

## Tasks
Sizes: **S** = under a day (0.5), **M** = 1–3 days (2), **L** = 3–5 days (4). Areas: design, Android, iOS, shared/KMP, backend/Supabase, content/ops.
- **OH** marks setup and release work that `docs/mvp.md` counts in the 30% overhead (CI, release lanes, regression QA).
- **Cut Cn** marks a task that is on the cut ladder (see Totals).

### F0 Release, store and QA (cross-cutting)
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F0-01 | Confirm who owns the store accounts. Enrol in the Apple Developer Program as an organization (needs a D-U-N-S number) and create the Play Console organization account. Add the engineers | content/ops | S | — |
| F0-02 | Check the app name (including use of "Kotlin" under JetBrains' brand rules). Set the application/bundle IDs and write the store listing copy and screenshots | content/ops | M | F0-01, F0-03 |
| F0-03 | App icon and store screenshot frames | design | S | — |
| F0-04 | Privacy policy under Kenya's Data Protection Act 2019 (data inventory, purposes, retention, sponsors see aggregates only, deletion), hosted on a static page | content/ops | M | F1-14 |
| F0-05 | Account deletion web page and request form (Play requires a web link as well as in-app deletion) | content/ops | S | F0-04, F7-07 |
| F0-06 | Play: Data safety form, content rating, target audience, app access (review test account) | content/ops | S | F0-01, F0-04 |
| F0-07 | App Store Connect: app record, App Privacy labels, export compliance, Sign in with Apple capability, beta test info, review demo account | content/ops | S | F0-01, F0-04 |
| F0-08 | Play closed testing track with 12 or more opted-in testers (organizers) **started by Nov 30**, so the 14-day clock runs out before January | content/ops | S | F0-06, F1-15 |
| F0-09 | Submit TestFlight external group for beta review **Dec 21–23**. Turn on the public link and Play open testing (or a widened closed test) Jan 4–8 | content/ops | S | F0-07, F0-08, F1-16 |
| F0-10 | Tester onboarding: sign-up form, install guide, feedback channel, known-issues list | content/ops | S | F0-09 |
| F0-11 | Supabase Studio runbook for organizers: create an event, sessions and speakers; attach sponsors and set logo plates; post jobs; open a CFP; review talks and change their status; grant the organizer role; handle deletion requests; what never to touch | content/ops | M | F4-02, F6-02, F8-02, F9-02 |
| F0-12 | Runbook dry run with two organizers on the dev project. Fix the gaps | content/ops | S | F0-11 |
| F0-13 | Accessibility pass 1, Android: TalkBack, 200% font, 48dp targets, dark theme on F2–F5 screens. File bugs | Android | M | F2-07, F3-03, F4-07, F5-09 |
| F0-14 | Accessibility pass 2, iOS: VoiceOver, Dynamic Type, 44pt on all screens, plus Android re-check of F6, F7 and F9 | iOS | M | F6-07, F7-04, F9-04 |
| F0-15 | Regression QA on a device matrix (low-end Android at min SDK, current Android, small iPhone, current iPhone) **OH** | shared/KMP | M | all features |
| F0-16 | Production Supabase hardening: RLS review of every table, auth redirect URLs, rate limits, point-in-time recovery, secrets (no service-role key in the app) | backend/Supabase | M | all schema tasks |
| F0-17 | Release candidate builds promoted to tester tracks; release notes | content/ops | S | F0-09 |

### F1 Foundation
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F1-01 | KMP + Compose Multiplatform project: modules, DI, navigation library, dev/prod build config, min OS versions | shared/KMP | M | — |
| F1-02 | App shell: four root tabs, per-tab back stacks with saved state, reselect scrolls to top, deep link scheme `android254://` | shared/KMP | M | F1-01 |
| F1-03 | Theme and tokens: M3 colour roles light/dark, Space Grotesk / Inter / JetBrains Mono, spacing, shape, font-scale caps | shared/KMP | M | F1-01 |
| F1-04 | Core components A: Button, IconButton, Chip, TextField, TopAppBar (Home, Small), NavigationBar, ListItem, SettingsRow, SectionHeader, StatusBadge, Avatar (photo or initials). Focus states, min heights | shared/KMP | L | F1-03 |
| F1-05 | Core components B: StateMessage (Empty, Error, Offline), Skeleton, SnackbarHost, AlertDialog (stacked above 1.3×), BottomActionBar Row/Stacked, InlineNote, OptionCard, StepIndicator | shared/KMP | M | F1-03 |
| F1-06 | Cards: EventCard (Featured, Compact), SessionCard, JobCard (Featured, Verified), PromoCard, StatTile (tones with icon), ShortcutTile. Merged semantics and 200% rules | shared/KMP | L | F1-04 |
| F1-07 | Supabase dev and prod projects, Supabase CLI migrations in the repo, supabase-kt client, environment config | backend/Supabase | M | — |
| F1-08 | Base schema: `profiles` (1:1 with `auth.users`), `role` (member, organizer), `topics`. RLS pattern and SQL tests | backend/Supabase | M | F1-07 |
| F1-09 | Data layer: repositories, error mapping, connectivity monitor, a shared UI state (loading, content, empty, error, offline) | shared/KMP | M | F1-01, F1-07 |
| F1-10 | Image loading (Coil 3) with initials fallback | shared/KMP | S | F1-01 |
| F1-11 | Storage buckets (event covers, sponsor logos, speaker photos): public read, organizer write | backend/Supabase | S | F1-08 |
| F1-12 | Crash reporting on Android and iOS, with symbol upload in CI | shared/KMP | M | F1-15, F1-16 |
| F1-13 | Analytics: choose the tool, shared tracker interface, screen views, user ID after sign-in, no personal data in properties | shared/KMP | M | F1-01, F1-14 |
| F1-14 | Analytics event catalogue (see "Analytics events" below) | content/ops | S | — |
| F1-15 | Android CI (PR build, tests, lint) and upload to the Play internal track, with upload key and Play App Signing **OH** | Android | M | F1-01, F0-01 |
| F1-16 | iOS CI (macOS runner, build, tests), signing, TestFlight upload **OH** | iOS | M | F1-18, F0-01 |
| F1-17 | Dev seed data (fictional events, sessions, speakers, sponsors, jobs from the placeholder media). Extended as schemas land | backend/Supabase | S | F1-08 |
| F1-18 | iOS host app: Xcode project, Compose entry point, launch screen, Info.plist usage strings (camera, calendar) | iOS | S | F1-01 |
| F1-19 | CI applies migrations: dev on merge, prod with manual approval **OH** | backend/Supabase | S | F1-07, F1-15 |
| F1-20 | External link opener (Custom Tabs / SFSafariViewController) with "opens in browser" semantics | shared/KMP | S | F1-01 |
| F1-21 | Design: MVP navigation. Community tab shows Jobs alone (no TabRow), drawer trimmed to Submit a talk · Our sponsors · Code of conduct · About · Settings, no notifications bell. Alternative with no drawer for cut C2 | design | S | — |
| F1-22 | Trimmed drawer, the same shared drawer on iOS **Cut C2** | shared/KMP | M | F1-02, F1-21 |

### F2 Sign in and onboarding
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F2-01 | Design: variant B trimmed. Welcome without guest, neutral step titles, no Step 0, no celebration (Step 3 goes to Home), iOS Welcome with Apple | design | S | — |
| F2-02 | Supabase Auth: GitHub OAuth app and Apple provider, redirect URLs, a trigger that creates `profiles` from GitHub (name, handle, avatar) | backend/Supabase | M | F1-08 |
| F2-03 | GitHub sign-in in the app: OAuth through the browser with a deep-link callback, session persistence and refresh, failed snackbar with Retry | shared/KMP | M | F1-02, F1-07, F2-02 |
| F2-04 | Android OAuth callback (Custom Tabs, intent filter) | Android | S | F2-03 |
| F2-05 | Sign in with Apple on iOS: system `SignInWithAppleButton`, ID token to Supabase | iOS | M | F2-02, F1-18 |
| F2-06 | Welcome screen ("Karibu" as a `sw` span, legal links) | shared/KMP | S | F1-05, F2-01 |
| F2-07 | Interest steps 1–3: OptionCards (checkbox role), polite count, disabled Continue with reason, Skip for now, StepIndicator, sticky footer; saves picks | shared/KMP | M | F1-05, F2-08 |
| F2-08 | `profile_topics` table with RLS (own rows), topics catalogue seeded | backend/Supabase | S | F1-08 |
| F2-09 | Launch routing: signed out → Welcome, onboarding not done → steps, otherwise Home | shared/KMP | S | F2-03 |
| F2-10 | Onboarding analytics events | shared/KMP | S | F1-13, F2-07 |

### F3 Home
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F3-01 | Design: Home MVP. Greeting, next meetup, two shortcut tiles (Jobs, Submit a talk), CFP PromoCard while open, decide whether to keep the FAB. Default, Empty (new member), Loading, Error, Offline, 200%, Dark, iOS | design | M | F1-21 |
| F3-02 | `cfps` table (title, opens_at, closes_at). Query for the next event with my RSVP status; open jobs count | backend/Supabase | S | F4-02 |
| F3-03 | Home UI: time-of-day greeting with first name, Featured EventCard, shortcuts, CFP promo, headings | shared/KMP | M | F1-06, F3-01, F3-02 |
| F3-04 | Home loading, empty, error and offline states with announcements | shared/KMP | S | F3-03 |
| F3-05 | Home analytics events | shared/KMP | S | F1-13, F3-03 |

### F4 Events
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F4-01 | Design: Event detail MVP. Full with no waitlist (disabled "Full" + reason), no bookmark or session save, SponsorRow instead of the marquee, "Show my ticket", organizer overflow. Session detail with no poll, recording or bookmark. Month-grouped list alternative for cut C1 | design | M | — |
| F4-02 | Schema: `events` (type, start/end, venue, address, lat/lng, capacity, status, cover), `sessions`, `speakers` (optional `profile_id`), `session_speakers`. RLS: public read of published rows, organizer write | backend/Supabase | M | F1-08 |
| F4-03 | RSVP and cancel as Postgres functions: an atomic capacity check (row lock), idempotent, a `seats_left` view. RLS on `rsvps` (own rows) | backend/Supabase | M | F4-02 |
| F4-04 | Calendar component: CalendarDay/Month, week/month toggle, marker shapes, merged cell semantics, live month title **Cut C1** | shared/KMP | L | F1-04 |
| F4-05 | Events tab: calendar with a selected-day list (or a month-grouped list after C1). Loading, empty, error and offline states | shared/KMP | M | F1-06, F4-02 (F4-04 unless C1) |
| F4-06 | Event detail: hero, info rows, StatTiles with tone, agenda SessionCards, pane title, states | shared/KMP | L | F1-06, F4-01, F4-02 |
| F4-07 | RSVP and cancel UI: button states (open, few seats, full, RSVP'd), cancel AlertDialog, announcements, focus to Add to calendar, errors | shared/KMP | M | F4-03, F4-06 |
| F4-08 | Venue opens Maps (geo URI / Apple Maps URL) | shared/KMP | S | F4-06 |
| F4-09 | Add to calendar on Android (CalendarContract insert intent) | Android | S | F4-07 |
| F4-10 | Add to calendar on iOS (EventKitUI editor, usage string) **Cut C8** | iOS | M | F4-07, F1-18 |
| F4-11 | Session detail screen: hero with time in EAT, speaker row, abstract, states **Cut C6 → S as an expandable agenda row** | shared/KMP | M | F4-06 |
| F4-12 | Events analytics events | shared/KMP | S | F1-13, F4-07 |

### F5 Ticket and check-in
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F5-01 | Design: scanner MVP results (no walk-in, no undo, offline error), ticket without Wallet or offline note | design | S | — |
| F5-02 | Ticket token: a signed token (HMAC with a server secret over event, member and nonce) created with the RSVP; `get_ticket` function; readable ticket ID | backend/Supabase | M | F4-03 |
| F5-03 | Ticket screen: TicketCard Full, QR rendering, white plate, entry from Event detail and Home | shared/KMP | M | F1-06, F5-02 |
| F5-04 | Android: full brightness and keep screen on while the ticket shows | Android | S | F5-03 |
| F5-05 | iOS: full brightness and idle timer off while the ticket shows | iOS | S | F5-03 |
| F5-06 | `check_in` function: verify the token, organizers only, return checked in / already (time, by whom) / not on list, write `check_ins` with the organizer's ID, count | backend/Supabase | M | F5-02 |
| F5-07 | Android scanner camera: CameraX + ML Kit barcode, permission rationale | Android | M | F1-18 |
| F5-08 | iOS scanner camera: AVFoundation through UIKit interop, usage string **Cut C3** | iOS | M | F1-18 |
| F5-09 | Shared scanner UI: result sheet (Success, Warning, Error), assertive announcement, haptics, 2 s auto-dismiss, counts, offline error, organizer-only entry | shared/KMP | M | F5-06, F5-07 |
| F5-10 | Ticket and check-in analytics events | shared/KMP | S | F1-13, F5-09 |
| F5-11 | Door test: run check-in with organizers at a mock or real meetup | content/ops | S | F5-09 |

### F6 Submit a talk
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F6-01 | Design: remove the mentor card, change "You can edit your talk until…" copy (no editing after submit), "Your talks" on Profile, read-only submitted talk, CFP closed state | design | M | — |
| F6-02 | Schema: `talk_submissions` (owner, CFP, title, abstract, format, level, tracks, takeaways, optional fields, status draft/submitted/accepted/declined, timestamps). RLS: owner edits drafts only, reads own rows; organizers update status | backend/Supabase | M | F1-08, F3-02 |
| F6-03 | Step 1, The pitch: title (max 65), abstract, format radio cards, validation with focus and error | shared/KMP | M | F1-05, F6-01 |
| F6-04 | Step 2, Content: tracks 1–3 (checkbox chips with a maximum), level (radio chips), takeaways 1–3 | shared/KMP | M | F6-03 |
| F6-05 | Step 3 (all optional), Submit, Submitted screen (Close clears the back stack) | shared/KMP | M | F6-04, F6-02 |
| F6-06 | Drafts: server autosave on step change and on leaving, "Draft saved · Undo", resume **Cut C5 → S, saved on the device only** | shared/KMP | M | F6-02, F6-03 |
| F6-07 | "Your talks" on Profile: status badges, resume a draft, read-only view of a submitted talk | shared/KMP | M | F6-05, F7-03 |
| F6-08 | Submit a talk analytics events | shared/KMP | S | F1-13, F6-05 |
| F6-09 | CFP gating: entry points and form show "closed" when no CFP is open | shared/KMP | S | F3-02, F6-03 |

### F7 Profile and settings
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F7-01 | Design: Profile MVP (no achievements, stats, Open to work or public profile) with My RSVPs and Your talks; Edit profile (bio, topics, links; no photo change); Settings trimmed to Account, Delete account, Privacy policy, Code of conduct, About and version | design | M | — |
| F7-02 | Profile fields (bio, LinkedIn, X, website). RLS: own row update; members read only their own profile | backend/Supabase | S | F1-08 |
| F7-03 | Profile screen: ProfileHeader from GitHub, bio, topics, links, Settings row, Sign out | shared/KMP | M | F1-04, F7-01, F7-02 |
| F7-04 | Edit profile: fields with input purpose and format hints, validation, Discard changes dialog, topic chips reused from onboarding, save snackbar | shared/KMP | M | F7-03, F2-07 |
| F7-05 | My RSVPs section: upcoming first, opens Event detail, empty state | shared/KMP | S | F7-03, F4-03 |
| F7-06 | Settings screen: rows, external links, version | shared/KMP | S | F1-04, F1-20 |
| F7-07 | Delete account Edge Function (service role): delete the auth user and personal rows; anonymise RSVPs and check-ins (pending OQ-8); log the request | backend/Supabase | M | F1-08, F4-03 |
| F7-08 | Delete account dialog and sign-out flow: clear session, local data and device token, return to Welcome | shared/KMP | S | F7-06, F7-07 |
| F7-09 | Profile and account analytics events | shared/KMP | S | F1-13, F7-04 |

### F8 Jobs (the Content tab rows are should-have)
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F8-01 | Design: Community with Jobs only (no TabRow; tab label per OQ-11), no search, filters or save; Job detail without Save | design | S | F1-21 |
| F8-02 | Schema: `jobs` (title, company, optional `sponsor_id`, location, type, remote, salary range, description, apply URL, posted_at, closes_at, featured). Check: featured needs a salary range. RLS: public read, organizer write | backend/Supabase | M | F1-08, F9-02 |
| F8-03 | Jobs list: up to 2 featured roles pinned, then newest first, JobCard badges, states | shared/KMP | M | F1-06, F8-02 |
| F8-04 | Job detail: header, spoken meta, description, external Apply, Applications closed, SponsorRow One for a sponsor company | shared/KMP | M | F8-03, F1-20, F9-04 |
| F8-05 | Jobs analytics events and view recording | shared/KMP | S | F1-13, F9-07 |
| F8-06 | *Should have:* design for the Content tab returning with Content · Jobs TabRow | design | S | F8-01 |
| F8-07 | *Should have:* `articles` table (title, author, URL, published_at, tags), organizer write | backend/Supabase | S | F1-08 |
| F8-08 | *Should have:* Content tab: ArticleCards opening Medium in the browser, states | shared/KMP | M | F8-06, F8-07 |

### F9 Sponsors
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F9-01 | Design: SponsorRow One/Few/Many only (no marquee), simple Sponsor detail (identity, about, website, open roles, disclosure), Our sponsors grouped by tier; alternatives for cuts C4 and C7 | design | S | — |
| F9-02 | Schema: `sponsors` (name, about, website, square and long logos, tier, manual `plate_light`/`plate_dark` defaulting to theme), `event_sponsors` (role host/supporter, order), `page_views` (entity type, entity ID, user ID, time; insert own, no client read) | backend/Supabase | M | F1-08, F1-11 |
| F9-03 | SponsorLogo (Square, Wide; Color, Mono) on the stored plate **Cut C7 → S: theme plate only, no Mono** | shared/KMP | M | F1-03, F9-02 |
| F9-04 | SponsorRow One/Few/Many on Event detail after the RSVP block, merged semantics | shared/KMP | M | F9-03, F4-06 |
| F9-05 | Our sponsors list grouped by tier, entry from the drawer (or Profile after C2) and from the SponsorRow overflow, empty state | shared/KMP | M | F9-03 |
| F9-06 | Sponsor detail: identity, about, Visit website, open roles (JobCards to Job detail), privacy disclosure, states **Cut C4: SponsorRow opens the website instead** | shared/KMP | M | F9-03, F8-02 |
| F9-07 | View recording: one view per entity per app session for Event detail, Sponsor detail and Job detail | shared/KMP | S | F9-02, F1-09 |
| F9-08 | Aggregate SQL views for the future report (RSVPs, check-ins, views per event and sponsor, groups under 5 suppressed). No client access | backend/Supabase | S | F9-02, F5-06 |

### F10 Push reminders (should have)
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F10-01 | Firebase Cloud Messaging project, APNs key, secrets in Supabase | backend/Supabase | S | F0-01 |
| F10-02 | Device token registration: `device_tokens` table, permission prompt after the first RSVP, unregister on sign-out | shared/KMP | M | F10-01, F4-07 |
| F10-03 | Android: FCM service, `POST_NOTIFICATIONS`, notification channel | Android | S | F10-02 |
| F10-04 | iOS: APNs registration, `UNUserNotificationCenter`, FCM iOS SDK | iOS | M | F10-02 |
| F10-05 | Day-before reminder: pg_cron at 18:00 EAT calls an Edge Function that sends with FCM HTTP v1, with a send log so nothing is sent twice | backend/Supabase | M | F10-02, F4-03 |
| F10-06 | Talk status change: a trigger on status update calls an Edge Function that sends the push | backend/Supabase | S | F10-05, F6-02 |
| F10-07 | Tap handling: deep links to Event detail and "Your talks"; opened and received analytics | shared/KMP | S | F10-03, F10-04 |

### Analytics events (F1-14)
No personal data in properties. Event, session, talk and job IDs are allowed.

| Area | Events |
|---|---|
| Onboarding | `onboarding_viewed` (step), `interest_selected` / `interest_deselected` (topic, step), `onboarding_skipped` (step), `sign_in_started` / `sign_in_succeeded` / `sign_in_failed` (provider), `onboarding_completed` (topics_count) |
| Home | `home_viewed`, `home_shortcut_tapped` (target), `cfp_promo_tapped` |
| Events | `event_viewed` (event_id, source), `session_viewed`, `rsvp_created`, `rsvp_cancelled`, `rsvp_failed` (reason: full, offline, error), `add_to_calendar_tapped`, `venue_maps_opened` |
| Ticket and check-in | `ticket_viewed`, `check_in_scanned` (result) |
| Submit a talk | `talk_started`, `talk_step_completed` (step), `talk_draft_saved`, `talk_submitted` |
| Profile | `profile_edited` (fields changed count), `signed_out`, `account_deleted` |
| Jobs and sponsors | `job_viewed`, `job_apply_tapped`, `sponsor_viewed`, `sponsor_website_tapped` |
| Push (should have) | `push_permission_result`, `push_opened` (type) |

The sponsor numbers (views, RSVPs, check-ins) come from Supabase tables, not the analytics tool, so they're reliable and can be queried later.

---

## Totals
S = 0.5, M = 2, L = 4 days. Engineering capacity is about **100 engineer-days** (Android, iOS, shared/KMP, backend). Design is done by the designer agent, and content/ops by organizers and the product owner, so neither counts against that capacity.

### By area
| Area | Must-have | Should-have (F10 + Content tab) |
|---|---|---|
| shared/KMP | 85 | 4.5 |
| backend/Supabase | 27.5 | 3.5 |
| Android | 7.5 | 0.5 |
| iOS | 11 | 2 |
| **Engineering** | **131** | **10.5** |
| design | 11 | 0.5 |
| content/ops | 11.5 | 0 |
| **All** | **153.5** | **11** |

### By feature (must-have; the should-have rows are separate)
| Feature | design | shared | backend | Android | iOS | content | Total | Engineering |
|---|---|---|---|---|---|---|---|---|
| F0 Release, store, QA | 0.5 | 2 | 2 | 2 | 2 | 10.5 | 19 | 8 |
| F1 Foundation | 0.5 | 25 | 5.5 | 2 | 2.5 | 0.5 | 36 | 35 |
| F2 Sign in, onboarding | 0.5 | 5.5 | 2.5 | 0.5 | 2 | — | 11 | 10.5 |
| F3 Home | 2 | 3 | 0.5 | — | — | — | 5.5 | 3.5 |
| F4 Events | 2 | 15 | 4 | 0.5 | 2 | — | 23.5 | 21.5 |
| F5 Ticket, check-in | 0.5 | 4.5 | 4 | 2.5 | 2.5 | 0.5 | 14.5 | 13.5 |
| F6 Submit a talk | 2 | 11 | 2 | — | — | — | 15 | 13 |
| F7 Profile, settings | 2 | 6 | 2.5 | — | — | — | 10.5 | 8.5 |
| F8 Jobs | 0.5 | 4.5 | 2 | — | — | — | 7 | 6.5 |
| F9 Sponsors | 0.5 | 8.5 | 2.5 | — | — | — | 11.5 | 11 |
| **Must-have total** | **11** | **85** | **27.5** | **7.5** | **11** | **11.5** | **153.5** | **131** |
| *F10 Push (should)* | — | 2.5 | 3 | 0.5 | 2 | — | 8 | 8 |
| *Content tab (should)* | 0.5 | 2 | 0.5 | — | — | — | 3 | 2.5 |

### Does it fit?
**No. Must-have engineering is 131 days against about 100, so it's 31% over. With the should-haves it's 141.5.**

Three things bring it to about 100. Each cut needs the decision-maker named in the table.
1. **Should-haves are out** (F10 push, Content tab: −10.5). They come back only if something else frees up time.
2. **Overhead tasks move to the 30% buffer.** `docs/mvp.md` already counts setup, store releases and bug fixing in the 30% it takes off. F1-15, F1-16, F1-19 and F0-15 (6.5 days, marked **OH**) are that work. 131 → **124.5**.
3. **The cut ladder.** Take the cuts in this order until the total fits. C1–C8 trim features without dropping any. C9 drops a feature, so it's the late-bind item.

| Cut | What changes | Saves | Running total | Who decides |
|---|---|---|---|---|
| — | Start (after the OH move) | — | 124.5 | — |
| C1 | Events tab is a month-grouped list, with no week/month calendar (drop F4-04) | 4 | 120.5 | Product owner |
| C2 | No drawer. Submit a talk, Our sponsors, Code of conduct and About move to Profile/Settings rows (drop F1-22) | 2 | 118.5 | Design + product owner |
| C3 | Check-in scanner on Android only for January; organizers scan with Android phones (drop F5-08) | 2 | 116.5 | Organizers |
| C4 | No Sponsor detail screen; the SponsorRow opens the sponsor's website, and Our sponsors stays (drop F9-06) | 2 | 114.5 | Product owner + organizers |
| C5 | Talk drafts saved on the device only; "Your talks" lists submitted talks (F6-06 M → S) | 1.5 | 113 | Product owner |
| C6 | Session detail becomes an expandable agenda row on Event detail (F4-11 M → S) | 1.5 | 111.5 | Design |
| C7 | Sponsor logos on the theme plate only, no Mono treatment (F9-03 M → S) | 1.5 | 110 | Design |
| C8 | Add to calendar on Android only; iOS follows (drop F4-10) | 2 | **108** | Product owner |
| C9 | **Jobs (F8-02 to F8-05) is a late-bind item:** built in S4 only if S1–S3 land on plan; otherwise it ships in a January tester update | 6.5 | **101.5** | Product owner |

**Recommendation:** decide C1–C8 by **Fri Nov 6**, so design (F1-21, F4-01, F9-01) and S2 build follow them, and treat Jobs as late-bind. That commits **101.5 engineer-days**, which roughly fits but has no slack. The first things back in, if velocity allows, are Jobs, then iOS add to calendar (C8), then push reminders. If the product owner keeps Jobs as committed, one of C1–C8 can't be undone and something else has to give, or we add capacity (OQ-7).

---

## Sprint plan
Assumes cuts C1–C8 are accepted and Jobs is late-bind. Feature capacity per sprint is 4 engineers × working days × 0.7: **S1 about 28, S2 about 28, S3 about 28, S4 about 22** (8 working days). Tasks marked **OH** come from the 30% buffer, not the sprint's feature days.

| Sprint | Engineering tasks | Feature days | Design and content/ops in parallel |
|---|---|---|---|
| **S1 Nov 2–13: foundation, store setup, auth** | F1-01, F1-02, F1-03, F1-04, F1-05, F1-07, F1-08, F1-09, F1-10, F1-11, F1-12, F1-13, F1-17, F1-18, F1-20, F2-02, F2-03 · **OH:** F1-15, F1-16, F1-19 | 28.5 | **Design:** F1-21, F2-01, F3-01, F4-01, F5-01, F9-01, F0-03 (all reflecting the cut decisions by Nov 6). **Content:** F0-01 (start day 1, D-U-N-S can take weeks), F1-14, F0-02, F0-04 started |
| **S2 Nov 16–27: onboarding, events, RSVP, account deletion** | F1-06, F2-04, F2-05, F2-06, F2-07, F2-08, F2-09, F2-10, F3-02, F4-02, F4-03, F4-05, F4-06, F4-07, F4-08, F4-09, F4-11 (as S), F4-12, F7-02, F7-07 | 26 | **Design:** F6-01, F7-01, F8-01. **Content:** F0-04 done, F0-06, F0-07, F0-05; **F0-08 Play closed testing starts by Nov 27–30** with the first internal build |
| **S3 Nov 30–Dec 11: Home, ticket and check-in, talk form, profile, sponsor data** | F3-03, F3-04, F3-05, F5-02, F5-03, F5-04, F5-05, F5-06, F5-07, F5-09, F5-10, F6-02, F6-03, F6-04, F7-03, F7-06, F7-08, F9-02, F9-03 (as S), F0-13 | 28 | **Content:** F0-11 runbook, F0-12 organizer dry run, F5-11 door test (Dec 10–11) |
| **S4 Dec 14–23: finish, accessibility, harden, submit** | F6-05, F6-06 (as S), F6-07, F6-08, F6-09, F7-04, F7-05, F7-09, F9-04, F9-05, F9-07, F9-08, F0-14, F0-16 · **OH:** F0-15 · **Late-bind:** F8-02, F8-03, F8-04, F8-05 | 17.5 committed (+6.5 late-bind = 24) | **Content:** **F0-09 TestFlight external beta review submitted Dec 21–23** with the S4 build, so the public link is approved before Jan 4 (later builds usually skip full review). Store listing final |
| **Jan 4–8: release to testers** | Bug fixes from QA and beta review, release candidate (F0-17). Jobs ships here as a tester update if it slipped | — | F0-09 public link and Play open testing live, F0-10 tester onboarding, announcement to the chapter |

Ordering notes:
- Delete account (F7-07) lands in S2, and the privacy policy and deletion page by the end of S2, because both stores check them before any external testing.
- The closed test needs a build in Play by about Nov 27 to finish its 14 days before January. The S2 build only needs sign-in and Events, not every feature.
- S4 at 24 days with Jobs is above its 22-day capacity. That is the signal that Jobs is genuinely at risk, not a formality.

---

## Risks and assumptions

### Risks
| Risk | Impact | Mitigation | Owner |
|---|---|---|---|
| Scope doesn't fit: 131 must-have days against 100 | Late or broken January build | Cut ladder decided by Nov 6; Jobs as late-bind; review velocity at the end of S1 and S2 | Product owner |
| Apple Developer enrolment as an organization needs a D-U-N-S number and can take weeks | No TestFlight, so no iOS testers in January | Start Nov 2. Fall back to an individual account held by an organizer if it isn't done by Nov 20 | Organizers |
| Play testing rules: new accounts need 12 or more testers for 14 days before production, and open testing may not be available on a new personal account | No open sign-up on Android in January | Closed test with organizers from Nov 30. If open testing is gated, use closed testing with an opt-in link or Google Group for open sign-up | Organizers + engineering |
| TestFlight beta review over the holidays | Public link not live Jan 4–8 | Submit Dec 21–23, with a demo account and clear review notes | Engineering |
| The ticket is online-only (offline ticket is cut), and venue connectivity in Nairobi is uneven | Queue at the door; check-in rate below target | Venue Wi-Fi for members at the door; the scanner needs only the organizer's connection. First add-back: cache the ticket on the phone at RSVP time (about S) | Product owner + organizers |
| Studio gives organizers full database access; a wrong edit or delete hits production | Lost or exposed member data | Two or three trained organizers only, the runbook's "never touch" list, point-in-time recovery on, a dry run on dev | Organizers |
| Data protection: GitHub profiles, RSVPs, check-ins and view logs are personal data under Kenya's Data Protection Act | Store rejection, legal exposure, loss of trust | Privacy policy before any tester signs up; no personal data in analytics; sponsors see aggregates only, with groups under 5 suppressed | Product owner + organizers |
| Shared Compose UI on iOS may feel non-native, or be rejected by design | Rework, or weaker iOS tester feedback | Native pieces only where a platform requires them; native chrome after testing; decide by Nov 6 | Engineering + design |
| Apple-only users can't sign in on Android, and Apple users have no GitHub profile data | Locked-out members; thin profiles | Initials avatar and name only; consider Apple web OAuth on Android (about M) | Engineering + product owner |
| No real meetup or open CFP during Jan–Feb | Success signal can't be measured | Organizers confirm dates by Nov 13 | Organizers |
| "Kotlin" in the app name | Store or trademark objection | Check JetBrains' brand guidelines; have a fallback name | Organizers |
| Design hand-offs for the cut screens land late | Engineers build from stale frames | All S1 design tasks are small; engineers build from the existing frames and adjust | Design |

### Assumptions
- Shared Compose UI on iOS for January (OQ-2). Native pieces only for Sign in with Apple, calendar, camera and brightness.
- English only, Nairobi chapter only, all times in EAT.
- Minimum OS: Android 8.0 (API 26) and iOS 16 (engineering to confirm).
- No offline cache; screens show the Offline state. The only on-device data is the session, local drafts (if C5) and analytics.
- Check-in verification happens on the server; the ticket QR is a signed token created at RSVP.
- Deleted accounts: RSVPs and check-ins are kept, but anonymised, so event counts stay correct (OQ-8).
- Organizers have Android phones for scanning (if C3).
- The designer agent can turn the S1 design tasks around in the first week.
- Overhead stays at about 30%, covering reviews, bug fixing and store releases.

---

## Open questions
| # | Question | Who answers |
|---|---|---|
| OQ-1 | Accept cuts C1–C8 and Jobs as late-bind? If not, which feature gives instead? By Nov 6 | Product owner + organizers |
| OQ-2 | Shared Compose UI on iOS for January, native chrome after testing? | Engineering + design |
| OQ-3 | Is Supabase Studio enough for the organizers who will run January meetups? Who are the two or three Studio users? | Organizers |
| OQ-4 | Is GitHub plus Apple enough? Should Apple sign-in also work on Android, and do members without GitHub need email sign-in? | Product owner (engineering sizes it) |
| OQ-5 | Who owns the store accounts, the privacy policy and the app name? Is a D-U-N-S number already available? | Organizers |
| OQ-6 | Which meetups fall in Jan–Feb, and when does the CFP open and close? | Organizers |
| OQ-7 | Are engineers available in January for a tester update with deferred items (Jobs, push, iOS add to calendar)? Can we add capacity instead of cutting? | Product owner |
| OQ-8 | On account deletion, do we delete RSVPs and check-ins or anonymise them? What retention does the privacy policy promise? | Product owner + organizers |
| OQ-9 | What may sponsors see, and is it only aggregates? Needed before testers sign up (already open in `docs/mvp.md`) | Product owner + organizers |
| OQ-10 | Which analytics and crash tools (for example Firebase or PostHog, Sentry or Crashlytics)? Do we need an analytics consent prompt? | Engineering + product owner |
| OQ-11 | With only Jobs, should the bottom tab be labelled "Community" or "Jobs"? Keep the Home FAB alongside the Submit a talk tile and promo? | Design |
| OQ-12 | Is "Share event" in the MVP? `docs/mvp.md` lists the share sheet as a native piece, but feature 4 doesn't mention sharing (about S if yes) | Product owner |
| OQ-13 | Do organizers who scan at the door use Android phones (needed for C3)? | Organizers |
| OQ-14 | Can speakers edit a talk after submitting, before the CFP closes, or do organizers handle changes? | Organizers |
