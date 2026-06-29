# Data Model and Test Scenarios: 02-shell-scripting

Layout of test inputs and outputs.

## Seeds
We will create a directory `/labs/02-shell-scripting/challenge/test_dir` containing:
- `file1.txt`
- `file2.txt`
- `file3.log`
- `notes.md`

## Testing Logic
The verification script will run the student's script and capture output:
1. `file_filter.sh` (0 arguments) -> stderr should have text, exit code must be `1`.
2. `file_filter.sh /nonexistent txt` -> stderr should have text, exit code must be `2`.
3. `file_filter.sh test_dir pdf` -> stdout should say no files found, exit code must be `3`.
4. `file_filter.sh test_dir txt` -> stdout must list `file1.txt` and `file2.txt`, exit code must be `0`.
