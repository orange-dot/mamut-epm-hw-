# P1 VCO Expected Behavior Sheet

## Purpose

This file is the bench-side contract for the first oscillator studies.

Before powering a build, fill in the exact expected values for the current revision.
After testing, update the observed values and note any mismatch.

## Current Revision

- revision: `sim-60-integrated-vco-chain`
- date: `2026-04-11`
- build type: `simulation reference`

## Threshold/Reset Realism Reference

There is now a second useful benchmark layer on top of the old `sim-60` reference:

- realism study: `sim-90-threshold-reset-realism`
- transistor reset study: `sim-100-threshold-reset-transistor-core`

Current realism-pass expectations:

- cycle window: about `0.788 V` to `0.981 V`
- nominal frequency: about `2.55 kHz`
- reset high level: about `4.86 V`
- threshold window: roughly `-0.10 V` to `+0.10 V`

Use this realism layer when benching the threshold/reset block itself.
Use the older `sim-60` layer when benching the broader integrated oscillator story.

Current transistor-reset expectations from `sim-100`:

- cycle window: about `0.864 V` to `0.981 V`
- nominal frequency: about `4.19 kHz`
- reset high level: about `4.86 V`
- base high level: about `0.776 V`
- collector low level: about `0.141 V`

Use this `sim-100` layer when the bench question is specifically about the reset transistor and discharge behavior, not the larger oscillator chain.

## Test Points

### `TP_REF`

- expected DC level: not explicitly modeled in the current integrated chain
- acceptable range: reserved for later hardware capture
- what it tells us: future reference stability and loading

### `TP_TUNE_SUM`

- expected DC level: `0 V` in the nominal reference run
- acceptable range: in the current `KiCad` capture this is a provisional passive weighted sum, not an ideal unity buffer
- practical note: with `COARSE_TUNE = 0 V` and `FINE_TUNE = 0 V`, the present front-door weighting makes `TP_TUNE_SUM` land a little below `CV_IN` rather than exactly on it
- current rough weighting intuition:
  `CV_IN` dominates through `R40 = 10k`,
  `COARSE_TUNE` rides in through `R41 = 220k`,
  `FINE_TUNE` rides in gently through `R42 = 1M`,
  and `R43 = 10M` gives the node a weak pull toward `AGND`
- what it tells us: honest front-door summer behavior before expo conversion, including whether the current passive weighting is still good enough for the next round

### `TP_EXPO_OUT`

- expected DC level or proxy: about `0.5 V` at `0 V CV` and `25 C`
- acceptable range: doubles per `+1 V` in the current reference model
- what it tells us: expo response and scaling behavior

### `TP_RAMP`

- expected waveform: rising ramp / saw core capacitor voltage
- expected amplitude: roughly `0.52 V` to `1.02 V` in steady state
- expected frequency range: about `1.0 kHz` at `0 V CV` and `25 C`; roughly `489 Hz` to `4021 Hz` from `-1 V` to `+2 V`
- what it tells us: current integration and reset behavior

### `TP_THRESHOLD`

- expected waveform: threshold crossing indicator or comparator-related node
- expected amplitude: roughly `-0.48 V` to `+0.02 V` in the nominal reference run
- what it tells us: comparator threshold behavior

### `TP_RESET_CTRL`

- expected waveform: reset control pulse or discharge drive
- expected amplitude: near `0 V` low and near `5 V` high
- expected timing: nominal period about `1.0 ms` at `0 V CV`; free-run period shifts to about `0.7 ms` when the current sync study is enabled
- what it tells us: whether reset happens cleanly and fast enough

### `TP_SAW`

- expected waveform: raw saw output
- expected amplitude: same as `TP_RAMP` in the current reference chain
- expected frequency range: same as `TP_RAMP` in the current reference chain
- what it tells us: raw musical core output

### `TP_PULSE`

- expected waveform: pulse output
- expected duty behavior: follows the reset pulse in the current reference chain
- what it tells us: edge integrity and derived digital-ish stability

## Current Success Conditions

For the active `P1` revision, the minimum success conditions are:

- reliable startup
- stable self-running oscillation
- musically sensible frequency response to control changes
- reset action that is visibly fast relative to the waveform period
- no obvious rail collapse or reference corruption during reset

## Observed Reality

Fill after measurement:

- what matched expectation:
  - self-running oscillation is stable in simulation
  - octave-like control movement is visible across the current range
  - reset-oriented sync injection clearly changes period
- what failed:
  - the current chain does not yet model a hardware reference block
  - temperature behavior is intentionally uncompensated and bends strongly
- what changed next:
  - next pass should choose behavioral vs transistor-level expo
  - stabilized blocks can now be promoted into more detailed KiCad capture
