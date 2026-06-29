# Tasks: 05-networking-services

**Input**: Design documents from `/specs/004-specs-05-networking/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md

---

## Phase 1: Setup

- [ ] T001 Create directory `labs/05-networking-services/challenge/`
- [ ] T002 Configure directory permissions for `labs/05-networking-services/`

---

## Phase 2: Foundational

- [ ] T003 Configure CLI helper `clear_section` and timing parameters in `labs/05-networking-services/demo.sh`
- [ ] T004 Implement nmcli, hostnamectl, chronyc, and cron/at sections in `labs/05-networking-services/demo.sh`

---

## Phase 3: User Story 1 - Demo y Challenge (Priority: P1)

- [ ] T005 Create instructions in Spanish in `labs/05-networking-services/instructions.md`
- [ ] T006 Create hints in `labs/05-networking-services/hints.md`
- [ ] T007 Implement verification checks for hostname and nmcli connection settings in `labs/05-networking-services/verify.sh`
- [ ] T008 Implement verification checks for chronyd and cron entries in `labs/05-networking-services/verify.sh`
- [ ] T009 Create cleanup commands in `labs/05-networking-services/reset.sh`

---



---

## Phase 5: Polish & Test

- [ ] T011 Configure executable permissions on all script files in `labs/05-networking-services/`
- [ ] T012 Validate full execution loop (Reset -> Demo -> Solve -> Verify -> Reset) locally in WSL.
