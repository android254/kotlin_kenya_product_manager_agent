# MVP for January testing: task breakdown

Last updated 2026-10-02. Status: **draft for product owner, organizer and engineering review.**
- **Source of truth:** `docs/mvp.md`, updated 2026-10-02 with 11 features, all must-have. The Content tab was added and then removed the same day; it's in Later.
- **Designs:** `kotlin-kenya-designer-agent` (the Figma file + `docs/*-handoff-notes.md`).
- **This scope:** the whole MVP as one phase. Build Nov 2 – Dec 23 2026; release to testers Jan 4–8 2027.

Each feature gets its own detailed scope later. This file is the plan and the sizing. **No cuts are applied here.** The thinner versions in Totals are proposals for the product owner to decide.

---

## Problem
Nairobi chapter members have no single place to find the next meetup, RSVP, get in at the door, submit a talk and say how the meetup went. Organizers run RSVPs, check-in, talks, sponsors, jobs and feedback by hand. We want one app, on Android and iOS, in testers' hands in the first week of January 2027, so that real Jan–Feb meetups run through it.

## Users
| Who | What they need from January |
|---|---|
| Community members (Nairobi chapter and open sign-up testers) | Sign in, find meetups, RSVP, show a ticket, see the agenda and speakers, rate the meetup, browse jobs |
| Speakers | Submit a talk from the phone, see its status, and see aggregated ratings after they speak |
| Sponsors (they don't use the app as sponsors) | Their logo on the events they back, a sponsors list and page, and their jobs on the board. Views, RSVPs and check-ins are recorded for a later report |
| Organizers | Check people in at the door from the app; read ratings and comments in Studio; run everything else in Supabase Studio from a runbook |

## Success signal
Proposed targets for the end of testing (28 Feb 2027). The product owner confirms the numbers.
- At least one real meetup runs end to end in the app. RSVPs are taken in the app, and **at least 70% of attendees are checked in with the scanner**.
- **At least 100 testers sign in**, and at least 40% of them RSVP to a meetup.
- **At least 30% of checked-in attendees rate the meetup.** Every speaker with 5 or more ratings can see their feedback.
- **At least 10 talks are submitted** through the app while a CFP is open.
- **Crash-free sessions are 99% or higher** on both platforms.
- Organizers run a meetup's events, talks, sponsors and jobs from Studio without engineering help.
- No store or beta review is rejected for privacy or account deletion.

---

## User stories
One to three stories per feature. Each feature's own scope adds the rest.

### Feature 1: Foundation
- **US-1.1:** As a **chapter member joining the test**, I want to install the app from the Play test track or the TestFlight link and move between Home, Events, Community and Profile, so that I can try everything on the phone I already use.
- **US-1.2:** As an **organizer running the test**, I want crashes and key actions reported without personal data, so that we know what to fix before a public release.

### Feature 2: Sign in and onboarding
- **US-2.1:** As a **new member**, I want to continue with GitHub (or Sign in with Apple on iOS), so that I can join without creating another password.
- **US-2.2:** As a **new member**, I want to pick the topics I care about in three short steps, so that the app knows what I'm interested in. I can change them later in Profile.

### Feature 3: Home
- **US-3.1:** As a **member**, I want to see the next meetup as soon as I open the app, so that I know what's coming without searching.
- **US-3.2:** As a **member who might speak**, I want to see when the call for speakers is open, so that I don't miss the deadline.

### Feature 4: Events
- **US-4.1:** As a **member**, I want to browse upcoming meetups and workshops and open one, so that I can see the date, venue, seats and agenda.
- **US-4.2:** As a **member**, I want to RSVP to an event and cancel if my plans change, so that I have a seat and the organizers know who's coming.
- **US-4.3:** As a **member deciding whether to attend**, I want to read a session's speaker and abstract, so that I know whether the talk is for me.

### Feature 5: Ticket and check-in
- **US-5.1:** As a **member with an RSVP**, I want to show a QR ticket at the door, so that I get in quickly.
- **US-5.2:** As an **organizer at the door**, I want to scan a ticket and see at once whether the person is checked in, already checked in or not on the list, so that the queue keeps moving and the attendance numbers are real.

### Feature 6: Submit a talk
- **US-6.1:** As a **speaker**, I want to submit a talk in three steps, with my draft saved as I go, so that I can finish it on my phone over more than one sitting.
- **US-6.2:** As a **speaker**, I want to see whether my talk is submitted, accepted or declined, so that I don't need to chase the organizers.

### Feature 7: Profile and settings
- **US-7.1:** As a **member**, I want to edit my bio, topics and links on top of my GitHub profile, so that my profile says what I work on.
- **US-7.2:** As a **member**, I want to see my RSVPs and talks in one place, so that I can find my ticket and my submissions.
- **US-7.3:** As a **member leaving the community**, I want to delete my account from the app, so that my personal data is removed.

### Feature 8: Jobs
- **US-8.1:** As a **member looking for work**, I want to browse open roles and open the company's application page, so that I can apply to roles shared through the community.

### Feature 9: Sponsors
- **US-9.1:** As a **member**, I want to see who supports an event and learn about them, so that I know which companies back the community and which have open roles.
- **US-9.2:** As a **sponsor**, I want our event page views, RSVPs and check-ins recorded from day one, so that a later impact report can use real numbers. (Only the recording is in the MVP. The report itself is cut.)

### Feature 10: Push reminders
- **US-10.1:** As a **member with an RSVP**, I want a reminder the day before, so that I don't forget to come, or I free my seat.
- **US-10.2:** As a **speaker**, I want a notification when my talk's status changes, so that I hear the decision without opening the app.

### Feature 11: Post-event ratings
- **US-11.1:** As a **member who attended a meetup**, I want to rate the meetup and give each session a quick rating, with an optional comment for the organizers, so that the next meetup gets better.
- **US-11.2:** As a **speaker**, I want to see my aggregated ratings in Your talks, so that I learn how my talk landed without anyone being singled out.
- **US-11.3:** As a **member who just attended**, I want Home to ask me how the meetup was while rating is open, so that I don't have to remember to find it.

---

## Acceptance criteria
These cover only the key behaviour and the states that matter. Each feature's acceptance also includes everything the a11y handoff notes mark "Must implement" for its screens: 200% text, 48dp/44pt targets, headings, live regions and merged card semantics. The notes that apply are named in each feature's heading.

### Global states (every screen with remote data)
- **Loading:**
  - **Given** data is being fetched
  - **When** the screen opens
  - **Then** a skeleton shows with one spoken description ("Loading events"), and "… loaded" is announced when content arrives.
- **Error:**
  - **Given** a request fails
  - **When** the screen can't load
  - **Then** the Error StateMessage shows with "Try again". Its title is a polite live region, and focus moves to "Try again" after a failed retry.
- **Offline:**
  - **Given** the device has no connection
  - **When** a screen needs data it doesn't have
  - **Then** the Offline StateMessage shows with "Try again".
  - Actions (RSVP, submit, save, rate) fail with a snackbar and keep the member's input.
  - There is no offline cache in the MVP.
- **Theme:**
  - **Given** the system is in dark mode
  - **When** the app opens
  - **Then** it uses the dark theme. The theme follows the system; there is no picker.

### F1 Foundation
- **Tab state:**
  - **Given** I'm on the Events tab, scrolled down
  - **When** I switch to Profile and back
  - **Then** Events keeps its scroll position and back stack.
  - Reselecting a tab scrolls it to the top.
- **200% text:**
  - **Given** the font scale is 200%
  - **When** I open any MVP screen
  - **Then** no information text is clipped or ellipsized. Nav labels are capped at 14sp and the app bar title at 1.5× (`a11y-font-scale-2026-10-02.md`).
- **Crashes:**
  - **Given** the app crashes
  - **When** it's opened again
  - **Then** the crash appears in the crash tool with symbols, for both platforms, and with no personal data.

### F2 Sign in and onboarding
Applies `onboarding-handoff-notes.md` (variant B only) and the analytics events in `onboarding-ab-test.md`, without the `variant` property.
- **Sign in:**
  - **Given** I'm on Welcome
  - **When** I complete GitHub sign-in
  - **Then** my profile is created from GitHub (name, handle, avatar) and I land on Step 1 of 3.
- **Sign in with Apple (iOS):**
  - **Given** I'm on iOS
  - **When** Welcome shows
  - **Then** the system Sign in with Apple button sits above "Continue with GitHub", at the same size.
- **Failure:**
  - **Given** sign-in fails or I'm offline
  - **When** I return to the app
  - **Then** a long snackbar "Couldn't sign you in" with Retry shows above the buttons, and focus returns to "Continue with GitHub".
  - If I cancel sign-in, I'm back on Welcome with no error.
- **Interests:**
  - **Given** nothing is selected on a step
  - **When** I look at Continue
  - **Then** it's disabled, with the reason "Select at least one topic".
  - The count ("3 topics selected") is announced after each toggle.
- **Saved picks:**
  - **Given** I finish Step 3 or tap "Skip for now"
  - **When** I reach Home
  - **Then** my picks (possibly none) are saved to my profile, and the next launch skips onboarding.

### F3 Home
Applies `home-screen-handoff-notes.md`, minus the chapter switcher, the People and Quick connect tiles, the sponsored promo and the journey stats.
- **Next meetup:**
  - **Given** a published upcoming event exists
  - **When** I open Home
  - **Then** the Featured EventCard shows the next event I've RSVP'd to (or else the next upcoming event), with "View event".
- **Empty:**
  - **Given** no upcoming event is published
  - **When** I open Home
  - **Then** the empty state says no meetup is scheduled yet and links to Events.
- **One promo at a time:**
  - **Given** a CFP is open and no rating window applies to me (F11)
  - **When** I open Home
  - **Then** the CFP PromoCard shows its close date and "Submit a talk".
  - Once the CFP closes, the card is gone.
  - Home shows one promo at a time, and the rating promo comes first.

### F4 Events
Applies `events-handoff-notes.md` and the session part of `notifications-session-handoff-notes.md`.
- **Browse:**
  - **Given** events are published
  - **When** I open Events
  - **Then** I see upcoming events in the week/month calendar, with the selected day's events listed below. Each EventCard opens Event detail.
  - **Empty day:** "No events on Mon, 25 Jan".
- **RSVP:**
  - **Given** seats remain
  - **When** I tap "RSVP for free"
  - **Then** the RSVP is saved, "You're RSVP'd" is announced, focus moves to "Add to calendar", and "Show my ticket" appears.
- **Few seats or Full:**
  - **Given** fewer than 15% of seats remain, **Then** the seats tile uses the Warning tone, with text.
  - **Given** no seats remain, **Then** the badge reads "Full" and RSVP is disabled with the reason. There's no waitlist.
- **Last seat:**
  - **Given** two members RSVP for the last seat at the same moment
  - **When** both requests reach the server
  - **Then** exactly one succeeds, and the other member sees "This event just filled up".
- **Cancel:**
  - **Given** I'm RSVP'd
  - **When** I confirm "Cancel your RSVP?"
  - **Then** my seat is released and "RSVP cancelled" is announced.
  - "Keep RSVP" changes nothing.
- **Venue:**
  - **When** I tap the venue row ("Open in Maps")
  - **Then** the maps app opens at the venue.
- **Add to calendar:**
  - **When** I tap "Add to calendar"
  - **Then** the system calendar editor opens, prefilled with the title, the time in EAT and the venue (Android and iOS).
- **Session detail:**
  - **When** I open an agenda item
  - **Then** I see the title, time (EAT), room, speaker (name, role, photo or initials) and abstract.
- **Offline RSVP:**
  - **Given** I'm offline
  - **When** I tap RSVP
  - **Then** a snackbar says I'm offline, and the button stays as it was.

### F5 Ticket and check-in
Applies only the ticket and scanner parts of `event-day-handoff-notes.md`. Online only.
- **Ticket:**
  - **Given** I'm RSVP'd
  - **When** I open "Show my ticket"
  - **Then** the QR shows on a white plate in both themes, with my name, the event and the ticket ID.
  - Brightness goes to full and the screen stays on until I leave.
  - The QR's description is "Ticket QR code for {event}, ticket {id}".
- **Ticket offline:**
  - **Given** I'm offline
  - **When** I open the ticket
  - **Then** I see "Connect to the internet to show your ticket", with Try again.
- **Scanner entry:**
  - **Given** I'm an organizer
  - **When** I open Event detail
  - **Then** the overflow menu has "Check-in scanner". Members never see it.
- **Checked in:**
  - **Given** a valid, unscanned ticket for this event
  - **When** I scan it
  - **Then** I see "Checked in · 9:21 AM" and "Attendee 142 of 180", with a light haptic.
  - The result is announced assertively and dismisses after 2 s.
- **Already checked in:**
  - **Given** a ticket that has already been scanned
  - **When** I scan it
  - **Then** I see "Already checked in · {time}" and who scanned it, with a double buzz.
- **Not on the list:**
  - **Given** a QR that isn't a valid ticket for this event (another event, a cancelled RSVP or a forged code)
  - **When** I scan it
  - **Then** I see "Not on the RSVP list" and "Scan again", with a double buzz.
- **Scanner offline:**
  - **Given** the scanner has no connection
  - **When** I scan
  - **Then** a blocking error says check-in needs a connection, and nothing is recorded.
- **Camera denied:**
  - **Given** camera access is denied
  - **When** I open the scanner
  - **Then** I see the rationale and "Open settings".

### F6 Submit a talk
Applies `submit-a-talk-handoff-notes.md`, minus the mentor card and the review step.
- **Title validation:**
  - **Given** the title is empty or longer than 65 characters
  - **When** I tap Continue
  - **Then** focus moves to the title, with the error "Enter a talk title, up to 65 characters".
- **Tracks:**
  - **Given** 3 tracks are selected
  - **Then** the other tracks are disabled, and "Maximum 3 tracks" is announced.
- **Draft:**
  - **Given** I've entered a title
  - **When** I go back from Step 1 or leave the app
  - **Then** the draft is saved, "Draft saved · Undo" shows, and I can resume it from "Your talks".
- **Submit:**
  - **Given** steps 1 and 2 are valid
  - **When** I tap "Submit talk"
  - **Then** the talk's status is Submitted, the Submitted screen shows with Close (no back), and "Talk submitted" is announced.
- **CFP closed:**
  - **Given** no CFP is open
  - **When** I start from any entry point
  - **Then** I see "The call for speakers is closed", and existing drafts are read-only.
- **Status:**
  - **Given** an organizer changes my talk's status in Studio
  - **When** I open Profile
  - **Then** "Your talks" shows Accepted or Declined as text in a status badge.
- **Offline submit:**
  - **Given** I'm offline
  - **When** I tap Submit
  - **Then** a snackbar says I'm offline, and nothing I entered is lost.

### F7 Profile and settings
Applies the edit-profile part of `job-member-editprofile-handoff-notes.md` and a trimmed `settings-handoff-notes.md`.
- **Edit:**
  - **Given** I edit my bio, topics or links
  - **When** I tap Save
  - **Then** the changes persist, "Profile updated" shows, and focus returns to "Edit profile".
  - The GitHub handle is read-only.
  - An invalid link shows an inline error and takes focus.
- **Discard:**
  - **Given** I have unsaved edits
  - **When** I tap Close or system Back
  - **Then** "Discard changes?" offers Keep editing or Discard.
- **My RSVPs:**
  - **When** I open Profile
  - **Then** upcoming RSVPs are listed first, then past ones. Each opens Event detail.
  - **Empty:** "No RSVPs yet", with a link to Events.
- **Delete account:**
  - **Given** I confirm "Delete account" (the button is in the error colour, and focus starts on the dialog title)
  - **When** the deletion succeeds
  - **Then** my auth user, profile, topics, drafts and device tokens are deleted.
  - My RSVPs, check-ins and ratings are anonymised (pending OQ-8).
  - I'm signed out and see Welcome.
  - **Offline:** the dialog shows an error, and nothing is deleted.
- **Sign out:**
  - **When** I tap "Sign out" on Profile
  - **Then** my session and local data are cleared, and I see Welcome.

### F8 Jobs
Applies the job board in `community-handoff-notes.md`, Job detail in `job-member-editprofile-handoff-notes.md`, and section #5 of `sponsors-handoff-notes.md`.
- **List:**
  - **Given** open jobs exist
  - **When** I open the Community tab
  - **Then** I see Jobs on its own, with no tab row. At most 2 featured roles are pinned on top, labelled "Featured · Community sponsor". The rest are listed newest first.
  - **Empty:** "No open roles right now".
- **Apply:**
  - **When** I tap "Apply on company site"
  - **Then** the link opens in the in-app browser, announced as "opens in browser".
- **Closed:**
  - **Given** the closing date has passed
  - **Then** Apply is disabled but still focusable, and reads "unavailable, applications closed".

### F9 Sponsors
Applies sections #3 and #4 (simple) of `sponsors-handoff-notes.md`. No SponsorMarquee and no automatic plates.
- **Attribution:**
  - **Given** an event has sponsors
  - **When** I open Event detail
  - **Then** a labelled SponsorRow sits after the RSVP block:
    - One sponsor: name and tier; the row opens Sponsor detail.
    - Few (2–3): their logos.
    - Many: 2 logos + "+N", which opens Our sponsors.
  - The row is the screen's only sponsor surface.
  - Each logo reads "Supported by {name}, {tier}".
- **Sponsor detail:**
  - **When** I open a sponsor
  - **Then** I see the logo, name, about, "Visit website" (external), open roles if there are any, and "Sponsors see total page views, never who viewed this page".
  - Without open roles, that section is hidden.
- **Recording:**
  - **Given** I open Event detail, Sponsor detail or Job detail
  - **Then** one view per entity per app session is recorded server-side.
  - Clients can't read the views.

### F10 Push reminders
- **Reminder:**
  - **Given** I'm RSVP'd and have allowed notifications
  - **When** it's 18:00 EAT the day before the event
  - **Then** I get one reminder, and tapping it opens Event detail.
  - Nothing is sent if I've cancelled.
- **Permission:**
  - **Given** I haven't been asked yet
  - **When** my first RSVP succeeds
  - **Then** the app asks for notification permission (Android 13+ and iOS).
  - There is no in-app notification settings screen.
- **Talk status:**
  - **Given** my talk changes to Accepted or Declined
  - **Then** I get one notification, and it opens "Your talks".
- **Denied:**
  - **Given** I've denied permission
  - **Then** nothing is sent, and the app doesn't ask again.

### F11 Post-event ratings
Applies `post-event-handoff-notes.md`, minus recordings, the RecapCard, the celebration, sponsor poll results and speaker-visible comments.
- **Who can rate:**
  - **Given** I was checked in to an event
  - **When** the window is open (from doors close + 1 h until `ratings_close_at`, default the Friday after)
  - **Then** I can rate the meetup.
  - Members who weren't checked in never see the prompt.
- **Home prompt:**
  - **Given** I can rate and haven't yet
  - **When** I open Home
  - **Then** "How was the {event}?" takes the promo slot, with the badge "Until Fri".
  - After I send or the window closes, it's gone.
- **Rate:**
  - **Given** I'm on Rate the meetup
  - **When** I give at least one star rating (the meetup or any session)
  - **Then** "Send N ratings" is enabled. Each RatingRow is a 1–5 radio group with 48dp stars and a value label (Poor → Excellent), and rows can be left unrated.
- **Send:**
  - **When** I tap Send
  - **Then** my ratings, the optional comment and the optional "first meetup" answer are saved, the Submitted state shows with "Back to Home", and "Ratings sent" is announced.
  - Sending again before the window closes updates my ratings; it doesn't duplicate them.
- **Skip:**
  - **When** I tap Skip
  - **Then** the snackbar says "No problem. You can rate until Friday from Profile → My RSVPs".
- **Comments:**
  - **Given** I wrote a comment
  - **Then** only organizers can read it (in Studio). Speakers and sponsors never see it.
- **Speaker feedback:**
  - **Given** my talk has 5 or more ratings
  - **When** I open it in Your talks
  - **Then** I see the average, the number of ratings, attendance (from check-ins) and the star distribution as text and bars.
  - **Under 5 ratings:** "Feedback appears once 5 people have rated your talk".
- **Window closed or offline:**
  - **Given** the window has closed
  - **Then** the rating screen is read-only.
  - **Given** I'm offline when sending
  - **Then** a snackbar says so, and my stars are kept.

---

## Out of scope
Everything in the "Cut from the design for now" column of `docs/mvp.md`. In particular:
- **Onboarding:** the A/B test (we ship variant B only), guest mode and merging guest picks, personalised step titles, the Step 0 chapter picker, the celebration.
- **Home:**
  - chapter switcher, Quick connect and People tiles, sponsored challenge promo
  - journey stats, achievements and trending topics
  - event-day Home mode and the notifications bell
  - the RecapCard
- **Events:** waitlist, saved sessions and bookmarks, live and sponsor polls, the recording alert.
- **Ticket and check-in:** offline ticket, offline check-in queue, walk-ins, undoing a check-in (organizers fix it in Studio), Apple and Google Wallet.
- **Submit a talk:** review step, speaking history card, mentor matching (the mentor card is removed), editing a talk after it's submitted.
- **Profile and settings:**
  - public profile, member profile and share card
  - Open to work, achievements
  - privacy controls, notification settings
  - theme and language pickers
  - download my data
  - changing the profile photo (we use the GitHub avatar)
- **Jobs:** roles matching your topics, search and filters, saved jobs, company pages, job poster stats, job alerts. The People tab.
- **Community:** the Content tab (moved to Later by the product owner) and the People tab. Community shows Jobs only, with no tab row.
- **Sponsors:** impact report, booth leads, challenges and badges, sponsor polls, `SponsorMarquee`, automatic logo plate detection. A manual plate field in Studio is in.
- **Push:** the Notifications screen and list, notification settings. Rating-prompt and feedback-ready pushes aren't listed in `docs/mvp.md` (see OQ-15).
- **Post-event:**
  - recordings and the recap card
  - the celebration on Submitted
  - sponsor poll results
  - speaker-visible comments
  - comment screening tools (organizers use Studio)
  - sharing feedback with a mentor
- **Platform:** native iOS chrome (assumed; see OQ-2), the web platform, organizer screens in the app other than the scanner, Kiswahili, multiple cities, email sign-in.
- **Share event:** `docs/mvp.md` lists the share sheet as a native piece, but feature 4 doesn't include sharing (see OQ-12).

---

## Tasks
- **Sizes:** **S** = under a day (0.5), **M** = 1–3 days (2), **L** = 3–5 days (4).
- **Areas:** design, Android, iOS, shared/KMP, backend/Supabase, content/ops.
- **OH** marks setup and release work that `docs/mvp.md` already counts in its 30% overhead (CI, release lanes, regression QA).
- **Tn** marks a task that has a thinner version proposed under Totals. Not applied.

### F0 Release, store and QA (cross-cutting)
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F0-01 | Confirm who owns the store accounts. Enrol in the Apple Developer Program as an organization (this needs a D-U-N-S number) and create the Play Console organization account. Add the engineers | content/ops | S | — |
| F0-02 | Check the app name (including use of "Kotlin" under JetBrains' brand rules). Set the application and bundle IDs, and write the store listing copy and screenshots | content/ops | M | F0-01, F0-03 |
| F0-03 | App icon and store screenshot frames | design | S | — |
| F0-04 | Privacy policy under Kenya's Data Protection Act 2019: data inventory (including ratings and comments), purposes, retention, sponsors see aggregates only, deletion. Host it on a static page | content/ops | M | F1-14 |
| F0-05 | Account deletion web page and request form (Play requires a web link as well as in-app deletion) | content/ops | S | F0-04, F7-07 |
| F0-06 | Play: Data safety form, content rating, target audience, app access (a review test account) | content/ops | S | F0-01, F0-04 |
| F0-07 | App Store Connect: app record, App Privacy labels, export compliance, Sign in with Apple and push capabilities, beta test info, review demo account | content/ops | S | F0-01, F0-04 |
| F0-08 | Play closed testing track with 12 or more opted-in testers (organizers), **started by Nov 30** so the 14-day clock finishes before January | content/ops | S | F0-06, F1-15 |
| F0-09 | Submit the TestFlight external group for beta review **Dec 21–23**. Turn on the public link and Play open testing (or a widened closed test) Jan 4–8 | content/ops | S | F0-07, F0-08, F1-16 |
| F0-10 | Tester onboarding: sign-up form, install guide, feedback channel, list of known issues | content/ops | S | F0-09 |
| F0-11 | Supabase Studio runbook for organizers. Covers: events, sessions and speakers; sponsors and logo plates; jobs; opening a CFP and reviewing talks; reading ratings and comments, and closing a rating window; granting the organizer role; deletion requests; and what never to touch | content/ops | M | F4-02, F6-02, F8-02, F9-02, F11-02 |
| F0-12 | Dry run of the runbook with two organizers on the dev project, then fix the gaps | content/ops | S | F0-11 |
| F0-13 | Accessibility pass 1 on Android (TalkBack, 200% text, 48dp, dark theme) for the F2–F5 screens. File the bugs | Android | M | F2-07, F3-03, F4-07, F5-09 |
| F0-14 | Accessibility pass 2: VoiceOver, Dynamic Type and 44pt targets on iOS for all screens, plus the F6–F11 screens on Android | iOS | M | F6-07, F7-04, F9-04, F11-05 |
| F0-15 | Regression QA on a device matrix: a low-end Android at the minimum SDK, a current Android, a small iPhone and a current iPhone **OH** | shared/KMP | M | all features |
| F0-16 | Harden production Supabase: review RLS on every table; check auth redirect URLs, rate limits and point-in-time recovery; secrets (the service-role key is never in the app) | backend/Supabase | M | all schema tasks |
| F0-17 | Promote release candidate builds to the tester tracks; write release notes | content/ops | S | F0-09 |

### F1 Foundation
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F1-01 | KMP + Compose Multiplatform project: modules, DI, navigation library, dev/prod build config, minimum OS versions | shared/KMP | M | — |
| F1-02 | App shell: four root tabs, a back stack per tab with saved state, reselecting a tab scrolls to top, deep link scheme `android254://` | shared/KMP | M | F1-01 |
| F1-03 | Theme and tokens: M3 colour roles in light and dark, Space Grotesk / Inter / JetBrains Mono, spacing, shape, font-scale caps | shared/KMP | M | F1-01 |
| F1-04 | Core components A: Button, IconButton, Chip, TextField, TopAppBar (Home, Small), NavigationBar, ListItem, SettingsRow, SectionHeader, StatusBadge, Avatar (photo or initials). Focus states and minimum heights **T1** | shared/KMP | L | F1-03 |
| F1-05 | Core components B: StateMessage (Empty, Error, Offline), Skeleton, SnackbarHost, AlertDialog (stacked above 1.3×), BottomActionBar (Row, Stacked), InlineNote, OptionCard, StepIndicator | shared/KMP | M | F1-03 |
| F1-06 | Cards: EventCard (Featured, Compact), SessionCard, JobCard (Featured, Verified), PromoCard, StatTile (tones with icon), ShortcutTile. Merged semantics and the 200% rules | shared/KMP | L | F1-04 |
| F1-07 | Supabase dev and prod projects, Supabase CLI migrations in the repo, the supabase-kt client, environment config | backend/Supabase | M | — |
| F1-08 | Base schema: `profiles` (1:1 with `auth.users`), `role` (member or organizer), `topics`. RLS pattern and SQL tests | backend/Supabase | M | F1-07 |
| F1-09 | Data layer: repositories, error mapping, a connectivity monitor, and a shared UI state (loading, content, empty, error, offline) | shared/KMP | M | F1-01, F1-07 |
| F1-10 | Image loading (Coil 3), falling back to initials | shared/KMP | S | F1-01 |
| F1-11 | Storage buckets for event covers, sponsor logos and speaker photos: public read, organizer write | backend/Supabase | S | F1-08 |
| F1-12 | Crash reporting on Android and iOS, with symbol upload in CI | shared/KMP | M | F1-15, F1-16 |
| F1-13 | Analytics: choose the tool; build a shared tracker interface; track screen views; set the user ID after sign-in; no personal data in properties | shared/KMP | M | F1-01, F1-14 |
| F1-14 | Analytics event catalogue (see "Analytics events" below) | content/ops | S | — |
| F1-15 | Android CI (PR build, tests, lint) and upload to the Play internal track, with the upload key and Play App Signing **OH** | Android | M | F1-01, F0-01 |
| F1-16 | iOS CI (macOS runner, build, tests), signing, upload to TestFlight **OH** | iOS | M | F1-18, F0-01 |
| F1-17 | Dev seed data (fictional events, sessions, speakers, sponsors and jobs from the placeholder media). Extend it as each schema lands | backend/Supabase | S | F1-08 |
| F1-18 | iOS host app: Xcode project, Compose entry point, launch screen, Info.plist usage strings (camera, calendar, notifications) | iOS | S | F1-01 |
| F1-19 | CI applies migrations: to dev on merge, to prod with manual approval **OH** | backend/Supabase | S | F1-07, F1-15 |
| F1-20 | External link opener (Custom Tabs / SFSafariViewController) with "opens in browser" semantics | shared/KMP | S | F1-01 |
| F1-21 | Design: MVP navigation. Community showing Jobs on its own, with no tab row; a drawer trimmed to Submit a talk · Our sponsors · Code of conduct · About · Settings; no notifications bell | design | S | — |
| F1-22 | Trimmed drawer; iOS uses the same shared drawer **T2** | shared/KMP | M | F1-02, F1-21 |

### F2 Sign in and onboarding
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F2-01 | Design: variant B, trimmed. Welcome without guest mode, neutral step titles, no Step 0, no celebration (Step 3 goes to Home). iOS Welcome with Sign in with Apple | design | S | — |
| F2-02 | Supabase Auth: the GitHub OAuth app and the Apple provider, redirect URLs, and a trigger that creates `profiles` from GitHub (name, handle, avatar) | backend/Supabase | M | F1-08 |
| F2-03 | GitHub sign-in in the app: OAuth in the browser with a deep-link callback, session persistence and refresh, a snackbar with Retry when it fails | shared/KMP | M | F1-02, F1-07, F2-02 |
| F2-04 | Android OAuth callback (Custom Tabs, intent filter) | Android | S | F2-03 |
| F2-05 | Sign in with Apple on iOS: the system `SignInWithAppleButton`, with the ID token passed to Supabase | iOS | M | F2-02, F1-18 |
| F2-06 | Welcome screen: "Karibu" as a `sw` span, legal links | shared/KMP | S | F1-05, F2-01 |
| F2-07 | Interest steps 1–3: OptionCards (checkbox role), a polite count, a disabled Continue with its reason, Skip for now, StepIndicator, sticky footer. Saves the picks **T3** | shared/KMP | M | F1-05, F2-08 |
| F2-08 | `profile_topics` table with RLS (own rows only); seed the topics catalogue | backend/Supabase | S | F1-08 |
| F2-09 | Launch routing: signed out → Welcome; onboarding not done → the steps; otherwise Home | shared/KMP | S | F2-03 |
| F2-10 | Onboarding analytics events | shared/KMP | S | F1-13, F2-07 |

### F3 Home
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F3-01 | Design: Home MVP. Greeting, next meetup, two shortcut tiles (Jobs, Submit a talk), one promo slot (rating first, then CFP), and whether to keep the FAB. States: Default, Empty (new member), Loading, Error, Offline, 200%, Dark, iOS | design | M | F1-21 |
| F3-02 | `cfps` table (title, opens_at, closes_at). A query for the next event with my RSVP status, and the count of open jobs | backend/Supabase | S | F4-02 |
| F3-03 | Home UI: time-of-day greeting with first name, Featured EventCard, shortcuts, the promo slot with its priority rule, headings | shared/KMP | M | F1-06, F3-01, F3-02 |
| F3-04 | Home loading, empty, error and offline states, with announcements | shared/KMP | S | F3-03 |
| F3-05 | Home analytics events | shared/KMP | S | F1-13, F3-03 |

### F4 Events
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F4-01 | Design: Event detail MVP. Full with no waitlist (disabled "Full" + the reason); no bookmark or session save; SponsorRow instead of the marquee; "Show my ticket"; the organizer overflow menu; past-event state with "Rate the meetup". Session detail without the poll, recording or bookmark | design | M | — |
| F4-02 | Schema: `events` (type, start/end, venue, address, lat/lng, capacity, status, cover, `ratings_close_at`), `sessions`, `speakers` (optional `profile_id`), `session_speakers`. RLS: anyone reads published rows; organizers write | backend/Supabase | M | F1-08 |
| F4-03 | RSVP and cancel as Postgres functions: an atomic capacity check with a row lock, idempotent, plus a `seats_left` view. RLS on `rsvps` (own rows only) | backend/Supabase | M | F4-02 |
| F4-04 | Calendar component: CalendarDay and CalendarMonth, week/month toggle, marker shapes, merged cell semantics, a live month title **T4** | shared/KMP | L | F1-04 |
| F4-05 | Events tab: the calendar with the selected day's list. Loading, empty, error and offline states | shared/KMP | M | F1-06, F4-02, F4-04 |
| F4-06 | Event detail: hero, info rows, StatTiles with tone, agenda SessionCards, pane title, states | shared/KMP | L | F1-06, F4-01, F4-02 |
| F4-07 | RSVP and cancel UI: button states (open, few seats, full, RSVP'd), cancel AlertDialog, announcements, focus moves to Add to calendar, errors | shared/KMP | M | F4-03, F4-06 |
| F4-08 | Venue opens Maps (geo URI / Apple Maps URL) | shared/KMP | S | F4-06 |
| F4-09 | Add to calendar on Android (CalendarContract insert intent) | Android | S | F4-07 |
| F4-10 | Add to calendar on iOS (EventKitUI editor, usage string) **T6** | iOS | M | F4-07, F1-18 |
| F4-11 | Session detail screen: hero with the time in EAT, speaker row, abstract, states **T5** | shared/KMP | M | F4-06 |
| F4-12 | Events analytics events | shared/KMP | S | F1-13, F4-07 |

### F5 Ticket and check-in
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F5-01 | Design: scanner results for the MVP (no walk-in, no undo, an offline error); a ticket without Wallet or the offline note | design | S | — |
| F5-02 | Ticket token: a signed token (HMAC with a server secret, over event, member and a nonce) created with the RSVP; a `get_ticket` function; a readable ticket ID | backend/Supabase | M | F4-03 |
| F5-03 | Ticket screen: TicketCard Full, QR rendering on a white plate, entry points from Event detail and Home | shared/KMP | M | F1-06, F5-02 |
| F5-04 | Android: full brightness and keep the screen on while the ticket shows | Android | S | F5-03 |
| F5-05 | iOS: full brightness and the idle timer off while the ticket shows | iOS | S | F5-03 |
| F5-06 | `check_in` function: verify the token (organizers only); return checked in, already checked in (time, by whom) or not on the list; write `check_ins` with the organizer ID; count | backend/Supabase | M | F5-02 |
| F5-07 | Android scanner camera: CameraX + ML Kit barcode scanning, permission rationale | Android | M | F1-18 |
| F5-08 | iOS scanner camera: AVFoundation through UIKit interop, usage string **T7** | iOS | M | F1-18 |
| F5-09 | Shared scanner UI: result sheet (Success, Warning, Error), assertive announcement, haptics, auto-dismiss after 2 s, counts, offline error, organizer-only entry point | shared/KMP | M | F5-06, F5-07 |
| F5-10 | Ticket and check-in analytics events | shared/KMP | S | F1-13, F5-09 |
| F5-11 | Door test: run check-in with organizers at a mock or real meetup | content/ops | S | F5-09 |

### F6 Submit a talk
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F6-01 | Design: remove the mentor card; change the "You can edit your talk until…" copy (no editing after submitting); "Your talks" on Profile, including feedback; a read-only submitted talk; the CFP-closed state | design | M | — |
| F6-02 | Schema: `talk_submissions` (owner, CFP, title, abstract, format, level, tracks, takeaways, optional fields, status draft/submitted/accepted/declined, timestamps, optional `session_id` once scheduled). RLS: the owner edits drafts only and reads their own; organizers update the status | backend/Supabase | M | F1-08, F3-02 |
| F6-03 | Step 1, The pitch: title (65 characters max), abstract, format radio cards, validation with focus and error | shared/KMP | M | F1-05, F6-01 |
| F6-04 | Step 2, Content: tracks (1–3 checkbox chips, with a maximum), level (radio chips), takeaways (1–3) | shared/KMP | M | F6-03 |
| F6-05 | Step 3 (all optional), Submit, and the Submitted screen (Close clears the back stack) **T9** | shared/KMP | M | F6-04, F6-02 |
| F6-06 | Drafts: autosave to the server on each step change and when leaving; "Draft saved · Undo"; resume **T8** | shared/KMP | M | F6-02, F6-03 |
| F6-07 | "Your talks" on Profile: status badges, resume a draft, a read-only view of a submitted talk | shared/KMP | M | F6-05, F7-03 |
| F6-08 | Submit a talk analytics events | shared/KMP | S | F1-13, F6-05 |
| F6-09 | CFP gating: entry points and the form show "closed" when no CFP is open | shared/KMP | S | F3-02, F6-03 |

### F7 Profile and settings
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F7-01 | Design: Profile MVP (no achievements, stats, Open to work or public profile) with My RSVPs (including past ones and the rating entry) and Your talks. Edit profile with bio, topics and links (no photo change). Settings trimmed to Account, Delete account, Privacy policy, Code of conduct, About and version | design | M | — |
| F7-02 | Profile fields (bio, LinkedIn, X, website). RLS: members update and read only their own row | backend/Supabase | S | F1-08 |
| F7-03 | Profile screen: ProfileHeader from GitHub, bio, topics, links, a Settings row, Sign out | shared/KMP | M | F1-04, F7-01, F7-02 |
| F7-04 | Edit profile: fields with input purpose and format hints, validation, the Discard changes dialog, topic chips reused from onboarding, a snackbar on save **T10** | shared/KMP | M | F7-03, F2-07 |
| F7-05 | My RSVPs section: upcoming first, then past; each opens Event detail; empty state | shared/KMP | S | F7-03, F4-03 |
| F7-06 | Settings screen: rows, external links, version | shared/KMP | S | F1-04, F1-20 |
| F7-07 | Delete account Edge Function (service role): delete the auth user and personal rows; anonymise RSVPs, check-ins and ratings (pending OQ-8); log the request | backend/Supabase | M | F1-08, F4-03 |
| F7-08 | Delete account dialog and sign-out flow: clear the session, local data and device token, then go to Welcome | shared/KMP | S | F7-06, F7-07 |
| F7-09 | Profile and account analytics events | shared/KMP | S | F1-13, F7-04 |

### F8 Jobs
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F8-01 | Design: Community showing Jobs on its own, with no tab row, search, filters or saving. Job detail without Save | design | S | F1-21 |
| F8-02 | Schema: `jobs` (title, company, optional `sponsor_id`, location, type, remote, salary range, description, apply URL, posted_at, closes_at, featured). A check that featured jobs have a salary range. RLS: anyone reads; organizers write | backend/Supabase | M | F1-08, F9-02 |
| F8-03 | Jobs list as the Community tab's only content (no tab row; deep link `community/jobs`): up to 2 featured roles pinned, then newest first; JobCard badges; states | shared/KMP | M | F1-06, F8-02 |
| F8-04 | Job detail: header, spoken meta, description, external Apply, Applications closed, a SponsorRow One for a sponsor company | shared/KMP | M | F8-03, F1-20, F9-04 |
| F8-05 | Jobs analytics events and view recording | shared/KMP | S | F1-13, F9-07 |

### F9 Sponsors
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F9-01 | Design: SponsorRow One/Few/Many only (no marquee); a simple Sponsor detail (identity, about, website, open roles, disclosure); Our sponsors grouped by tier | design | S | — |
| F9-02 | Schema: `sponsors` (name, about, website, square and long logos, tier, manual `plate_light`/`plate_dark` defaulting to the theme); `event_sponsors` (role host or supporter, order); `page_views` (entity type, entity ID, user ID, time; clients insert their own rows and can't read them) | backend/Supabase | M | F1-08, F1-11 |
| F9-03 | SponsorLogo (Square, Wide; Color, Mono) on the stored plate **T11** | shared/KMP | M | F1-03, F9-02 |
| F9-04 | SponsorRow One/Few/Many on Event detail after the RSVP block, with merged semantics **T12** | shared/KMP | M | F9-03, F4-06 |
| F9-05 | Our sponsors list grouped by tier, reached from the drawer and from the SponsorRow overflow; empty state | shared/KMP | M | F9-03, F1-22 |
| F9-06 | Sponsor detail: identity, about, Visit website, open roles (JobCards that open Job detail), privacy disclosure, states **T13** | shared/KMP | M | F9-03, F8-02 |
| F9-07 | View recording: one view per entity per app session, for Event detail, Sponsor detail and Job detail | shared/KMP | S | F9-02, F1-09 |
| F9-08 | Aggregate SQL views for the future report: RSVPs, check-ins, views and session rating averages per event and sponsor, with groups under 5 suppressed. No client access | backend/Supabase | S | F9-02, F5-06, F11-02 |

### F10 Push reminders
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F10-01 | Firebase Cloud Messaging project and APNs key, with the secrets stored in Supabase | backend/Supabase | S | F0-01 |
| F10-02 | Device token registration: a `device_tokens` table; ask for permission after the first RSVP; unregister on sign-out | shared/KMP | M | F10-01, F4-07 |
| F10-03 | Android: FCM service, `POST_NOTIFICATIONS`, a notification channel | Android | S | F10-02 |
| F10-04 | iOS: APNs registration, `UNUserNotificationCenter`, the FCM iOS SDK **T14** | iOS | M | F10-02 |
| F10-05 | Day-before reminder: pg_cron at 18:00 EAT calls an Edge Function that sends through FCM HTTP v1, with a send log so nothing is sent twice | backend/Supabase | M | F10-02, F4-03 |
| F10-06 | Talk status change: a trigger on the status update calls an Edge Function that sends the push | backend/Supabase | S | F10-05, F6-02 |
| F10-07 | Handle taps: deep links to Event detail and "Your talks"; analytics for opened and received | shared/KMP | S | F10-03, F10-04 |

### F11 Post-event ratings
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| F11-01 | Design: Rate the meetup without the celebration or RecapCard (Submitted → "Back to Home"); the Home "After the meetup" promo without the RecapCard; Skip copy pointing to Profile → My RSVPs; speaker feedback in Your talks with no comments or mentor sharing; states | design | M | F3-01, F6-01 |
| F11-02 | Schema: `event_ratings` (event, member, stars, comment, first_meetup) and `session_ratings` (session, member, stars). Upserts are idempotent. RLS: members write their own rows only if they were checked in and before `ratings_close_at`; only organizers read comments | backend/Supabase | M | F4-02, F5-06 |
| F11-03 | Speaker feedback function: for the caller's talks, return the average, count, distribution and attendance (from check-ins), only once there are 5 or more ratings; never return comments | backend/Supabase | S | F11-02, F6-02 |
| F11-04 | RatingRow component: a 1–5 radio group, 48dp stars, a value label (Poor → Excellent), stateDescription "4 of 5 stars, Great" **T15** | shared/KMP | M | F1-03 |
| F11-05 | Rate the meetup screen: the meetup row plus a row per session; optional comment; optional "first meetup" Yes/No; Skip with a snackbar; "Send N ratings" (disabled until there's at least one rating); Submitted; edits allowed until the window closes; states | shared/KMP | M | F11-02, F11-04 |
| F11-06 | Home "After the meetup" promo for checked-in members until the window closes, taking priority in the promo slot; rate entry from past RSVPs and past Event detail | shared/KMP | S | F3-03, F7-05, F11-05 |
| F11-07 | Speaker feedback in Your talks: StatTiles (average, ratings, attended), distribution bars with text, "No feedback yet" under 5 ratings, states **T16** | shared/KMP | M | F11-03, F6-07 |
| F11-08 | Ratings analytics events | shared/KMP | S | F1-13, F11-05 |

### Analytics events (F1-14)
Properties never contain personal data. Event, session, talk, job and link IDs are allowed.

| Area | Events |
|---|---|
| Onboarding | `onboarding_viewed` (step), `interest_selected` / `interest_deselected` (topic, step), `onboarding_skipped` (step), `sign_in_started` / `sign_in_succeeded` / `sign_in_failed` (provider), `onboarding_completed` (topics_count) |
| Home | `home_viewed`, `home_shortcut_tapped` (target), `home_promo_tapped` (kind: cfp, rating) |
| Events | `event_viewed` (event_id, source), `session_viewed`, `rsvp_created`, `rsvp_cancelled`, `rsvp_failed` (reason: full, offline, error), `add_to_calendar_tapped`, `venue_maps_opened` |
| Ticket and check-in | `ticket_viewed`, `check_in_scanned` (result) |
| Submit a talk | `talk_started`, `talk_step_completed` (step), `talk_draft_saved`, `talk_submitted` |
| Profile | `profile_edited` (number of fields changed), `signed_out`, `account_deleted` |
| Jobs and sponsors | `job_viewed`, `job_apply_tapped`, `sponsor_viewed`, `sponsor_website_tapped` |
| Push | `push_permission_result`, `push_opened` (type) |
| Ratings | `rating_prompt_viewed` (source), `ratings_sent` (count, has_comment), `ratings_skipped`, `speaker_feedback_viewed` |

The sponsor numbers (views, RSVPs, check-ins) and the rating aggregates come from Supabase tables, not the analytics tool. That keeps them reliable and queryable later.

---

## Totals
- **Day values:** S = 0.5, M = 2, L = 4 days.
- **Engineering capacity:** about **100 engineer-days** (Android, iOS, shared/KMP and backend).
- **Not counted against that capacity:** design (done by the designer agent) and content/ops (organizers and the product owner).

### By area (all 11 features, must-have)
| Area | Days |
|---|---|
| shared/KMP | 94.5 |
| backend/Supabase | 33 |
| Android | 8 |
| iOS | 13 |
| **Engineering** | **148.5** |
| of which overhead-type (OH: F1-15, F1-16, F1-19, F0-15) | 6.5 |
| design | 13 |
| content/ops | 11.5 |
| **All** | **173** |

### By feature
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
| F10 Push reminders | — | 2.5 | 3 | 0.5 | 2 | — | 8 | 8 |
| F11 Post-event ratings | 2 | 7 | 2.5 | — | — | — | 11.5 | 9.5 |
| **Total** | **13** | **94.5** | **33** | **8** | **13** | **11.5** | **173** | **148.5** |

### Does it fit?
**No.** Engineering is **148.5 days against about 100, which is 48.5 days (about 49%) over.**

`docs/mvp.md` already counts setup, store releases and bug fixing in its 30% overhead. If the 6.5 OH days move into that buffer, the feature work is **142 days, still 42 days (42%) over.**

Push reminders (8) and post-event ratings (9.5) added 17.5 days to the estimate. Removing the Content tab saved 3.5.

### Thinner versions to decide (not applied)
Each row keeps the feature but builds less of it. They're listed roughly from best to worst value for the days they save.

| # | Feature | Thinner version | Task change | Saves | What testers lose | Who decides |
|---|---|---|---|---|---|---|
| T4 | F4 Events | Events tab as a month-grouped list, without the week/month calendar | drop F4-04; F4-05 stays M | 4 | Calendar browsing (few events per month, so it matters little) | Product owner |
| T2 | F1 Foundation | No drawer. Submit a talk, Our sponsors, Code of conduct and About become rows on Profile and Settings | drop F1-22 | 2 | A secondary menu | Design + product owner |
| T1 | F1 Foundation | Stock M3 components themed with our tokens. Custom builds only for StatusBadge, Avatar and SettingsRow | F1-04 L → M | 2 | Some pixel fidelity to Figma | Design + engineering |
| T13 | F9 Sponsors | No Sponsor detail screen. Logos open the sponsor's website; Our sponsors stays | drop F9-06 | 2 | Sponsor page with open roles in the app | Product owner + organizers |
| T7 | F5 Check-in | Scanner on Android only for January (organizers scan with Android phones) | drop F5-08 | 2 | Organizers can't scan on iPhones | Organizers |
| T6 | F4 Events | Add to calendar on Android only for January | drop F4-10 | 2 | iOS members add events by hand | Product owner |
| T5 | F4 Events | Session detail becomes an expandable agenda row on Event detail | F4-11 M → S | 1.5 | A separate session screen | Design |
| T3 | F2 Onboarding | One interests screen (all topics grouped) instead of three steps | F2-07 M → S | 1.5 | A gentler onboarding pace | Design + product owner |
| T8 | F6 Submit a talk | Drafts saved on the device only. Your talks lists submitted talks | F6-06 M → S | 1.5 | Drafts across devices; drafts in Your talks | Product owner |
| T9 | F6 Submit a talk | Two steps: the optional Step 3 fields move into Step 2 | F6-05 M → S | 1.5 | A shorter last step | Design + product owner |
| T10 | F7 Profile | Edit profile covers bio and links. Topics are changed by reopening the onboarding interests screen | F7-04 M → S | 1.5 | Editing topics inline | Design |
| T11 | F9 Sponsors | Logos on the theme plate only, no Mono treatment | F9-03 M → S | 1.5 | Some logos may be faint in one theme | Design |
| T12 | F9 Sponsors | SponsorRow as one wrapped row of logos, without the One/Few/Many variants | F9-04 M → S | 1.5 | Name and tier on a single sponsor | Design |
| T15 | F11 Ratings | Rating row as a 1–5 segmented control with labels instead of a custom star component | F11-04 M → S | 1.5 | Stars | Design |
| T16 | F11 Ratings | Speaker feedback as a summary line in Your talks ("4.6 average from 58 ratings, 131 attended"), with no distribution | F11-07 M → S | 1.5 | The distribution bars | Product owner |
| T14 | F10 Push | Use one KMP push library over FCM on both platforms (an engineering lever, not a scope change) | F10-04 M → S | 1.5 | Nothing visible | Engineering |
| | | **All thinner versions** | | **29** | | |

**Even with every thinner version, it's still over:** 142 − 29 = **113 days, 13 over (13%).** Thinner versions alone can't close the gap. The product owner also has to pick at least one of these:
1. **Sequence, don't drop.** Ship F11 Ratings (6.5 days after T15/T16) in a **tester update in the second half of January**. Ratings only matter after the first January meetup. That brings the total to **106.5**, which matches the ~106 sprint capacity below but leaves no slack. It needs engineers in January (OQ-7).
2. **Add capacity.** One more engineer from Nov 16 adds about 20 feature days. With every thinner version that's about 7 days of slack, and ratings ship in the January build.
3. **Accept less polish in QA.** Not recommended: accessibility is part of the MVP.

**My recommendation for the product owner:** take the thinner versions you can live with, ideally all of them, and add an engineer (option 2). If that isn't possible, use option 1 for ratings. Every thinner version you decline adds its days back, and something else has to give. Decide by **Fri Nov 6**, so the S1 design tasks reflect it.

---

## Sprint plan
This plan uses **full-size tasks, with no thinner versions applied.**
- **Feature capacity per sprint** is 4 engineers × working days × 0.7: **S1 about 28, S2 about 28, S3 about 28, S4 about 22** (8 working days). That's about 106 in total.
- **OH tasks** come out of the 30% buffer, not the sprint's feature days.
- **Ordering:** foundation and store setup first, then the bet (sign in, find, RSVP, door, submit a talk, sponsors visible).
- **What doesn't fit** sits in "Above capacity". Thinner versions and the sequencing option above decide how much of it moves into S3–S4.

| Sprint | Engineering tasks | Feature days | Design and content/ops in parallel |
|---|---|---|---|
| **S1 Nov 2–13: foundation, store setup, auth** | F1-01, F1-02, F1-03, F1-04, F1-05, F1-07, F1-08, F1-09, F1-10, F1-11, F1-12, F1-13, F1-17, F1-18, F1-20, F2-02, F2-03 · **OH:** F1-15, F1-16, F1-19 | 28.5 | **Design:** F1-21, F2-01, F3-01, F4-01, F5-01, F9-01, F0-03 (all reflecting the Nov 6 decisions). **Content:** F0-01 on day 1 (a D-U-N-S number can take weeks), F1-14, F0-02, and F0-04 started |
| **S2 Nov 16–27: onboarding, events, RSVP, account deletion** | F1-06, F2-04, F2-05, F2-06, F2-07, F2-08, F2-09, F2-10, F3-02, F4-02, F4-03, F4-04, F4-06, F4-07, F7-07 | 27 | **Design:** F6-01, F7-01, F8-01, F11-01. **Content:** F0-04 done, F0-05, F0-06, F0-07; **F0-08 Play closed testing starts Nov 27–30** with the first internal build |
| **S3 Nov 30–Dec 11: Home, events finish, ticket and check-in, talk form, profile** | F3-03, F3-04, F3-05, F4-05, F4-08, F4-09, F4-11, F4-12, F5-02, F5-03, F5-04, F5-05, F5-06, F5-07, F5-08, F5-09, F5-10, F6-02, F6-03, F7-02, F7-03 | 28.5 | **Content:** F0-11 runbook, F0-12 organizer dry run, F5-11 door test (Dec 10–11) |
| **S4 Dec 14–23: submit a talk, sponsors, accessibility, hardening, beta submission** | F6-04, F6-05, F6-06, F6-07, F6-08, F6-09, F7-05, F7-06, F7-08, F7-09, F9-02, F9-03, F9-04, F9-07, F9-08, F0-13, F0-14, F0-16 · **OH:** F0-15 | 24 (about 1.5 over) | **Content:** **F0-09 TestFlight external beta review submitted Dec 21–23** with the S4 build, so the public link is approved before Jan 4. Later builds usually skip a full review. Final store listing |
| **Above capacity (34 days at full size)** | F1-22 (2), F4-10 (2), F7-04 (2), F8-02 to F8-05 (6.5), F9-05 (2), F9-06 (2), F10-01 to F10-07 (8), F11-02 to F11-08 (9.5) | 34 | Lands in S3–S4 only as thinner versions free days, or moves to a January tester update (option 1), or needs added capacity (option 2) |
| **Jan 4–8: release to testers** | Bug fixes from QA and beta review; release candidate (F0-17) | — | F0-09 public link and Play open testing go live; F0-10 tester onboarding; announcement to the chapter |

**Ordering notes**
- **Store checks:** delete account (F7-07) lands in S2. The privacy policy and the deletion page are done by the end of S2, because both stores check them before external testing.
- **Closed test clock:** the build needs to be in Play by about Nov 27 to finish its 14 days before January. That build only needs sign-in and Events.
- **Above-capacity order:** if thinner versions free days, bring work back in this order:
  1. F10 push (the reminders help the first meetup)
  2. F8 Jobs (the bet's sponsor promise)
  3. F7-04 Edit profile
  4. F9-05 and F9-06 (sponsors)
  5. F11 Ratings (needed only after the first January meetup)
  6. F4-10 iOS add to calendar
  7. F1-22 drawer

---

## Risks and assumptions

### Risks
| Risk | Impact | Mitigation | Owner |
|---|---|---|---|
| Scope doesn't fit: 148.5 engineering days against 100 (142 after the OH move) | A late or broken January build | Decide thinner versions and sequencing or capacity by Nov 6; review velocity at the end of S1 and S2 | Product owner |
| Ratings and push depend on check-in and RSVP data that only exists after a real meetup | Ratings can't be tested before January | Test with seeded check-ins on dev; first real test at the first January meetup | Engineering + organizers |
| Apple Developer enrolment as an organization needs a D-U-N-S number and can take weeks | No TestFlight, so no iOS testers in January | Start Nov 2. If it isn't done by Nov 20, fall back to an individual account held by an organizer | Organizers |
| Play testing rules: new accounts need 12 or more testers for 14 days before production, and open testing may not be available on a new personal account | No open sign-up on Android in January | Closed test with organizers from Nov 30. If open testing is gated, use closed testing with an opt-in link or Google Group | Organizers + engineering |
| TestFlight beta review over the holidays | Public link not live Jan 4–8 | Submit Dec 21–23 with a demo account and clear review notes | Engineering |
| The ticket is online-only (the offline ticket is cut), and venue connectivity in Nairobi is uneven | Queue at the door; check-in rate below target, which also shrinks who can rate | Venue Wi-Fi for members at the door; the scanner needs only the organizer's connection. First add-back: cache the ticket on the phone at RSVP time (about S) | Product owner + organizers |
| Studio gives organizers full database access, including member comments | Wrong edits or exposure of member data | Two or three trained organizers only; the runbook's "never touch" list; point-in-time recovery on; a dry run on dev | Organizers |
| Data protection: GitHub profiles, RSVPs, check-ins, view logs, ratings and comments are personal data under Kenya's Data Protection Act | Store rejection, legal exposure, loss of trust | Privacy policy before any tester signs up; no personal data in analytics; aggregates only for sponsors and speakers, with groups under 5 suppressed | Product owner + organizers |
| Shared Compose UI on iOS may feel non-native, or design may reject it | Rework, or weaker feedback from iOS testers | Native pieces only where a platform requires them; native chrome after testing; decide by Nov 6 | Engineering + design |
| Apple-only users can't sign in on Android, and Apple users have no GitHub profile data | Locked-out members; thin profiles | Initials avatar and name only; consider Apple web OAuth on Android (about M) | Engineering + product owner |
| No real meetup or open CFP during Jan–Feb | The success signal can't be measured | Organizers confirm dates by Nov 13 | Organizers |
| "Kotlin" in the app name | Store or trademark objection | Check JetBrains' brand guidelines; keep a fallback name | Organizers |
| Design handoffs for the trimmed screens land late | Engineers build from stale frames | The S1 and S2 design tasks are small; engineers start from the existing frames and adjust | Design |

### Assumptions
- **iOS UI:** shared Compose UI on iOS for January (OQ-2). Native pieces only for Sign in with Apple, calendar, camera, brightness and push.
- **Locale:** English only, the Nairobi chapter only, all times in EAT.
- **Minimum OS:** Android 8.0 (API 26) and iOS 16 (engineering to confirm).
- **Offline:** no offline cache. The only data on the device is the session and analytics.
- **Check-in:** verified on the server. The ticket QR is a signed token created with the RSVP.
- **Ratings eligibility:** only checked-in members can rate. Every session of the event is listed, with no per-session attendance tracking.
- **Rating window:** by default it closes on the Friday after the event (`ratings_close_at`). Organizers can change it in Studio.
- **Deleted accounts:** RSVPs, check-ins and ratings are kept but anonymised, so aggregates stay correct (OQ-8).
- **Design:** the designer agent can turn the S1 design tasks around in the first week.
- **Overhead:** stays at about 30%, covering reviews, bug fixing and store releases.

---

## Open questions
| # | Question | Who answers |
|---|---|---|
| OQ-1 | Which thinner versions (T1–T16) do we take, and which of sequencing (option 1) or added capacity (option 2) closes the rest? Decide by Nov 6 | Product owner + organizers |
| OQ-2 | Do we ship shared Compose UI on iOS for January, with native chrome after testing? | Engineering + design |
| OQ-3 | Is Supabase Studio enough for the organizers who will run January meetups? Who are the two or three Studio users? | Organizers |
| OQ-4 | Is GitHub plus Apple sign-in enough? Should Apple sign-in also work on Android? Do members without GitHub need email sign-in? | Product owner (engineering sizes it) |
| OQ-5 | Who owns the store accounts, the privacy policy and the app name? Do we already have a D-U-N-S number? | Organizers |
| OQ-6 | Which meetups fall in Jan–Feb, and when does the CFP open and close? | Organizers |
| OQ-7 | Are engineers available Jan 11–29 for a tester update (F11 Ratings or other items above capacity)? Can we add an engineer from Nov 16? | Product owner |
| OQ-8 | When an account is deleted, do we delete or anonymise its RSVPs, check-ins and ratings? What retention does the privacy policy promise? | Product owner + organizers |
| OQ-9 | What may sponsors see (aggregates only)? We need the answer before testers sign up | Product owner + organizers |
| OQ-10 | Which analytics and crash tools (Firebase or PostHog; Sentry or Crashlytics)? Do we need an analytics consent prompt? | Engineering + product owner |
| OQ-11 | Should the Home FAB stay next to the Submit a talk tile and the promo? | Design |
| OQ-12 | Is "Share event" in the MVP? `docs/mvp.md` lists the share sheet as a native piece, but feature 4 doesn't include sharing (about S if yes) | Product owner |
| OQ-13 | Do the organizers who scan at the door have Android phones? (This decides T7.) | Organizers |
| OQ-14 | Can speakers edit a talk after submitting, before the CFP closes, or do organizers handle changes? | Organizers |
| OQ-15 | Should we send a rating-prompt push the evening after the meetup (about S on top of F10)? The design relies on it to get ratings; `docs/mvp.md` lists only two notices | Product owner |
| OQ-16 | Is 5 ratings the right minimum before a speaker sees feedback? Should speakers ever see screened comments? | Organizers + product owner |
| OQ-17 | Can members who attended but weren't scanned in (scanner down, walk-ins) rate the meetup, or only checked-in members? | Organizers |
