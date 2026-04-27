# P1 Step 2: Behavioral vs Transistor-Level Boundary

## Purpose

This document locks the current recommendation for what should remain behavioral and what should move toward transistor-level implementation next.

The point is not purity for its own sake.
The point is to spend learning effort where it teaches the actual oscillator.

## Core Principle

Keep the harness behavioral.
Move the oscillator physics toward transistor-level.

That means the next transistor-level effort should land on the blocks that define:

- pitch law in hardware
- ramp formation
- threshold decision
- reset discharge

## What Should Stay Behavioral For Now

These elements should remain behavioral or idealized in the near term:

- simulation stimulus sources for `CV_IN`
- coarse and fine input placeholders
- summary measurement helpers
- sync source waveforms used only as test stimuli
- some temporary output sense helpers

Why:

- they are not where the main oscillator learning lives
- they are scaffolding for studies
- replacing them too early adds complexity without teaching the core

## What Should Move Toward Transistor-Level Next

### 1. Threshold And Reset Path

This is the highest-value next transistor-level target.

Why first:

- the current `30/40` studies already stabilized the vocabulary
- reset behavior strongly shapes waveform range and period
- this block is central to both free-running behavior and future sync behavior

Expected learning:

- comparator realism
- hysteresis behavior
- discharge path speed
- interaction between threshold decision and actual reset current

### 2. Expo Converter

This is the second major transistor-level target.

Why next:

- the current behavioral expo has already taught the octave-law structure
- temperature sensitivity is already visible in `70`
- moving this block into transistor-level form now gives real tuning and drift insight

Expected learning:

- transistor pair behavior
- `Vbe` and thermal scaling
- tempco strategy
- offset and scale trim interactions

### 3. Current Integrator

This should move with or just after the expo conversion, depending on how the chosen topology couples them.

Why:

- it is physically simple in concept but central in timing
- a more realistic integrator exposes loading and reset recovery behavior

Expected learning:

- capacitor choice impact
- discharge recovery
- loading sensitivity
- current source realism

## What Should Not Yet Be Forced Into Transistor-Level

Not yet:

- complete power/reference circuitry inside the integrated chain
- full sync conditioning hardware
- output buffering polish
- triangle shaping
- panel circuitry

Those are important later, but they are not the highest-value next move for `P1`.

## Recommended Mixed-Level Transition Strategy

The healthiest next sequence is:

1. keep `60` as the behavioral reference truth
2. build a transistor-level threshold/reset replacement study
3. compare it against the `60` reference behavior
4. build a transistor-level expo study
5. compare it against the `50` and `70` reference behavior
6. reassemble an integrated mixed-level chain

This avoids losing the current clear reference while still deepening the learning path.

## Practical Rule

Behavioral blocks are allowed when they answer:

- stimulus
- bookkeeping
- measurement
- temporary scaffolding

Transistor-level blocks are required when they answer:

- the analog mechanism we actually want to learn
- the mechanism most likely to surprise us on the bench

For `P1`, those mechanisms are now clearly:

- expo conversion
- threshold decision
- reset discharge
- current integration

## Current Recommendation

The current recommendation for the next round is:

- keep `CV_IN`, coarse/fine sources, and sync pulse source behavioral
- replace threshold/reset first
- replace expo second
- keep `60` alive as the stable benchmark while those replacements happen

That keeps the project honest.
It also keeps the learning painful in the useful places instead of the boring ones.
