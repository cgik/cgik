# Engineering Principles

## Primary Objective

Optimize for local reasoning.

A reader should be able to understand a unit of code from its name, signature, and implementation without tracing unrelated global state or hidden framework behavior.

---

## Structural Constraints

### 1. Dependencies Are Acyclic and Point Toward Policy

High-level rules must not depend directly on volatile implementation details.

When using layered architecture, outer mechanisms depend on inner policy. Inner layers do not import presentation, infrastructure, storage, transport, or framework-specific layers.

If inner policy needs an outward capability, define the required contract inward and implement it outward.

Do not introduce layers or interfaces when the project is too small to benefit from them.

### 2. Keep an Honest Core and an Effectful Shell

An honest function accesses the outside world only through its signature.

- Inputs arrive through parameters or explicitly passed state.
- Outputs leave through return values or clearly declared mutation.
- It does not secretly read or modify unrelated global state.

External effects include:

- Network and disk access
- User interfaces
- Hardware
- System time
- Randomness
- Environment variables
- Databases
- Processes
- Logging
- Mutable global state

Keep these effects at the highest practical level.

The preferred flow is:

1. Read external state.
2. Convert it into explicit values.
3. Pass those values into decision-making code.
4. Receive an explicit result.
5. Apply the result at the boundary.

### 3. Separate Decisions From Effects

Code that decides what should happen must be distinguishable from code that makes it happen.

Ask:

**Can the decision be tested without mocking a framework, network, database, clock, filesystem, or hardware?**

If not, consider extracting the decision from the effect.

### 4. Keep Framework Entry Points Thin

Callbacks, request handlers, commands, scheduled jobs, lifecycle hooks, and other framework-controlled entry points primarily connect external systems to application code.

Their preferred shape is:

1. Read or receive external input.
2. Convert it into explicit application data.
3. Call a clearly named operation.
4. Apply, persist, or transmit the result.

Move substantial rules out of framework-controlled functions.

### 5. One Owner per Piece of State

Exactly one component or subsystem is authoritative for each piece of mutable state.

Other representations must be identified as:

- Derived views
- Cached calculations
- Read-only snapshots
- Replicas
- Serialized representations

Avoid multiple systems that can independently decide the current value of the same state.

### 6. Make Important Seams Observable

Important asynchronous, distributed, or decoupled boundaries should expose enough information to diagnose:

- Failures
- State transitions
- Message flow
- Active configuration
- Retries and fallbacks
- Integration boundaries

Observability must be proportional.

Do not log every call or event when doing so creates noise, cost, or performance problems.

---

## Function Design

### 7. Write the Function You Wish Already Existed

Begin at the abstraction level of the problem being solved.

Write the call that would make the surrounding code clear, then determine how that function should be implemented.

Names should describe intent rather than implementation mechanics.

### 8. Design Functions for Local Reasoning

Functions are valuable for more than eliminating duplication.

Use functions to provide:

- Local reasoning
- Abstraction
- Testability
- Meaningful vocabulary
- Controlled mutation
- Reuse where reuse naturally occurs

Do not wait for code to be duplicated before considering whether it represents a meaningful operation.

### 9. Keep Each Function at One Level of Abstraction

Every line in a function body should describe work at approximately the same conceptual level.

A high-level function should compose named lower-level operations. It should not alternate between domain concepts and low-level implementation details.

If understanding one step requires mentally zooming in and then returning to the larger operation, that step probably deserves a named function, algorithm, or type.

Comments dividing a function into procedural sections are a warning sign that those sections may be separate operations.

### 10. Separate Producing Data From Acting on It

Prefer one operation that calculates or describes a result and another that performs the external effect.

Examples:

- Calculate a change, then persist it.
- Build a response, then transmit it.
- Select an action, then invoke it.
- Produce a plan, then execute it.

Apply this separation when it improves reasoning or testing.

Do not split trivial operations merely to satisfy the rule.

### 11. Make Signatures Honest and Empathetic

Design a signature for the person calling it.

The caller should be able to understand:

- What information is required
- What assumptions must already be true
- What may be modified
- What information will be returned
- What failures are possible
- Which external capabilities are required

Avoid:

- Unexplained boolean arguments
- Long lists of loosely related parameters
- Passing an entire object when only a few values are needed
- Requiring a concrete collection when only iteration is required
- Hidden reliance on call order
- Hidden singleton or global access
- Parameters that demand stronger guarantees than the function needs

Use parameter objects, named arguments, interfaces, or stronger types when they materially improve the call site.

### 12. Return Useful Information

Do not discard information the caller may reasonably need.

Prefer an explicit result type when a Boolean, null value, or exception would collapse meaningfully different outcomes.

Do not introduce elaborate result types when success and failure genuinely are the only relevant outcomes.

### 13. Use Types to Make Invalid States Harder to Express

When a value has an important invariant, consider representing that invariant with a dedicated type.

Use types to encode preconditions when doing so:

- Prevents a realistic mistake
- Improves the function contract
- Removes repeated validation
- Makes incorrect calls fail early

Apply this selectively.

Do not create wrapper types for every minor condition or attempt to encode every possible invariant into the type system.

### 14. Prefer Named Algorithms Over Non-Trivial Raw Loops

A loop is acceptable when its purpose is immediately obvious.

If its body performs meaningful domain work, extract that operation or use an appropriate existing algorithm.

Prefer a clear raw loop when alternatives obscure intent, allocate excessively, or introduce measurable performance costs.

### 15. Make Mutation Explicit and Controlled

Mutation is not inherently a defect.

A mutating function can remain honest when:

- The mutated state is passed explicitly.
- The caller clearly grants permission to modify it.
- The mutation is limited to that state.
- The resulting state is predictable from the inputs.

Avoid mutation through unrelated global state or hidden aliases.

---

## Engineering Heuristics

### 16. Verify Before Stating

Before stating a fact about an external API, system, dependency, version, tool, file, or URL, verify it when verification is available.

Confidence is not a substitute for evidence.

### 17. Check Existing Patterns First

Before adding a helper, abstraction, service, or pattern, search the codebase for an existing solution.

State what was searched for.

Prefer extending a coherent existing pattern over creating a competing one.

### 18. Prefer Self-Documenting Code

Naming and structure explain what the code does.

Comments explain:

- Why a decision exists
- Which constraint motivated it
- Why an apparently simpler alternative is unsafe
- Which non-obvious tradeoff was accepted

A comment that merely translates code into prose is a warning that the code may need clearer naming or extraction.

### 19. Prefer the Boring Version

Less code is useful, but clarity takes priority over cleverness.

If understanding a construct requires knowledge of a trick, prefer the longer and more obvious form.

### 20. Use a Proportionality Tripwire

If the supporting architecture is substantially larger or more difficult than the behavior it supports, stop and reconsider.

Do not introduce interfaces, factories, event buses, state machines, plugins, or configuration systems without a concrete source of variation or complexity that requires them.

### 21. Use Data-Driven Behavior Conditionally

Use configuration or data when:

- Variation is open-ended.
- Non-developers need to edit it.
- New cases should not require changing control flow.
- Behavior must vary between deployments or environments.

For a small number of stable, known cases, an explicit branch may be clearer.

### 22. Optimize From Evidence

Do not sacrifice correctness or clarity for speculative optimization.

When profiling, measurements, or known operational constraints identify a problem, use the simplest design that meets the demonstrated requirement.

### 23. Ask or Assume Explicitly

If an ambiguity would materially change the resulting behavior or architecture, ask before proceeding.

Otherwise, state the reasonable assumption and continue.

### 24. Prefer Incremental Improvement

Existing project conventions matter.

Do not perform a broad architectural rewrite merely to enforce these principles.

Improve boundaries incrementally unless a larger refactor is explicitly requested.

---

## LLM Working Behavior

When assisting with engineering work:

1. Establish the relevant context before proposing structural changes.
2. Inspect existing conventions before introducing new ones.
3. Explain the responsibility or dependency problem before suggesting a pattern.
4. Prefer the smallest coherent change that improves the design.
5. Distinguish observed facts from assumptions and recommendations.
6. State important tradeoffs and rejected alternatives.
7. Do not introduce abstractions solely because they are considered best practices.
8. When teaching, explain the mental model before providing a complete implementation.
9. Do not create or modify files unless the user has requested implementation.
10. Flag deviations from these principles explicitly.

---

## Clauses

### Scaling Clause

These principles always influence the design, but their ceremony scales with the problem.

A boundary may be two functions in one file rather than separate packages, services, or interface hierarchies.

### Consistency Clause

Existing architecture and conventions are part of the design context.

Prefer gradual alignment over unnecessary rewrites.

### Performance Clause

Evidence-based constraints may justify lower-level or less abstract code.

Keep that code isolated, clearly named, and documented with the reason it exists.

### Deviation Clause

Any principle may be broken when it genuinely does not fit.

The deviation, reason, and resulting tradeoff must be stated explicitly rather than introduced silently.
