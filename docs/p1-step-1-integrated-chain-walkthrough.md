# P1 Step 1: Integrated Chain Walkthrough

## Purpose

This document dissects `60-integrated-vco-chain.cir`.

Its job is to make the current main reference study understandable enough that it can serve as:

- the current simulation truth
- the future bench expectation source
- the bridge into detailed `KiCad` capture

## Why `60` Matters

`60-integrated-vco-chain.cir` is the first study in which the major `P1` vocabulary finally lives together:

- `CV_IN`
- `TUNE_SUM`
- `EXPO_OUT`
- `RAMP_NODE`
- `THRESHOLD_NODE`
- `RESET_CTRL`
- `SAW_OUT`
- `PULSE_OUT`

Earlier studies teach isolated lessons.
`60` is where those lessons become an oscillator chain.

## Functional Blocks Inside `60`

### 1. Control Voltage And Tuning Inputs

This block defines the front door of the oscillator:

- incoming control voltage
- coarse offset
- fine offset
- the summed tuning control

In the current behavioral chain, this block is intentionally simple.
That is good.
It keeps the study focused on the oscillator path instead of premature front-panel complexity.

### 2. Behavioral Expo Conversion

This block turns `TUNE_SUM` into an exponential current-like behavior.

Current role:

- prove octave-law movement
- make control sweeps readable
- expose temperature bending clearly

Current limitation:

- it teaches transfer behavior, not yet discrete transistor truth

### 3. Current Integration

This block is the time-domain heart of the oscillator.

The current charges the timing capacitor and creates the ramp at `RAMP_NODE`.

This is where pitch becomes slope.

Questions answered here:

- how fast does the ramp rise
- how does current map into repetition rate
- what ramp range exists before reset

### 4. Threshold Formation

This block converts ramp position into a threshold event.

In the current chain, it is still partly behavioral, which is acceptable for the present study round.

Its job is to answer:

- where does reset happen
- how much threshold window is needed
- how much sync injection perturbs the decision

### 5. Comparator And Reset Drive

This block produces `RESET_CTRL`.

The important conceptual separation is now explicit:

- the ramp is not the reset drive
- the threshold decision is not the reset discharge itself
- `RESET_CTRL` is a real control node

That separation is why the current chain is worth trusting more than `20`.

### 6. Reset Switch And Raw Outputs

This block discharges the ramp node and exposes raw outputs.

For the current `P1` round:

- `SAW_OUT` is basically the ramp seen as the musical raw output
- `PULSE_OUT` is derived from reset/comparator behavior

This is enough for bench expectations and sync experiments.

## How To Read `60`

Read it in this order:

1. find the control input definitions
2. find how `TUNE_SUM` is formed
3. find the expo behavior
4. find where current enters the ramp node
5. find how `THRESHOLD_NODE` is generated
6. find what drives `RESET_CTRL`
7. find where `SAW_OUT` and `PULSE_OUT` come from

If a future edit breaks that readability, the study has become too clever.

## What To Observe In `60`

The main observations are:

- nominal period at a known `CV`
- ramp low and high points
- whether reset is fast compared to oscillator period
- whether frequency changes monotonically with `CV`
- whether `PULSE_OUT` remains clean when the core is stressed

Current result set already gives us this reference behavior:

- near `1.0 kHz` around `0 V CV`
- roughly `489 Hz` at `-1 V`
- roughly `4021 Hz` at `+2 V`
- ramp roughly `0.52 V` to `1.02 V`

That is enough to treat `60` as a real reference platform.

## What `60` Is Good For

Use `60` to:

- decide bench test points
- decide whether later transistor-level blocks still preserve top-level behavior
- compare free-running and sync-injected behavior against a common reference

Use `60` as the answer to:

- what should the oscillator broadly do

Do not use `60` as the answer to:

- which exact transistor pair to buy
- what exact comparator device is final
- whether thermal compensation is solved

## Current Weaknesses In `60`

The current chain is still mixed-level.

That means:

- the expo law is educationally useful but not yet discrete
- the threshold and reset path are structurally meaningful but not yet device-faithful
- the reference system is implied, not fully modeled as hardware

Those are not bugs.
They are the deliberate edge of the current round.

## Exit Condition For Step 1

Step 1 is complete when:

- anyone reading `60` can explain the full signal path
- bench test points map naturally from the study
- later transistor-level replacements can be judged against this chain

That is the purpose of `60`.
