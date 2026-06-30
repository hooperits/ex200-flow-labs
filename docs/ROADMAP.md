# RHCSA-EX200 — Public Roadmap (Educational View)

This is the **public-friendly** view of our plans. Everything here focuses exclusively on helping students pass the RHCSA EX200 exam.

For the complete internal strategic roadmap (including production pipeline details), see the private `ROADMAP.md` at the project root.

## High-Level Goals

- Reach **90%+ coverage** of official Red Hat EX200 objectives
- Provide the best automated verification experience possible
- Make practice fast, reliable, and realistic
- Support multiple environments (not just Hyper-V)
- Add exam simulation mode with timing and scoring

## Planned Phases (High Level)

### Phase 0 — Quality & Reliability
- Shared libraries for verifiers and resets
- Much more robust `verify.sh` scripts (better diagnostics, `--explain` mode)
- Improved `reset.sh` (more complete and idempotent)
- Multi-provider Vagrant support + standalone setup script

### Phase 1 — Content Expansion
- New labs for currently weak areas:
  - Package management & repositories
  - Advanced logging & troubleshooting
  - SSH, keys & sudoers
  - Kernel/sysctl & basic tuning
  - Systemd timers
  - Dedicated troubleshooting scenarios
- Full objective traceability matrix

### Phase 2 — Better Learning Experience
- Local progress tracking
- CLI tool (`ex200`)
- Timed **Exam Simulation** mode
- Better hints system

### Phase 3 — Accessibility & Polish
- Better support for VirtualBox, libvirt, cloud VMs
- Bilingual (Spanish + English) path
- Improved documentation and onboarding

## Current Status (June 2026)

- 9 solid foundational labs
- Strong "demo → practice → verify → reset" flow
- Work in progress on video production support (for higher quality demonstrations) and multi-environment compatibility

We are actively working on making the labs more complete, the verifiers more reliable, and the overall experience closer to the real exam.

Want to contribute? Check the issues or open a discussion.

---

*This document deliberately contains only educational goals.*