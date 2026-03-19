---
name: run-based-pipeline
description: |
  Use this skill when the user asks to execute a multi-step task, build a feature,
  implement a plan, or perform any structured work that requires planning, execution,
  and review. Trigger when users say things like "implement X", "build X", "create X",
  "do X step by step", or ask for a plan before coding. Apply this skill to manage
  Planner → Developer → Reviewer workflows with run-based artifact tracking and
  immutable history. Also use when users mention "runs", "artifacts", "pipeline",
  or "audit trail".
---

# Skill: Run-Based Multi-Agent Execution Pipeline

## Core Principle

Never execute without a plan.
Never overwrite artifacts.
Every execution is a new run.

---

## Artifact System

All work must be stored under:

artifacts/runs/<run-id>/

Each run must contain:

- plan.md
- progress.md
- review.md
- logs.md
- meta.json

Global files:

- artifacts/index.json
- artifacts/memory.md

---

## Run Initialization

Before any work:

1. Load artifacts/index.json
2. Generate new run-id:
   format: run-YYYY-MM-DD-XXX
3. Create directory:
   artifacts/runs/<run-id>/
4. Create all required files
5. Register run in index.json

---

## Immutability Rules

- NEVER overwrite previous runs
- NEVER modify past run files
- Only append or create new data
- Each run is immutable after completion

---

## Roles

### Planner

- Creates execution plan
- Writes plan.md
- Waits for confirmation
- Controls step flow
- Marks steps COMPLETED

### Developer

- Implements step
- Writes progress.md
- Does NOT approve own work

### Reviewer

- Validates against plan
- Writes review.md
- Can reject or approve

---

## Plan Structure

Each step must include:

- ID
- Status
- Owner
- Description
- Done criteria
- Reviewer notes

Statuses:

- PENDING
- IN_PROGRESS
- IN_REVIEW
- CHANGES_REQUESTED
- COMPLETED

---

## Workflow

### Phase 1 — Planning

1. Planner creates plan.md
2. All steps = PENDING
3. Ask user for confirmation
4. STOP

---

### Phase 2 — Execution Loop

For each step:

1. Planner:
   - set IN_PROGRESS
   - assign Developer

2. Developer:
   - implement step
   - update progress.md
   - set IN_REVIEW

3. Reviewer:
   - validate against plan

IF FAIL:
   - set CHANGES_REQUESTED
   - return to Developer

IF PASS:
   - Planner sets COMPLETED

Repeat.

---

### Phase 3 — Completion

1. Verify all steps COMPLETED
2. Update meta.json
3. Append summary to logs.md
4. Optionally update memory.md

---

## Memory Rules

- Use artifacts/memory.md
- Only store stable insights
- Append only
- Do not store temporary data

---

## Constraints

- No implementation before plan
- No skipping review
- No direct completion
- No plan drift without update

---

## Behavior

Act as a structured delivery system:
- deterministic
- auditable
- step-driven
- role-separated
