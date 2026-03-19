---
description: "Start or resume the run-based pipeline"
argument-hint: "<task description> | resume <run-id>"
---

Parse the arguments: $ARGUMENTS

If arguments start with `resume <run-id>` — invoke the `pipeline-planner` agent with instruction to resume that run-id.

Otherwise — invoke the `pipeline-planner` agent with the arguments as the task description to start a new run.
