# Tasks: 06-security-selinux

**Input**: Design documents from `/specs/005-specs-06-security/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md

---

## Phase 1: Setup

- [ ] T001 Create directory `labs/06-security-selinux/challenge/`
- [ ] T002 Configure directory permissions for `labs/06-security-selinux/`

---

## Phase 2: Foundational

- [ ] T003 Configure CLI helper `clear_section` and timing parameters in `labs/06-security-selinux/demo.sh`
- [ ] T004 Implement firewalld, SELinux context, SELinux port, and boolean sections in `labs/06-security-selinux/demo.sh`

---

## Phase 3: User Story 1 - Demo y Challenge (Priority: P1)

- [ ] T005 Create instructions in Spanish in `labs/06-security-selinux/instructions.md`
- [ ] T006 Create hints in `labs/06-security-selinux/hints.md`
- [ ] T007 Implement verification checks for firewalld service/port configuration in `labs/06-security-selinux/verify.sh`
- [ ] T008 Implement verification checks for folder SELinux context and boolean status in `labs/06-security-selinux/verify.sh`
- [ ] T009 Create cleanup commands in `labs/06-security-selinux/reset.sh`

---

## Phase 4: User Story 2 - Lyrics (Priority: P2)

- [ ] T010 Write the Spanish technical rap lyrics to `../RHCSA-EX200-lyrics/06-security-selinux.txt`

---

## Phase 5: Polish & Test

- [ ] T011 Configure executable permissions on all script files in `labs/06-security-selinux/`
- [ ] T012 Validate full execution loop (Reset -> Demo -> Solve -> Verify -> Reset) locally in WSL.
