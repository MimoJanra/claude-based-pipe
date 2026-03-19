# Run-Based Multi-Agent Execution Pipeline

A Claude Code plugin that enforces structured task delivery: **plan first, execute step by step, review every step, keep an immutable audit trail.**

Every task becomes a **run** — an isolated directory with its own plan, progress log, review, and metadata. Nothing executes without a confirmed plan. Nothing is overwritten. Every run is permanent.

```
artifacts/
  runs/
    run-2026-03-19-001/
      plan.md        ← Planner writes this, waits for your OK
      progress.md    ← Developer logs what was done
      review.md      ← Reviewer validates against the plan
      logs.md        ← All events
      meta.json      ← Run status and timestamps
  index.json         ← History of all runs
  memory.md          ← Stable insights that carry across runs
```

**Three roles, strict separation:**
- **Planner** — creates the plan, controls step flow, marks steps COMPLETED
- **Developer** — implements each step, does NOT approve own work
- **Reviewer** — validates against the plan, can reject back to Developer

---

## Install

### Option 1 — tell Claude Code (recommended)

Open a Claude Code session and say:

```
Install this plugin: https://github.com/Glawk/run-based-pipeline
```

Claude will edit your `~/.claude/settings.json` automatically.

### Option 2 — manual

Add to `~/.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "run-based-pipeline": {
      "source": {
        "source": "github",
        "repo": "Glawk/run-based-pipeline"
      },
      "autoUpdate": true
    }
  },
  "enabledPlugins": {
    "run-based-pipeline@run-based-pipeline": true
  }
}
```

Restart Claude Code.

---

## Usage

Just give Claude a task:

```
Build a REST API in Go
```

Claude will:
1. Create `artifacts/runs/run-YYYY-MM-DD-001/`
2. Write `plan.md` with all steps as `PENDING`
3. **Stop and wait for your confirmation**
4. After you confirm — execute step by step through the full loop
5. Update `artifacts/index.json` on completion

The skill triggers automatically when you say **implement**, **build**, **create**, **plan**, or mention **runs / artifacts / pipeline / audit trail**.

---

## Commands

| Command | Description |
|---|---|
| `/pipe <task>` | Start a new run for the given task |
| `/pipe resume <run-id>` | Resume an existing run by its ID |

---

## Step statuses

```
PENDING → IN_PROGRESS → IN_REVIEW → COMPLETED
                              ↓
                    CHANGES_REQUESTED → IN_PROGRESS
```
