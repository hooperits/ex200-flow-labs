# Implementation Plan: 02-shell-scripting

Detailed design for Module 02 - Shell Scripting.

## User Review Required
None. Standard design according to constitution.

## Proposed Changes

### Labs Folder

#### [NEW] [Vagrantfile](file:///home/juanca/proys/RHCSA-EX200/Vagrantfile)
Already configured.

#### [NEW] [demo.sh](file:///home/juanca/proys/RHCSA-EX200/labs/02-shell-scripting/demo.sh)
Interactive Bash 5.x tutorial showing:
- Variables and user input.
- Conditional statements (`if [ -f file ]`).
- Loops (`for` and `while`).
- Script arguments ($1, $2, $#, $@).

#### [NEW] [instructions.md](file:///home/juanca/proys/RHCSA-EX200/labs/02-shell-scripting/instructions.md)
Detailed guidelines in Spanish for creating a file filter script `challenge/file_filter.sh`.

#### [NEW] [hints.md](file:///home/juanca/proys/RHCSA-EX200/labs/02-shell-scripting/hints.md)
Pistas for conditionals, loop checks, and arguments.

#### [NEW] [verify.sh](file:///home/juanca/proys/RHCSA-EX200/labs/02-shell-scripting/verify.sh)
Checks if `challenge/file_filter.sh` behaves correctly:
- Returns exit code 1 when no arguments are provided.
- Returns exit code 2 when directory does not exist.
- Returns exit code 3 when no files match the extension.
- Returns exit code 0 and lists correct files when valid.

#### [NEW] [reset.sh](file:///home/juanca/proys/RHCSA-EX200/labs/02-shell-scripting/reset.sh)
Cleans up test folders and any user script.

## Verification Plan

### Manual Verification
- Run verify.sh before solving (should fail).
- Solve the challenge and check verify.sh (should pass).
- Check demo.sh duration is at least 3 minutes.
