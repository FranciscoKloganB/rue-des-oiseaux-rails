---
trigger: model_decision
description: Testing Rails Backend & Business Logic
---

You are an expert in Ruby on Rails backend testing with a focus on correctness, isolation, and long-term maintainability.

Key Philosophy:

- Test behavior, not implementation details
- Favor fast, deterministic tests
- Isolate business logic from frameworks when possible
- Failures should point directly to broken intent
- Backend tests define the domain contract

Testing Scope & Boundaries:

- Unit tests validate pure business logic
- Integration tests validate collaboration between objects
- Avoid testing Rails internals
- Minimize reliance on the database unless required
- Each test level has a clear responsibility

Service Objects:

- Test public interfaces only
- One responsibility per service
- Inputs in, outcomes out
- Assert on return values and side effects
- Avoid stubbing the object under test

Service Object Structure:

- Initialize with explicit dependencies
- Expose a single `call` (or equivalent) method
- Return result objects or well-defined outcomes
- Raise domain-specific errors intentionally
- Avoid hidden global state

Service Object Testing:

- Validate success and failure paths
- Assert state changes in the database (when applicable)
- Verify emitted events or enqueued jobs
- Avoid mocking ActiveRecord excessively
- Use real models when logic depends on validations

Repositories / Query Objects:

- Encapsulate complex queries
- Return domain-relevant data structures
- Avoid leaking ActiveRecord relations when possible
- Keep query logic out of models and controllers
- Treat repositories as read-only collaborators

Repository Testing:

- Use real database records
- Assert on returned data, not SQL
- Test edge cases (empty results, ordering, limits)
- Verify filtering and scoping behavior
- Avoid testing private query methods

Domain Logic & POROs:

- Prefer plain Ruby objects for business rules
- No Rails dependencies unless necessary
- Fast unit tests with no I/O
- Deterministic inputs and outputs
- Ideal candidates for table-driven tests

Result Objects & Errors:

- Standardize success and failure responses
- Avoid boolean returns with hidden meaning
- Test explicit error types and messages
- Prefer objects over hashes
- Make failures impossible to ignore

Background Jobs:

- Assert jobs are enqueued, not performed
- Validate job arguments
- Test job behavior in isolation
- Avoid time-based flakiness
- Keep jobs thin; logic lives elsewhere

External Dependencies:

- Stub network calls at the boundary
- Use VCR or WebMock consistently
- Test adapters, not third-party behavior
- Assert on request intent and response handling
- Never hit real external services in test

Database Interaction:

- Use transactions for test isolation
- Prefer factories with explicit traits
- Avoid excessive `before` blocks
- Keep fixtures minimal or avoid them
- Test constraints and validations intentionally

Performance & Safety:

- Avoid N+1 queries in core flows
- Use `bullet` in development/test
- Assert query counts only when critical
- Guard against race conditions
- Test idempotency where required

Anti-Patterns to Avoid:

- Testing private methods
- Excessive mocking of ActiveRecord
- Overlapping test responsibilities
- God services with many branches
- Implicit dependencies and hidden state

Antigravity Backend Agent Rules:

- If logic changes, tests must fail meaningfully
- If tests are hard to read, they are wrong
- Business rules belong in tests
- Refactors should improve clarity, not coverage hacks
- Tests are executable documentation
