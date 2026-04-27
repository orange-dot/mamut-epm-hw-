# P1 VCO ngspice Studies

This directory holds the first `ngspice` studies for the `P1` oscillator work.

Current starter files:

- `00-rc-smoke.cir` - basic transient simulation sanity check
- `10-ramp-reset-core.cir` - first synth-relevant ramp and reset experiment
- `20-threshold-reset-core.cir` - first self-running threshold-reset oscillator study
- `30-comparator-driven-reset-core.cir` - first trustworthy self-running core with separated threshold and reset control
- `40-reset-sensitivity-core.cir` - reset path sweeps for Ron, leakage, and reset window depth
- `50-standalone-expo-transfer.cir` - standalone expo transfer curve and octave scaling check
- `60-integrated-vco-chain.cir` - first integrated `CV -> expo -> core -> saw/pulse` study
- `70-temp-drift-vco.cir` - temperature sweep on the integrated chain
- `80-sync-injection-vco.cir` - first sync injection comparison on the integrated chain
- `90-threshold-reset-realism.cir` - first more device-like threshold/reset realism pass
- `91-threshold-reset-window-sweep.cir` - first sweep of stable hysteresis/base-drive regions
- `100-threshold-reset-transistor-core.cir` - first transistor-level reset/discharge core benchmark
- `101-reset-transistor-sensitivity.cir` - sweep of transistor reset strength, discharge resistance, and base bleed
- later studies should continue numerically, not by overwriting earlier lessons

## Quick Start

Run directly:

```bash
cd sim/ngspice/p1-vco
ngspice 00-rc-smoke.cir
```

Or use the batch helper:

```bash
cd .
./tools/run-ngspice.sh sim/ngspice/p1-vco/00-rc-smoke.cir
./tools/run-ngspice.sh sim/ngspice/p1-vco/10-ramp-reset-core.cir
```

## What These Files Are For

`00-rc-smoke.cir` is only there to verify that the simulation toolchain is healthy.

`10-ramp-reset-core.cir` is more interesting.
It demonstrates the core time-domain intuition behind a saw-like oscillator:

- a current charges a capacitor
- the voltage ramps up
- a reset switch dumps the capacitor
- the waveform starts again

This is not yet a real self-running VCO.
It is the cleanest first visual lesson before we add expo conversion and autonomous reset behavior.

`20-threshold-reset-core.cir` is the next step.
It removes the external periodic reset pulse and lets the ramp node trigger its own reset through a thresholded switch model.

At the moment, treat it as an active study, not as a solved oscillator core.
The correct next move is to refine the threshold-to-reset control path rather than pretending the current file is already the final answer.

`30-comparator-driven-reset-core.cir` is the first solved core reference for this round.
It uses a separated threshold node, a saturated reset control node, and a dedicated reset switch.

`40-reset-sensitivity-core.cir` maps what the reset path actually cares about.
It writes summary files for:

- reset on-resistance
- reset leakage
- reset window depth

`50-standalone-expo-transfer.cir` proves the standalone expo law before it is mixed into oscillator behavior.

`60-integrated-vco-chain.cir` is the current main reference study.
It closes the loop from `CV_IN` to `SAW_OUT` and produces a usable frequency summary over a modest control range.

`70-temp-drift-vco.cir` characterizes how the integrated chain bends under temperature.

`80-sync-injection-vco.cir` shows the first useful sync comparison:

- free-running period near `1.0 ms`
- sync-forced period near `0.7 ms`

`90-threshold-reset-realism.cir` is the first pass where the threshold/reset side starts behaving like its own real circuit block instead of a gentle shortcut.

`91-threshold-reset-window-sweep.cir` then maps which `Rhyst / Rbase` combinations are actually stable in that realism pass.

`100-threshold-reset-transistor-core.cir` is the next step:

- keep the threshold decision idealized
- deepen the reset/discharge path into a more bench-truthful transistor study
- compare directly back to the locked `90` numbers

`101-reset-transistor-sensitivity.cir` then asks the next real question:

- which transistor reset settings still oscillate cleanly
- which settings push the discharge path out of the useful region

## Study Rule

For `P1`, use this directory for:

- single-mechanism experiments
- parameter sweeps
- startup behavior
- reset behavior
- leakage and drift studies later

Do not collapse several unanswered questions into one giant netlist too early.
