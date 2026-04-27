# Mamut P1 VCO KiCad Project

This is the starter KiCad project for the `P1` oscillator work.

Current stance:

- this is an architecture and interface skeleton first
- it is not yet the authoritative component-level oscillator design
- mechanism learning for `P1` still lives primarily in `sim/ngspice/p1-vco/`
- threshold/reset is now the first real promoted capture block, while the rest of the project remains intentionally lighter
- current_integrator has now joined that first promoted capture tier as the timing-body companion to threshold/reset
- power_reference has now joined that same tier as the first honest support-sheet capture
- input_tune has now joined that same tier as the first honest front-door capture
- bench_io has now joined that same tier as the explicit bench-facing external-interface owner
- expo_converter has now joined that same tier as the first honest rail-aware matched-pair/tempco handoff into the timing body
- the reset sheet now follows the nominal transistor reset pocket from `100-threshold-reset-transistor-core.cir`
- the reset sheet now carries its own embedded `KiCad` symbol definitions and exports a real standalone netlist
- the threshold sheet now carries its own embedded `KiCad` symbol definitions and exports a real standalone netlist
- the threshold sheet has now been reworked into a wire-driven comparator fragment, so `THRESHOLD_NODE`, `RESET_CTRL`, and `PULSE_OUT` are backed by actual part connectivity rather than label-only geometry
- the current integrator sheet now carries its own embedded `KiCad` symbol definitions and exports a real standalone netlist
- the input/tune sheet now carries its own embedded `KiCad` symbol definitions and exports a real standalone netlist
- the expo sheet now carries its own embedded `KiCad` symbol definitions and exports a real standalone netlist
- the threshold resistor references now live at `R10` through `R14` to avoid clashes with the reset pocket
- the current integrator timing and buffer fragment currently lives at `R20`, `C20`, `R21`, `R22`, `U20`, `TP20`, `TP21`, and `TP22`
- the power/reference support fragment currently lives at `C30`, `C31`, `C32`, `R30`, `R31`, `TP30`, `TP31`, `TP32`, and `TP33`
- the input/tune front-door fragment currently lives at `R40`, `R41`, `R42`, `R43`, and `TP40`
- the bench-facing support fragment currently lives at `J50`, `J51`, and `R50`
- the current expo-control fragment currently lives at `Q60`, `Q61`, `Q62`, `R60` through `R65`, `RV60`, `RV61`, and `TP60`

Current files:

- `mamut-p1-vco.kicad_pro`
- `mamut-p1-vco.kicad_sym`
- `mamut-p1-vco.kicad_sch`
- `p1-input-tune.kicad_sch`
- `p1-expo-converter.kicad_sch`
- `p1-current-integrator.kicad_sch`
- `p1-threshold-comparator.kicad_sch`
- `p1-reset-output.kicad_sch`
- `p1-power-reference.kicad_sch`
- `p1-bench-io.kicad_sch`
- `p1-trim-test.kicad_sch`
- `sym-lib-table`

Open it with:

```bash
kicad hardware/p1-vco/kicad/mamut-p1-vco.kicad_pro
```

Or open the schematic editor directly:

```bash
eeschema hardware/p1-vco/kicad/mamut-p1-vco.kicad_sch
```

## Good Practice For This Folder

Promote work into this KiCad project only when:

- the mechanism has already been studied in `raw ngspice`
- the interface names are stable
- the required test points are known
- the block is ready to become hardware-facing structure

Until then, this folder should stay honest:

- block diagrams are fine
- interface sheets are fine
- unresolved mechanism experiments belong in `sim/`, not hidden inside premature schematic capture

## Current Promotion / Deepening Order

The first promoted capture group is now:

1. `p1-input-tune.kicad_sch`
2. `p1-power-reference.kicad_sch`
3. `p1-bench-io.kicad_sch`
4. `p1-expo-converter.kicad_sch`
5. `p1-threshold-comparator.kicad_sch`
6. `p1-reset-output.kicad_sch`
7. `p1-current-integrator.kicad_sch`

The next recommended deepening order is:

1. `p1-threshold-comparator.kicad_sch`
2. `p1-reset-output.kicad_sch`
3. `p1-expo-converter.kicad_sch`
4. `p1-current-integrator.kicad_sch`

Reference docs for that transition:

- `docs/p1-current-usage-guide.md`
- `docs/p1-step-1-integrated-chain-walkthrough.md`
- `docs/p1-step-2-model-boundary.md`
- `docs/p1-step-3-threshold-reset-capture.md`

## Current Validation Reality

Right now the top-level project does successfully:

- export a netlist
- export per-sheet SVG output
- open in KiCad as a hierarchical project
- complete `kicad-cli sch erc` without crashing
- pass `kicad-cli sch erc` with zero findings

Also treat the current reset sheet as:

- topology-aligned with the SPICE learning path
- useful for human review and future capture work
- internally electrically meaningful enough to use as the first trustworthy `KiCad` capture block

Treat the current threshold sheet as:

- promoted alongside the reset and integrator sheets into the first electrically meaningful capture group
- good enough to reason about comparator topology, hysteresis, pull-up, and pulse tap honestly
- already strong enough that standalone netlist export proves the intended threshold/reset/pulse nets through real wiring
- still not the end of hierarchy cleanup or final electrical validation

Treat the current integrator sheet as:

- the first honest timing-body plus active saw-buffer capture instead of an empty interface stub
- intentionally modest: raw current entry, timing capacitor, bleed path, TL071 follower, light saw-output isolation, and ramp/reset/saw observation hooks
- structurally trustworthy enough that the top-level netlist now includes its parts and joins them to `EXPO_OUT`, `RAMP_NODE`, `SAW_OUT`, `AGND`, and the shared `+12V` / `-12V` rails
- now the owning sheet for public `SAW_OUT`, while `reset_output` stays focused on the discharge pocket driven by `RESET_CTRL`
- still downstream of a first honest matched-pair/tempco capture rather than a production-locked expo converter with final HF compensation and part selection

Treat the current power/reference sheet as:

- the first bench-facing support capture instead of a decorative rail declaration
- intentionally modest: light rail decoupling, rail test taps, and a low-impedance `REFERENCE` divider for the current threshold work
- top-level-netlist-real enough that the shared project now sees `+12V`, `-12V`, `AGND`, and `REFERENCE` tied to actual support components
- still not a final PSU design, buffered reference stage, or production power story

Treat the current bench_io sheet as:

- the explicit bench-facing owner for `CV_IN`, `COARSE_TUNE`, `FINE_TUNE`, `SYNC_IN`, `SAW_OUT`, `PULSE_OUT`, and shared `AGND`
- intentionally modest: one simple input header, one simple output header, and only a weak `SYNC_IN` pulldown for idle definition
- top-level-netlist-real enough that the shared project now sees the external I/O vocabulary attached to actual connector parts instead of dangling root labels
- still not a final panel/jack field, protected input stage, or buffered output stage

Current honest rail note:

- the active rail vocabulary inside the current `KiCad` capture is now standard global `+12V` / `-12V`
- the comparator rail blocker is closed at top level: `LM311` no longer trips `V+` / `V-` `power_pin_not_driven` under project ERC
- the embedded `LM311` symbol in the threshold sheet now treats `V+` / `V-` as ordinary rail pins so the promoted capture follows the real shared rail nets instead of a broken hierarchy-only power heuristic
- that intentional comparator variant is now formalized as the project-local symbol `mamut-p1-vco:LM311_P1` in `mamut-p1-vco.kicad_sym`, while the embedded passive `R` / `C` symbols have been synced to the current KiCad 9 library definitions
- the shared project now passes top-level ERC with zero findings, so the old embedded-symbol drift cleanup is closed rather than merely deferred

Treat the current input/tune sheet as:

- the first honest front-door capture instead of a pure port vocabulary box
- intentionally provisional: a passive weighted summer where `CV_IN` dominates, `COARSE_TUNE` and `FINE_TUNE` ride on top, and `AGND` gives the node a weak home
- top-level-netlist-real enough that the shared project now sees `CV_IN`, `COARSE_TUNE`, `FINE_TUNE`, `AGND`, and `TUNE_SUM` tied to actual front-door parts
- still not a final panel law, buffered summer, or calibration strategy

Treat the current expo sheet as:

- the first honest rail-aware matched-pair/tempco handoff between the front-door tuning vocabulary and the timing body instead of a pure port stub
- organized around a thermally-coupled `Q60` / `Q61` NPN pair, a tempco-bearing `R60` plus `RV60` `SCALE_TRIM`, a real `RV61` `OFFSET_TRIM` path from `REFERENCE`, and a sourced `Q62` helper into `EXPO_OUT`
- explicit about internal analog ownership: `CV_BASE`, `REF_BASE`, `REF_COL`, `PAIR_EMIT`, and `EXPO_CTRL` now make the transistor-level control and tail-current story legible in the netlist instead of hiding it behind a single proxy node
- top-level-netlist-real enough that the shared project now sees `+12V`, `-12V`, `AGND`, `TUNE_SUM`, `REFERENCE`, and `EXPO_OUT` tied to actual expo parts instead of a decorative interface box
- still not the final production matched-pair package choice, exact tempco BOM lock, or later `HF_TRIM` compensation pass
