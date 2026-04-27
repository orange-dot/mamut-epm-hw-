# Simulation Playbook

## Purpose

This document records the current simulation tooling playbook for `Mamut` on Linux.

The goal is not to find one magical simulator for everything.
The goal is to choose a practical default workflow and keep the more advanced tools in reserve until they are actually needed.

## Current Tooling Decision

The current recommended stack is:

- `KiCad + ngspice` as the main workbench
- raw `ngspice` in the terminal for deeper sweeps and experiments
- `Qucs-S` only if its GUI turns out to be more comfortable for a specific task
- `Xyce` later, if we run into especially heavy nonlinear problems or large simulation workloads
- `OpenVAF` later, if we want custom models or more advanced behavioral modeling through `Verilog-A`

This is the playbook unless a later prototype proves that it is too limited.

## Workflow Split

The current best-practice split is:

- `raw ngspice` first for mechanism studies
- `KiCad + ngspice` second for stable block capture
- bench work third, only after the study has taught something concrete

This means we do not force every early idea into a `KiCad` schematic too soon.
For `P1`, the mechanism learning happens first in text netlists and controlled studies.

## Why This Stack

### KiCad + ngspice

This is the default.

Reasons:

- schematic capture and simulation stay close together
- the same schematic can later feed PCB work
- the workflow is Linux-native
- it is good enough for most first-pass analog synth studies

This is the main design desk for the project.

Important clarification:

- use `KiCad` once the block interfaces are stable
- do not use `KiCad` as camouflage for still-unclear circuit behavior

### Raw ngspice

This is the deeper lab bench.

Reasons:

- better for scripted sweeps
- better for repeated experiments
- easier to automate and version
- useful when GUI flow gets in the way

This is where we go when we want to push harder on one circuit question.

For `P1`, this is where the real mechanism work starts:

- ramp studies
- threshold studies
- leakage studies
- reset behavior
- temperature and sensitivity work later

### Qucs-S

This is optional, not primary.

Reasons:

- it can be friendlier for some schematic and simulation tasks
- it can still use established simulator backends

We use it only if it genuinely helps, not because we want yet another tool by default.

### Xyce

This is the heavyweight reserve option.

Reasons:

- useful for more demanding nonlinear simulation work
- useful when scale or solver behavior becomes a problem

This is not the everyday tool for the first learning prototypes.

### OpenVAF

This is the advanced modeling path.

Reasons:

- useful for custom compact models
- useful for `Verilog-A` based behavioral blocks
- useful when the built-in model set stops being expressive enough

This is later-stage tooling, not day-one tooling.

## What Simulation Is Good For

Simulation is especially useful for:

- power supplies
- reference generation
- expo converter behavior
- oscillator core studies
- waveshaping blocks
- filter cells
- VCA behavior
- first-pass sync and crossmod experiments

This makes it ideal for the `P0`, `P1`, `P2`, and `P3` learning path.

## What Simulation Will Not Settle For Us

Simulation is not enough for:

- final thermal drift truth
- layout parasitics in messy real builds
- grounding mistakes
- bleed and interference surprises
- the final question of whether the sound feels huge, cheap, alive, or dead

The bench and the ear still decide those.

## Project Workflow Rule

The current workflow rule is:

1. simulate first when the circuit question is clear enough
2. capture in `KiCad` only when interfaces and test points are stable
3. breadboard or proto-board only when the simulation has taught something useful
4. measure and listen before declaring the simulation correct

This keeps the project from turning into either:

- pure simulation fantasy
- pure CAD theater
- or pure solder-first confusion

## Naming And Test Point Discipline

Simulation and hardware should share the same language.

For `P1`, the locked names are:

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

Every bench prototype should also reserve matching test points.

## Study Artifacts

Every meaningful study should leave behind:

- a netlist
- a log
- a CSV or equivalent exported data
- one short note explaining the purpose and outcome

That is the minimum record of learning.

## Current Recommendation For Mamut

For now:

- `KiCad + ngspice` is the default simulation environment
- terminal `ngspice` is the main experiment environment
- everything else is optional and later

That is the current playbook.
