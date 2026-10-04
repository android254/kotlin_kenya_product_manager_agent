# Web platform W1: public pages

Last updated 2026-10-04. Status: **draft for product owner, organizer and engineering review.**
- **Source:** `docs/web-platform-brief.md` (§6, §7, §9) and `docs/decisions.md` (2026-10-04 entries).
- **Absorbs:** `docs/mvp.md` / `docs/scopes/mvp-january.md` tasks **F0-04** (privacy policy) and **F0-05** (account deletion web page). Those rows stay in the Android scope as tracking references. The work is done here, on the web platform, not on a one-off static page.
- **Sibling scope:** W2 (Call for X forms, Google + GitHub auth, status ledger, role gating) is separate and isn't written yet. It's blocked on the Open Collective meeting.
- **Build window:** Nov 2 – Dec 23 2026, by the same 4 engineers building Android. W1 has two date-driven milestones (see Tasks). It's small enough to stay one phase.

> **Headline for the product owner.** W1 is cheap: about **7.5 engineer-days**. It isn't late, though. The privacy policy and deletion page have to be live by about **Nov 27**, because Play closed testing (F0-08) starts then. That pulls about **6 of the 7.5 days into S1–S2**, the most crowded Android sprints. It also puts the **unowned legal review** on the Android critical path. Added to the ~8.5 days Android is already over, the plan is about **16 engineer-days over**. Nothing in W1 can make that up, because F0-04 and F0-05 were counted as content/ops and never as engineering days.

---

## Problem
Android254 has no public home for the things that someone without the app needs to read. Store reviewers, would-be testers and members who left need a privacy policy, terms and a way to request deletion. Sponsors' finance and marketing people need the case for sponsoring and who runs the community. Today none of this exists. The Android plan needs the first three before external testing starts, and organizers have no single link to send a prospective sponsor.

## Users
| Who | What they need from W1 |
|---|---|
| Testers and members (including ones who uninstalled the app) | Read what data we hold and why; read the terms; request account deletion without reinstalling the app |
| Store reviewers (Google Play now, Apple later) | A privacy policy URL and an account deletion URL that work, and that match the app's Data safety answers |
| Sponsor contacts arriving cold (finance, marketing, often not on GitHub) | The plain case for sponsoring, who the organizers are, and how to get in touch, without a login or a call |
| Prospective members and speakers | Who runs Android254, and whether it's credible |
| Organizers | One link to send sponsors. A way to update page text without an engineer. Certainty that the legal pages can't go live unreviewed |

## Success signal
Proposed targets for the end of testing (28 Feb 2027). The product owner confirms them.
- **Store gate:** Play accepts the privacy policy URL and the account deletion URL, and closed testing (F0-08) starts on schedule. No store review is rejected for privacy or deletion.
- **No dead links from the app:** on Jan 4, every web link in the January build (Welcome "Terms", Settings "Privacy policy" and "About") opens a live page.
- **Sponsor outreach uses it:** organizers send the pitch link in every sponsor outreach in Jan–Feb, and no separate pitch doc is maintained. Organizers keep a simple log; there's no web analytics in W1.
- **Content is self-serve:** an organizer changes page text through a pull request, and it's live within a day without engineering help (at least once before Jan 4).
- **Deletion requests are handled:** every web deletion request gets a reply within the promised time, which is still to be set (OQ-W6).

---

## User stories
- **US-W1.1 (privacy):** As a **member deciding whether to sign in**, I want to read what data the app and site collect, who can see it and how long it's kept, so that I can join knowing sponsors see totals and never me.
- **US-W1.2 (deletion):** As a **member who has uninstalled the app**, I want to request deletion of my account from a web page, so that my personal data is removed without reinstalling anything.
- **US-W1.3 (terms):** As a **member or visitor**, I want to read the terms for using the app and site, so that I know the rules before I sign in.
- **US-W1.4 (sponsor pitch):** As a **sponsor's marketing or finance contact who got a link**, I want to read what my company gets from backing Android254, in plain terms, so that I can make the case internally without booking a call first.
- **US-W1.5 (about):** As a **prospective member, speaker or sponsor**, I want to see who runs the community and how to reach them, so that I can judge whether it's real and who I'd be dealing with.
- **US-W1.6 (organizer: edit):** As an **organizer**, I want to change page text through a pull request that deploys on merge, so that copy fixes don't wait for an engineer.
- **US-W1.7 (organizer: legal gate):** As an **organizer**, I want the terms and privacy pages to stay unpublished until a legal review is recorded, so that an unreviewed draft can't go live by accident.

---

## Acceptance criteria
### Global (every W1 page)
- **No login:**
  - **Given** any visitor
  - **When** they open any W1 URL
  - **Then** the page renders in full. There's no sign-in prompt, no Supabase call and no cookie.
- **Loading:**
  - **Given** a slow connection or JavaScript turned off
  - **When** the page opens
  - **Then** all content is in the first HTML response. There's no skeleton and no client-side fetch.
- **Error (unknown URL):**
  - **Given** a URL that doesn't exist, or a legal page that isn't published yet
  - **When** it's requested
  - **Then** a 404 page in the site's layout links to the published pages and the contact address.
- **Offline:**
  - **Given** the visitor has no connection
  - **When** they open a link
  - **Then** the browser's own offline page shows. There's no service worker and no offline copy in W1.
  - Opened from the app, the in-app browser (F1-20) shows its own error. No app work is needed.
- **Theme:**
  - **Given** the system is in dark mode
  - **When** a page opens
  - **Then** it uses the dark token set. The theme follows the system, with no picker, the same as the app.
- **Accessibility:**
  - **Given** WCAG 2.2 AA
  - **When** a page is checked at 320px width, at 200% text zoom, by keyboard only, and with TalkBack (Chrome Android) and VoiceOver (Safari)
  - **Then** nothing is clipped and there's no horizontal scroll. Headings are in order, a skip link works, focus is visible, contrast passes in both themes, and email links say they open your email app.
- **Same product:**
  - **Given** the Figma tokens (colour, type, spacing, shape)
  - **When** a page renders
  - **Then** it uses those tokens and the app's fonts (Space Grotesk, Inter, JetBrains Mono), self-hosted.
- **Link previews:**
  - **When** a page link is pasted into WhatsApp, Slack or email
  - **Then** the preview shows the page title and a one-line description.

### US-W1.1 Privacy policy (absorbs F0-04)
- **Content:**
  - **Given** the published policy
  - **When** I read it
  - **Then** it covers Kenya's Data Protection Act 2019, and for the January app build plus the W1 site it states:
    - the data inventory: GitHub profile fields, topics, RSVPs, check-ins, page views, ratings and comments, device tokens, analytics and crash data
    - the purpose of each item
    - retention
    - "sponsors see aggregates only", with groups under 5 suppressed
    - deletion versus anonymisation
    - my rights and how to contact the data controller
- **Matches the store forms:**
  - **Given** the Play Data safety answers (F0-06)
  - **When** they're compared with the policy
  - **Then** every data type declared in one appears in the other.
- **Effective date:**
  - **Then** the effective date and "last updated" date show at the top.
- **Gate:** covered by US-W1.7.
- **Copyable:** headings have anchor links, and the page prints cleanly to PDF.

### US-W1.2 Account deletion request (absorbs F0-05)
- **App first:**
  - **Given** I open `/delete-account`
  - **Then** the page names the app and the developer.
  - The in-app steps come first (Profile → Settings → Delete account).
  - The page links to the privacy policy section on what is deleted and what is anonymised. It doesn't restate it.
- **Without the app:**
  - **Given** I no longer have the app
  - **When** I follow "Request deletion by email"
  - **Then** my email app opens, addressed to the privacy inbox, with the subject "Account deletion request" and a body asking for my GitHub handle.
  - The address also shows as plain text I can copy.
- **What happens next:**
  - **Then** the page states how organizers confirm it's my account, and how long a reply takes. Both are still to be set (OQ-W6).
- **Handled:**
  - **Given** a request arrives
  - **When** an organizer follows the runbook's deletion-request section (F0-11)
  - **Then** the account is deleted through F7-07, and the requester gets a reply within the stated time.
- **No unauthenticated database write.** A web form that stores requests is W2 or later (OQ-W6).
- **No separate legal gate.** The page only describes steps. It can go live before the privacy policy is approved, but the privacy policy link only resolves once that page is published.

### US-W1.3 Terms of Service
- **Content:**
  - **Given** the published terms
  - **Then** they cover:
    - who may use the app and site
    - acceptable use, with a link to the code of conduct
    - member content (talk submissions, comments)
    - account suspension and deletion
    - no warranty and limits of liability
    - governing law
    - contact
  - The effective date shows at the top.
- **Gate:** covered by US-W1.7.

### US-W1.4 Sponsor pitch
- **Order:**
  - **Given** the pitch page
  - **When** I read it top to bottom
  - **Then** the value sections come in the order of `sponsors-handoff-notes.md` "Sponsorship model" §3: Visibility → Talent → Engagement → Insights. Value comes first, and insights come last.
- **Honest claims:**
  - **Given** any claim on the page
  - **When** the product owner checks it against the January build
  - **Then** it describes something that ships. Planned items are omitted or marked as planned without dates, depending on OQ-W7.
  - For January, that means:
    - Visibility: attribution on the events they back, and the "Our sponsors" list
    - Talent: featured roles on the job board
    - Insights: "we record aggregate event numbers from day one; a sponsor report is planned"
  - Engagement has nothing in the January build (no polls, challenges or offers). The page must not imply it does.
- **Privacy promise:**
  - **Then** the page states that sponsors see totals, never who. The wording matches the privacy policy.
- **Voice (P3):**
  - **Then** there are no marketing superlatives and no exclamation marks. The copy gives facts about what sponsors get and what members get.
- **No tiers or prices:**
  - **Then** the page shows no tier list, no thresholds and no amounts (W2, blocked).
- **Contact:**
  - **Given** W2 forms don't exist yet
  - **When** I choose "Talk to the organizers"
  - **Then** my email app opens to the sponsors inbox.
  - Swapping this for the Call for Sponsors form is a W2 task.

### US-W1.5 About Us
- **Content:**
  - **Then** the page shows what Android254 / Kotlin Kenya is, what it runs, and the organizers.
  - Each organizer has a name, role, photo or initials, and optional links.
  - The page ends with a contact address.
- **Consent:**
  - **Given** an organizer
  - **When** they're listed
  - **Then** they've agreed to the name, photo and links shown. Anyone who hasn't agreed isn't listed.
- **No photo:**
  - **Given** an organizer without a photo
  - **Then** an initials avatar shows, the same as the app's Avatar.

### US-W1.6 Organizer edits content
- **Edit:**
  - **Given** the page text lives as Markdown in the web repo
  - **When** an organizer's pull request is merged
  - **Then** the change is live within 10 minutes, and each pull request gets a preview link before merge.
- **Broken build:**
  - **Given** a change that breaks the build
  - **When** it's merged
  - **Then** the live site keeps the last good version, and the author sees the failed check.

### US-W1.7 Legal publish gate
- **Unreviewed:**
  - **Given** the terms or privacy page has no recorded legal approval (reviewer, date, version)
  - **When** the site builds
  - **Then** the page isn't published. It's left out of the build, the navigation, the footer and the sitemap, and its URL returns the 404.
- **Approved:**
  - **Given** approval is recorded in the page's front matter in a merged pull request
  - **When** the site builds
  - **Then** the page is live, and the approved version and date show in its "last updated" line.
- **Changed after approval:**
  - **Given** an approved legal page
  - **When** its text changes without a new approval record
  - **Then** the CI check fails, and the live version stays as it was.

---

## Out of scope
- **Everything in W2:** the sponsor tier list page (blocked on thresholds and custom-tier names); the Call for Speakers, Call for Sponsors and Call for Donations forms; Google and GitHub sign-in on web; the organizer financial status ledger; organizer role granting; organizer-only routes.
- **Any database write or Supabase dependency.** This includes a stored deletion-request form; W1 uses email.
- **Live sponsor logos on the pitch page.** That needs Supabase reads and the plate logic. The pitch is static text.
- **Public event pages and link previews for events.** `docs/mvp.md` puts these in Next (Feb–Apr).
- **A CMS.** Content is Markdown edited through pull requests.
- **Web analytics, cookies and a consent banner** (see OQ-W9).
- **Offline support:** no service worker.
- **Kiswahili:** English only.
- **Search** and a blog or news section.
- **A Code of Conduct page,** unless OQ-W8 adds it.
- **Changes to the Android app.** F2-06 and F7-06 already link out; they just use the W1 URLs.

---

## Tasks
- **Sizes:** S = under a day (0.5), M = 1–3 days (2), L = 3–5 days (4).
- **Areas:** design, frontend (web), content/ops.
- **Not counted against Android engineering:** design (designer agent) and content/ops (organizers and the product owner). These follow the `mvp-january.md` convention.
- **Assumption:** one engineer owns all W1 frontend work.

### Milestone 1: store-critical, live by Fri Nov 27 (S1–S2)
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| W1-01 | Choose the web stack and hosting. It must serve W1 as static pages, then take Supabase Auth (Google + GitHub) and forms in W2 **without a rewrite**. Write the decision in `docs/decisions.md`. Decide by Nov 6 | frontend | S | — |
| W1-C1 | Domain, fixed URLs (`/privacy`, `/terms`, `/delete-account`, `/about`, `/sponsor`) and two monitored inboxes (privacy, sponsors). Give the URLs to F2-06, F7-06 and F0-06 | content/ops | S | — |
| W1-D1 | Design: web page template: header and navigation, footer with legal links, long-form prose (headings, lists, a data-inventory table), "last updated" block, 404, breakpoints from 320px, light and dark. It uses existing tokens and isn't a Compose port | design | M | — |
| W1-02 | Repo, build, deploy on merge, preview deploy per pull request, custom domain with HTTPS, the last good version stays live if a build fails | frontend | M | W1-01, W1-C1 |
| W1-03 | Export the tokens to CSS variables (light/dark through `prefers-color-scheme`), and self-host the fonts. The Figma tokens already carry web code syntax | frontend | S | W1-02 |
| W1-04 | Page template and 404 from W1-D1: skip link, focus styles, heading anchors, print styles, page titles and link-preview meta | frontend | M | W1-03, W1-D1 |
| W1-05 | Legal publish gate: approval front matter (reviewer, date, version); unapproved pages left out of the build, navigation and sitemap; a CI check that fails when an approved page changes without a new approval | frontend | S | W1-02 |
| W1-06 | Render the privacy policy and deletion pages: prose, data table, effective date, mailto with prefilled subject and body | frontend | S | W1-04, W1-05 |
| W1-C2 | **= F0-04.** Draft the privacy policy (see the US-W1.1 criteria). Inputs: F1-14 analytics catalogue, OQ-8 (delete or anonymise), OQ-9 (what sponsors see), OQ-10 (analytics and crash tools) | content/ops | M | F1-14 |
| W1-C3 | **= F0-05.** Deletion page copy, plus the email deletion process: identity check, reply time, and the runbook F0-11 "deletion requests" section | content/ops | S | W1-C2, F7-07 |
| W1-C4 | **Decide the legal review route and its owner:** in-house, hired, or AI-assisted. Decide by **Nov 6** | content/ops | S | — |
| W1-C5 | **Legal review of the privacy policy. No owner yet.** Record the approval (W1-05). It has to finish by about **Nov 20** to leave time for changes before Nov 27 | content/ops | **unsized** | W1-C2, W1-C4 |

### Milestone 2: the rest, live by Dec 23 (S3–S4)
| ID | Task | Area | Size | Depends on |
|---|---|---|---|---|
| W1-D2 | Design: sponsor pitch layout: four value sections in order, the privacy promise, the contact action | design | S | W1-D1 |
| W1-D3 | Design: About Us layout: intro, organizer cards (photo or initials), contact | design | S | W1-D1 |
| W1-C6 | Draft the Terms of Service (net new; see the US-W1.3 criteria) | content/ops | M | W1-C2 |
| W1-C7 | **Legal review of the Terms of Service. No owner yet.** Record the approval. It's needed by Dec 23 if the Welcome "Terms" link ships in January (OQ-W3) | content/ops | **unsized** | W1-C6, W1-C4 |
| W1-C8 | Sponsor pitch copy: adapt the value story to the P3 voice; claims limited to the January build; product owner checks the claims | content/ops | M | — |
| W1-C9 | About Us copy, organizer list and written consent from each person listed | content/ops | S | — |
| W1-07 | Build the sponsor pitch page from W1-D2 | frontend | S | W1-04, W1-D2, W1-C8 |
| W1-08 | Build the About Us page from W1-D3, with the initials fallback | frontend | S | W1-04, W1-D3, W1-C9 |
| W1-09 | Accessibility and browser pass on all pages: 320px, 200% zoom, keyboard, TalkBack + Chrome, VoiceOver + Safari, contrast in both themes. Fix what it finds | frontend | S | W1-06, W1-07, W1-08 |

The Terms page uses the W1-04 template and the W1-05 gate, so it needs no extra frontend task. It goes live by merging the approval record.

### Totals
| Area | Days | Notes |
|---|---|---|
| frontend (engineering) | **7.5** | 6 in Milestone 1 (S1–S2), 1.5 in Milestone 2 |
| design | 3 | — |
| content/ops | 8 | W1-C2 (2) and W1-C3 (0.5) were already counted in `mvp-january.md` as F0-04/F0-05, so **5.5 are new** |
| legal review | **unsized** | External; no owner; elapsed time unknown |
| **All (known)** | **18.5** | — |

**Against the Android budget:**
- **New engineering days:** about 7.5. Absorbing F0-04 and F0-05 saves no engineering, because they were content/ops tasks.
- **Overall:** Android is already ~8.5 over, so the total is about **16 over**.
- **What could close the gap:** the Android thinner versions still in reserve (T3, T5, T8–T12, T15, T16) save about 14.5 days.

**The premise holds on size, but not on timing.** W1 is the cheapest web slice. Most of its engineering still lands in S1–S2, because the template and deploy pipeline have to exist before the store-critical pages.

**If S1–S2 can't take 6 days:** ship Milestone 1 as plain token-styled prose pages on the final URLs. That means W1-04 without the designed header and navigation. Finish the template in Milestone 2. This moves about 1 day out of S1–S2. It doesn't save days.

**Not recommended:** a throwaway page on another host. That's the one-off page the brief set out to avoid, and the URLs given to Play would change.

---

## Risks and assumptions

### Risks
| Risk | Impact | Mitigation | Owner |
|---|---|---|---|
| **The legal review has no owner, and the privacy policy is on the Android critical path.** Play closed testing (F0-08) needs it by about Nov 27 to finish its 14 days before January | Closed testing slips, so open sign-up on Android in January slips | Decide the route by Nov 6 (W1-C4). If the review can't finish by about Nov 20, the product owner chooses (OQ-W2): slip closed testing, or knowingly publish an interim, internally reviewed policy for the organizer-only closed test | Product owner |
| W1 adds about 7.5 engineering days to a plan already about 8.5 over, front-loaded into S1–S2 | Android foundation work slips, or the pace becomes unsustainable (brief §6) | Pick the thinner versions from the reserve by Nov 6. One named engineer owns W1, so the cost is visible | Product owner |
| AI-assisted review (one of the product owner's options) gives no qualified sign-off under the Data Protection Act | Legal exposure if the policy is wrong | If chosen, use it to draft and check against a DPA checklist, and record "no qualified review" as an accepted risk in `docs/decisions.md` | Product owner |
| The engineers are Android/KMP specialists, new to the web stack | Estimates slip | Choose boring, well-documented tools (W1-01). Static first | Engineering |
| A W1 stack that can't carry W2 auth and forms | A rewrite in W2 | W1-01's criterion: it must take Supabase Auth and forms later | Engineering |
| The pitch overpromises (engagement features, impact report, speaking slots) | Sponsor trust, and conflict with design decision #26 | Claims check against the January build (W1-C8); OQ-W7 | Product owner + organizers |
| Email deletion requests: deleting the wrong account, or a slow reply | Harm to a member; DPA complaint | Identity check and reply time in W1-C3 and runbook F0-11 | Organizers |
| W2 adds Google sign-in and sponsor/donor submissions | The privacy policy goes stale and needs a **second legal review** | Make "privacy policy revision + review" an explicit W2 task | Product manager (W2 scope) |
| About Us publishes organizers' personal data | Consent problem | Written consent per person (W1-C9) | Organizers |

### Assumptions
- **Play deletion resource:** Play accepts a web page that names the app, shows the in-app steps and offers an email request route. Check this when filling in F0-06. If Play wants a form, that's an unauthenticated write, which pulls a W2-style task forward.
- **Domain and inboxes:** the community owns a domain, or can get one cheaply, and can run two monitored inboxes on it.
- **Hosting:** a free static tier is enough. There's no Supabase usage in W1.
- **Editing:** organizers are comfortable editing Markdown through GitHub pull requests. They already use GitHub.
- **One policy:** a single privacy policy covers the January app build and the W1 site. W2 revises it.
- **Language:** English only.

---

## Open questions
| # | Question | Who answers |
|---|---|---|
| OQ-W1 | Which legal review route (in-house, hired, AI-assisted), who owns it, and can it finish the privacy policy by about Nov 20? Decide by Nov 6 | Product owner + organizers |
| OQ-W2 | If the privacy review isn't done by Nov 27: slip Play closed testing, or knowingly publish an interim, internally reviewed policy for the organizer-only closed test? | Product owner |
| OQ-W3 | The Welcome screen links "Terms" (F2-06, `onboarding-handoff-notes.md`). If the ToS isn't approved by Dec 23, do we drop the link from the January build, or hold the build? | Product owner + design |
| OQ-W4 | Which web stack and hosting? Decide by Nov 6 (W1-01) | Engineering |
| OQ-W5 | Which domain, and who owns it and the two inboxes? | Organizers |
| OQ-W6 | Is email enough for web deletion requests in W1, or do we need a stored form (W2)? How do we confirm a requester owns the account, and what reply time do we promise? Ties to OQ-8 | Product owner + organizers |
| OQ-W7 | The pitch: describe planned items (engagement, impact report) as "planned", or leave them out? The brief's Call for Sponsors example lists a "speaking slot", but design decision #26 says sponsors never back sessions. Which is right? | Product owner + organizers |
| OQ-W8 | The app links "Code of Conduct" from Welcome and Settings. Does it live on the web platform as a sixth W1 page (content exists? about S frontend + S content), or somewhere else? | Product owner |
| OQ-W9 | Do we want cookieless page-view counts to measure the pitch (about S, plus a privacy policy line), or is the organizers' outreach log enough? | Product owner |
| OQ-W10 | Who is the one engineer who owns W1, and which reserve thinner versions pay for the ~7.5 days? | Product owner + engineering |
