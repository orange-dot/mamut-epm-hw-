# P1 Oscillator Skeleton Spec

## Purpose

This document locks the schematic-ready skeleton for the `P1` oscillator work.

It does not yet choose every transistor and resistor.
It does choose the required structure, interfaces, trims, and observation points so later detailed capture does not drift.

## Locked Block Order

The locked `P1` order is:

1. `CV_IN`
2. `COARSE_TUNE` and `FINE_TUNE`
3. `EXPO CONVERTER`
4. `CURRENT INTEGRATOR`
5. `THRESHOLD COMPARATOR`
6. `RESET / OUTPUT`

With support blocks for:

- `POWER / REFERENCE`
- `TRIM / TEST`

## Required Interfaces

External-facing interfaces:

- `CV_IN`
- `COARSE_TUNE`
- `FINE_TUNE`
- `SYNC_IN`
- `SAW_OUT`
- `PULSE_OUT`

Locked internal interfaces:

- `REFERENCE`
- `TUNE_SUM`
- `EXPO_OUT`
- `RAMP_NODE`
- `THRESHOLD_NODE`
- `RESET_CTRL`

These names are now the project vocabulary for the first oscillator.

## Required Rails

The first oscillator skeleton reserves:

- `+12V`
- `-12V`
- `AGND`
- `REFERENCE`

For this sprint, `REFERENCE` is the only support net that must be visibly distributed in the block diagram.
The rail names stay locked now so later detailed sheets and bench notes use the same language, and the current `KiCad` capture now uses the standard global `+12V` / `-12V` form directly.

## Required Trims

Minimum trim set for later detailed capture:

- `OFFSET_TRIM` for base pitch placement
- `SCALE_TRIM` for `1 V/oct` scaling
- `HF_TRIM` reserved for high-frequency tracking correction

`COARSE_TUNE` and `FINE_TUNE` are user controls, not calibration trims.

## Required Test Points

Minimum observation points:

- `TP_REF`
- `TP_TUNE_SUM`
- `TP_EXPO_OUT`
- `TP_RAMP`
- `TP_THRESHOLD`
- `TP_RESET_CTRL`
- `TP_SAW`
- `TP_PULSE`

These are required because `P1` is a learning prototype first.

## Required Outputs

Minimum raw outputs:

- `SAW_OUT`
- `PULSE_OUT`

`TRIANGLE_OUT` remains optional and later.
`LINEAR_FM` remains reserved and later.

## Non-Goals For This Sprint

This skeleton does not yet decide:

- the exact production matched-pair package and tempco BOM
- the exact comparator part
- the exact reset device
- sync conditioning details
- pulse shaping details beyond reserving `PULSE_OUT`

Those decisions come after the self-running core behavior is understood and measured.
