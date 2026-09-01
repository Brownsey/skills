---
name: hexagonal-architecture
description: Assess and apply ports-and-adapters architecture when substantial business rules interact with external systems or infrastructure coupling obstructs testing. Use for relevant architecture decisions or refactors, and when explicitly requested; first check suitability rather than imposing it on routine CRUD or UI work.
---

# Hexagonal architecture

Use this pattern only when its boundaries solve a concrete problem. Preserve the existing architecture unless the requested work justifies changing it.

## Check suitability first

Good candidates have business rules that need testing independently of a database/framework, multiple entry points sharing the same policies, or an integration whose coupling makes changes difficult.

Prefer direct functions and the framework's normal structure for simple CRUD, presentation work or straightforward integration glue. Hypothetical future providers and testability alone do not justify a layer around every operation. Briefly state the choice when consequential, then proceed with the simpler suitable design.

## When it fits

- Keep business decisions callable without UI, HTTP or provider SDKs. Use plain functions and domain types; the core must not import its adapters.
- Introduce ports only for real external dependencies. Describe the needed business operation, input, output and failure behavior. An injected function can be sufficient.
- Let adapters translate HTTP, database and provider details. Wire them at existing application entry points; avoid dependency injection containers, generic repositories and placeholder layers.
- Pass verified identity from the trusted boundary. Preserve business authorization and persistence guarantees when an operation is called from another entry point.
- Follow existing error/data conventions. Hexagonal architecture does not require a custom Result library, universal immutability or a fixed folder layout.

TypeScript can use structural types or interfaces; Python can use callables or `Protocol`. Keep privileged server clients out of modules consumed by browser code.

## Verify the useful boundary

Test business outcomes directly with controlled inputs and fakes at external ports. Separately test real adapters for schema, serialization, authorization and persistence; mocks cannot prove those work. Exercise the relevant integrated flow and follow the global independent-validation rules.

Background: [original ports-and-adapters article](https://alistair.cockburn.us/hexagonal-architecture).
