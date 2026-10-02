# Kotlin Kenya App: product vision PRD

Last updated 2026-10-02 · Owner: product manager · Status: **draft for organizer review**

This PRD describes the product we're aiming for when it's done: the mobile app, the web platform, and the community running on them. It doesn't plan the January release. That plan is in `docs/mvp.md` and `docs/scopes/mvp-january.md`. Related docs: `docs/roadmap.md`, `docs/decisions.md`. The designs are in the Figma file and in `../kotlin-kenya-designer-agent/docs/`.

Gaps are tagged inline: 🔶 **Assumption** means plausible but not checked yet. 🔵 **Open question** means someone has to decide or find out.

---

## 1. Executive summary
We're building the home of the Android254 / Kotlin Kenya community. It has three parts:
- a mobile app for Android and iOS, built with Kotlin Multiplatform;
- a public website;
- an organizer platform.

Members use it to find meetups, get in at the door, learn, find work and meet each other. Speakers use it to submit talks and grow a track record. Sponsors get visibility, hiring and engagement they can measure. Organizers use it to run events from one place instead of a mix of tools. Once it's stable, it goes open source, and the community it serves helps build it.

The aim: **more Kotlin and Android developers in Kenya, and later the region, keep showing up, speaking, and getting hired through the community.**

## 2. Problem statement

### Who has the problem, and what is it?
| Who | What they're trying to do | What gets in the way today |
|---|---|---|
| **Members** (developers, students, job seekers) | Find the next meetup, get in, learn, find work, meet people with the same stack | Event info, recordings, jobs and contacts are spread across separate channels. Nothing remembers what you've attended or what you care about. 🔶 *Assumption: the community currently relies on chat groups, social posts, third-party event pages and forms.* |
| **Speakers** (first-time and experienced) | Find out when talks are wanted, submit one, get feedback, build a record | Calls for speakers are easy to miss. First-time speakers get no guidance. Feedback is rare, and speaking history lives nowhere. |
| **Sponsors** (companies hiring Kotlin and Android developers, developer-tool companies) | Reach and hire developers, and show their company what the money bought | Sponsorship mostly means a logo on a slide. There's no talent pipeline, and nothing measures the return. |
| **Organizers** (volunteers) | Run events, choose talks, look after sponsors, grow chapters | Manual work across many tools: RSVP lists, check-in, talk review, sponsor reports. Their volunteer hours limit how big the community can grow. |

### Why it matters
- For members, every missed meetup, recording or job is a missed chance to grow in their career.
- For the community, its growth and sponsor funding depend on volunteer time, and that doesn't scale.

### Evidence
🔵 **Open question: there's no formal evidence yet.** What we have:
- the organizers' own experience;
- a complete design exploration (25 design issues, all closed, in the designer repo).

Before investing past the MVP, we should gather:
- attendance numbers (RSVPs against people who actually came) from recent meetups;
- 5–8 short interviews per group (the `discovery-interview-prep` skill can plan these);
- what January–February testers do in the app and what they tell us.

## 3. Target users and personas
🔶 These are proto-personas, built from the designs and organizer knowledge. Testing will check them.

| Persona | Snapshot | Main job |
|---|---|---|
| **Zawadi, member** (primary) | Mid-level Android developer in Nairobi. Goes to some meetups, wants to move to Compose and Kotlin Multiplatform, would consider a new job | "Help me keep growing and stay connected without hunting for information" |
| **Brian, first-time speaker** | Junior to mid-level developer with something to share, nervous about applying | "Help me get on stage and do well" |
| **Amina, job seeker** | Recent graduate or career switcher | "Help me get seen by companies hiring Kotlin developers" |
| **Kasha Health, sponsor** (a fictional company from the designs) | Engineering lead or developer relations at a company that hires Android developers | "Show me we reached and hired the right people" |
| **Organizer** | Volunteer co-organizer of a chapter | "Let me run a great meetup in fewer hours" |
| **Contributor** (after open source) | Community developer who wants to build something real in KMP | "Let me ship a feature people use, and learn while doing it" |

## 4. Strategic context
- **Goal:** a self-sustaining community. Members come back, speakers keep coming through, sponsors renew, and organizer hours per event go down.
- **Why now:**
  - The community is big enough that manual tools are a bottleneck. 🔶
  - KMP and Compose Multiplatform are now production-ready, so the app itself can show what the community teaches.
  - Supabase lets a small team go from idea to production quickly.
- **Open source as a strategy:** the app becomes a reference KMP project and a place where people get their first contribution. That pulls in members and contributors, and makes sponsorship more credible.
- **Alternatives:**
  - general event platforms (Meetup, Luma, Eventbrite, Sessionize for calls for speakers);
  - job boards;
  - chat groups.
  
  🔶 None of them connect attending, speaking, hiring and sponsoring for one local developer community. That connection is our advantage. It's also the scope risk.
- **Market size:** not relevant in money terms, since this isn't a commercial product. 🔵 *What matters is how many Kotlin and Android developers there are in Kenya and East Africa that we could reach. Organizers to estimate.*

## 5. Solution overview

### Three surfaces
| Surface | For | What it does |
|---|---|---|
| **Mobile app** (Android first, then iOS, from one KMP and Compose Multiplatform code base) | Members, speakers, organizers at the venue | Everything a member does day to day: discover, RSVP, ticket, event day, talks, jobs, people, profile. The organizer's check-in tool |
| **Public web** | Anyone, plus search engines and link previews | Event pages, public profiles and share cards, job listings, sponsor pages, the call for speakers |
| **Organizer platform** | Organizers, and later sponsors | Create and run events, review talks, manage sponsors and jobs, approve sponsor polls, send impact reports, manage chapters |

🔵 *Are the public web and the organizer platform one web product with organizer features switched on per role, or two products? (See `docs/decisions.md`.)*

### Product pillars (the end state)
1. **Events.** A calendar of meetups and workshops, event detail with agenda and venue, RSVP with capacity and waitlist, add to calendar. An **event-day mode**: QR ticket that works offline, Wallet passes, Wi-Fi, now and next, venue directions. Organizer check-in that works offline. After the event: ratings, recordings, a recap.
2. **Speak.** An open call for speakers with a three-step submission, drafts, and status. Mentoring for first-time speakers. A speaking history. Speaker feedback from attendees. Organizer review and scheduling tools.
3. **Community.**
   - **Content:** articles, the newsletter, recordings.
   - **Jobs:** a job board, roles matching your topics, featured and sponsor roles, company pages.
   - **People:** a developer directory, "people you should meet", and Quick connect (scan a code to swap profiles).
4. **Grow.**
   - A profile that works as a portfolio: talks, attendance, topics, links.
   - "Open to work", strictly opt-in.
   - Achievements.
   - A mentorship flow that matches mentors and mentees.
5. **Sponsors.** In order of what sponsors care about:
   - **Visibility:** attribution on the events they back, "Today's host", the sponsor strip on posters.
   - **Talent:** featured roles, a company page, booth leads that attendees choose to share.
   - **Engagement:** sponsor polls, challenges, member offers.
   - **Insight:** an impact report built from real RSVPs, check-ins and engagement.

   Two rules: sponsors back whole events, never single sessions, and each screen shows at most one sponsor surface.
6. **Chapters.** Several cities (Nairobi first, then others such as Kampala), with a chapter switcher, events per chapter, and chapter organizers.
7. **Shareable meetup posters.** Each event edition gets a themed poster that attendees, speakers and sponsors can share. Titles and names can't be edited, so a poster can't misrepresent the event.
8. **For everyone.**
   - Accessibility to WCAG 2.2 AA throughout, including 200% text, TalkBack and VoiceOver.
   - Kiswahili alongside English.
   - Privacy by default: the directory, profile fields and sponsor sharing are all opt-in, and consent can be withdrawn.
9. **Open source.** A public repo, contributor docs, "good first issues", a local Supabase setup with seed data, and the public backlog on GitHub.

### Principles
- **Members come first.** A sponsor surface never pushes a member's main action off the first screen.
- **Ask before sharing.** Member data reaches sponsors only by explicit opt-in. Sponsors see totals, and groups under 5 are hidden.
- **Same content on both platforms, platform-native feel.** Android uses Material 3. iOS uses native chrome as it matures (`docs/mvp.md` explains the January exception).
- **Free for members.** 🔶 *Assumption: no paid tickets or payments.*

## 6. Success metrics
🔶 Targets below are placeholders. We set them once January–February testing gives us a baseline.

| Type | Metric | Why |
|---|---|---|
| **North star** | **Members who attend (check in at) at least one event per quarter** | Showing up is what everything else builds on |
| Members | Repeat attendance (attended 2+ events in 6 months). Gap between RSVPs and check-ins. Members who complete their profile | Whether people come back, and whether RSVPs are reliable |
| Speakers | Talk submissions per call for speakers, share of first-time speakers, speakers who return | A healthy pipeline of speakers |
| Job seekers | Job detail views leading to "Apply" taps. 🔵 Hires reported back (how do we find out?) | Whether the community helps people get hired |
| Sponsors | Sponsors who renew. Booth leads shared. Impact reports delivered within 7 days of an event | Whether sponsorship is worth paying for |
| Organizers | Organizer hours per event (self-reported) | Whether running events got easier |
| Open source | External contributors who get a PR merged per quarter | Whether open-sourcing works |
| **Guardrails** | Crash-free sessions ≥ 99.5% 🔶. Accessibility audit with no open must-fix issues. Zero privacy incidents. Sponsor-related complaints from members. App store rating | Things that must not get worse |

## 7. Epics and hypotheses
Each pillar becomes epics. Each epic gets its own scope in `docs/scopes/` when we pick it up.

| Epic | Hypothesis: we believe… | We'll know it's working when… |
|---|---|---|
| Events and RSVP (MVP) | one place to find meetups and RSVP raises attendance | the gap between RSVPs and check-ins shrinks, and repeat attendance rises |
| Ticket and check-in (MVP, offline later) | QR check-in makes the door faster and gives us real attendance data | door time per attendee drops, and every event has check-in data |
| Call for speakers (MVP) | submitting from the phone, with mentoring, brings in more and newer speakers | submissions and the share of first-time speakers go up |
| Jobs (MVP) | putting community jobs where members already are gets them hired | apply taps grow, sponsors renew, hires get reported |
| Post-event loop | asking for feedback right after a meetup improves talks and gives speakers data | rating response rate ≥ 30% 🔶, and speakers open their feedback |
| People and Quick connect | helping members meet the right people makes meetups more valuable | connections made per event, and repeat attendance |
| Sponsor impact report | a report built on real data makes sponsors renew | renewal rate, and time to deliver the report |
| Mentorship | structured mentorship keeps juniors in the community | mentorship pairs that meet 3+ times |
| Chapters | the same platform can launch a new city cheaply | a second chapter runs its events on the platform |
| Kiswahili | members who prefer Kiswahili engage more 🔶 | engagement from Kiswahili users compared with the baseline |
| Organizer platform | one tool reduces organizer hours | organizer hours per event go down |
| Open source | a public KMP reference app attracts contributors | external contributors merged per quarter |

## 8. Out of scope (for the product, not just the MVP)
- **Paid ticketing and payments.** Events are free. 🔵 *Revisit if paid workshops ever happen.*
- **Chat and messaging.** The community already has chat channels, and moderating chat is costly. Quick connect hands people off to their existing channels instead.
- **A general social feed** (posts, likes, comments). It's noisy, needs moderation, and isn't our job.
- **Hosting video.** Recordings link out to YouTube or similar.
- **A recruiting platform** (applicant tracking, in-app applications). Jobs link to the employer's own form.
- **Selling or exporting member data to sponsors** beyond what members opt into.
- **A general events platform for other communities.** It's built for Android254 chapters first. Being open source, others can fork it.

## 9. Dependencies and risks
| Risk | Mitigation |
|---|---|
| **Scope.** The designs already cover more than a year of work for 4 engineers | Phase hard (`docs/mvp.md`). Each phase is decided by what testers and metrics tell us, not by what's in the designs |
| **Volunteer capacity** for engineering and organizing | Open source and good contributor docs. The organizer platform removes manual work |
| **Privacy and trust** (Kenya's Data Protection Act, sponsors and member data) | Opt-in by default, a privacy review before each feature that touches data, and a published privacy policy |
| **Getting locked into Supabase** | Keep business logic in shared KMP code and Postgres. Review after the open-source release (`docs/decisions.md`) |
| **iOS quality** with shared UI | A native-chrome phase after January. iOS-specific QA in every phase |
| **Members depend on GitHub sign-in** | 🔵 Add email or Google sign-in if testers without GitHub get stuck |
| **Sponsors expect more than we can deliver** | Promise visibility and talent first. Offer the impact report only once the data exists |
| **App store policies** (account deletion, closed testing rules; Sign in with Apple once iOS ships) | Built into the MVP |

**Dependencies:**
- the design system and screens in Figma (designer agent);
- Supabase;
- GitHub and Apple sign-in;
- Play Console and App Store Connect accounts;
- chapter organizers' time;
- the Linear workspace (until the open-source release).

## 10. Open questions
| Question | Who answers |
|---|---|
| One web product with organizer features switched on per role, or two? Who uses it, and when does it ship? | Product owner and organizers |
| What evidence do we have today (attendance, sponsor feedback)? Can organizers share numbers from recent meetups? | Organizers |
| Which cities come after Nairobi, and who organizes there? | Organizers |
| Is everything free for members, forever? | Organizers |
| Which sign-in methods beyond GitHub and Apple? | Product owner |
| What may sponsors see, exactly? (Opt-in leads, totals, the group-size threshold of 5.) | Organizers, plus legal or privacy advice |
| After the open-source release: governance, licence, who reviews and merges, code of conduct for contributors | Organizers and engineering |
| When does iOS move to native chrome? | Engineering and design |

## Self-assessment
- **Strongest section:** solution overview. The designs are detailed and already reviewed for accessibility and sponsors.
- **Weakest section:** problem evidence. Almost everything about the problem is an assumption so far.
- **Top assumptions to check in January–February:**
  1. Members will move event discovery and RSVP into the app.
  2. RSVP and check-in data is reliable enough to serve as the north star.
  3. Sponsors value talent and engagement over visibility alone.
- **Recommended next steps:** organizers review this PRD and `docs/mvp.md` together. Then run 5–8 member and sponsor interviews in October, before the build starts, so the MVP isn't built on assumptions alone.
