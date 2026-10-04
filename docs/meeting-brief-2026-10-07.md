# Team meeting brief — Wed Oct 7, 2026

For the product owner going into the team meeting. Two parts: what's already decided (don't reopen these unless something's actually changed), and what the team needs to decide this week. Full detail and reasoning behind every line here lives in `docs/web-platform-brief.md`, `docs/decisions.md` and `docs/scopes/web-platform-w1-public-pages.md` — this is the condensed version to carry into the room.

---

## Part 1 — What's decided

### The app and the web platform are one product, split by what each is for
- **The app is the daily driver.** Anything offline, anything with state you come back to — tickets, drafts, check-in, your RSVPs — stays there.
- **The web platform is for walk-ins.** People without the app doing a one-shot action: fill in a form, read a page. No offline needs, no persistence of its own.
- One login, one design system, shared across both. Default role is `member`; a small set of accounts get `organizer`, unlocking extra routes on the **web only**.
- The in-app door check-in scanner **stays in the app** — it's camera-driven, venue-side, and was already built that way for good reason. "Organizer tools stay off the app" is a default for *new* tooling, not a rule that moves what's already there.

### The web platform ships in two sub-phases
- **W1 — public pages.** Terms of Service, Privacy Policy, account-deletion request page, About Us, and a sponsor "what's in it for you" pitch. No login, no forms, no database writes. **Already scoped** (`docs/scopes/web-platform-w1-public-pages.md`): ~7.5 engineering days, 3 design days, 8 content/ops days, plus an unsized legal review.
- **W2 — Call for Speakers, Call for Sponsors, Call for Donations forms**, Google + GitHub sign-in, an organizer financial status ledger, and organizer role-granting. Not scoped yet — blocked on the Open Collective decision (Part 2, below).

### Call for Speakers / Sponsors / Donations
- Three distinct public forms, each requiring sign-in (no anonymous submissions — "easier to keep track").
- **Call for Speakers** on web writes to the **same `talk_submissions` table** the app uses. One CFP, two entry points, not two pots.
- **Call for Sponsors** ("expects something in return") and **Call for Donations** ("no strings attached") are kept separate — "separation of church and state" — with different fields. Sponsors get a repeatable list for what they want back (booth, logo, speaking slot, etc.), not a fixed dropdown.
- Donations and sponsorship money most likely route through the community's existing **Open Collective account** — our platform doesn't build payment processing, reconciliation, or receipts.

### Sponsors
- **Sponsors can ask for a speaking slot.** Confirmed, with last year's Huawei sponsorship as precedent. This reopens part of a standing design decision (designer repo #26: "sponsors back whole events, never sessions," no sponsored-session label) — **not fully resolved**, see Part 2.
- **Tiers are a hybrid model:** some at a fixed money threshold, plus custom in-kind tiers (e.g. a venue host) organizers define case by case. Exact numbers not set yet.
- Organizer financial visibility is a **status ledger** ("pledged → invoiced → paid"), manually updated. Not a read-only view, and explicitly not full accounting — "we don't need to see everything."

### Platform and sign-in
- Web adds **Google sign-in** alongside GitHub, because sponsor/donor contacts in finance or marketing mostly won't have GitHub accounts. Apple sign-in stays an iOS-app-only thing.
- **Web framework: React**, confirmed. Specific framework flavor and hosting still open (Part 2).
- Granting the `organizer` role happens only on the web — manually in Supabase for now, a small admin screen later.

### Resourcing — the one everyone needs to walk in understanding
- The web platform is built **Nov–Dec 2026, by the same 4 engineers already building the Android app** for January testing. No separate hire, no separate team.
- The Android MVP plan (`docs/mvp.md`) was already running **~8.5 engineer-days over its ~100-day budget** before any of this existed. Adding W1 alone — even though it's the cheap sub-phase — pushes that to **~16 days over**, because the privacy policy and deletion page have to be live by ~Nov 27 for Play closed testing, which lands most of W1's engineering in the **two busiest Android sprints (S1–S2)**.
- The reserve "thinner version" cuts already identified for Android (~14.5 days available) can close most of that gap — but that's a trade the team needs to make on purpose, in this meeting, not something that happens by default.

---

## Part 2 — Decisions needed

### The one this meeting was called for
| # | Decision | Why it's blocking |
|---|---|---|
| **1** | **One Open Collective field/collective for both Call for Sponsors and Call for Donations, or two separate ones?** | Determines whether sponsorship and donation money stay separated the way the forms do ("church and state" applied to the ledger, not just the UI). **Blocks all of W2** — the forms can't be finalized until this is settled. |

### Needed this week (Nov 6 deadlines already built into the W1 plan)
| # | Decision | Notes |
|---|---|---|
| 2 | **Legal review route for the Terms of Service and Privacy Policy:** in-house, hired, or AI-assisted? Who owns it? | Must finish the privacy policy review by **~Nov 20** or Play closed testing (needs 14 days before January) slips. Still "I don't know" as of last check. |
| 3 | **Which engineer owns W1, and which reserve thinner version(s) from the Android list pay for its ~7.5 days?** | Still unassigned. Makes the resourcing trade-off above concrete rather than theoretical. |
| 4 | **Which specific React framework, and hosting?** | React itself is decided, but W1's own acceptance criteria (page works with JavaScript off, no client-side fetch, link-preview cards) need something that pre-renders — a plain client-rendered single-page app won't pass them. Needs a framework pick (e.g. Next.js, Remix, Astro, Gatsby), not just "React." |
| 5 | **Sponsor speaking slot — the actual mechanism.** Does it bypass the open Call for Speakers review entirely, or does the sponsor's nominee still go through the same CFP review as any other speaker (sponsorship buys consideration, not the seat)? | This decides whether the standing design decision (#26: sessions curated through the open CFP only, no sponsored-session label) needs an actual follow-up in the designs, and whether a deprecated "Sponsored" session label needs to come back. Affects both the W1 sponsor pitch copy and the W2 form. |

### No hard deadline yet, but worth raising
| # | Decision | Notes |
|---|---|---|
| 6 | Actual sponsor tier thresholds (money amounts per tier) and names/criteria for custom in-kind tiers | Needed before the sponsor tier list page can be written for real. |
| 7 | Domain name, and who owns it plus the privacy/sponsors inboxes | Housekeeping, but blocks W1's URLs. |
| 8 | Is an email-based account-deletion request enough for Play, or do we need a stored web form? How do we confirm the requester owns the account, and what reply time do we promise? | Currently scoped as email-only to avoid a database write in W1; worth a sanity check against Play's actual requirements. |
| 9 | Does the Code of Conduct (already linked from the app's Welcome and Settings screens) get a sixth W1 page, or live somewhere else? | Small, but currently has no home anywhere. |
| 10 | Cookieless page-view counts on the sponsor pitch, or is the organizers' own outreach log enough? | Low stakes, easy to defer. |
| 11 | If the privacy policy review isn't done by Nov 27: slip Play closed testing, or knowingly ship an internally-reviewed interim policy? | Only matters if decision 2 slips. Good to have a fallback answer going in. |
| 12 | If the Terms of Service isn't approved by Dec 23: drop the "Terms" link from the January app build, or hold the build? | Same shape as 11, further out. |

---

**If the meeting only gets through one thing, make it #1 (Open Collective) and #5 (speaking slot mechanism)** — both block real work (W2, and the sponsor pitch copy in W1) and both need people outside this document to weigh in.
