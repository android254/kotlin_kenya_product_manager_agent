# Web platform: product brief

Last updated 2026-10-04 · Owner: product manager · Status: **shape and resourcing decided by the product owner. Split into two sub-phases (W1 public pages, W2 Call for X forms) — W1 is close to scope-ready, W2 waits on one external meeting. See §9 and "Before this becomes a scope" below.**

This resolves the open decision in `docs/decisions.md` (2026-10-02: "one web product or two?") and the matching open question in `docs/prd.md` (§10): one product, role-flagged. **It also changes the January plan**: the product owner wants this built in Nov–Dec, by the same 4 engineers building Android, not deferred to Feb–Apr as `docs/mvp.md` assumed. That's a real risk to the already-tight Android budget (§6) — accepted by the product owner, not hidden, and partly managed by shipping the low-cost public pages first. See "Where this sits in the roadmap."

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

## 6. Where this sits in the roadmap — building now, same team, sequenced to manage the risk

**Decided 2026-10-04: built in Nov–Dec, by the same 4 engineers who are building Android.** "Don't worry about us, we have enough coffee to spare." I'm recording that as the decision, but I'm not going to quietly drop the concern it answers:

- `docs/mvp.md` set the January MVP at **~100 engineer-days from 4 engineers**, and `docs/scopes/mvp-january.md` already runs **~8.5 engineer-days over that before any cuts.** That was the Android app alone, planned before this brief existed.
- Adding the web platform on top, with the same headcount and no extended runway, means one of three things actually happens in practice: the Android list shrinks further (more thinner versions taken, or another feature deferred), the Jan 4–8 date slips, or the team works at a pace that isn't sustainable for 8 weeks straight. "Coffee" is the last of those. I'd rather name that honestly now than have it surface in December as burnout or a missed date.
- **One thing that genuinely helps, and that today's answer on public pages makes possible:** the public pages (§7 — ToS, Privacy Policy, About Us, sponsor pitch, tier list) are mostly content, not engineering, and you've confirmed they can ship **before** the Call for X forms. That means the heaviest web engineering — auth with Google, the three forms, the status ledger, role-gated organizer views — can be sequenced *after* the public pages, and ideally after the worst of the Android crunch, rather than all of it landing in the same weeks as the Android build. I'd treat this as two sub-phases rather than one lump:
  - **W1 — public pages.** Low engineering cost, no auth, no Open Collective dependency. Can start almost immediately.
  - **W2 — Call for X forms, auth, ledger, role gating.** Needs the Open Collective team meeting resolved first (§9), and is the part that actually competes with Android engineering time.
- I'd like `task-scoper` to size W1 and W2 separately once the Open Collective meeting happens, so you can see the real day-count against the Android plan rather than taking "it'll be fine" on faith.

## 7. Public pages

You also want the web platform to carry the "front door" content that currently has no home: Terms of Service, Privacy Policy, About Us, a sponsor pitch, and a sponsor tier list. These are all **public, no login needed** — they're what a sponsor or donor reads *before* deciding to fill in a Call for X form, so they have to come first in the information architecture, not be buried behind it.

| Page | Content | Notes |
|---|---|---|
| **Terms of Service** | Standard ToS for using the site/app | Net new — nothing in the PRD or MVP plan covers a ToS today, only a privacy policy. Needs legal review before publishing, same as the privacy policy. |
| **Privacy Policy** | Data inventory, purposes, retention, "sponsors see aggregates only," deletion | Already planned work — `docs/mvp.md` task **F0-04** builds this for the app ("host it on a static page"). **This is that static page.** Consolidating it here means F0-04 doesn't build a one-off page that gets thrown away when the web platform ships. |
| **Account deletion request** | The web form Play requires alongside in-app deletion | Already planned as **F0-05**. Same consolidation point as above — this is a natural home for it rather than a bare standalone page. |
| **About Us** | Who the community/organizers are | Net new, content/ops to write, not engineering-heavy. |
| **"What's in it for you" (sponsor pitch)** | The case for sponsoring, addressed to sponsors | Doesn't need to be invented from scratch — `sponsors-handoff-notes.md` already has this story worked out for the app (visibility → talent → engagement → insight, in that order, "value first"). This page is that pitch, written for someone arriving cold on the web rather than already using the app. |
| **Sponsor tier list** | What a sponsor can offer (you named **money and/or venue**) and, presumably, what each tier gets back | **Model decided 2026-10-04:** a hybrid — some tiers defined by a **fixed money threshold** (e.g. Gold/Silver/Community by KES amount, carrying the existing labels from `sponsors-handoff-notes.md`), plus room for **custom tiers** for in-kind or one-off contributions that don't fit a money bracket (e.g. a venue host). The actual thresholds and what a custom tier is called/gets are not set yet — that's real work, not just a model choice. |

**Why this matters for the Call for Sponsors form (§3):** right now that form asks sponsors to free-text "what you're offering." With the tier model now set, the form should offer the fixed-threshold tiers as choices and a "something else" path for a custom/in-kind arrangement that an organizer defines case by case — rather than free-texting everything. The specific numbers and custom-tier names are still open (§9).

## 8. Organizer role management, and the app/web boundary

**Confirmed 2026-10-04: the door check-in scanner stays in the app.** You walked back "organizer controls purely on web" yourself — "that's a bit optimistic" — so this is a **preference going forward, not a hard rule**: new organizer tooling (reviewing Call for X submissions, the financial status ledger, granting roles) defaults to web so the app stays lean, but it's not a constraint that overrides where a feature actually belongs. The scanner is camera-driven, venue-side, and the one place offline matters most — it was right to keep it in the app, and this doesn't reopen that.

Granting the `organizer` role itself is still web-only: manually in Supabase for the MVP, or a small admin screen on the website later. That part stands.

## 9. Open questions — remaining after 2026-10-04

Resolved this round: the scanner stays in the app (§8), resourcing is the same 4 engineers with public pages sequenced first to manage the risk (§6), the sponsor tier model is fixed-threshold-plus-custom (§7), and public pages are confirmed to ship ahead of the forms. Still open:

| # | Question | Who decides |
|---|---|---|
| 1 | **Blocking a team meeting you've already called:** one Open Collective field/collective for both Call for Sponsors and Call for Donations, or two separate ones? This gates W2 (§6) — the forms can't be finalized until it's settled. | Product owner + team |
| 2 | The actual **money thresholds** for each fixed sponsor tier, and what custom/in-kind tiers are called and what they get (venue host, and anything beyond venue) | Product owner + organizers |
| 3 | **Legal support for the Terms of Service and Privacy Policy — genuinely unresolved, by your own account** ("we may need to get legal support or build an agent from scratch, I don't know"). This blocks *publishing* the ToS/Privacy pages, not drafting them — a draft can exist and wait for review. Worth deciding before W1 ships, since those two pages specifically can't go live unreviewed the way About Us or the sponsor pitch can. | Product owner + organizers |

## Before this becomes a scope
Two sub-phases, two different states of readiness:
- **W1 (public pages)** is close to ready for `task-scoper` now. The only blocker is question 3 — decide whether legal review is in-house, hired, or AI-assisted before publishing, so the scope can plan for a review step rather than assume the first draft ships.
- **W2 (Call for X forms, auth, ledger, role gating)** is blocked on question 1, the Open Collective meeting, since it decides whether sponsors and donations are one submission flow or two and where each points.

Once question 1 is settled, I'd size W1 and W2 as separate scopes (so the day-count against the Android plan is visible, per §6) rather than one combined document.
