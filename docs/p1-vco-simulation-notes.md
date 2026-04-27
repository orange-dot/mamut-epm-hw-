# P1 VCO Simulation Notes

## Purpose

This document defines the first simulation step for the `P1` oscillator work.

The first goal is not to simulate a complete analog polysynth voice.
The first goal is to make the time-domain heart of the oscillator visually and mathematically obvious.

## Current Starter Simulations

The current study ladder is:

- `sim/ngspice/p1-vco/00-rc-smoke.cir`
- `sim/ngspice/p1-vco/10-ramp-reset-core.cir`
- `sim/ngspice/p1-vco/20-threshold-reset-core.cir`
- `sim/ngspice/p1-vco/30-comparator-driven-reset-core.cir`
- `sim/ngspice/p1-vco/40-reset-sensitivity-core.cir`
- `sim/ngspice/p1-vco/50-standalone-expo-transfer.cir`
- `sim/ngspice/p1-vco/60-integrated-vco-chain.cir`
- `sim/ngspice/p1-vco/70-temp-drift-vco.cir`
- `sim/ngspice/p1-vco/80-sync-injection-vco.cir`
- `sim/ngspice/p1-vco/90-threshold-reset-realism.cir`
- `sim/ngspice/p1-vco/91-threshold-reset-window-sweep.cir`
- `sim/ngspice/p1-vco/100-threshold-reset-transistor-core.cir`
- `sim/ngspice/p1-vco/101-reset-transistor-sensitivity.cir`

## Why Start With A Forced-Reset Ramp

The `10-ramp-reset-core.cir` study is intentionally simple.

It demonstrates:

- current into a capacitor
- linear voltage ramping
- reset discharge
- the birth of a saw-like waveform

This is not yet the final oscillator topology.
It is the cleanest possible first lesson before introducing:

- exponential conversion
- comparator threshold logic
- autonomous core reset behavior
- sync interaction between oscillators

## What To Look For

In `10-ramp-reset-core.cir`, watch:

- the slope of `v(ramp)`
- the reset sharpness
- the resulting waveform period
- the relationship between charge current and ramp speed

The important intuition is:

- more current means faster ramp
- more capacitance means slower ramp
- reset timing defines the repetition

That is the oscillator heart in one page.

## Transition From `20` To `30`

`20-threshold-reset-core.cir` is now the current next simulation step.

It replaces the external reset pulse with threshold-based reset behavior.

Current status:

- useful as a study
- not yet trustworthy as a solved self-running core
- the next technical move should separate threshold detection from reset drive more explicitly

What to inspect there:

- autonomous repetition without an external clock
- where the ramp tops out before reset
- how fast the reset event collapses the node
- whether the hysteresis band prevents chatter
- whether the period tracks the expected current/capacitance/threshold relationship

Important failure shapes:

- ramp charges but never resets
- switch chatters around threshold
- reset is too weak and leaves the node hanging high
- reset is so aggressive the waveform becomes pulse-like instead of saw-like

After that, the next useful step is likely:

- replace the thresholded switch shortcut with an explicit comparator-driven reset loop

That is where the study starts turning from "self-running oscillator principle" into "actual VCO control architecture".

That move is now implemented in `30-comparator-driven-reset-core.cir`.

## Current Working Reference

`30-comparator-driven-reset-core.cir` is the first trustworthy self-running core in the chain.

Current reference behavior:

- steady-state ramp swings roughly from `0.52 V` to `1.02 V`
- reset control reaches about `5 V`
- period is about `49.5 us` with the intentionally hot `30` study current

The point of `30` is not pitch realism.
The point is that the core now closes on its own with a separated threshold detector and reset driver.

## Reset Sensitivity

`40-reset-sensitivity-core.cir` shows what the reset path actually changes.

Most important result from the current sweep set:

- reset window depth changes the cycle far more than reset leakage in the tested range
- deeper reset windows pull the ramp lower and lengthen the period
- reset Ron matters, but less dramatically than the reset window in the current parameter set

This means the reset comparator window is a first-class musical parameter, not just an implementation detail.

## Standalone Expo Result

`50-standalone-expo-transfer.cir` now gives a clean standalone transfer before oscillator dynamics enter the picture.

At `25 C` with the current sense scaling:

- `0 V` maps to `0.5 V` at `EXPO_OUT`
- `+1 V` maps to `1.0 V`
- `+2 V` maps to `2.0 V`

That is a good first-order octave law for the current behavioral expo block.

## Integrated Chain Result

`60-integrated-vco-chain.cir` is the main reference for this round.

At `25 C` and `0 V CV`:

- nominal period is about `1.018 ms`
- the steady-state sweep summary gives about `1.01 kHz`
- the ramp sits roughly between `0.52 V` and `1.02 V`

Across the current modest range from `-1 V` to `+2 V`, the simulated frequency summary is approximately:

- `-1 V` -> `489 Hz`
- `-0.5 V` -> `861 Hz`
- `0 V` -> `1010 Hz`
- `0.5 V` -> `1411 Hz`
- `1.0 V` -> `1979 Hz`
- `1.5 V` -> `2887 Hz`
- `2.0 V` -> `4021 Hz`

This is good enough to treat the integrated chain as a real study platform.

## Temperature And Sync

`70-temp-drift-vco.cir` and `80-sync-injection-vco.cir` close the round.

Current temperature result:

- `0 V` frequency stays near `1010 Hz` in the current model
- the `+1 V / 0 V` ratio bends with temperature:
  - about `2.58` at `0 C`
  - about `1.96` at `25 C`
  - about `1.90` at `50 C`

That is a useful first characterization of uncompensated expo drift in this simplified chain.

Current sync result:

- free-running period is about `0.999 ms`
- with sync injection enabled, period moves to about `0.700 ms`

That is enough to prove the first reset-oriented sync hook.

## Next Useful Step

The next useful technical move after this round is:

- decide whether the next expo pass stays behavioral or becomes transistor-level
- promote the stabilized core blocks into more detailed `KiCad` capture
- choose whether sync remains a threshold kick or becomes a more device-faithful reset path

## Threshold And Reset Realism Pass

`90-threshold-reset-realism.cir` is the first explicit realism pass for the threshold/reset path.

It keeps the wider oscillator harness mostly behavioral, but makes the threshold/reset side more device-like:

- comparator action is explicit
- hysteresis is explicit
- reset discharge happens through a transistor path instead of a pure ideal switch shortcut

Current nominal result with the locked `90` reference:

- ramp cycle settles around `0.788 V` to `0.981 V`
- nominal period is about `392 us`
- nominal frequency is about `2.55 kHz`
- reset drive reaches about `4.86 V`
- transistor base drive reaches about `0.71 V`
- threshold window sits roughly between `-0.10 V` and `+0.10 V`

Important interpretation:

- the realism pass is materially faster than the `60` benchmark
- the threshold/reset block is no longer just a gentle wrapper around the old behavior
- this is useful because it exposes the reset block as a real musical shaper rather than a bookkeeping detail

## Reset Window Sweep

`91-threshold-reset-window-sweep.cir` maps which threshold/reset settings stay stable in the current realism pass.

Current practical result:

- `Rhyst = 1.0 M` and `2.2 M` do not hold stable oscillation in the tested setup
- the first stable region appears at `Rhyst = 4.7 M`
- within that region, `Rbase` changes frequency more gently than hysteresis changes basic stability

Stable combinations currently observed:

- `Rhyst = 4.7 M`, `Rbase = 2.2 k` -> about `2.23 kHz`
- `Rhyst = 4.7 M`, `Rbase = 4.7 k` -> about `2.55 kHz`
- `Rhyst = 4.7 M`, `Rbase = 10 k` -> about `2.57 kHz`

That means the current realism pass has a narrow useful operating region, which is exactly the kind of thing we want to learn before touching real hardware.

## First Transistor-Level Reset Core

`100-threshold-reset-transistor-core.cir` is the first study where the reset/discharge side is treated as the real learning target.

It still keeps the threshold decision idealized, but the discharge path is now more bench-facing:

- explicit base drive
- explicit base-emitter bleed
- explicit discharge resistor
- explicit emitter resistor
- explicit fast clamp diode on the reset transistor path

Current nominal result:

- cycle window: about `0.864 V` to `0.981 V`
- nominal period: about `238 us`
- nominal frequency: about `4.19 kHz`
- reset high: about `4.86 V`
- base high: about `0.776 V`
- collector low: about `0.141 V`

Direct comparison to `90`:

- period is about `0.608x` of the `90` reference
- the low end of the ramp rises by about `+76 mV`
- the high end is nearly unchanged

Interpretation:

- the transistor reset path is now clearly strong enough to change the musical timing class of the oscillator
- the main visible change is not the top of the ramp, but how far the core is allowed to discharge before climbing again

## Transistor Reset Sensitivity

`101-reset-transistor-sensitivity.cir` sweeps only the transistor reset side.

Current sweep dimensions:

- `Rbase`
- `Rdischarge`
- `Rbe`

Current useful result:

- all tested combinations around `Rbase = 2.2 k` and `4.7 k` stayed stable
- the strongest currently stable region reaches roughly `4.62 kHz`
- the weakest currently stable region sits around `3.80 kHz`
- an intentionally extreme `Rbase = 100 M` region fails across all tested `Rdischarge / Rbe` combinations

That gives the first honest stable/unstable boundary inside the transistor reset path.
