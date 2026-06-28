# Implementation Plan: 01-essential-tools

**Branch**: `001-essential-tools` | **Date**: 2026-06-28 | **Spec**: [spec.md](file:///home/juanca/proys/RHCSA-EX200/specs/01-essential-tools/spec.md)
**Input**: Feature specification from `/specs/01-essential-tools/spec.md`

## Summary

El módulo 01-essential-tools implementa el primer laboratorio práctico del examen RHCSA (EX200), enfocado en comandos esenciales en Rocky Linux 9. Se diseñará una estructura de scripts en Bash que correrán dentro de la máquina virtual provista por Vagrant con Hyper-V. El laboratorio consta de una demo animada paso a paso, instrucciones en español, pistas progresivas, un script de verificación automatizado no destructivo y un script para restablecer el entorno. El control se ejecutará de forma nativa en el host Windows.

## Technical Context

**Language/Version**: Bash 5.x  
**Primary Dependencies**: Rocky Linux 9 (VM), Vagrant 2.4.9, Hyper-V  
**Storage**: Local file system (XFS/ext4) of the Rocky Linux 9 VM  
**Testing**: Automated non-destructive shell script (`verify.sh`)  
**Target Platform**: Rocky Linux 9 virtualized environment  
**Project Type**: Infrastructure CLI Lab scripts  
**Performance Goals**: `demo.sh` duration < 3 min, `verify.sh` execution < 5s, `reset.sh` execution < 1s  
**Constraints**: Fully offline-capable, non-destructive validation, execution isolated inside the guest VM  
**Scale/Scope**: 5 key essential tools topics: Redirections, grep/regex, tar compression, hard/soft links, standard permissions (chmod/chown)

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **Principle I: Isolated Hyper-V Environment**: **PASSED**. All labs and evaluations will run strictly inside the Rocky Linux 9 guest VM, controlled from the Windows Host.
- **Principle II: Standardized Module Structure**: **PASSED**. The lab folder will contain `demo.sh`, `instructions.md`, `hints.md`, `verify.sh`, and `reset.sh`.
- **Principle III: External Lyrics**: **PASSED**. Lyrics file will be stored outside Git at `../RHCSA-EX200-lyrics/01-essential-tools.txt`.
- **Principle IV: Language Localization**: **PASSED**. Explanations and instruction prose in Spanish; commands, arguments, and Red Hat service names in English.
- **Principle V: Non-destructive Evaluation**: **PASSED**. The verification script will check file statuses/content without modifying any configurations.
- **Principle VI: Public Visibility (README)**: **PASSED**. The main README has been updated to document this lab module and its contents.

## Project Structure

### Documentation (this feature)

```text
specs/01-essential-tools/
├── plan.md              # This file
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
└── quickstart.md        # Phase 1 output
```

### Source Code (repository root)

```text
labs/01-essential-tools/
├── challenge/
│   └── original_data.txt
├── demo.sh
├── instructions.md
├── hints.md
├── verify.sh
└── reset.sh
```

**Structure Decision**: A single project structure under the `labs/` directory at the repository root.
