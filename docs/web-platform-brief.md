# Web platform: product brief

Last updated 2026-10-04 · Owner: product manager · Status: **draft, captures the product owner's vision from conversation. Not yet a scope — see "Before this becomes a scope" below.**

This resolves the open decision in `docs/decisions.md` (2026-10-02: "one web product or two?") and the matching open question in `docs/prd.md` (§10). It does not change the January MVP (`docs/mvp.md`): the web platform stays in the **Next** bucket (Feb–Apr 2027), built after testing, unless the product owner decides to pull it forward. See "Where this sits in the roadmap."

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

| Surface | everyone, no login (public) | member | organizer |
|---|---|---|---|
| Public pages — ToS, Privacy Policy, About Us, sponsor pitch, sponsor tier list | ✅ read | ✅ read | ✅ read |
| Call for Speakers — submit a talk | — (see open question 4) | ✅ submit | ✅ submit, **and** see every submission (today: in Supabase Studio; this brief proposes a web view replaces that) |
| Call for Sponsors — submit a request | — (see open question 4) | ✅ submit | ✅ see every submission |
| Call for Donations — submit a pledge/gift | — (see open question 4) | ✅ submit | ✅ see every submission |
| Financials (sponsorship status, totals) | ❌ | ❌ | ✅ |

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
- Name (or anonymous)
- Amount or in-kind description
- Optional note
- Status, visible only to organizers

**🔴 This is the one piece that needs a real decision before it's buildable, not just designable:** is a "Call for Donations" submission a **pledge/expression of interest** that an organizer follows up on manually (M-Pesa, bank transfer, in person) — or does the web platform actually **collect money**? The PRD currently has "no paid ticketing and payments" as an explicit assumption and out-of-scope item for the *product* (not just the MVP). If donations touch money directly, that assumption needs revisiting, and it drags in payment processing, reconciliation, receipts, and probably legal/tax questions that a feature-flag decision doesn't answer by itself. I'd treat "web platform takes a donor's intent, organizers handle the money offline" as the safe default until you say otherwise.

## 4. "Financials" for organizers

You mentioned organizers seeing "financials if needed" alongside sponsorship submissions. Before this is scoped I need to know what that actually means, because the engineering cost is very different depending on the answer:

- **(a) Visibility only** — organizers see what sponsors offered and what they asked for, and what donors pledged. No ledger, no accounting. (Cheapest — basically a filtered view of the two tables above.)
- **(b) A lightweight status/ledger** — "Kasha Health: KES 150,000 pledged, invoiced, paid" — tracked in the platform. (More: needs a status model, probably manual entry by an organizer, not derived from anything automatic.)
- **(c) Real financial reporting** — reconciliation against actual bank/M-Pesa records, totals, reporting over time. (Much more — this starts to look like lightweight accounting software.)

My read of "financials if needed" is (a) or (b), not (c) — but I'm flagging it rather than assuming.

## 5. Same login, same design system

- **Login:** same Supabase Auth as the app. Today that's GitHub only (Apple comes with iOS). **Open question carried over from the PRD (§10):** is GitHub-only workable for web walk-ins? A sponsor's finance contact or a one-off donor is exactly the person least likely to have a GitHub account. The PRD already flags "add email or Google sign-in if testers without GitHub get stuck" for the app; for web walk-ins specifically, I think this stops being optional. 🔵 Needs a decision.
- A related question: should *submitting* a Call for Sponsors/Donations/Speakers form require sign-in at all? Most sponsor and donor intake forms elsewhere don't gate on an account — they just ask for contact details on the form itself. Requiring sign-in adds friction for exactly the "walk-in" audience this platform is for. Proposed default: **forms are submittable without sign-in** (just name + email), and only the *organizer views* of submissions require the `organizer` role. Flag if you disagree.
- **Design system:** same tokens, same components, same voice as the app (Figma file, `docs/*-handoff-notes.md`). Web gets its own layout (it's not Compose), but it should read as the same product. This is a design-team task once the above is settled enough to brief them.

## 6. Where this sits in the roadmap

`docs/mvp.md` currently has **"no organizer web platform in the MVP"** — organizers run everything through Supabase Studio until "Next" (Feb–Apr 2027). This brief doesn't change that by itself. Two honest options:

- **(a) Leave it in Next.** This brief becomes the starting point for that phase's scope once January testing is done and the 4 engineers are free. Nothing changes for Nov–Dec.
- **(b) Pull a thin slice forward.** The three Call for X forms are small, don't need the app's offline machinery, and don't block on anything else — they could plausibly be a tiny parallel scope in Nov–Dec if someone has slack. I would **not** recommend this: it competes directly with the Android build for the same 4 engineers, and the MVP is already ~8.5 engineer-days over budget before any thinner versions are applied (`docs/scopes/mvp-january.md`). Pulling web forward needs the product owner to explicitly accept a later Android date or a 5th engineer, not a quiet scope-creep.

**My recommendation: (a).** Write and size this properly once the open questions below are answered, size it for Feb–Apr, and don't touch the Nov–Dec plan.

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

## 8. Open questions — need an answer before this is a scope

| # | Question | Who decides |
|---|---|---|
| 1 | Call for Donations: pledge/intent only, or does the platform actually collect money? | Product owner (+ legal/tax advice if money moves) |
| 2 | "Financials" for organizers: visibility only, a status/ledger, or real reporting? (§4, options a/b/c) | Product owner + organizers |
| 3 | Is GitHub-only sign-in acceptable for web walk-ins, or do we need email/Google sign-in for web specifically? | Product owner |
| 4 | Do the Call for X forms require sign-in to submit, or just contact details on the form? | Product owner |
| 5 | Does the web Call for Speakers write to the same `talk_submissions` table as the in-app flow (one CFP, two entry points), or is it separate? | Engineering |
| 6 | Does this ship in the Next phase (Feb–Apr 2027) as planned, or does the product owner want a thin slice pulled into Nov–Dec at the cost of Android scope? | Product owner |
| 7 | Who grants the `organizer` role to an account, and how (Studio today — same mechanism on web)? | Organizers + engineering |
| 8 | What defines each sponsor tier — fixed money thresholds, named in-kind equivalents (e.g. "hosting a venue = Gold"), or organizer judgement case by case? Is "venue" the only non-money contribution type, or are there others (products, services, swag)? | Product owner + organizers |
| 9 | Who writes and legally reviews the Terms of Service and Privacy Policy text — is there any legal support, or does the core team draft them? | Organizers |
| 10 | Can these public pages (ToS, Privacy, About, sponsor pitch, tier list) ship as static content ahead of the Call for X forms, so there's something live even before the forms are built? | Product owner |

## Before this becomes a scope
Once questions 1–4 have answers, this is ready for `task-scoper` to turn into user stories, acceptance criteria and a sized task breakdown — the same way `docs/scopes/mvp-january.md` was built. I haven't done that yet because two of the open questions (donations handling money, and what "financials" means) change the size of the work by a large margin, and deciding that silently isn't mine to do.
