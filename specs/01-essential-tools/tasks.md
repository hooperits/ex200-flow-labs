# Tasks: 01-essential-tools

**Input**: Design documents from `/specs/01-essential-tools/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3, US4)
- Include exact file paths in descriptions

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [x] T001 Create lab module folder in `labs/01-essential-tools/`
- [x] T002 Configure directory permissions for local development in `labs/01-essential-tools/`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T003 Configure the Rocky Linux 9 VM basic provisioning in the root `Vagrantfile` to mount `/labs/` folder
- [x] T004 Implement CLI coloring helpers and delay typist function for guest VM outputs in `labs/01-essential-tools/demo.sh`

**Checkpoint**: Foundation ready - user story implementation can now begin

---

## Phase 3: User Story 1 - Demostración Interactiva en la VM (Priority: P1) 🎯 MVP

**Goal**: Interactive colored Spanish CLI demo of stdout/stderr, grep, tar, links, and permissions in guest VM.

**Independent Test**: Execute `labs/01-essential-tools/demo.sh` in the guest VM. It should display interactive tutorials and run example commands.

### Implementation for User Story 1

- [x] T005 [P] [US1] Create script skeleton and type_text helper in `labs/01-essential-tools/demo.sh`
- [x] T006 [US1] Implement stdout and stderr redirection demo section in `labs/01-essential-tools/demo.sh`
- [x] T007 [US1] Implement grep and regex text filtering demo section in `labs/01-essential-tools/demo.sh`
- [x] T008 [US1] Implement tar compression and archiving demo section in `labs/01-essential-tools/demo.sh`
- [x] T009 [US1] Implement hard and soft links creation demo section in `labs/01-essential-tools/demo.sh`
- [x] T010 [US1] Implement owner and permission changes chmod/chown demo section in `labs/01-essential-tools/demo.sh`

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently.

---

## Phase 4: User Story 2 - Resolución del Challenge Práctico (Priority: P1)

**Goal**: Spanish instructions with exact paths and requirements, and hints.

**Independent Test**: Read `labs/01-essential-tools/instructions.md` and check if instructions are complete and understandable.

### Implementation for User Story 2

- [x] T011 [P] [US2] Create challenge instructions in Spanish with exact paths in `labs/01-essential-tools/instructions.md`
- [x] T012 [P] [US2] Create progressive challenge hints in `labs/01-essential-tools/hints.md`
- [x] T013 [US2] Create challenge folder and seed test data file in `labs/01-essential-tools/challenge/original_data.txt`

**Checkpoint**: At this point, User Stories 1 and 2 should both work.

---

## Phase 5: User Story 3 - Evaluación Automatizada (Priority: P1)

**Goal**: Non-destructive automated tests and state reset.

**Independent Test**: Run `labs/01-essential-tools/verify.sh` and `labs/01-essential-tools/reset.sh` on the Rocky Linux 9 guest VM.

### Implementation for User Story 3

- [x] T014 [P] [US3] Implement soft and hard link target resolution validation in `labs/01-essential-tools/verify.sh`
- [x] T015 [P] [US3] Implement permissions (640) and group checks validation in `labs/01-essential-tools/verify.sh`
- [x] T016 [P] [US3] Implement grep result checks validation in `labs/01-essential-tools/verify.sh`
- [x] T017 [US3] Implement user-friendly evaluation report output in `labs/01-essential-tools/verify.sh`
- [x] T018 [US3] Implement cleanup of challenge files and links in `labs/01-essential-tools/reset.sh`

**Checkpoint**: User stories 1, 2, and 3 should now be independently functional.

---

## Phase 6: User Story 4 - Letra del Rap para Nemotecnia (Priority: P2)

**Goal**: External Spanish lyrics file.

**Independent Test**: Read `../RHCSA-EX200-lyrics/01-essential-tools.txt` on the host to check if lyrics are created.

### Implementation for User Story 4

- [x] T019 [US4] Write the Spanish mnemotechnic lyrics to `../RHCSA-EX200-lyrics/01-essential-tools.txt`

**Checkpoint**: All user stories are functional.

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [x] T020 [P] Configure executable permissions on all script files in `labs/01-essential-tools/`
- [x] T021 Test the entire workflow (Reset → Demo → Solve → Verify → Reset) in the Rocky Linux 9 guest VM

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User stories can proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2 → P3)
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P2)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 3 (P3)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 4 (P2)**: Can start after Foundational (Phase 2) - No dependencies on other stories

---

## Parallel Opportunities

- All Setup tasks marked [P] can run in parallel (T001, T002)
- Models/scenarios within US1, US2, and US3 marked [P] can run in parallel
- Once Foundational phase completes, Developer A can work on US1, Developer B on US2, and Developer C on US3 simultaneously

---

## Parallel Example: User Story 3

```bash
# Implement link checks, permissions checks, and grep checks in parallel:
Task: "Implement soft and hard link target resolution validation in labs/01-essential-tools/verify.sh"
Task: "Implement permissions (640) and group checks validation in labs/01-essential-tools/verify.sh"
Task: "Implement grep result checks validation in labs/01-essential-tools/verify.sh"
```

---

## Implementation Strategy

### MVP First (User Stories 1, 2, 3 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational
3. Complete Phase 3: User Story 1 (Demo)
4. Complete Phase 4: User Story 2 (Challenge setup)
5. Complete Phase 5: User Story 3 (Verify & Reset)
6. **STOP and VALIDATE**: Verify entire lab loop inside guest VM.
