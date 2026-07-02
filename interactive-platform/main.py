#!/usr/bin/env python3
"""
Interactive Web Platform for RHCSA EX200 Labs (Gold Version)

Run with:
  uvicorn main:app --host 0.0.0.0 --port 8080
"""

from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse, JSONResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
import markdown
import re
import os
import subprocess
from pathlib import Path
from typing import Dict, List

app = FastAPI(title="EX200 Interactive Guide")

BASE_LABS = Path("/labs")

# Simple in-memory progress (in real use, use file or redis)
progress: Dict[str, int] = {}

def get_lab_dir(lab: str) -> Path:
    for d in BASE_LABS.iterdir():
        if d.is_dir() and d.name.startswith(lab + "-"):
            return d
    raise FileNotFoundError(f"Lab {lab} not found")

def parse_tasks(instructions_path: Path) -> List[Dict]:
    """Parse numbered tasks from instructions.md"""
    text = instructions_path.read_text(encoding="utf-8")
    tasks = []
    # Match patterns like "1. **Title**:" or "## 1. Title"
    pattern = re.compile(r'^(?:\d+\.\s*\*\*|##\s*\d+\.\s*)(.+?)(?:\*\*:|$)')
    lines = text.split('\n')
    current_title = None
    current_body = []
    
    for line in lines:
        stripped = line.strip()
        m = pattern.match(stripped)
        if m:
            if current_title:
                tasks.append({
                    "num": len(tasks) + 1,
                    "title": current_title,
                    "body": "\n".join(current_body).strip()
                })
            current_title = m.group(1).strip("* ").strip()
            current_body = []
        elif current_title and not stripped.startswith(("##", "1.", "2.", "3.", "4.", "5.", "6.", "7.", "8.", "9.", "0.")):
            current_body.append(line)
    
    if current_title:
        tasks.append({
            "num": len(tasks) + 1,
            "title": current_title,
            "body": "\n".join(current_body).strip()
        })
    
    return tasks

def parse_hints(hints_path: Path) -> Dict[int, List[str]]:
    """Parse hints by task number"""
    if not hints_path.exists():
        return {}
    text = hints_path.read_text(encoding="utf-8")
    hints = {}
    current_num = None
    current_hints = []
    
    for line in text.split('\n'):
        stripped = line.strip()
        m = re.match(r'^##\s*(\d+)\.', stripped)
        if m:
            if current_num:
                hints[current_num] = current_hints
            current_num = int(m.group(1))
            current_hints = []
        elif current_num and stripped and not stripped.startswith('##'):
            current_hints.append(stripped)
    
    if current_num:
        hints[current_num] = current_hints
    return hints

@app.get("/", response_class=HTMLResponse)
async def home(request: Request, lab: str = "01"):
    try:
        lab_dir = get_lab_dir(lab)
    except FileNotFoundError:
        return HTMLResponse("<h1>Lab not found</h1>")
    
    instructions = lab_dir / "instructions.md"
    tasks = parse_tasks(instructions) if instructions.exists() else []
    
    return templates.TemplateResponse("index.html", {
        "request": request,
        "lab": lab,
        "lab_name": lab_dir.name,
        "tasks": tasks,
        "current_step": progress.get(lab, 1),
        "ttyd_url": "http://localhost:7681"
    })

@app.get("/api/tasks/{lab}")
async def get_tasks(lab: str):
    try:
        lab_dir = get_lab_dir(lab)
        instructions = lab_dir / "instructions.md"
        tasks = parse_tasks(instructions) if instructions.exists() else []
        return {"tasks": tasks}
    except Exception as e:
        return {"error": str(e)}

@app.get("/api/hint/{lab}/{task_num}")
async def get_hint(lab: str, task_num: int, level: int = 1):
    try:
        lab_dir = get_lab_dir(lab)
        hints_path = lab_dir / "hints.md"
        all_hints = parse_hints(hints_path)
        task_hints = all_hints.get(task_num, [])
        
        if level <= 0:
            level = 1
        hints_to_show = task_hints[:level]
        
        return {
            "task": task_num,
            "level": level,
            "hints": hints_to_show,
            "has_more": level < len(task_hints)
        }
    except Exception as e:
        return {"error": str(e)}

@app.post("/api/check/{lab}/{task_num}")
async def check_step(lab: str, task_num: int):
    try:
        lab_dir = get_lab_dir(lab)
        verify_script = lab_dir / "verify.sh"
        
        if not verify_script.exists():
            return {"success": False, "message": "No verify.sh found"}
        
        # Run verify with task filter if supported
        result = subprocess.run(
            ["bash", str(verify_script), "--task", str(task_num)],
            cwd=lab_dir,
            capture_output=True,
            text=True,
            timeout=30
        )
        
        output = result.stdout + result.stderr
        success = result.returncode == 0
        
        # Simple heuristic: if no "FAILED" for this task
        if "FAILED" in output and f"Task {task_num}" in output or "Permisos" in output:
            # More precise check can be added
            pass
        
        return {
            "success": success,
            "output": output[-2000:],  # last 2000 chars
            "task": task_num
        }
    except subprocess.TimeoutExpired:
        return {"success": False, "message": "Verification timed out"}
    except Exception as e:
        return {"success": False, "message": str(e)}

@app.get("/api/progress/{lab}")
async def get_progress(lab: str):
    return {"current_step": progress.get(lab, 1)}

@app.post("/api/progress/{lab}/{step}")
async def set_progress(lab: str, step: int):
    progress[lab] = step
    return {"current_step": step}

# Mount static if needed
# app.mount("/static", StaticFiles(directory="static"), name="static")

# Templates
templates = Jinja2Templates(directory="templates")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8080)