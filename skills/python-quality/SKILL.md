---
name: python-quality
description: Establish or repair Python project quality gates with uv, Ruff, pytest, optional type checking, fast commit hooks and CI. Use for new Python services or packages, or when existing Python lint, test and verification commands are missing or inconsistent; preserve a coherent established toolchain.
---

# Python quality

Inspect the repository before changing tools. Keep a coherent existing setup unless the user requests migration or a concrete gap prevents reliable verification.

For a new project or a project with incomplete gates, read [workflow.md](references/workflow.md). Adapt it to the application and its existing runner rather than copying every optional tool. Keep application commands, hook configuration and CI in the application repository.

Quality tooling supplies fast evidence. Define tests from observable requirements, keep external-boundary integration where it matters, and provide one aggregate verification command that fails on missing required checks.
