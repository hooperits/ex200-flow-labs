# RHCSA-EX200 — Complete Strategic Roadmap

**Project**: ex200-flow-labs (RHCSA EX200 hands-on labs in Spanish)  
**Primary Public Purpose**: Help students master and pass the Red Hat Certified System Administrator (EX200) exam on RHEL 9 / AlmaLinux 9.  
**Internal Dual Engine**: High-quality educational content that powers professional YouTube video production (Eminem-style Spanish RAP) + drives GitHub growth.

> **CRITICAL RULE (Public vs Internal)**:  
> Nothing about video production, Suno, RAP lyrics, YouTube channel strategy, content funnel, or "why we have demo.sh" may appear in `README.md`, public documentation, commit messages visible in the main branch, or any file that ships with the public repository.  
> The public face must remain 100% clean, professional, and focused exclusively on RHCSA exam preparation.

---

## 1. Vision (1000% Improvement)

Transform this project into the **best open-source RHCSA preparation platform in Spanish** (and eventually bilingual) measured by:

### Educational Impact
- 90%+ coverage of official EX200 objectives
- Students can reliably pass verifiers on first or second attempt
- Clear, fast feedback loops
- Real exam-like pressure (timed simulation mode)
- All changes pass post-task review against Educational Quality Rules (see AGENTS.md)

### Content Production Power
- `demo.sh` become best-in-class assets for high-retention terminal screen recordings
- Tight, repeatable synchronization with timed RAP lyrics
- Dramatically reduced time from "lab ready" → "video published"

### Growth Flywheel (Internal)
- YouTube channel (@hooperits8) generates views + subscriptions via educational RAP videos
- Videos act as top-of-funnel that drives:
  - GitHub clones
  - Stars & forks
  - Followers on the repo
- Strong "practice what you saw" call-to-action without revealing the meta strategy publicly

---

## 2. Core Principles & Constraints

1. **Public Purity** — README, instructions, and all public docs talk only about learning RHCSA.
2. **demo.sh is sacred for video** — Primary design goal of demo scripts is excellent screen-recordable sessions (clean pacing, consistent sections, chapter-friendly headers).
3. **Lyrics live outside** — `/home/juanca/proys/RHCSA-EX200-lyrics/` (with `suno_prompts.md`).
4. **YouTube automation lives outside** — `/home/juanca/proys/hooperits8/` (OAuth, upload scripts, TTS).
5. **Changes have lyrics cost** — Any modification to demos or lab content requires planned re-examination of corresponding lyrics.
6. **Immutability & Quality** — Follow high standards for scripts (strict mode, shared libs, good error messages).
7. **Equal weight** — Educational quality and video production have the same strategic priority.
8. **Guardrail process** — After each task, review against Educational Quality Rules (see AGENTS.md). If a change would compromise a rule for video production, pause and consult before proceeding.
9. **Anti-Loop Rule** — All editing (especially generators and prompt strings) is governed by the strict ANTI-LOOP RULE in AGENTS.md: read-first discipline, max 2 micro-iterations on the same target, mandatory run + inspect generated output, prefer structural changes.

Educational Quality Rules and post-task checklist are maintained in AGENTS.md.

---

## 3. Current State (as of 2026-06-30, updated with Phase 0 progress)

### Strengths
- Excellent consistent structure across 9 labs (`demo.sh`, `instructions.md`, `verify.sh`, `hints.md`, `reset.sh`, `challenge/`)
- Strong pedagogical "The Flow"
- Automated non-destructive verifiers with colored output
- All in Spanish
- Vagrant + AlmaLinux 9 baseline
- Shared `lib/demo-common.sh` with `--video` / `--fast` modes (production support without changing default student experience)
- Video skeleton + Suno prompt generator (`scripts/generate-video-skeleton.sh`)
- Active post-task Educational Quality Checklist usage (see docs/educational-quality-audit.md)
- Strict ANTI-LOOP RULE in AGENTS.md (read-first, iteration limits, mandatory run+review)

### Major Gaps
- **Coverage**: ~55-65% of EX200 objectives (still the main gap)
- **demo.sh problems** (progress on some, remaining work):
  - Pacing now controllable via `--video`/`--fast` flags (shared lib) — default remains educational (~5s sleeps)
  - Some reduction in simulation (e.g. module 07 now uses real pvcreate/vgcreate/lvextend + cleanup)
  - Section ordering and lyrics alignment started (module 01 re-ordered; 03 partial)
  - Missing key challenge elements remain in some demos (e.g. full GRUB recovery in 03)
- Brittle verifiers and incomplete resets (Phase 0 priority)
- Hyper-V + SMB only (painful for Mac/Linux users)
- No progress tracking, no exam simulation
- Code duplication (verify logic repeated 9x)
- No documented lyrics sync process across repos

**Alignment Analysis Summary** (updated):
- Modules 02, 04, 05, 06, 09: Good-to-excellent topic match
- Modules 01, 03, 07, 08: Partial progress on order/simulation; alignment debt remains highest for video production
- Generator + checklist now provide better tooling for lyrics sync and quality gates

---

## 4. Strategic Pillars

**Pillar A — Educational Excellence**  
World-class, verifiable, objective-mapped labs. All deliverables reviewed against Educational Quality Rules after completion.

**Pillar B — Video Production Excellence**  
demo.sh optimized for fast, clean, chapterable recordings that map tightly to lyrics.

**Pillar C — Growth Flywheel**  
YouTube RAP videos → high retention → GitHub clones/stars + channel subs.

Equal priority between A and B. Use post-task checklist (AGENTS.md) as guardrail.

---

## 5. Phased Roadmap

### Phase 0: Foundation + Balanced Readiness (2–4 weeks)

**Goal**: Establish solid base for both educational quality and video production with equal priority. Apply Educational Quality Rules (AGENTS.md) after each deliverable.

Key deliverables:
- Internal `AGENTS.md` with Educational Quality Rules, post-task checklist and ANTI-LOOP RULE (done + actively used)
- Shared `lib/demo-common.sh` (demo helpers with --video/--fast; verify/reset libs still pending)
- demo.sh improvements with video support across all modules (done via shared lib) while preserving default educational experience
- Video skeleton + Suno prompt generator (done)
- Standardize section headers for consistent chapter naming (partial progress)
- Vagrantfile improvements (multi-provider support started)
- Cross-repo sync checklist documented (pending)

**Success criteria**:
- All deliverables pass post-task checklist review against the 7 Educational Quality Rules (AGENTS.md)
- demo.sh supports efficient video recording without degrading default student use
- Lyrics team can map sections easily
- No rule violations without documented consultation

### Phase 1: Content Expansion & Lyric Alignment (6–10 weeks)

**Goal**: Reach 90%+ objective coverage + fix alignment debt.

- Fix high-priority alignment issues (01, 03 especially)
- Add missing high-value labs (in rough priority):
  1. Package Management & DNF/Repositories/Modules
  2. Logging, journalctl advanced + rsyslog
  3. SSH key auth + advanced sudoers
  4. Kernel parameters, sysctl, performance basics
  5. Systemd timers + advanced units
  6. Troubleshooting scenarios (deliberately broken states)
- For every new or changed lab:
  - Update demo
  - Re-examine + update lyrics in sibling folder
  - Update Suno prompts
- Improve verifiers (more robust checks, `--explain` mode that suggests fixes)
- Make resets more complete and idempotent

**Deliverable**: Full objective traceability matrix (internal + public sanitized version)

### Phase 2: Platform & Accessibility (parallel / 4–8 weeks)

- Multi-provider Vagrant (VirtualBox, libvirt, Hyper-V)
- Standalone provisioning script (`setup-lab.sh`) that works on real Alma/RHEL machines or cloud VMs
- Consider Packer images for consistent recording environments
- Better documentation for non-Windows users
- Optional containerized recording environment (where possible)

### Phase 3: Supercharged Learning Experience (8–12 weeks)

- Progress tracking (local JSON or simple DB)
- CLI tool: `ex200 lab list | run | verify | status | exam-simulate`
- **Exam Simulation Mode**: 2.5-hour timed mixed tasks across objectives, final score report by category
- "Explain" mode on verifiers
- Hints system that can be progressively revealed
- Bilingual support path (Spanish primary)

### Phase 4: Growth, Distribution & Ecosystem (ongoing)

- GitHub optimizations (README polish, badges, "Star this if it helped", clear clone instructions)
- Cross-repo tooling:
  - Script that generates YouTube description skeletons + timestamps from lab metadata
  - Video script skeleton generator from demo sections
- Release process that includes "update lyrics checklist"
- Community guidelines (while keeping strategy internal)
- Potential future: English version, Anki deck export, etc.

---

## 6. Cross-Cutting Workstreams

### A. demo.sh Evolution (Video-First)
- Add flags and modes
- Consistent helpers
- Ability to output timing/script data for lyrics team
- Consider separate "video-demo" variants if needed (without polluting student experience)

### B. Lyrics & Content Sync Process
- After any demo or instructions change → mandatory re-examination ticket
- Use structured sections in demos that map to "CORO / ESTROFA 1 / ..."
- Maintain phonetic style guide

### C. Tooling Between Repositories
- `RHCSA-EX200` (this repo — education)
- `RHCSA-EX200-lyrics` (lyrics + Suno prompts + recordings)
- `hooperits8` (YouTube API, upload, TTS, video production pipeline)

Recommended bridges (live in lyrics or hooperits8 folders):
- Metadata exporter from labs
- Description + CTA generator ("Clona el repo para practicar con verificadores automáticos")

### D. Quality & Automation
- GitHub Actions: shellcheck, shfmt, basic verifier smoke tests
- Pre-commit hooks
- Consistent error handling

---

## 7. Success Metrics

**Educational**
- Objective coverage %
- % of labs with passing verifiers on first try (target >70%)
- Student-reported time to complete a lab
- Exam simulation completion rate + score distribution
- % of tasks passing post-task Educational Quality Checklist without consultation (target >90%)

**Production Velocity**
- Time from "lab finalized" to "video uploaded" (target: significantly lower)
- Consistency of recordings (same machine state every time)

**Growth (Internal)**
- YouTube views per video, watch time, subs per video
- GitHub clones and stars attributed to video traffic
- Video → repo conversion rate

---

## 8. Risks & Mitigations

- **Risk**: Strategy leaks into public repo → Mitigation: AGENTS.md + code review checklist + never document "why demo.sh exists" publicly
- **Risk**: Lyrics get out of sync after big changes → Mitigation: Explicit sync checklist + tooling
- **Risk**: Over-optimizing for video hurts student experience → Mitigation: Default behavior stays educational; video mode is opt-in
- **Risk**: Vagrant complexity frustrates users → Mitigation: Strong standalone scripts + multi-provider support

---

## 9. Immediate Next Steps (Next 7–14 Days)

**Completed / Advanced in recent work:**
- Apply post-task checklist to work items (now actively used; see latest in docs/educational-quality-audit.md)
- `--video` / `--fast` mode implemented across **all** demos via shared lib (exceeds original 3-4 target)
- Video Script Skeleton generator created and in use (`scripts/generate-video-skeleton.sh`)
- Initial + follow-up audit of labs against rules (extended with checklist review)

**Remaining high priority:**
1. Produce detailed alignment fix plan + execute for Modules 01 and 03 (highest video/lyrics impact)
2. Improve verifiers (robustness, `--explain` mode) and resets (more complete/idempotent)
3. Add first new high-value lab: Package Management & repositories (biggest coverage gap)
4. Set up / test basic multi-provider Vagrant (VirtualBox + libvirt)
5. Document the exact lyrics ↔ code sync process (sibling repo)
6. Re-audit Phase 0 deliverables against the 7 rules + anti-loop process

**Metrics to track going forward**:
- Post-task checklist pass rate (target >90%)
- Demo recording time reduction with `--video` mode
- Lyrics alignment coverage per module

---

## Execution Process, Log & Amendments

This section operationalizes the phased roadmap using guardrails from AGENTS.md.

**Roadmap Execution Cycle** (apply to every task):
1. Pre: Read current ROADMAP state + relevant audit section + AGENTS.md (Educational Quality Rules + Post-Task Checklist + ANTI-LOOP RULE + Context Management & Turn Governance). Perform context hygiene on bloated files if signals are present.
2. Execute using reuse (lib/demo-common.sh, generator, per-lab verify/reset patterns); structural changes preferred.
3. Post (mandatory): Fill Post-Task Educational Quality Checklist (see AGENTS.md). Run tests (verify.sh, reset.sh, generator if demo touched). Update audit + skeletons.
4. If verification gap or new insight: Create "Amendment Proposal" (documented below).
5. Update metrics, this log, next steps.
6. Commit referencing checklist/alignment/amendment.

**Cross-cutting**: Lyrics sync cost (re-examine sibling after demo/instructions change); 1:1 section alignment; public purity.


### Current Execution Log (latest first; compacted per Context Management rules)

- **2026-06-30 / Lab 13 instructions full flesh**: Expanded instructions.md for kernel/sysctl with detailed steps (sysctl -a/-w, /etc/sysctl.d/, -p, /proc checks, challenge doc). Matches demo/verify. Post-task applied. Now 4/6 Phase1 full detailed (10,13,14,15). Re-audit note updated. Improves Rules 1,2,5.
- **2026-06-30 / Lab 15 instructions full flesh**: Expanded instructions.md with detailed, specific EX200 commands for each of 4 tasks (journalctl filters, systemctl, ip/ss, permissions chmod, logger, log documentation in challenge/). Matches demo sections and verify checks. Improves Rules 1,2,5. Post-task checklist applied.
- **2026-06-30 / docs(agents): add Context Management & Turn Governance (commit 5a1a263)**: Added the 5 mandatory rules as a new section in AGENTS.md (with same weight as ANTI-LOOP). Updated warning banner and ROADMAP Execution Cycle. Directly targets repeated "response truncated by max_tokens" errors.
- **2026-06-30 / Context hygiene + compaction (this pass)**: Proactively compacted ROADMAP.md (massive log) and educational-quality-audit.md per new rule #1. Kept strategic state, Execution Process, recent valuable milestones + concise summaries. Removed heavy duplication from repeated continues/re-audits.
- **2026-06-30 / Alignment 01+03 (commit 6bebb49)**: Structural merge of sections to match lyric ESTROFAS count/order. 01: links+tar combined. 03: procesos+logs combined, GRUB as 4. Generator run + reviewed. Checklist applied.
- **2026-06-30 / Phase 0 Re-audit + Process Setup**: Added "Execution Process, Log & Amendments" section + cycle to ROADMAP. Extended audit. Followed full cycle + anti-loop.
- **2026-06-30 / Verifier --explain (multiple labs)**: Piloted on 03, extended to 07/01/10, then full backport to all 9 labs. Added --explain + suggestions. Strong improvement to rule 3.
- **2026-06-30 / Shared Reset Helpers**: Created lib/reset-common.sh. Backported to all labs (01,02,03,04,05,06,07,08,09). Phase 0 resets complete.
- **2026-06-30 / Phase 1 New Labs (10-15)**: Added 6 new labs for coverage (Package Management 10 full; Logging 11, SSH/Sudoers 12, Kernel 13, Timers 14, Troubleshooting 15 basic+). Full structure, real commands, challenge data, verifiers with --explain, resets, generator skeletons, post-task checklists applied.
- **2026-06-30 / Objective Traceability Matrix**: Created docs/objective-matrix.md. Mapped labs to EX200 objectives. Phase 1 coverage progress tracked.
- **2026-06-30 / Phase 2 CLI Stub**: Created bin/ex200 (list, run, verify, status, exam-simulate, matrix, progress). Integrated progress.json. Tested key commands.
- **2026-06-30 / Post-task batches & generator**: Multiple full checklist applications + `./scripts/generate-video-skeleton.sh --all`. High pass rate.
- **2026-06-30 / Lyrics Sync Process**: Documented 9-step process in docs/lyrics-sync-process.md. Ties code changes to sibling repo updates.
- **2026-06-30 / Vagrant & foundational improvements**: Multi-provider notes, lib/demo-common.sh (VIDEO/FAST modes), initial alignment work.

(Older repeated "continue", CLI test spam, and duplicate re-audit summaries from 2026-06-30 sessions compacted. ~100k+ lines of low-signal history removed. Full detail preserved in git history.)

### Amendments Log & Process
### Amendments Log & Process
- **Proposal format** (add here or in audit): ID, Trigger (verification result), Description, Affected rules/metrics, Proposed change, Checklist status on proposal, Decision.
- Example template entry:
  ```
  - [YYYY-MM-DD] Amendment N: <title>
    Trigger: <e.g. audit score 4.5/7 on rule 2>
    Why: <evidence>
    Impact: ...
    Proposal: ...
    Status: Proposed / Approved / Integrated (see commit XXX)
  ```
- All amendments must pass checklist themselves before integration.

### Phase 0 Execution Status
- Foundation items largely complete (AGENTS, lib, generator, some alignment).
- Remaining (see list above): verifiers/resets, full multi-provider, sync doc, re-audit.
- Next action per log: Re-audit + begin verifiers for low-score labs.

---

## 10. Governance

- All public-facing text (README, instructions, etc.) must pass a "pure education" review.
- Strategic discussions and production notes stay in internal files or the sibling repositories.
- When in doubt, default to "this helps students pass the exam."

---

**This roadmap captures the full context we have built together:**

- Original 1000% improvement vision
- Deep codebase + verifier + demo analysis
- Detailed demo ↔ lyrics alignment audit
- Strict separation of public educational value vs internal content production engine
- Growth flywheel (YouTube RAP videos → GitHub)

Ready to start executing any phase or specific work item. Just tell me the priority.

---

*Last updated: 2026-06-30 (governance rules + major context compaction: ROADMAP 229k→328 lines, audit 847→157 lines)*
*Internal document — do not publish strategy details publicly*