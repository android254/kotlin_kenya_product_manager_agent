# Foundation: domain models and design system

Last updated 2026-10-08. Status: **draft for engineering, design and product owner review.**
- **Source:** `docs/decisions.md` 2026-10-08 §4 (build order), 2026-10-02 "Architecture: clean architecture, modular, offline first", 2026-10-02 "Thinner versions T1, T2, T4 and T13 accepted". Feature list: `docs/mvp.md` features 1–9.
- **Designs:** `kotlin-kenya-designer-agent` (Figma file, `README.md` token and component inventory, `docs/*-handoff-notes.md`).
- **Absorbs:** `docs/scopes/mvp-january.md` tasks **F1-03** (theme and tokens), **F1-04** (core components A, sized M under T1), **F1-05** (core components B) and **F1-06** (cards). Those rows stay in `mvp-january.md` as tracking references, but the work happens here. This follows the same pattern W1 used for F0-04/F0-05. Everything else in F1 stays where it is: project setup, CI, root tabs, Supabase projects, schema and RLS, crash reporting, analytics.
- **Thinner versions applied:** T1 (stock M3, themed), T2 (no drawer), T4 (month-grouped Events list, no calendar), **T13 (no Sponsor detail screen; logos open the sponsor's website)**. T13 is accepted in `docs/decisions.md`; it isn't one of the reserve options. The reserve options (T3, T5, T8–T12, T15, T16) are **not** applied. The models and components here work the same way whether or not any of them is taken later.
- **Build window:** S1 (Nov 2–13) plus the first week of S2. The work is split into three milestones by the date the consuming feature starts (see Tasks). It stays a single phase because all of it has to land before the features it serves are built.

> **Headline for the product owner.** This scope is about **24.5 engineering days**. **10** of those are F1-03 to F1-06, which are already counted in `mvp-january.md`, so it adds **14.5 days on paper**. About 10 of the 14.5 are model and column-spec work that the feature and schema tasks already implied. That work moves earlier rather than appearing from nowhere. No feature task has been re-estimated down, though, so **treat all 14.5 as new until engineering re-sizes F2–F9 after the contract freeze.** The work that is genuinely new is about **4.5 days**: conventions, fake repositories, the review, two extra kit tasks, and splitting the S1 component work into more tasks so it can be picked up in parallel.
>
> **The bigger cost is timing.** Domain-first doesn't save days ("they don't reduce the total engineer-days", 2026-10-02). It moves them to the front. S1 was planned at ~26.5 days with T1 applied, against ~28. With this scope it is **~37.5**, even after moving the talk, job and Home contracts into S2 week 1 (Milestone 3). Moving crash reporting and analytics (F1-12, F1-13) to S2 brings it to **~33.5, still ~5.5 over S1**. The product owner chooses (OQ-FD10): a later start for S2 feature work, taking reserve thinner versions now, or accepting the overrun.

---

## Problem
The team agreed to build "reusable first" before the 9 January features are split across 4 engineers. Without that, each engineer invents their own `Event`, `Profile` and `Sponsor`, each guesses which fields can be missing, and each builds their own button and empty state. That shows up later as mapping glue, null crashes when Supabase and the app disagree, and screens that drift from Figma and from the accessibility rules. If the shared contracts (domain models with every field marked nullable or not, plus repository interfaces) and the shared UI kit (tokens plus the components the MVP screens use) exist first, each feature's local source, remote source, repository and UI can be built in parallel without anyone waiting on someone else's assumptions.

## Users
| Who | What they need from this scope |
|---|---|
| The 4 engineers picking up F2–F9 | One agreed type per domain concept, with nullability settled and justified. Repository interfaces to build against. Fakes, so UI work can start before the Supabase tables exist |
| The backend engineer on the schema tasks (F1-08, F2-08, F3-02, F4-02, F4-03, F5-02, F6-02, F7-02, F8-02, F9-02) | A column spec whose `NOT NULL` constraints match the app's non-null fields |
| Designer (designer agent) | One place (a component gallery) to check fidelity and dark mode once, instead of screen by screen |
| Product owner | A contract that reflects the accepted cuts and doesn't quietly bring back cut scope (F10/F11, the drawer, the calendar, Sponsor detail) |
| Members (indirectly) | Screens that behave the same across features, with fewer null crashes in testing |

## Success signal
Proposed. Engineering confirms the numbers.
- **Parallel start:** S2 feature tasks for F2, F4 and F5 start on Mon Nov 16 against frozen contracts. In S2, **no Linear issue is blocked waiting on another engineer's model.**
- **One definition:** from S2 to S4, **no feature module defines its own copy of a shared model.** This is checked in review, plus a simple CI grep for duplicate class names in `:feature:*`.
- **Low churn:** after the freeze, **at most one breaking change per model area**, and each one goes through the change process (DM-11).
- **No hard-coded styling:** the CI check (DS-03) finds **zero raw colour literals or raw dp/sp values** in feature modules.
- **No mismatch crashes:** QA (F0-15) and closed testing (F0-08) find **zero crashes caused by a Supabase/app nullability mismatch.**
- **Kit, not screens:** every component-level accessibility bug from the passes (F0-13, F0-14) is fixed once in the kit, not patched per screen. The designer signs off the gallery (DS-D2) before S3 starts on Nov 30.

---

## User stories
These are engineering-facing stories. Members get the value indirectly, through features that ship on time and behave the same everywhere.

- **US-FD.1 (contract):** As an **engineer picking up Events (F4)**, I want agreed `Event`, `Session`, `Speaker` and `Rsvp` types with every field's nullability settled, so that I can build the Supabase source while a teammate builds Event detail against the same types, and neither of us waits on the other.
- **US-FD.2 (fakes):** As an **engineer building a feature's UI**, I want fake repositories that return fixture data for every design state (default, empty, error, offline), so that I can build and preview the screen before its table exists.
- **US-FD.3 (offline shape):** As an **engineer building an offline-capable feature (talk drafts, check-in)**, I want one shared sync-state and freshness shape, so that offline behaviour looks and works the same in every feature.
- **US-FD.4 (schema match):** As the **engineer writing a feature's schema**, I want each domain field mapped to a column with matching `NOT NULL`, so that the app never receives a null it declared impossible.
- **US-FD.5 (tokens):** As an **engineer building any MVP screen**, I want the Figma tokens (colour in light and dark, type, spacing, shape, size) as Compose values, so that I never hard-code a colour or a dp.
- **US-FD.6 (kit):** As an **engineer building any MVP screen**, I want the components the MVP uses, built with their accessibility rules (48dp targets, semantics, 200% text), so that every screen meets the a11y criteria without solving them again.
- **US-FD.7 (sign-off):** As the **designer**, I want a gallery of every kit component in light, dark and 200% text, so that I can sign off fidelity once instead of on every screen.
- **US-FD.8 (no scope creep):** As the **product owner**, I want the models and the kit limited to the 9 January features and the accepted cuts, so that the foundation doesn't quietly bring back cut scope.

---

## Acceptance criteria
`mvp-january.md`'s global states still apply to screens. The criteria below cover what the **contracts and the kit** must provide so those screen states can be built. One correction: `mvp-january.md`'s "There is no offline cache in the MVP" was overtaken by the 2026-10-02 offline-first decision. The read-offline, write-offline and online-only split below follows that decision.

### Every domain model
- **Nullability is justified:**
  - **Given** a domain model pull request
  - **When** it's reviewed
  - **Then** every nullable field has a KDoc line naming the Figma frame or state where the field is absent ("Avatar Type=Initials", "Job without a closing date"), or the data-source reason ("GitHub `name` is optional").
  - A field with no stated reason is non-null.
- **Loading is not null:**
  - **Given** any model
  - **Then** no field is nullable just because the data "hasn't loaded yet".
  - Loading is a UI state (F1-09), never a null field.
- **Collections and booleans:**
  - **Given** a list field
  - **Then** it's a non-null `List` where empty means none.
  - **Given** a boolean field
  - **Then** it's non-null.
- **Required on submit:**
  - **Given** a value that's optional while drafting and required on submit
  - **Then** it's nullable in the draft type and non-null in the submitted type.
  - Two types are used, not a runtime check.
- **Derived values are functions:**
  - **Given** seat tone, "is full", "is past", "CFP is open" or "applications closed"
  - **Then** each is a function on the model that takes `now` or other fields, with unit tests. None is a stored field.
- **Platform-free:**
  - **Given** a model or repository interface
  - **Then** it lives in `commonMain` with no Android, Supabase or serialization imports. Transfer objects (DTOs) live in the data layer.
  - The iOS-target compile check stays green.
- **Cut scope stays out:**
  - **Given** a field
  - **When** it's checked against `docs/mvp.md`'s "Cut" column and T2/T4/T13
  - **Then** it serves a January screen.
  - The only exception is `Event.ratingsCloseAt`, an F11 placeholder that's already in the F4-02 schema.
- **One definition:**
  - **Given** a feature pull request in S2–S4 that needs a shared concept
  - **When** it's reviewed
  - **Then** it imports the shared type. A duplicate or "extended copy" is rejected, and changes go through DM-11.
- **Fixtures per state:**
  - **Given** a model
  - **Then** DM-09 provides at least one fixture for each design state that model appears in.
  - Fixtures use the fictional people and brands from `placeholder-media-handoff-notes.md`, never real members.

### States at the contract level
- **Empty:**
  - **Given** no upcoming published event
  - **When** the Home repository is asked for the feed
  - **Then** `HomeFeed.nextEvent` is null, and Home shows its empty state.
  - Empty lists (jobs, sponsors, my RSVPs, your talks) are empty `List`s, not nulls.
- **Error:**
  - **Given** a request fails
  - **When** a repository returns
  - **Then** it returns a `DomainError` variant that the UI maps to the Error StateMessage.
  - Feature-specific failures have their own variants. For example, the last-seat race returns `RsvpError.EventFull` ("This event just filled up").
- **Offline, cached (read-offline types: events, sessions, speakers, own ticket, jobs, sponsors, profile, your talks):**
  - **Given** data was fetched before
  - **When** the device is offline
  - **Then** the repository returns `Cached<T>` with `fetchedAt`, and the screen shows the content plus a FreshnessNote ("Last updated 2 hours ago").
- **Offline, nothing cached:**
  - **Given** no cached copy
  - **When** offline
  - **Then** the repository returns `DomainError.Offline`, and the Offline StateMessage shows.
- **Offline write (write-offline types: talk drafts; check-ins pending OQ-FD1):**
  - **Given** a draft saved while offline
  - **Then** its `syncState` is `Pending` until the server confirms it, and `Synced` after.
  - Persisting and retrying is the feature's job. The model only carries the state.
- **Online-only (RSVP, cancel, sign-in, delete account):**
  - **Given** the device is offline
  - **When** RSVP is attempted
  - **Then** the repository returns `DomainError.Offline` without touching `myRsvp`, and no sync field exists on these types.

### By domain area
- **Identity and profile (DM-02):**
  - **Given** a GitHub account with no display name set
  - **When** the profile is mapped
  - **Then** `displayName` falls back to the GitHub handle, so the greeting, ticket and header never see null.
- **Events (DM-03):**
  - **Given** `seatsLeft / capacity`
  - **When** the seat tone is derived
  - **Then** it returns Neutral at 15% or more, Warning below 15% and Error at 0. This matches `events-handoff-notes.md`, with no waitlist.
  - An agenda item with zero speakers and no abstract is a valid `Session`.
- **Ticket and check-in (DM-04):**
  - **Given** the three scanner results in `event-day-handoff-notes.md` (Checked in, Already checked in, Not on the list)
  - **Then** `CheckInResult` has exactly one variant for each, carrying the fields the frames show.
  - "Already checked in by" is nullable, because the scanning organiser's account may have been deleted (OQ-8).
- **Submit a talk (DM-05):**
  - **Given** a `TalkDraft`
  - **When** it's converted to a `SubmittedTalk`
  - **Then** the conversion either succeeds or returns a validation error for each failing field: title up to 65 characters, abstract present, format and level chosen, 1–3 tracks, 1–3 takeaways.
  - A `SubmittedTalk` can't be constructed with a null required field.
- **Jobs (DM-06):**
  - **Given** a job with `isFeatured = true` and no salary range
  - **When** it's constructed
  - **Then** it fails. This mirrors the F8-02 schema check and the P2 rule "a salary range is required for a featured slot".
- **Sponsors (DM-07):**
  - **Given** a sponsor on a custom tier ("Venue partner") rather than a fixed one
  - **Then** it's representable without a code change, because tiers are data, not an enum.
  - **Given** a sponsor with no logo uploaded
  - **Then** the model allows it, and `SponsorLogo` shows the placeholder monogram.

### Design tokens
- **Theme follows the system:**
  - **Given** the system is in dark mode
  - **When** any kit component renders
  - **Then** it uses the dark colour scheme. There's no picker.
- **Tokens only:**
  - **Given** a feature module
  - **When** CI runs
  - **Then** it finds no raw colour literals and no raw dp/sp values outside the token objects.
- **Type scales:**
  - **Given** the font scale is 200%
  - **When** any kit text renders
  - **Then** it scales with no clipping, with navigation labels capped at 14sp and the app bar title capped at 1.5×.
  - The smallest style is 12sp.

### Stock M3 components (T1)
- **Themed, not forked:**
  - **Given** a stock component (Button, Chip, TextField, TopAppBar, NavigationBar, ListItem, AlertDialog, Snackbar, bottom sheet)
  - **Then** it's the M3 component with our colour scheme, typography and shapes, plus at most a thin wrapper for the accessibility rules. No forked implementation.
- **Targets and names:**
  - **Given** any interactive kit component
  - **Then** its touch target is at least 48dp.
  - Icon-only controls take a non-null `contentDescription` parameter, so a missing label is a compile error, not a TalkBack bug.
- **Large-text layouts:**
  - **Given** a font scale of 1.3× or more
  - **Then** AlertDialog actions stack vertically, with confirm on top.
  - **Given** a font scale of 1.5× or more
  - **Then** BottomActionBar uses Stacked, and SettingsRow values move under the headline.
- **Cuts reflected:**
  - **Given** the root TopAppBar
  - **Then** it has no menu button (T2) and no notifications bell.
  - The kit contains no drawer, calendar, tab row, search field, switch, rating row or marquee (see "Not built").

### Custom components (allowed by T1: StatusBadge, Avatar, SettingsRow)
- **Avatar:**
  - **Given** a null photo URL, a loading image or a failed image
  - **Then** the Avatar shows initials, or the person glyph if there's no name.
  - Initials that repeat a name next to them are decorative.
- **StatusBadge:**
  - **Given** any tone
  - **Then** the badge has text. The Success, Warning and Error tones also have an icon, so colour is never the only signal.
- **SettingsRow:**
  - **Given** a row with a Chevron, Value, External or Destructive trailing element
  - **Then** the whole row is the target, at least 56dp tall.
  - External rows announce "opens in browser".

### Composites and cards
- **StateMessage:**
  - **Given** an Empty, Error or Offline variant
  - **Then** its title is a heading and a polite live region, and "Try again" is focusable.
- **Skeleton:**
  - **Given** a Skeleton container
  - **Then** it exposes exactly one spoken description, supplied by the caller (for example, "Loading events").
- **Cards:**
  - **Given** any card
  - **Then** it's one merged node with an `onClickLabel`. Its full title is in the description even when the visible title is truncated.
  - Nothing clips at 200% text.
  - EventCard and ShortcutTile strokes use `outline`, not `outlineVariant`. This closes the open WCAG 1.4.11 follow-up in `home-screen-handoff-notes.md`.
- **Gallery:**
  - **Given** the debug component gallery (DS-09)
  - **When** the designer reviews it (DS-D2)
  - **Then** every kit component has previews in Light, Dark, 200% text and 360dp width.
  - Sign-off is recorded in Linear before S3.

---

## Out of scope
- **F10 push and F11 ratings models:** device tokens, notification payloads, `EventRating`, `SessionRating`, speaker feedback aggregates, the Home "After the meetup" promo variant, and the `RatingRow` component. These are deferred to the mid-January update scope. The only exception is `Event.ratingsCloseAt` (one nullable field that's already in the F4-02 schema).
- **The full 127-component library.** Only the components in the inventory below are built (T1). In particular, none of these:
  - CalendarDay/Month (T4)
  - NavigationDrawerItem and the drawer (T2)
  - TabRow (Community shows Jobs only)
  - SearchField
  - Switch
  - SegmentedButton
  - Badge
  - AchievementBadge
  - PollResult
  - NetworkGraph
  - MemberSuggestionCard
  - ArticleCard
  - NotificationItem
  - RecapCard
  - Celebration
  - SponsorMarquee
  - PanelSessionCard (unless OQ-FD3 says panels are in)
  - TicketCard Compact (event-day mode)
  - `MeetupPoster`
- **Token collections:** Motion (8; motion choreographies are cut, so M3 defaults are used) and Poster (11; posters aren't planned). Also the 5 `iOS/*` type styles.
- **Design system automation:** an automated Figma-to-code token sync. Tokens are exported once (DS-01), and changes after that are manual pull requests. Screenshot testing (for example, Roborazzi) is a later add.
- **Web domain models and web components.** The React web platform is a separate product with its own stack.
- **iOS-specific UI:** the `08 — iOS chrome` stand-ins, native iOS components and the iOS styles. Models stay in `commonMain`, so iOS can reuse them later.
- **Anything that only exists behind a reserve thinner version** (T3, T5, T8–T12, T15, T16). The models and kit support the full MVP versions and don't pre-apply any of those cuts.
- **Models for cut features:** chapters, People and the developer network, Quick connect and booth leads, Content, saved jobs and sessions, polls, recordings, waitlist, walk-ins, Wallet passes, privacy controls, notification settings, Open to work, achievements, mentorship, the sponsor impact report, sponsored challenges, and the Sponsor detail extras that T13 removes (about, offers, open roles, meetups supported).
- **Use cases.** Feature owners write them. This scope stops at models, repository interfaces, error types and fakes.
- **The offline sync and outbox engine, and the local database.** This scope defines only the `SyncState` and `Cached<T>` shapes those layers use (see Risks).
- **Screen designs.** The MVP-version screen trims stay in their feature tasks (F1-21, F3-01, F4-01, F6-01, F7-01, F8-01, F9-01).

---

## Tasks
- **Sizes:** S = under a day (0.5), M = 1–3 days (2), L = 3–5 days (4).
- **Areas:** design, shared/KMP, backend/Supabase. There's no Android-only or iOS work: tokens, components and models all live in `commonMain`.
- **Design isn't counted against engineering capacity** (the `mvp-january.md` convention).
- **Code depends on F1-01** (the KMP project and its modules). Field extraction (reading frames and notes, drafting the field tables) can start on day 1 without it.

### Milestones
| Milestone | Date | Contents | Why then |
|---|---|---|---|
| **M1: contract freeze for S2 features** | Tue Nov 10 | DM-01–DM-04, DM-07, DM-D1, DS-D1, DS-01–DS-03 | F2 onboarding, F4 Events (including the SponsorRow on Event detail), F5 ticket and F7-07 deletion start S2 on Nov 16 |
| **M2: kit and fakes for S2** | Fri Nov 13 | DS-04–DS-06, DS-07a, DS-08, DS-09, DM-09 and DM-10 for the M1 models, DM-11 review 1 | S2 screens need the kit and the column spec (F4-02 is in S2) |
| **M3: contracts for S3–S4 features** | Fri Nov 20 | DM-05, DM-06, DM-08, DS-07b, DM-09 and DM-10 for these models, DM-11 review 2, DS-D2 | F6 talks, F8 jobs and F3 Home start in S3 (Nov 30) or later, so their contracts still freeze before their feature work starts |

### Draft domain model inventory (input to DM-02–DM-08)
This is a starting point taken from the handoff notes and the existing schema tasks. Each DM task **verifies it against the Figma MVP frames** (Default, Empty, Loading, Error, Offline, 200%) and corrects it. Types are indicative. `?` means nullable.

**Conventions (DM-01):**
- IDs are value classes over the Supabase UUID string. Talk drafts and check-ins use IDs generated on the device, so they can be created offline.
- Times are `kotlinx.datetime.Instant`, displayed in `Africa/Nairobi` (EAT).
- `SyncState { Pending, Synced, Failed }` appears only on write-offline types.
- `Cached<T>(value, fetchedAt)` wraps read-offline results. Freshness lives in the wrapper, not as a field on every model.
- `DomainError` covers Offline, Network, Unauthorized, NotFound and Validation(field, reason), plus feature variants.
- The agenda item is called `Session`. The auth state is called **`AuthState`**, never "session", to avoid the clash with Supabase's auth session.

**Identity and profile (F2, F3 greeting, F7): DM-02**
| Model | Field | Type | Why (nullable or not) |
|---|---|---|---|
| `Profile` | id | ProfileId | Equals the auth user ID |
| | displayName | String | GitHub `name` is optional, so the data layer maps `name ?: login`. The greeting, ticket and header always need a name |
| | githubHandle | String? | Read-only in Edit profile. Always present in January, but nullable for Apple or email sign-in later (OQ-4, OQ-FD4) |
| | avatarUrl | String? | Avatar has Initials and Placeholder variants (`placeholder-media-handoff-notes.md`) |
| | bio | String? | Optional. Empty for a new member |
| | location | String? | Optional on GitHub. Shown in the "Signed in as …, Nairobi" identity line. Confirm against F7-01 |
| | links | ProfileLinks | Always present. `linkedIn`, `x` and `website` are each `String?` |
| | topics | List\<Topic> | Can be empty: "Skip for now" saves none |
| | role | MemberRole { Member, Organizer } | Organizer unlocks the scanner entry point |
| | onboardingCompletedAt | Instant? | Null means show onboarding (F2-09 launch routing) |
| `Topic` | id, name | TopicId, String | Plain names, no "#" |
| | description | String? | The catalogue is edited in Studio. OptionCard works with a title only |
| | group | TopicGroup { Stack, Architecture, Emerging } | One per onboarding step. Still valid if T3 is later taken (grouped on one screen) |
| | isPopular, sortOrder | Boolean, Int | The "Popular" badge on the OptionCard, and display order |
| `AuthState` | — | SignedOut \| SignedIn(profileId, needsOnboarding) | Drives F2-09 |

Cut: Open to work, employer, achievements, journey stats, chapter, privacy settings, photo change, topic post counts.

**Events (F3, F4): DM-03**
| Model | Field | Type | Why |
|---|---|---|---|
| `Event` | id, title | EventId, String | — |
| | type | EventType { Meetup, Workshop } | Label on EventCard. The calendar markers are gone (T4), but the type is still shown. Confirm on the T4 list frame |
| | startsAt, endsAt | Instant | Agenda, add to calendar, Home "next", past or upcoming |
| | venue | Venue | Non-null unless OQ-FD6 allows "venue TBA" |
| | coverImageUrl | String? | The hero has a fallback (F1-11 bucket, upload optional) |
| | description | String? | Confirm whether Event detail has an "about" block |
| | capacity | Int | The seat tone and "Full" need it. No frame shows an "unlimited" state |
| | seatsLeft, goingCount | Int | From the `seats_left` view. Can be stale when cached (FreshnessNote). RSVP re-checks live |
| | ratingsCloseAt | Instant? | **F11 placeholder.** Already in the F4-02 schema and unused by the January UI |
| `Venue` | name | String | — |
| | address | String? | Maps can open from the name plus coordinates |
| | geo | GeoPoint? | Without it, Maps opens a search for the name and address |
| | directionsNote | String? | "Getting there" copy, optional |
| `EventSponsor` | sponsor, role, order | Sponsor, { Host, Supporter }, Int | SponsorRow overline "HOSTED BY … · SUPPORTED BY" |
| `EventDetail` | event, sessions, sponsors | Event, List\<Session>, List\<EventSponsor> | Both lists can be empty: no agenda yet means an empty agenda; no sponsors means no SponsorRow |
| | myRsvp | Rsvp? | Null means not RSVP'd |
| `Session` | id, eventId, title, startsAt, endsAt | — | — |
| | abstract | String? | Non-talk agenda items ("Opening", "Networking") have none. Confirm that they exist |
| | room | String? | Single-room venues |
| | format | SessionFormat | The same enum as the Step 1 format cards. Panel is pending OQ-FD3 |
| | level | AudienceLevel? | Non-talk items have none |
| | tracks, speakers, takeaways | List\<Track>, List\<Speaker>, List\<String> | Empty for non-talk items. `speakers` is a list, so panels need no model change |
| `Speaker` | id, name | — | — |
| | headline | String? | "Staff mobile engineer, M-KOPA". Organisers may not have it |
| | photoUrl | String? | Initials fallback |
| | bio | String? | Optional |
| | profileId | ProfileId? | External speakers have no account (F4-02). Cleared when an account is deleted (OQ-8) |

Not in the domain: event `status` (draft or published). RLS hides drafts, so clients never see them. Cut: saved sessions, polls, recording alert, the Sponsored session flag (#26), and session resources (OQ-FD8).

**RSVP, ticket and check-in (F4 RSVP, F5): DM-04**
| Model | Field | Type | Why |
|---|---|---|---|
| `Rsvp` | eventId, createdAt | EventId, Instant | Online-only, so no sync field. Only active RSVPs are returned, so there's no status field |
| | checkedInAt | Instant? | Null until scanned. Used to split past and upcoming in My RSVPs, and for F11 eligibility later |
| `Ticket` | eventId, code, qrPayload, holderName | all non-null | A ticket exists only for an active RSVP, and nothing on the screen is optional ("#A254-0141", signed token, name). Read-offline (cached) per the 2026-10-02 decision (OQ-FD2) |
| `CheckInResult` | CheckedIn(attendeeName, at, checkedInCount, expectedCount) | — | "Checked in · 9:21 AM", "Attendee 142 of 180" |
| | AlreadyCheckedIn(attendeeName, firstAt, byName: String?) | — | `byName` is null if the scanning organiser's account was deleted |
| | NotOnList | — | Covers another event, a cancelled RSVP or a forged code |
| `CheckIn` | id, eventId, ticketPayload, scannedAt, scannedBy, syncState | **only if OQ-FD1 confirms offline check-in** | The outbox record. Conflicts resolve to the earliest scan (`event-day-handoff-notes.md`) |

**Submit a talk (F6, Your talks on F7): DM-05**
| Model | Field | Draft type | Submitted type | Why |
|---|---|---|---|---|
| `TalkDraft` / `SubmittedTalk` | id | TalkId | TalkId | Generated on the device, so a draft can be created offline |
| | cfpId | CfpId | CfpId | — |
| | title | String | String | A draft is saved only once a title exists (F6 draft criterion). Up to 65 characters |
| | abstract | String? | String | Required on submit |
| | format, level | SessionFormat?, AudienceLevel? | non-null | Required on submit |
| | tracks, takeaways | List (0–3) | List (1–3) | Lists, never null |
| | Step 3 fields | all `?` | all `?` | "All optional". DM-05 lists them from the Step 3 frame |
| | status | — | TalkStatus { Submitted, Accepted, Declined } | A draft is its own type |
| | updatedAt / submittedAt | Instant | Instant | — |
| | syncState | SyncState | — | Drafts are write-offline. Submitting is online-only |
| | sessionId | — | SessionId? | Null until the talk is scheduled (F6-02) |
| `Cfp` | id, title, opensAt, closesAt | non-null | | `isOpen(now)` is derived. It drives the Home promo and the closed state |
| `Track` | id, name | non-null | | Possibly the same catalogue as `Topic` (OQ-FD5) |
| `YourTalk` | Draft(TalkDraft) \| Submitted(SubmittedTalk) | | | The list on Profile |

Cut: mentor opt-in, review step, editing after submitting, panel invites, speaker feedback (F11).

**Jobs (F8): DM-06**
| Field | Type | Why |
|---|---|---|
| id, title, companyName, description, applyUrl, postedAt | non-null | The card, the detail screen and "Apply on company site" can't work without them |
| companyLogoUrl | String? | Monogram fallback |
| sponsor | SponsorRef? (id, name, tier) | Null for companies that aren't sponsors. "Verified" is derived from `sponsor != null` (assumption) |
| location | String? | Null for fully remote roles |
| workMode, employmentType | enums | Shown in the meta line |
| salary | SalaryRange? (min, max, currency, period) | Optional, except that it's **required when `isFeatured`** (P2) |
| closesAt | Instant? | Open-ended roles. "Applications closed" is derived |
| isFeatured | Boolean | At most 2 are pinned. The list enforces that, not the model |

Cut: saved, topic matching, poster stats, search, skills filters.

**Sponsors (F9, plus the SponsorRow on Event detail and Job detail): DM-07**
| Model | Field | Type | Why |
|---|---|---|---|
| `Sponsor` | id, name | non-null | — |
| | tier | SponsorTier(id, name, rank) | **Data, not an enum.** The hybrid tier model allows custom tiers that organisers define (2026-10-04). Thresholds aren't needed by the app |
| | websiteUrl | String | Non-null: under T13 the logo's only destination is the website |
| | squareLogo, wideLogo | SponsorLogoAsset? | `SponsorLogo Content=Placeholder` (monogram) covers a missing upload |
| `SponsorLogoAsset` | url, plateLight, plateDark | String, Plate, Plate | Plate { Theme, Light, Dark, Mono }, a manual field with Theme as the default (F9-02). Mono stays because T11 isn't taken |
| `ViewRecord` | entityType { Event, Job }, entityId | write-only | Sponsor detail views are gone with T13 |

Cut by T13: about, offers, open roles on the sponsor, meetups supported.

**Home and app links (F3, F7 Settings, T2): DM-08**
| Model | Field | Type | Why |
|---|---|---|---|
| `HomeFeed` | greetingName | String | First token of `displayName` |
| | nextEvent | EventSummary? (event plus myRsvp?) | Null means the Empty state ("no meetup is scheduled yet") |
| | openJobsCount | Int | Jobs ShortcutTile meta ("48 open roles") |
| | promo | HomePromo? = Cfp(cfp) | Null means no promo. F11 adds a Rating variant in January |
| `AppLinks` | privacyPolicy, terms, codeOfConduct, about, deleteAccount | non-null URLs | Config, not an entity. URLs come from W1-C1. Under T2 these are rows on Profile and Settings |

### Domain models
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| DM-01 | **Conventions and core types:** ID value classes, time and EAT display, `SyncState`, `Cached<T>`, the `DomainError` hierarchy, and the nullability rules above. Also proposes module placement (OQ-FD9). F1-09 maps Supabase errors onto these types | shared/KMP | S | F1-01 |
| DM-D1 | **Design answers for extraction:** the designer answers the field questions raised by DM-02 to DM-08 against the MVP frames (Step 3 fields, JobCard meta, the Event "about" block, whether agendas include non-talk items, EventCard type label under T4) | design | S | DS-D1 |
| DM-02 | **Identity and profile:** `Profile`, `ProfileLinks`, `MemberRole`, `Topic`, `TopicGroup`, `AuthState`, plus the `AuthRepository`, `ProfileRepository` and `TopicRepository` interfaces. Sources: onboarding, Edit profile and Profile frames | shared/KMP | S | DM-01 |
| DM-03 | **Events:** `Event`, `Venue`, `EventDetail`, `Session`, `Speaker`, `EventSponsor` (referencing DM-07's `Sponsor`), `SessionFormat`, `AudienceLevel`, the seat-tone function with unit tests, and `EventRepository`. Sources: the T4 list, Event detail (all states), Session detail | shared/KMP | M | DM-01, DM-07 |
| DM-04 | **RSVP, ticket and check-in:** `Rsvp`, `Ticket`, `CheckInResult`, `RsvpError`, and `CheckIn` with outbox fields only if OQ-FD1 confirms offline check-in. Interfaces: `RsvpRepository`, `TicketRepository`, `CheckInRepository` | shared/KMP | M | DM-01, DM-03 |
| DM-05 | **Submit a talk:** `Cfp`, `TalkDraft`, `SubmittedTalk`, `YourTalk`, `TalkStatus`, `Track`, the draft-to-submitted validation with unit tests, and `TalkRepository` and `CfpRepository` | shared/KMP | M | DM-01, DM-03 (`SessionFormat`) |
| DM-06 | **Jobs:** `Job`, `SalaryRange`, `WorkMode`, `EmploymentType`, the "featured requires salary" invariant, and `JobRepository` | shared/KMP | S | DM-01, DM-07 |
| DM-07 | **Sponsors:** `Sponsor`, `SponsorTier`, `SponsorLogoAsset`, `Plate`, `ViewRecord`, and the `SponsorRepository` and `ViewRecorder` interfaces. Applies T13 | shared/KMP | S | DM-01 |
| DM-08 | **Home and app links:** `HomeFeed`, `HomePromo`, `AppLinks`, and `HomeRepository` | shared/KMP | S | DM-02, DM-03, DM-05 (`Cfp`) |
| DM-09 | **Fakes and fixtures:** an in-memory fake for each repository interface, returning fixtures for every design state (Default, Empty, Error, Offline-cached, Offline-empty), using the fictional names and brands. Used by Compose previews, the gallery and UI tests. Delivered in two increments (M2 and M3) | shared/KMP | M | DM-02 – DM-08 |
| DM-10 | **Schema column spec:** map every domain field to a column, with `NOT NULL` matching the non-null fields. Covers `profiles`, `profile_topics`, `topics`, `cfps`, `events`, `sessions`, `speakers`, `session_speakers`, `rsvps`, the ticket token, `check_ins`, `talk_submissions`, `jobs`, `sponsors`, `event_sponsors` and `page_views`. Attach it to F1-08, F2-08, F3-02, F4-02, F4-03, F5-02, F6-02, F7-02, F8-02 and F9-02 as their input. List every place the existing task text disagrees. Two increments | backend/Supabase | M | DM-02 – DM-08 |
| DM-11 | **Contract review and freeze:** a walkthrough with all 4 engineers and the designer (twice: M2 and M3). Tag the frozen version. Agree the change process: after the freeze, a model change is a pull request labelled `contract`, approved by one engineer from each consuming feature | shared/KMP | S | DM-01 – DM-10 |

### Design tokens (7 Figma collections → what Compose needs)
| Figma collection | Compose output | In this scope? |
|---|---|---|
| `Palette` (122 primitives) | Not exposed. Used only to generate the colour schemes | Input only |
| `Color` (46 M3 roles + success/warning + `surfaceCard` + `backgroundTransparent`; Light and Dark) | `lightColorScheme` / `darkColorScheme`, plus an `ExtendedColors` CompositionLocal for success/warning (and their on/container roles), `surfaceCard` and `backgroundTransparent`. Also the Kotlin gradient as a `Brush` | Yes |
| `Spacing` (17) | A `Spacing` object of `Dp` (includes `layout/section-gap` and the margin tokens) | Yes |
| `Shape` (13) | M3 `Shapes` (5 slots) plus named extras | Yes |
| `Size` (10) | A `Sizes` object (48dp target, avatar and icon sizes) | Yes |
| Type (18 M3 styles; Space Grotesk, Inter, JetBrains Mono) | `Typography` plus Mono overline styles in an extended local, with fonts bundled through Compose resources | Yes |
| `Motion` (8) | — | **No.** M3 defaults; choreographies are cut |
| `Poster` (11) | — | **No.** Posters aren't planned |
| Elevation (4 styles) | M3 tonal elevation | Defaults only |

### Component inventory (what the 9 features use)
| Component | Kind | Used by | Built in |
|---|---|---|---|
| Button (Filled, Tonal, Outlined, Text; external-link variant with `open_in_new`) | Stock M3 | All | DS-04 |
| IconButton | Stock M3 | All | DS-04 |
| Chip (FilterChip with checkbox or radio role; read-only topic chip) | Stock M3 | F2, F6, F7 | DS-04 |
| Checkbox, RadioButton | Stock M3 | F2, F6 | DS-04 |
| TextField (counter, error, read-only "Synced from GitHub") | Stock M3 | F6, F7 | DS-04 |
| TopAppBar (Root: logo and title, **no menu (T2), no bell**; Small: back plus up to 2 actions, 2-line title) | Stock M3 | All | DS-04 |
| NavigationBar (4 tabs, 14sp label cap) | Stock M3 | Shell (F1-02) | DS-04 |
| ListItem (1–3 lines, chevron rule) | Stock M3 | F4, F7, F9 | DS-04 |
| AlertDialog (stacked actions above 1.3×; destructive confirm in error colour) | Stock M3 | F4 cancel RSVP, F7 discard and delete | DS-04 |
| SnackbarHost (long duration, with action) | Stock M3 | F2, F6, F7 | DS-04 |
| ModalBottomSheet | Stock M3 | F5 scanner result | DS-04 |
| ExtendedFloatingActionButton | Stock M3 | F3, **only if OQ-11 keeps it** | DS-04 |
| StatusBadge (Neutral, Primary, Success, Warning, Error; icon on status tones) | Custom (T1) | F4, F5, F6, F8 | DS-05 |
| Avatar (Photo, Initials, Placeholder) | Custom (T1) | F4, F7 | DS-05 (after F1-10) |
| SettingsRow (Chevron, Value, External, Destructive; **no Switch**) | Custom (T1) | F7, and the T2 rows on Profile and Settings | DS-05 |
| StateMessage (Empty, Error, Offline) | Composite | All | DS-06 |
| Skeleton (Card, ListItem, Hero) | Composite | All | DS-06 |
| InlineNote and **FreshnessNote** ("Last updated …", new for offline-first) | Composite | All read-offline screens | DS-06 |
| SectionHeader (overline merged; also the **month header for the T4 list**) | Composite | F3, F4, F7, F9 | DS-06 |
| BottomActionBar (Row, Stacked) | Composite | F2, F6, F8 | DS-06 |
| OptionCard (checkbox or radio role) | Composite | F2, F6 | DS-06 |
| StepIndicator | Composite | F2, F6 | DS-06 |
| EventCard (Featured, Compact) | Card | F3, F4, F7 | DS-07a |
| SessionCard (talk; no bookmark, no Sponsored label) | Card | F4 | DS-07a |
| StatTile (5 tones) | Card | F4 | DS-07a |
| JobCard (Featured, Verified) | Card | F8 | DS-07b |
| PromoCard (CFP; no "presented by") | Card | F3 | DS-07b |
| ShortcutTile (Jobs, Submit a talk) | Card | F3 | DS-07b |
| ProfileHeader | Feature-owned | F7 | F7-03 |
| SponsorLogo (Square, Wide × Color, Mono × Plate) | Feature-owned | F4, F8, F9 | F9-03 (T11 pending) |
| SponsorRow (One, Few, Many; **One now opens the website under T13**) | Feature-owned | F4, F8 | F9-04 (T12 pending) |
| TicketCard Full and QR on a white plate | Feature-owned | F5 | F5-03 |
| Scanner result content | Feature-owned | F5 | F5-09 |

Feature-owned components are listed so nobody builds a second copy. Their days stay in their feature tasks.

### Design system
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| DS-D1 | **MVP component inventory in Figma:** mark the components and icons above as MVP, mark the stock-M3 substitutions (T1), and mark what's cut (T2, T4, T13, and the cut features). This is the 2026-10-02 "mark as MVP version" follow-up, applied to components | design | S | — |
| DS-01 | **Colour, spacing, shape and size tokens:** export from the Figma variables (which carry Android code syntax) into Kotlin. Light and dark colour schemes, `ExtendedColors`, the Kotlin gradient, `Spacing`, `Shapes`, `Sizes`. *(Absorbs F1-03 with DS-02 and DS-03)* | shared/KMP | S | F1-01 |
| DS-02 | **Typography:** 18 M3 styles, Mono overlines, the three bundled font families, the 12sp minimum, and font-scale cap helpers (navigation labels 14sp, app bar title 1.5×) | shared/KMP | S | F1-01 |
| DS-03 | **Theme wiring and guardrails:** a `KotlinKenyaTheme` that follows the system theme, the extended token locals, a shared multi-preview annotation (Light, Dark, 200%, 360dp, 412dp), and a CI check for raw colour and dp literals in `:feature:*` | shared/KMP | S | DS-01, DS-02 |
| DS-04 | **Stock M3, themed (T1):** Button, IconButton, Chip, Checkbox and Radio, TextField, TopAppBar (Root without menu or bell, Small), NavigationBar, ListItem, AlertDialog (stacked, destructive), SnackbarHost, ModalBottomSheet, and the FAB if OQ-11 keeps it. Thin wrappers only for the 48dp target, required `contentDescription` and large-text layouts. *(Absorbs F1-04 at its T1 size, with DS-05)* | shared/KMP | M | DS-03, DS-D1 |
| DS-05 | **Custom builds allowed by T1:** StatusBadge (tones and icons), Avatar (Photo, Initials, Placeholder through Coil), SettingsRow (Chevron, Value, External, Destructive) | shared/KMP | S | DS-03, F1-10 |
| DS-06 | **States and composites:** StateMessage, Skeleton, InlineNote and FreshnessNote, SectionHeader (including the T4 month header), BottomActionBar, OptionCard, StepIndicator. *(Absorbs F1-05)* | shared/KMP | M | DS-04 |
| DS-07a | **Cards for S2 features:** EventCard (Featured, Compact), SessionCard, StatTile. Merged semantics, the 200% rules, and the `outline` stroke fix. *(Absorbs half of F1-06)* | shared/KMP | M | DS-04, DS-05, DM-03 |
| DS-07b | **Cards for S3 features:** JobCard (Featured, Verified), PromoCard (CFP), ShortcutTile. *(Absorbs the other half of F1-06)* | shared/KMP | M | DS-04, DS-05, DM-06, DM-08 |
| DS-08 | **Icon subset:** only the Material Symbols Rounded icons used by the inventory, with decorative-or-labelled guidance in KDoc | shared/KMP | S | DS-D1 |
| DS-09 | **Component gallery:** a debug-only screen listing every kit component with its variants, fed by DM-09 fixtures. Used for the DS-D2 review and by engineers | shared/KMP | S | DS-04 – DS-06, DS-07a |
| DS-D2 | **Design review of the gallery:** check fidelity, Light and Dark, and 200% against the MVP frames. File the issues, then sign off in Linear. Repeat for DS-07b in M3 | design | S | DS-09 |

### Changes to `mvp-january.md` tasks (tracking only; no edits made there)
- **F1-03, F1-04, F1-05 and F1-06** are absorbed here, as described above.
- **F1-09** (data layer) now depends on DM-01 for the error and freshness types.
- **The schema tasks** listed in DM-10 take its column spec as input.
- **F1-21's drawer and F1-22** were already dropped by T2. F1-21 still needs the T2 row placement on Profile and Settings, which stays in that task and F7-01.

### Totals
| Area | Days | Notes |
|---|---|---|
| shared/KMP | 22.5 | 11 domain (DM-01–DM-09, DM-11) + 11.5 design system |
| backend/Supabase | 2 | DM-10 |
| **Engineering** | **24.5** | |
| of which absorbed from `mvp-january.md` | 10 | F1-03 (2), F1-04 at its T1 size (2), F1-05 (2), F1-06 (4) |
| **Engineering, new on paper** | **14.5** | About 10 of this (DM-02–DM-08 and DM-10) is model and schema-spec work the feature tasks already implied. About 4.5 is genuinely new (DM-01, DM-09, DM-11, and +1.5 in the design system) |
| design | 1.5 | DM-D1, DS-D1, DS-D2 |
| content/ops | 0 | — |
| **All** | **26** | |

**Sprint impact:**
- **S1** was ~26.5 days with T1 applied. Take out F1-03/04/05 (6) and add this scope's M1 and M2 work (~17): **S1 ≈ 37.5 against ~28**. Without the M3 sequencing, it would be ~45.
- **Moving F1-12 (crash reporting) and F1-13 (analytics) to S2** gives **~33.5**.
- **S2** loses F1-06 (4) and gains M3 (~7.5), plus F1-12 and F1-13 if they move.
- **The overall plan** grows by 4.5 to 14.5 days, depending on how much engineering trims F2–F9 once the contracts exist. **Recommend:** after the M3 freeze, ask each feature owner to re-size their schema and UI tasks given DM-09 and DM-10.

---

## Risks and assumptions

### Risks
| Risk | Impact | Mitigation | Owner |
|---|---|---|---|
| S1 is about 5.5–9.5 days over capacity once this scope lands, before W1's S1–S2 frontend days | Foundation slips, so S2 feature work starts late and the Nov 27 closed-test build is at risk | Milestone sequencing (talks, jobs and Home in S2 week 1). Move F1-12 and F1-13 to S2. The product owner decides on the rest (OQ-FD10) by Nov 6 | Product owner |
| The contracts freeze before the MVP design trims (F3-01, F4-01, F6-01, F7-01, F8-01 are S1–S2 design tasks) | Extracted fields don't match the final MVP frames, so the contract churns | Extract from the existing frames minus the `docs/mvp.md` cuts. DM-D1 answers the doubtful fields. After the freeze, design changes that add or remove fields go through DM-11 | Design + engineering |
| The offline-first decision (check-ins written offline, own ticket readable offline) conflicts with `mvp-january.md` F5 ("online only", "Connect to the internet to show your ticket") | The wrong `CheckIn` and `Ticket` shapes, or offline check-in arrives as a surprise L-size feature | OQ-FD1 and OQ-FD2 before M1. Until then, DM-04 models the online-only result and keeps the outbox fields in a separate type that can be added without breaking anything | Product owner + engineering |
| **The offline sync and outbox engine and the local database aren't sized anywhere.** `mvp-january.md` assumed no offline cache, and the 2026-10-02 decision says the estimate is "being re-estimated" | `Cached<T>` and `SyncState` have nothing behind them, so the read-offline promise misses January | Raise it as its own scope (core sync module). This scope only defines the shapes | Product manager + engineering |
| Scope creep inside the models ("while we're here, add `isSaved`") | Cut features creep back in, and the schema grows | The acceptance criterion that every field must cite a January screen. DM-11 review | Engineering |
| Stock M3 doesn't meet some design a11y rules out of the box (32dp chips, the 4dp app bar action gap, the `outlineVariant` stroke) | Repeated a11y bugs across screens | Thin wrappers in DS-04, and the stroke fix in DS-07a. These are already known from `home-screen-handoff-notes.md` and `panel-discussion-handoff-notes.md` | Engineering |
| Panels were designed on 2026-10-05, after `docs/mvp.md` was written | If they're in, the format enum, `PanelSessionCard` and the panel invite flow add scope | `Session.speakers` is already a list. Panel is in or out per OQ-FD3. The invite flow stays out | Product owner |

### Assumptions
- **Repository interfaces are in scope; use cases aren't.** The interface is the seam between the data engineer and the UI engineer. Use cases stay with the feature owner.
- **Module placement:** shared models live in one `:core:model` module, so features don't depend on each other. Repository interfaces live in each feature's `:domain` module. Engineering confirms this (OQ-FD9).
- **IDs:** Supabase primary keys are UUIDs. Talk drafts and check-ins are created with IDs generated on the device.
- **Time:** everything is stored as an instant and shown in EAT. There are no other time zones in January.
- **Tokens:** a one-time export from the Figma variables is accurate. Later token changes are manual pull requests.
- **T13 is accepted** (`docs/decisions.md` 2026-10-02), so there's no Sponsor detail model or screen. Event and Job page views are still recorded.
- **"Verified"** on a job is derived from the company being a sponsor, so there's no separate field.

---

## Open questions
| # | Question | Who answers |
|---|---|---|
| OQ-FD1 | **Offline check-in in January?** The 2026-10-02 architecture decision says door check-ins write offline and sync. `mvp-january.md` F5 says the scanner is online-only, with a blocking error. If offline wins, `CheckIn` needs outbox fields, **and the scanner has to verify tickets without the server** (a cached RSVP list per event, or verifying the token's signature on the device). That's an engineering question this scope can't settle. Needed before M1 (Nov 10) | Product owner + engineering |
| OQ-FD2 | **Cached ticket?** The same conflict for the member's own ticket: the decision says read-offline, while the F5 criterion says "Connect to the internet to show your ticket". Recommend following the decision (cache the ticket at RSVP time, which is cheap) and updating F5's criterion | Product owner |
| OQ-FD3 | **Panels in January?** Panels were designed 2026-10-05, after `docs/mvp.md`. Is "Panel" a January `SessionFormat` (with `PanelSessionCard` in the kit), or later? The invite flow stays out either way | Product owner |
| OQ-FD4 | Is `githubHandle` nullable now, so Apple or email sign-in later doesn't need a migration? The recommendation is yes. Ties to OQ-4 | Engineering + product owner |
| OQ-FD5 | Are Submit a talk **tracks** the same catalogue as onboarding **topics**? If yes, `Track` becomes `Topic`, and F6-02 and F2-08 share one table | Design + product owner |
| OQ-FD6 | Can an event be published before its **venue** is confirmed ("Venue TBA")? If yes, `Event.venue` becomes nullable, and Event detail, Maps and add-to-calendar need that state | Organizers |
| OQ-FD7 | Can organizers **cancel or postpone** a published event, and should members see that? If yes, `Event` needs a status, and the cards need a cancelled state | Organizers + design |
| OQ-FD8 | Does Session detail keep **resources** (slides, demo repo links) in January? F4-01 cuts the poll, recording and bookmark, but doesn't mention resources | Product owner + design |
| OQ-FD9 | Module layout: one shared `:core:model` module, or models split per feature with cross-feature references? | Engineering |
| OQ-FD10 | How do we absorb S1's ~5.5–9.5 day overrun: a later start for S2 feature work, taking reserve thinner versions now (T3, T5, T8–T12, T15, T16), or accepting it? Decide by Nov 6, alongside OQ-1 | Product owner |
| OQ-FD11 | Salary range shape: are open-ended ranges allowed ("from 300,000")? Is the period always monthly, and the currency always KES? | Organizers |
| OQ-11 *(existing)* | Does the Home FAB stay? This decides whether ExtendedFloatingActionButton is in the kit | Design |
| OQ-8 *(existing)* | When an account is deleted: anonymise or delete? This decides whether `Speaker.profileId` and `AlreadyCheckedIn.byName` can become null after deletion, which this scope already assumes | Product owner + organizers |
