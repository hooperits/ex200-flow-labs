# Lyrics ↔ Code Sync Process

**Purpose**: Ensure that any changes to educational content in this repo are properly reflected in the corresponding lyrics, Suno prompts, and recordings in the sibling repository `~/proys/RHCSA-EX200-lyrics/`. This maintains tight synchronization for video production while preserving the public educational focus.

**Core Rules** (from AGENTS.md):
- Changes have lyrics cost: Any modification to `demo.sh`, `instructions.md`, `verify.sh`, or related content requires planned re-examination and update of the corresponding lyrics (`.txt` files) and Suno prompts.
- Maintain 1:1 section alignment where possible between demo `clear_section` titles and lyric "ESTROFAS".
- All video/lyrics work happens outside this repo (in `RHCSA-EX200-lyrics/` and `hooperits8/`).
- Public files must remain 100% focused on RHCSA exam prep (no internal strategy mentions).

**When to Trigger This Process**:
- After any significant change to a lab's demo, instructions, verify, reset, or structure.
- When adding a new lab.
- Periodically (e.g., after a Phase milestone or re-audit).
- Before releases or video production sprints.

## Step-by-Step Process

1. **Make the Change in This Repo**
   - Follow the Roadmap Execution Cycle (see ROADMAP.md).
   - Prefer structural improvements.
   - Update relevant files (demo.sh, instructions.md, etc.).

2. **Apply Quality Gates**
   - Fill and document the Post-Task Educational Quality Checklist (from AGENTS.md).
   - Run `./verify.sh` and `./reset.sh` for the affected lab(s).
   - Test `demo.sh` (default mode and `--video`/`--fast`).

3. **Regenerate Skeletons & Prompts**
   - Run the generator for the affected module(s):
     ```bash
     ./scripts/generate-video-skeleton.sh labs/NN-xxx/demo.sh
     # or for all
     ./scripts/generate-video-skeleton.sh --all
     ```
   - Review the output:
     - `skeletons/NN-xxx.md` (ESTROFAS, timings, command list).
     - `skeletons/suno-prompts/NN-xxx.txt`.
   - Check `skeletons/MASTER-SERIES.md` if the change affects overall series structure.
   - Use `git diff` on the generated files to see impact.

4. **Verify Alignment**
   - Compare the generated ESTROFA titles and order against the corresponding lyrics file in the sibling repo:
     - `~/proys/RHCSA-EX200-lyrics/NN-xxx.txt`
   - Ensure:
     - Number of main ESTROFAS matches (or is intentionally updated).
     - Section order and grouping align with lyric structure (CORO / ESTROFA 1... / OUTRO).
     - Commands and explanations are up-to-date.
   - Update the alignment notes in `docs/educational-quality-audit.md` if needed.

5. **Commit in This Repo**
   - Use conventional commits referencing the checklist and sync:
     ```bash
     git commit -m 'chore(alignment): ... (checklist applied, lyrics sync required)'
     ```
   - Push if appropriate.

6. **Handoff to Lyrics Repo** (`~/proys/RHCSA-EX200-lyrics/`)
   - Re-examine the corresponding `.txt` lyrics file.
   - Adjust ESTROFAS to match the new/updated demo sections (timings, commands, phrasing).
   - Update phonetic/rap-friendly descriptions as needed.
   - Regenerate or edit the dedicated Suno prompt if the generator output changed significantly.
   - Update `suno_prompts.md` or master notes if present.
   - If demo recording needs refresh: use the `--video` mode from this repo to produce clean footage.

7. **Optional: Update Video Production Assets**
   - In `hooperits8/` or lyrics repo: regenerate YouTube descriptions, timestamps, or other metadata using the new skeletons.
   - Re-record and sync audio if the rap timing changed.

8. **Final Verification**
   - Re-run the generator and confirm skeletons/lyrics are in sync.
   - Update `docs/educational-quality-audit.md` with any alignment changes.
   - Run a full re-audit of the affected module against the 7 Quality Rules.
   - Update metrics in ROADMAP.md (e.g., "Lyrics alignment coverage per module").

9. **Document & Close**
   - Add an entry to the Execution Log in ROADMAP.md.
   - If this change triggers an Amendment Proposal, document it per the process.

## Tools & Artifacts

- **Primary Tool**: `scripts/generate-video-skeleton.sh` — produces the bridge between code and lyrics.
- **Checklists**:
  - Post-Task Educational Quality Checklist (AGENTS.md).
  - This sync process checklist.
- **Outputs**:
  - `skeletons/*.md` and `suno-prompts/*.txt` (this repo).
  - `*.txt` lyrics and Suno prompts (sibling repo).
- **References**:
  - `skeletons/MASTER-SERIES.md`
  - Per-lab `demo.sh` (use `clear_section` and `run_demo_cmd` for parsability).
  - `docs/educational-quality-audit.md`

## Example Workflow (After a Demo Change)

```bash
# In RHCSA-EX200
./scripts/generate-video-skeleton.sh labs/01-essential-tools/demo.sh
git diff skeletons/01-essential-tools.md
# Review alignment
git commit ...
```

Then switch to lyrics repo and update the matching `.txt`.

## Risks & Mitigations

- **Lyrics drift**: Mitigated by mandatory generator run + explicit handoff step.
- **Timing changes**: Use `--video` mode for accurate re-recording.
- **Public leakage**: Never commit lyrics-related notes to public files (README, instructions, etc.).

This process ensures the dual goals of educational quality and video production stay aligned.

*Version: 1.0 — Created as part of systematic roadmap execution (2026-06-30)*
