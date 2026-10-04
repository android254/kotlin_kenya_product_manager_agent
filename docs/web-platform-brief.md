# Web platform: product brief

Last updated 2026-10-04 · Owner: product manager · Status: **most open questions answered by the product owner; blocked on resourcing before it's a real scope — see §9 and "Before this becomes a scope" below.**

This resolves the open decision in `docs/decisions.md` (2026-10-02: "one web product or two?") and the matching open question in `docs/prd.md` (§10): one product, role-flagged. **It also changes the January plan**, pending §6: the product owner wants this built in Nov–Dec alongside the Android app, not deferred to Feb–Apr as `docs/mvp.md` assumed — but whether that's free (separate capacity) or comes out of the already-tight Android budget is still unanswered. See "Where this sits in the roadmap."

## 1. The split: app vs. web

**App = daily driver. Web = walk-in.**

| | App | Web |
|---|---|---|
| Who | Members who've installed it and come back | Anyone with a browser and no app — a sponsor's finance person, a one-time donor, a speaker who heard about the CFP from a tweet |
| What it's for | Everything that benefits from being remembered: offline tickets, check-in, your RSVPs, your talk drafts, your profile | Quick, mostly stateless actions: submit a form, read public info, look something up once |
| Persistence | Local-first. Source of truth is the on-device database; network syncs into it | None of its own. Whatever Supabase already holds, read or written over the network each time |

**Rule of thumb for "does this belong on web":** if a feature needs to work offline, needs a draft you come back to over days, or benefits from being on the phone you carry (ticket, check-in scanner), it's app-only. If it's a form someone fills in once, or a read someone does once, it can be on web too. Call for Speakers, Call for Sponsors and Call for Donations are all the second kind — one-shot submissions — so they're the natural first web surfaces.

## 2. Roles and feature flagging

- **`member`** — the default. Everyone who signs in starts here. This is the existing `role` column on `profiles` (`docs/decisions.md`, stack decision) — no new auth concept, just a value the web reads to decide what to render.
- **`organizer`** — a small, named set of people (today's co-organizing team). Same login, more surface area.

| Surface | everyone, no login (public) | member (signed in) | organizer |
|---|---|---|---|
| Public pages — ToS, Privacy Policy, About Us, sponsor pitch, sponsor tier list | ✅ read | ✅ read | ✅ read |
| Call for Speakers — submit a talk | ❌ sign-in required (decided 2026-10-04 — see §5) | ✅ submit, into the same `talk_submissions` table the app uses (one CFP, two entry points — confirmed 2026-10-04) | ✅ submit, **and** see every submission (today: in Supabase Studio; this brief proposes a web view replaces that) |
| Call for Sponsors — submit a request | ❌ sign-in required | ✅ submit | ✅ see every submission |
| Call for Donations — submit a pledge/gift | ❌ sign-in required | ✅ submit | ✅ see every submission |
| Financials — **a status ledger** (decided 2026-10-04: not full reporting, not visibility-only — see §4) | ❌ | ❌ | ✅ |
| Grant the `organizer` role | ❌ | ❌ | ✅ — **web only**, see §8 |

This is one product, one deployment, one login. The organizer-only pages are routes gated by `role = 'organizer'` (RLS on the read, same pattern as the app) — not a second site. That's the "feature flagging as per your role" you described.

## 3. Call for Speakers, Call for Sponsors, Call for Donations

You were explicit that sponsors and donations are a **separation of church and state**, and I've kept that as two distinct forms with different fields and almost certainly different review flows:

### Call for Speakers (web mirror of Submit a talk)
Same intent as the in-app flow (`submit-a-talk-handoff-notes.md`): title, abstract, format, tracks, level. The web version exists so someone without the app — a speaker who found the CFP link on Twitter — can still submit. Organizers see submissions either here or in Studio (today). 🔵 *Open question: does the web submission write to the same `talk_submissions` table the app uses, so "Your talks" in-app and the web form are the same CFP? Assumed yes — one CFP, two entry points.*

### Call for Sponsors — *expects something in return*
A company says what they want from the community in exchange for backing an event: a speaking slot, a booth, a demo to attendees, logo placement, intro to attendees about their product, etc. You described this as needing **a repeatable list of text fields** — not a fixed dropdown, because what a sponsor wants varies — so the form is closer to "tell us what you want, add another" than a form with a fixed set of checkboxes.

Proposed shape (for the task-scoper to turn into real fields once confirmed):
- Company name, contact person, contact email
- Tier interest (optional, if tiers are still a thing — Gold/Silver/Community per `sponsors-handoff-notes.md`)
- What you're offering (money, product, in-kind — free text or a short structured choice)
- **What you'd like in return** — repeatable text field, e.g. "Speaking slot", "Booth at the venue", "Logo on event page" — add as many as apply
- Status (new → in review → approved → declined), visible only to organizers

### Call for Donations — *no strings attached*
"Offerings to the church," as you put it. No expectation fields, because there's no expectation. Proposed shape:
- Name (sign-in required to submit — see §5, so this is never truly anonymous on our side)
- Amount or in-kind description
- Optional note
- Status, visible only to organizers

**Update 2026-10-04 — partly resolved, one piece still needs a team meeting:** there's an existing **Open Collective account**. That answers the hard part of the original question — the platform itself doesn't need to build payment processing, reconciliation or receipts; money moves through Open Collective, which already handles that transparently, and our web platform captures the submission/pledge and (presumably) links out to or references the Open Collective flow for the actual transfer. That keeps the PRD's "no paid ticketing and payments" assumption intact for *our own systems*.

**Still open, and explicitly deferred to a team decision:** whether Call for Sponsors and Call for Donations need **two separate Open Collective "fields"** (likely two separate collectives, or two tiers/funds within one) so the money itself stays separated the same way the forms are separated — "church and state" applying to the ledger, not just the UI. You flagged this needs a team conversation regardless of what I'd propose, so I'm not proposing anything here — just noting that the web form design (one submission flow or two, and where each one points) is blocked on that meeting's outcome.

## 4. "Financials" for organizers

**Decided 2026-10-04: option (b), a status ledger.** Not visibility-only (a) and explicitly not full reporting (c) — "we don't need to see everything, it's going to be a complex thing to build."

So the shape is: a status per submission — something like "Kasha Health: KES 150,000 pledged → invoiced → paid" — tracked and updated manually by an organizer in the platform, not derived automatically from bank or M-Pesa records, and not reconciled against anything external. This is a status field on top of the Call for Sponsors / Call for Donations submissions, not a separate accounting system. Given the Open Collective account (§3), the actual money and any real reconciliation lives there; this ledger is organizers tracking *where a submission is in the process*, in our own platform, alongside it.

## 5. Same login, same design system

- **Login — decided 2026-10-04: GitHub + Google.** Same Supabase Auth as the app, but web adds a **Google** sign-in provider on top of GitHub, because finance and marketing contacts on the sponsor/donor side mostly won't have GitHub accounts. (Apple sign-in stays an iOS-app-only thing, per the existing decision in `docs/decisions.md` — it's not relevant to web.) **Engineering follow-up:** add a Google OAuth app and wire it into Supabase Auth for the web client; this is new work, the app today only has GitHub configured.
- **Decided 2026-10-04: the Call for X forms require sign-in to submit.** Not anonymous, not just contact details on the form — "it's easier to keep track when we don't have anonymous data." This simplifies the public-access row in §2's table (there's no unauthenticated submission path to design for) but it does mean a sponsor or donor's very first interaction with the platform is "create an account," which is worth being honest about as friction — if it turns out to block real sponsors/donors during testing, this is the first thing I'd revisit.
- **Design system:** same tokens, same components, same voice as the app (Figma file, `docs/*-handoff-notes.md`). Web gets its own layout (it's not Compose), but it should read as the same product. This is a design-team task once the above is settled enough to brief them.

## 6. Where this sits in the roadmap — decided to build now, resourcing still needs an answer

**Decided 2026-10-04: build it now, in Nov–Dec, not Feb–Apr.** Your reasoning — everyone has AI tooling, so it can move fast in parallel — I want to flag rather than just accept at face value, because it changes a plan that's already committed and already tight:

- `docs/mvp.md` set the January MVP at **~100 engineer-days of feature work from 4 engineers**, and `docs/scopes/mvp-january.md` already has it running **~8.5 engineer-days over that budget before any of the "thinner version" cuts are applied.** That's the Android app alone — nothing in it assumed a web platform would also be built in the same window.
- This brief adds real, non-trivial scope on top: three forms with different field shapes, a status ledger, Google OAuth, role-gated organizer views, five content pages (one needing legal review), and a sponsor tier model that doesn't exist yet. AI tooling speeds up writing code; it doesn't remove the need to design the tier list, get the ToS reviewed, decide the Open Collective split, or test that the status ledger does what organizers need. Those are the slow parts here, not the typing.
- **So the real question isn't "can we," it's "with whose time":**
  1. Is this built by the **same 4 engineers**, meaning it now competes with an Android scope that's already over budget — something in `docs/mvp.md`'s feature list has to shrink further or slip?
  2. Or is this **separate capacity** — a 5th person, or organizers themselves building the web platform alongside the 4 engineers on Android — in which case the Android plan doesn't need to move at all?

I haven't assumed an answer and haven't touched the Android MVP scope. **I need you to tell me which of those two it is** before I treat "ship in Nov–Dec" as a plan rather than an intent — it's the difference between "this is free" and "something else on the Android list gets cut or slips."

## 7. Public pages

You also want the web platform to carry the "front door" content that currently has no home: Terms of Service, Privacy Policy, About Us, a sponsor pitch, and a sponsor tier list. These are all **public, no login needed** — they're what a sponsor or donor reads *before* deciding to fill in a Call for X form, so they have to come first in the information architecture, not be buried behind it.

| Page | Content | Notes |
|---|---|---|
| **Terms of Service** | Standard ToS for using the site/app | Net new — nothing in the PRD or MVP plan covers a ToS today, only a privacy policy. Needs legal review before publishing, same as the privacy policy. |
| **Privacy Policy** | Data inventory, purposes, retention, "sponsors see aggregates only," deletion | Already planned work — `docs/mvp.md` task **F0-04** builds this for the app ("host it on a static page"). **This is that static page.** Consolidating it here means F0-04 doesn't build a one-off page that gets thrown away when the web platform ships. |
| **Account deletion request** | The web form Play requires alongside in-app deletion | Already planned as **F0-05**. Same consolidation point as above — this is a natural home for it rather than a bare standalone page. |
| **About Us** | Who the community/organizers are | Net new, content/ops to write, not engineering-heavy. |
| **"What's in it for you" (sponsor pitch)** | The case for sponsoring, addressed to sponsors | Doesn't need to be invented from scratch — `sponsors-handoff-notes.md` already has this story worked out for the app (visibility → talent → engagement → insight, in that order, "value first"). This page is that pitch, written for someone arriving cold on the web rather than already using the app. |
| **Sponsor tier list** | What a sponsor can offer (you named **money and/or venue**) and, presumably, what each tier gets back | New — the designs have tier *labels* (Gold/Silver/Community, from `sponsors-handoff-notes.md`) but nothing yet defines what qualifies for which tier, or that a tier can be earned with an in-kind contribution (venue) rather than money. See open question 8 below — this list should drive the Call for Sponsors form, not sit disconnected from it. |

**Why this matters for the Call for Sponsors form (§3):** right now that form asks sponsors to free-text "what you're offering." If a tier list with defined thresholds exists, the form should probably reference it directly — e.g., "Which tier are you aiming for?" with the tier list's criteria shown inline — rather than asking sponsors to describe their offer from nothing. I'd sequence the tier list *before* finalizing the form's fields.

## 8. Organizer role management, and the app/web boundary

**Decided 2026-10-04:** all organizer controls live on the web, none in the app — "we would like to keep the app lean." Granting the `organizer` role itself is **web-only too**: manually in Supabase for the MVP, or a small admin screen on the website later. Nothing about role-granting touches the app.

**🟡 One thing I want to confirm rather than assume, because it would reverse an already-built decision:** the Jan MVP (`docs/mvp.md` feature 5, `docs/decisions.md` offline-first section) already has an **organizer-only check-in scanner inside the app** — scanning attendee QR tickets at the door, deliberately in-app because it's camera-driven, venue-side, and the one place offline matters most ("door check-ins... this is where offline matters most"). I'm reading "organizer controls purely on web" as describing the **new** organizer surfaces this brief introduces — reviewing Call for X submissions, the financial status ledger, granting roles — not as an instruction to move the door scanner out of the app. If that reading is wrong and you do want the scanner moved to web, say so explicitly, because it reopens a decision that's already shaped January's build. Otherwise I'm treating the app as lean **going forward** (no new organizer features added to it) while the scanner stays where it already is.

## 9. Open questions — remaining after 2026-10-04

Resolved this round: donations' payment mechanism (Open Collective, though the two-field split is pending a team meeting), the financials ledger scope, Google sign-in, sign-in-required forms, the shared `talk_submissions` table, and where organizer role-granting lives. Still open:

| # | Question | Who decides |
|---|---|---|
| 1 | **Blocking a team meeting you've already called:** one Open Collective field/collective for both Call for Sponsors and Call for Donations, or two separate ones, so the money stays separated the way the forms are? | Product owner + team |
| 2 | **Resourcing, see §6 — this is the one I most need an answer to:** is the Nov–Dec web build done by the same 4 engineers (something in the Android MVP list shrinks or slips), or by separate capacity (a 5th person, or organizers building it themselves)? | Product owner |
| 3 | Confirming §8: does "organizer controls purely on web" include moving the already-decided in-app door check-in scanner to web, or does it only apply to the new organizer surfaces this brief adds? | Product owner |
| 4 | What defines each sponsor tier — fixed money thresholds, named in-kind equivalents (e.g. "hosting a venue = Gold"), or organizer judgement case by case? Is "venue" the only non-money contribution type, or are there others (products, services, swag)? | Product owner + organizers |
| 5 | Who writes and legally reviews the Terms of Service and Privacy Policy text — is there any legal support, or does the core team draft them? | Organizers |
| 6 | Can the public pages (ToS, Privacy, About, sponsor pitch, tier list) ship ahead of the Call for X forms, so something is live before the forms are built — relevant now that both are happening in the same Nov–Dec window? | Product owner |

## Before this becomes a scope
Most of the field-level questions are answered now. What's left blocking a real scope is **resourcing (§9, question 2)** — I can't size or sequence this against the Nov–Dec Android plan without knowing whose time it's coming from — and, to a lesser extent, the Open Collective split (§9, question 1), which affects the Call for Sponsors/Donations form design directly. Once you've settled resourcing, this is ready for `task-scoper` to turn into user stories, acceptance criteria and a sized task breakdown, the same way `docs/scopes/mvp-january.md` was built — and if it's running in the same Nov–Dec window as Android, it should probably get its own scope doc immediately so it's visible in the same planning view as the rest of the build.
