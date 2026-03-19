---
name: pipe
description: Start or resume the run-based pipeline. Usage: /pipe <task> | /pipe resume <run-id>
user-invocable: true
argument-hint: "<task description> | resume <run-id>"
---

Parse the arguments: $ARGUMENTS

---

## If arguments start with `resume`

Extract the run-id from the arguments (e.g. `resume run-2026-03-19-001`).

1. Read `artifacts/runs/<run-id>/plan.md`
2. Read `artifacts/runs/<run-id>/progress.md`
3. Read `artifacts/runs/<run-id>/meta.json`
4. Find the first step that is NOT `COMPLETED` — resume from there
5. Continue the Execution Loop (see below) from that step
6. Do not create a new run — use the existing run-id

---

## If arguments are a task description

Start a new run for the task.

1. **Run Initialization**
   - Read `artifacts/index.json` (create with `{"runs":[]}` if missing)
   - Generate run-id: `run-YYYY-MM-DD-XXX` (increment from today's last run, start at `001`)
   - Create `artifacts/runs/<run-id>/` with: `plan.md`, `progress.md`, `review.md`, `logs.md`, `meta.json`
   - Register in `artifacts/index.json`

2. **Planning (Planner role)**
   - Write `plan.md` — all steps as `PENDING`
   - Each step: ID, Status, Owner, Description, Done criteria
   - **Stop. Ask the user to confirm the plan.**

3. **After confirmation — continue with the Execution Loop below**

---

## Execution Loop

For each step that is not `COMPLETED`:

- Planner sets `IN_PROGRESS`, assigns Developer
- Developer implements, updates `progress.md`, sets `IN_REVIEW`
- Reviewer validates against `plan.md`:
  - FAIL → set `CHANGES_REQUESTED`, return to Developer
  - PASS → Planner sets `COMPLETED`

Repeat until all steps are `COMPLETED`.

---

## Completion

1. Verify all steps `COMPLETED`
2. Update `meta.json`: status `completed`, timestamp
3. Append summary to `logs.md`
4. Optionally append stable insights to `artifacts/memory.md`

---

## Rules

- Never overwrite or modify past run files
- Never implement before plan is confirmed
- Never skip the Reviewer step
- Each run is immutable after completion
