# Python quality workflow

Use this reference for a new Python service or when an existing service has Python tools but no coherent local and CI gate. Existing repository commands and framework conventions take precedence.

## Baseline

- Manage dependencies with `uv` and commit `pyproject.toml` plus `uv.lock`.
- Put development tools in the `dev` dependency group. Default to Ruff and pytest; add `pytest-cov` when coverage reporting is useful. Add `ty` when typed application boundaries or non-trivial backend logic justify static checking.
- Keep Ruff, pytest, coverage and type-checker settings in `pyproject.toml` where supported. Point coverage at application packages rather than the repository root.
- Provide one `verify` command that fails if any applicable lint, format, type, test or required integration check fails. Use an existing task runner when present; otherwise keep the wrapper small and direct.

Typical locked commands are:

```text
uv run --locked ruff check .
uv run --locked ruff format --check .
uv run --locked ty check
uv run --locked pytest
```

Omit a command only when its tool or test layer is intentionally not part of the project. Avoid duplicating CLI flags already held in `pyproject.toml`.

## Fast commit hooks

Use pre-commit only when hooks are appropriate for the repository. Keep it to deterministic, fast feedback. This local-hook form uses the versions already captured by `uv.lock`:

```yaml
repos:
  - repo: local
    hooks:
      - id: ruff-check
        name: ruff check
        entry: uv run --locked ruff check --fix
        language: system
        types_or: [python, pyi]
      - id: ruff-format
        name: ruff format
        entry: uv run --locked ruff format
        language: system
        types_or: [python, pyi]
```

Add pre-commit to the development group, install the hook with `uv run pre-commit install`, and verify it with `uv run pre-commit run --all-files`. Re-stage files changed by an auto-fixing hook and inspect the resulting diff. Do not put slow integration, browser or deployment checks in this hook by default.

## CI gate

CI checks out the exact revision, installs `uv` using Astral's current pinned action revision, syncs with `uv sync --locked`, and runs the repository's `verify` command. Pin third-party actions to immutable revisions when the repository's policy permits it. Keep the command the same locally and in CI rather than maintaining a second list of checks.

Retain useful failure output. Browser suites retain traces or screenshots when they fail; backend integration suites report which isolated service or database they exercised. A skipped required test or absent test directory must fail the aggregate gate rather than silently passing.

## Test selection

Map tests to observable acceptance criteria. Prefer fast domain and use-case tests, then add adapter/API integration tests at real boundaries and one full journey when frontend and backend form the deliverable. Mock external systems in isolated tests, but keep required persistence and policy behaviour covered against an isolated real service.

Do not impose an arbitrary coverage percentage. If a project adopts a threshold, choose it from the behaviour and risk that the suite is expected to cover, and exclude generated code and tooling from the measured application source.

The initial pattern was informed by [Brownsey/lendable](https://github.com/Brownsey/lendable): retain its useful central `pyproject.toml`, `uv.lock` and cross-platform task entry point while closing the observed gaps around tests, format checking, pinned type checking and CI.

Sources: [uv projects and lockfiles](https://docs.astral.sh/uv/concepts/projects/sync/), [uv in GitHub Actions](https://docs.astral.sh/uv/guides/integration/github/), [Ruff pre-commit integration](https://docs.astral.sh/ruff/tutorial/), [ty installation](https://docs.astral.sh/ty/installation/).
