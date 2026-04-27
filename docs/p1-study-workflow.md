# P1 Study Workflow

## Purpose

This document turns the larger `KiCad + ngspice` research into a concrete working method for `P1`.

`P1` is not a race to a full oscillator board.
It is a staged study:

1. prove the mechanism
2. name the interfaces
3. record expected behavior
4. build only when the study has taught something real

## Core Rule

For `P1`, every block must pass through three states:

1. `study`
2. `capture`
3. `bench`

Do not skip directly from a vague idea to solder.
Do not promote a block into `KiCad` just because we want it to look official.

## Stage Definitions

### Study

This is the `raw ngspice` phase.

Use this phase when:

- one mechanism is still unclear
- the circuit is still idealized
- we are testing slope, threshold, leakage, reset timing, or thermal effects
- parameter sweeps matter more than visual schematic polish

Expected artifacts:

- `.cir` netlists
- `.log` outputs
- `.csv` exports
- a short note saying what the study was trying to prove

Exit condition:

- the mechanism is understood well enough to describe in plain language
- the important internal nodes are known
- the likely failure modes are known

### Capture

This is the `KiCad` phase.

Use this phase when:

- the study block has stabilized
- the public interfaces are known
- test points and trims can be named intentionally
- we want the simulation-facing diagram to start becoming hardware-facing structure

Expected artifacts:

- top-level block diagram
- sheet structure
- stable interface vocabulary
- test point plan
- trim plan

Important:

At this stage, `KiCad` is allowed to be a structured architecture skeleton.
It does not need to pretend to be a fully resolved component-level schematic before the mechanism is ready.

### Bench

This is the physical prototype phase.

Use this phase when:

- the mechanism has already been proven in study form
- there is a defined expected behavior sheet
- there are named test points to probe
- we know what "success" means before power is applied

Expected artifacts:

- build notes
- scope captures
- frequency measurements
- trim notes
- drift observations
- photos if layout questions appear

## `P1` Recommended Order

The working order for `P1` is:

1. `00-rc-smoke`
2. `10-ramp-reset-core`
3. `20-threshold-reset-core`
4. `30-comparator-driven-reset-core`
5. `40-reset-sensitivity-core`
6. `50-standalone-expo-transfer`
7. `60-integrated-vco-chain`
8. `70-temp-drift-vco`
9. `80-sync-injection-vco`
10. `90-threshold-reset-realism`
11. `91-threshold-reset-window-sweep`
12. `100-threshold-reset-transistor-core`
13. `101-reset-transistor-sensitivity`

Only after that should the detailed component-level `KiCad` schematic become the main battlefield.

The current post-simulation reference docs are:

- `docs/p1-current-usage-guide.md`
- `docs/p1-step-1-integrated-chain-walkthrough.md`
- `docs/p1-step-2-model-boundary.md`
- `docs/p1-step-3-threshold-reset-capture.md`

## Naming Contract

The following names are locked for `P1` and must stay consistent across:

- `ngspice` netlists
- `KiCad` sheets
- bench notes
- scope screenshots
- expected behavior sheets

Locked names:

- `CV_IN`
- `COARSE_TUNE`
- `FINE_TUNE`
- `SYNC_IN`
- `REFERENCE`
- `TUNE_SUM`
- `EXPO_OUT`
- `RAMP_NODE`
- `THRESHOLD_NODE`
- `RESET_CTRL`
- `SAW_OUT`
- `PULSE_OUT`

Test point names should map directly:

- `TP_REF`
- `TP_TUNE_SUM`
- `TP_EXPO_OUT`
- `TP_RAMP`
- `TP_THRESHOLD`
- `TP_RESET_CTRL`
- `TP_SAW`
- `TP_PULSE`

## What Must Be Logged For Every Study

Each nontrivial study should record:

- purpose
- circuit assumptions
- analysis type used
- parameters swept
- expected result
- actual result
- what changed next

If we do not write that down, we will repeat the same confusion later.

## What Must Be Measured On The Bench

For the first real oscillator path, the minimum recurring measurements are:

- rail voltage
- reference voltage
- `RAMP_NODE` amplitude
- reset timing shape
- output amplitude
- frequency at fixed control settings
- warm-up drift over time

## Promotion Gate

A `P1` block is ready to move forward only when:

- it has a clean conceptual purpose
- it has stable names
- it has defined test points
- it has a written expected behavior
- it has a known failure checklist

That is the standard from now on.
