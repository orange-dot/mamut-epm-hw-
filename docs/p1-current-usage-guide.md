# P1 Current Usage Guide

## Purpose

This document explains how to use the current `P1` simulation chain as an everyday working tool.

The current `P1` state is not a finished oscillator design.
It is a decision laboratory.

Use it to answer questions like:

- does the reset loop behave cleanly
- does the expo transfer move in octave-like steps
- what bends with temperature
- where sync should enter the core
- which block is stable enough to promote into `KiCad`

## Current Authoritative Studies

The current practical entry points are:

- `30-comparator-driven-reset-core.cir`
- `50-standalone-expo-transfer.cir`
- `60-integrated-vco-chain.cir`
- `70-temp-drift-vco.cir`
- `80-sync-injection-vco.cir`
- `90-threshold-reset-realism.cir`
- `91-threshold-reset-window-sweep.cir`
- `100-threshold-reset-transistor-core.cir`
- `101-reset-transistor-sensitivity.cir`

Read them as a ladder:

1. `30` proves the self-running core
2. `50` proves the octave-law behavior in isolation
3. `60` closes the full control-to-waveform loop
4. `70` shows what temperature is already breaking
5. `80` shows the first useful sync hook
6. `90` locks a more realistic threshold/reset benchmark
7. `91` finds the first stable hysteresis pocket
8. `100` makes the reset/discharge path truly transistor-facing
9. `101` maps the first stable and failed transistor reset regions

## Daily Workflow

The normal working loop is:

1. pick one study
2. change one assumption
3. rerun the study
4. inspect the summary output
5. write one sentence into the study log
6. decide whether the block is still a study or ready for capture

Do not edit three studies at once.
Do not change five parameters at once unless the point is a sweep.

## Run Commands

Run from the repo root:

```bash
cd .

./tools/run-ngspice.sh sim/ngspice/p1-vco/30-comparator-driven-reset-core.cir
./tools/run-ngspice.sh sim/ngspice/p1-vco/50-standalone-expo-transfer.cir
./tools/run-ngspice.sh sim/ngspice/p1-vco/60-integrated-vco-chain.cir
./tools/run-ngspice.sh sim/ngspice/p1-vco/70-temp-drift-vco.cir
./tools/run-ngspice.sh sim/ngspice/p1-vco/80-sync-injection-vco.cir
./tools/run-ngspice.sh sim/ngspice/p1-vco/90-threshold-reset-realism.cir
./tools/run-ngspice.sh sim/ngspice/p1-vco/91-threshold-reset-window-sweep.cir
./tools/run-ngspice.sh sim/ngspice/p1-vco/100-threshold-reset-transistor-core.cir
./tools/run-ngspice.sh sim/ngspice/p1-vco/101-reset-transistor-sensitivity.cir
```

The helper writes logs next to the netlist.

## What To Read After A Run

The first file to read is usually not the raw `.log`.

Read these first:

- `40-reset-ron-summary.txt`
- `40-reset-roff-summary.txt`
- `40-reset-window-summary.txt`
- `50-standalone-expo-transfer.txt`
- `60-integrated-vco-chain-summary.txt`
- `70-temp-drift-summary.txt`
- `80-sync-injection-summary.txt`
- `90-threshold-reset-realism-summary.txt`
- `91-threshold-reset-window-sweep-summary.txt`
- `100-threshold-reset-transistor-core-summary.txt`
- `101-reset-transistor-sensitivity-summary.txt`

Read the `.log` when:

- a measurement failed
- a sweep did not write expected output
- the circuit did something physically strange

Read the `.csv` when:

- you want waveform shape
- you want to inspect startup
- you want to compare ramp amplitude, reset width, or sync effect visually

## What Each Study Is For

### `30-comparator-driven-reset-core`

Use `30` when the question is:

- is the reset loop topologically correct
- is the comparator/reset separation good enough
- is the ramp cycling cleanly

This is the simplest trustworthy self-running core in the current chain.

### `40-reset-sensitivity-core`

Use `40` when the question is:

- what matters more, `Ron`, leakage, or reset window
- where does the core stop behaving like a clean saw oscillator

This is where implementation detail becomes musical behavior.

### `50-standalone-expo-transfer`

Use `50` when the question is:

- does the octave law behave the way we think it does
- how do `CV`, coarse, and fine sum before the core
- what should `EXPO_OUT` look like before integration exists

This file should stay mentally separate from reset drama.

### `60-integrated-vco-chain`

Use `60` when the question is:

- does the whole loop make sense together
- what frequency should we expect at a given control voltage
- which nodes become bench test points later

This is the current main reference study.

### `70-temp-drift-vco`

Use `70` when the question is:

- what bends with temperature already
- is the drift mostly in expo scaling or elsewhere

Do not treat this as compensation yet.
Treat it as drift characterization.

### `80-sync-injection-vco`

Use `80` when the question is:

- where should sync enter the core
- does reset-oriented sync make sense for `P1`
- how badly does sync disturb nominal behavior

This is the first sync foothold, not the final `Baklja` answer.

### `90-threshold-reset-realism`

Use `90` when the question is:

- what does a more realistic threshold/reset block do before we commit to transistor-level reset
- what is the immediate benchmark for the next reset study

This is the reference right before transistor reset deepening.

### `91-threshold-reset-window-sweep`

Use `91` when the question is:

- which hysteresis region is stable enough to treat as the starting pocket
- which nominal reset-drive setting should be carried into the transistor reset study

### `100-threshold-reset-transistor-core`

Use `100` when the question is:

- how much does the real transistor reset path change timing and ramp depth
- what are the correct transistor-side observability nodes
- how should `90` be reinterpreted once the discharge path becomes more physical

### `101-reset-transistor-sensitivity`

Use `101` when the question is:

- which transistor reset settings still oscillate cleanly
- where is the first obviously failed reset region
- how strong does the base drive really need to be

## Editing Discipline

When changing a study:

- preserve the locked node names
- leave existing summary outputs intact unless the study meaning changes
- make one new numbered study instead of silently repurposing an old one
- keep comments honest about what is idealized

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

## Promotion Rule

Do not promote a block into real `KiCad` capture just because the netlist runs.

Promote a block only when:

- its purpose is clear
- its public interfaces are stable
- its test points are obvious
- its failure modes are known
- its expected bench behavior can be written down

For the current `P1` round, that means:

- `30` and `40` justify comparator/reset capture
- `50` informs expo capture but does not yet force transistor choice
- `60` is the bench-facing reference contract
- `90` and `91` justify the locked threshold/reset benchmark pocket
- `100` and `101` justify the first transistor reset design pocket

## Current Meaning Of Success

Success for this round is not:

- perfect tuning
- finished compensation
- final parts selection
- a fully detailed KiCad schematic

Success for this round is:

- a trustworthy self-running core
- a clear standalone expo law
- an integrated chain that behaves consistently
- a real transition path from SPICE study to hardware capture
