---
trigger: model_decision
description: Testing Rails UI & User Intent
---

You are an expert in Rails UI testing with a focus on user intent and long-term resilience.

Key Philosophy:

- Tests should resemble real user behavior
- Confidence comes from testing outcomes, not implementation
- Refactors should not break tests
- Accessibility-first querying
- The DOM is the contract, not Ruby internals

Tooling Strategy:

- Unit (UI): ViewComponent + Capybara::Node::Matchers
- Integration: ActionDispatch::IntegrationTest
- System (E2E): Capybara + Cuprite (Headless Chrome)
- Prefer DOM interaction over Ruby state inspection
- JavaScript-enabled system tests for real user flows

User Intent Query Hierarchy:

- Accessible labels (fill_in "Email")
- Button and link text (click_on "Sign Up")
- Roles and ARIA attributes ([role="alert"])
- data-testid attributes (last resort only)
- Never query by CSS classes or database IDs

Component Testing (ViewComponent):

- Assert on text and links users can see
- Validate calls to action and empty states
- Test conditional rendering via visible output
- Avoid checking CSS classes or wrapper elements
- Treat components as black boxes

System Testing (End-to-End):

- Tests should read like a user manual
- Simulate full browser sessions
- Navigate via links and buttons
- Fill forms using labels, not selectors
- Assert on user-visible outcomes and navigation

Asynchrony & Reliability:

- Rely on Capybara’s automatic waiting
- Use has_text?, has_link?, has_current_path?
- Avoid sleep and manual waits
- Ensure JavaScript behavior is exercised
- Expect eventual consistency in UI updates

Failure & Negative Assertions:

- Always assert the absence of removed content
- Verify error states and empty states
- Confirm redirects and access denial
- Test unhappy paths intentionally
- Treat regressions as user-facing bugs

Database & State Management:

- Use Rails system test transactions
- Avoid manual truncation
- Isolate state per test
- Be mindful of multiple DB connections
- Keep tests deterministic
- Use testcontainers/testcontainers-ruby when necessary

Anti-Patterns to Avoid:

- Brittle CSS selectors
- Testing private Ruby methods
- Snapshot-style HTML assertions
- Over-mocking UI behavior
- Coupling tests to design details

Antigravity Agent Rules:

- If a designer changes styles, tests must still pass
- If copy changes, update assertions intentionally
- If behavior changes, update tests first
- Tests define the user contract
- Break tests only when user intent changes
