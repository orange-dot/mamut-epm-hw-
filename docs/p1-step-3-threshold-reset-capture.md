# P1 Step 3: First Real KiCad Capture For Threshold And Reset

## Purpose

This document defines the first proper `KiCad` capture target for `P1`.

The first detailed sheet should be the threshold and reset block.

Not the whole oscillator.
Not the whole voice.
One real hardware-facing block.

## Why This Block Goes First

The threshold/reset path is the best first capture target because:

- `30` already proved the conceptual separation
- `40` already mapped the most important sensitivities
- it is central to free-running behavior
- it will later matter for sync behavior as well

This is the first place where `KiCad` can stop being a placeholder and start being a true circuit capture tool.

## Sheet Role

The `p1-threshold-comparator.kicad_sch` and `p1-reset-output.kicad_sch` sheets should become the first detailed sheets.

Their combined purpose is:

- observe the ramp node
- decide when reset should happen
- generate a usable reset-control signal
- discharge the timing capacitor cleanly
- expose a usable `PULSE_OUT`

## Locked Interfaces

Inputs:

- `RAMP_NODE`
- `SYNC_IN`
- `REFERENCE`
- `+12V`
- `-12V`
- `AGND`

Outputs:

- `THRESHOLD_NODE`
- `RESET_CTRL`
- `PULSE_OUT`

Supporting internal signals may exist, but those names above must remain stable.

## Required Subfunctions

### Ramp Sense

The block must accept the ramp node without corrupting it.

Capture concern:

- avoid pretending a high-impedance sense path is the same thing as a hard load

### Threshold Reference And Window

The block must define where the reset decision lives.

Capture concern:

- hysteresis or window behavior must be intentional
- this is where later trim or threshold bias may enter

### Comparator Core

The block must turn analog ramp state into a real decision.

Capture concern:

- keep the path readable
- make polarity obvious
- leave room for later device substitution if needed

### Reset Driver

The block must turn the comparator decision into a useful control signal.

Capture concern:

- separate logic-like control from the actual discharge path
- make `RESET_CTRL` probeable

### Reset Switch / Discharge Path

The block must actually pull the timing node down.

Capture concern:

- discharge speed
- leakage path
- interaction with the integrator capacitor

### Pulse Output Derivation

The block should expose `PULSE_OUT` as a meaningful byproduct of reset/comparator action.

Capture concern:

- keep it honest about what it really represents
- do not add fancy pulse-shaping yet unless it teaches something essential

## Required Test Points

The first capture must include at minimum:

- `TP_THRESHOLD`
- `TP_RESET_CTRL`
- `TP_PULSE`

If the actual capture benefits from one more point, add:

- `TP_RESET_SW`

## What This Capture Is Allowed To Be

This first detailed capture is allowed to be:

- mixed-level
- part-placeholder-heavy
- explicit about unknowns

It is not required yet to be:

- final parts-locked
- PCB-ready
- fully ERC-polished as if it were production

It does need to be:

- electrically legible
- consistent with the study vocabulary
- bench-minded

## What Must Stay Out Of This First Capture

Do not let this first real capture balloon into:

- full expo design
- full integrator design
- full sync conditioning architecture
- power-entry board design
- output polish

The job here is narrower:

- make threshold and reset real enough to own them

## Promotion Gate

This sheet can be called a successful first real `KiCad` capture when:

- the interfaces match the simulation vocabulary
- the test points match the bench sheet vocabulary
- the block purpose is obvious at a glance
- the comparator and reset path are no longer empty placeholders
- a later bench build could be planned from this capture without fiction

## Current Implementation Status

This step is now materially underway.

The current `KiCad` project now includes real first-pass capture in:

- `hardware/p1-vco/kicad/p1-input-tune.kicad_sch`
- `hardware/p1-vco/kicad/p1-threshold-comparator.kicad_sch`
- `hardware/p1-vco/kicad/p1-reset-output.kicad_sch`
- `hardware/p1-vco/kicad/p1-current-integrator.kicad_sch`
- `hardware/p1-vco/kicad/p1-power-reference.kicad_sch`
- `hardware/p1-vco/kicad/p1-bench-io.kicad_sch`
- `hardware/p1-vco/kicad/p1-expo-converter.kicad_sch`

What is already true:

- the empty placeholders are gone
- the threshold sheet now shows comparator, threshold network, hysteresis path, and probe points
- the reset sheet now mirrors the current `sim-100 / sim-101` transistor reset pocket:
  `Rbase 4k7`, `Rbe 100k`, `Creset 33p`, `Rdischarge 330`, `Remit 22`, and a fast clamp diode
- the reset sheet now embeds the required `KiCad` library symbols directly, so standalone netlist export sees real parts and real internal nets instead of an empty or fictional sheet
- the reset sheet now resolves the internal pocket nets explicitly as:
  `AGND`, `QBASE`, `QCOL`, `QEMIT`, `RAMP_NODE`, and `RESET_CTRL`
- the threshold sheet now does the same for the comparator side:
  it embeds `LM311`, `R`, and `TestPoint` symbols directly and exports a real standalone netlist with explicit nets for
  `AGND`, `-12V`, `+12V`, `REFERENCE`, `RAMP_NODE`, `SYNC_IN`, `THRESHOLD_NODE`, `RESET_CTRL`, and `PULSE_OUT`
- the threshold sheet was then tightened further into a truly wire-driven comparator fragment instead of a label-only sketch;
  the current standalone export now proves the intended threshold/reset/pulse nets through actual part connectivity, not just named aliases
- the threshold and power/reference sheets now share standard global rail names `+12V` and `-12V` instead of the older `PLUS12` / `MINUS12` aliases
- the embedded `LM311` symbol now treats `V+` and `V-` as ordinary rail pins inside this capture sheet, because `KiCad` was not carrying the intended bench-rail source semantics cleanly through this hierarchy
- that intentional comparator variant is now formalized as the project-local symbol `mamut-p1-vco:LM311_P1`, so the sheet no longer depends on a drifted copy of stock `Comparator:LM311`
- the threshold sheet resistor references were shifted to `R10` through `R14` so the top-level project no longer collides with the reset pocket references
- the top-level block diagram no longer hard-wires the threshold and reset sheets together through misleading straight-line geometry; the reset block is now referenced through its named interfaces instead of accidental wire alignment
- the current integrator sheet is no longer a pure placeholder; it now captures the first honest timing-body plus active saw-buffer fragment with
  `R20`, `C20`, `R21`, `R22`, `U20`, `TP20`, `TP21`, and `TP22`
- the current integrator sheet now exports a real standalone netlist with explicit external nets for
  `AGND`, `EXPO_OUT`, `RESET_CTRL`, `RAMP_NODE`, and `SAW_OUT`
- the current integrator now owns the public `SAW_OUT` path through a modest TL071 follower, while the reset sheet has been narrowed back to the transistor discharge pocket around the raw `RAMP_NODE`
- the input/tune sheet is no longer a pure port box; it now captures a first honest front-door fragment with
  `R40`, `R41`, `R42`, `R43`, and `TP40`
- the input/tune sheet now exports a real standalone netlist and the top-level project now includes explicit `CV_IN`, `COARSE_TUNE`, `FINE_TUNE`, `AGND`, and `TUNE_SUM` participation in the front-door block
- the expo sheet is no longer a pure interface stub; it now captures a first honest rail-aware matched-pair/tempco handoff with
  `Q60`, `Q61`, `Q62`, `R60` through `R65`, `RV60`, `RV61`, and `TP60`
- the expo sheet now exports a real standalone netlist with explicit external nets for
  `+12V`, `-12V`, `AGND`, `TUNE_SUM`, `REFERENCE`, and `EXPO_OUT`, plus internal `CV_BASE`, `REF_BASE`, `REF_COL`, `PAIR_EMIT`, and `EXPO_CTRL` nodes that make the trim and transistor handoff electrically legible
- the bench I/O sheet is no longer implicit root-sheet vocabulary; it now captures a first honest external-interface owner with
  `J50`, `J51`, and `R50`
- the bench I/O sheet now exports a real standalone netlist and the top-level project now includes explicit ownership for
  `CV_IN`, `COARSE_TUNE`, `FINE_TUNE`, `SYNC_IN`, `SAW_OUT`, `PULSE_OUT`, and `AGND`
- the top-level project now pulls the current integrator into the shared hierarchy cleanly enough that top-level netlist export includes the timing parts and the expected named nets
- the power/reference sheet is no longer a pure rail placeholder; it now exports a real standalone netlist with
  `C30`, `C31`, `C32`, `R30`, `R31`, `TP30`, `TP31`, `TP32`, and `TP33`
- the power/reference sheet now owns a minimal bench-facing support story:
  light rail decoupling and a low-impedance `REFERENCE` divider around `1.0 V` from the `+12 V` rail
- the full top-level project can export a netlist and SVG sheet set successfully
- the full top-level project now exports a netlist with shared `+12V` and `-12V` rails visible across the promoted capture sheets
- the top-level `kicad-cli sch erc` no longer crashes and now completes with zero findings after the embedded-symbol cleanup plus the current-integrator active-buffer pass
- the expo promotion remains intact through that cleanup; no new error-level or warning-level regression was introduced

What is not yet true:

- standalone subsheet ERC is still noisy and not a trustworthy acceptance gate, because these sheets are hierarchical by construction
- the top-level architecture sheet still contains older placeholder behavior outside the threshold/reset/current-integrator/power-reference/bench-io capture path
- the expo side is still intentionally modest in component ambition; it is now a real matched-pair/tempco capture, but not yet a production-locked package, exact tempco BOM, or later `HF_TRIM` pass
- the input front door is now electrically present, but its weighting is still deliberately provisional rather than a final panel-law or calibration design
- standalone subsheet ERC still does not serve as a trustworthy acceptance gate for the comparator sheet, because the sheet is hierarchical by construction and the local symbol semantics are now tuned for the promoted project capture rather than for isolated-sheet purity

Current honest read:

- input_tune, expo, threshold, reset, current-integrator, power-reference, and bench-io sheets have crossed from "topology-aligned sketch" into "electrically meaningful first capture"
- the next blocker is no longer comparator rail semantics, root-sheet I/O hygiene, or embedded-symbol drift; it is whether to deepen the integrator around this now-more-honest expo handoff or to start locking the expo BOM and compensation details

## Relationship To The Rest Of `P1`

After this block is captured properly:

- the current integrator becomes easier to detail
- sync strategy gets a more honest insertion point
- `60` remains the top-level behavioral benchmark
- the expo block can be deepened without losing the reset reference

This is why threshold/reset is the correct first real capture step.
