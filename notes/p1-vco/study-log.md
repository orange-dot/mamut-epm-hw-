# P1 VCO Study Log

## Log Format

For each entry, capture:

- date
- study id
- question
- assumptions
- result
- next move

## Entries

### 2026-04-11 - `00-rc-smoke`

- question: does the local `ngspice` workflow run end to end
- assumptions: simple RC transient is enough to verify tooling
- result: toolchain runs and produces expected text outputs
- next move: start synth-relevant ramp studies

### 2026-04-11 - `10-ramp-reset-core`

- question: can we demonstrate the basic ramp-and-dump intuition behind a saw-like oscillator
- assumptions: external reset is acceptable for the first visual lesson
- result: yes, the ramp/reset story is visible
- next move: replace forced reset with threshold-driven behavior

### 2026-04-11 - `20-threshold-reset-core`

- question: can the ramp node drive its own reset through a thresholded mechanism
- assumptions: the first version may use idealized switching
- result: current study exists, but the self-running reset behavior is not yet trustworthy enough to treat as a solved oscillator core
- next move: revise the control path so threshold detection and reset drive are separated more explicitly

### 2026-04-11 - `30-comparator-driven-reset-core`

- question: can we close the oscillator with explicit threshold detection and a separate reset control node
- assumptions: a saturated comparator model plus reset switch is enough for a trustworthy first core
- result: yes; the core now self-runs repeatably with a steady-state ramp around `0.52 V` to `1.02 V` and a period around `49.5 us`
- next move: map which reset parameters matter most before folding expo into the chain

### 2026-04-11 - `40-reset-sensitivity-core`

- question: what actually matters in the reset path
- assumptions: reset Ron, reset leakage, and reset window depth are the first high-value knobs to sweep
- result: reset window depth is the strongest shaper in the current range; reset leakage matters least in the tested range; reset Ron matters, but more mildly
- next move: keep the reset window explicit and move on to a clean standalone expo study

### 2026-04-11 - `50-standalone-expo-transfer`

- question: does the current expo block produce a readable octave law on its own
- assumptions: a first-order behavioral expo block is acceptable for this simulation round
- result: yes; at `25 C`, the current sense proxy gives `0.5 V` at `0 V`, `1.0 V` at `+1 V`, and `2.0 V` at `+2 V`
- next move: feed that expo law into the oscillator core and measure the whole chain

### 2026-04-11 - `60-integrated-vco-chain`

- question: does the first full `CV -> expo -> core -> saw/pulse` chain behave like a real oscillator study platform
- assumptions: a modest range is more important than a fake huge range
- result: yes; the chain is stable from `-1 V` to `+2 V`, with frequency moving from about `489 Hz` to `4021 Hz`
- next move: characterize temperature drift and prove the first sync hook

### 2026-04-11 - `70-temp-drift-vco`

- question: how badly does the integrated chain bend with temperature in the current simplified expo model
- assumptions: the current round is characterization first, not full compensation
- result: the `+1 V / 0 V` ratio bends from about `2.58` at `0 C` to about `1.90` at `50 C`
- next move: keep this as the baseline before any compensation or transistor-level expo pass

### 2026-04-11 - `80-sync-injection-vco`

- question: can a reset-oriented sync kick meaningfully steer the integrated chain
- assumptions: a threshold kick is an acceptable first sync hook
- result: yes; free-run sits near `1.0 ms`, and sync-on pulls the period to about `0.7 ms`
- next move: decide later whether this stays a threshold kick or becomes a more device-faithful sync path

### 2026-04-11 - `90-threshold-reset-realism`

- question: can we replace the gentler behavioral threshold/reset path with a more device-like reset block while keeping the larger chain understandable
- assumptions: explicit hysteresis plus a transistor discharge path are enough for a first realism pass
- result: yes, but the behavior shifts strongly; the current nominal cycle sits around `0.788 V` to `0.981 V` with frequency near `2.55 kHz`, so the threshold/reset block is now clearly shaping the oscillator rather than hiding inside it
- next move: sweep hysteresis and base-drive sensitivity to find the first stable operating pocket

### 2026-04-11 - `91-threshold-reset-window-sweep`

- question: which threshold/reset settings remain stable in the current realism pass
- assumptions: `Rhyst` and `Rbase` are the highest-value first knobs
- result: the tested setup only becomes stable when `Rhyst` reaches `4.7 M`; within that stable region, `Rbase` shifts frequency modestly from about `2.23 kHz` to `2.57 kHz`
- next move: treat the current `4.7 M` hysteresis region as the first capture target while keeping the wider search space open for later device refinement

### 2026-04-11 - `100-threshold-reset-transistor-core`

- question: what changes when the reset/discharge side becomes a more honest transistor block while the threshold decision remains idealized
- assumptions: compare directly against the locked `90` reference instead of pretending the new path is automatically better
- result: the transistor reset core is clearly stronger and faster; nominal frequency moves to about `4.19 kHz`, the ramp low point rises to about `0.864 V`, and the high point stays almost unchanged
- next move: map which reset-path settings still behave cleanly and which ones collapse the oscillator

### 2026-04-11 - `101-reset-transistor-sensitivity`

- question: where is the first stable/unstable boundary inside the transistor reset path
- assumptions: `Rbase`, `Rdischarge`, and `Rbe` are the highest-value first knobs inside the current transistor block
- result: the nominal and moderately strong drive regions stay stable, while an intentionally extreme `Rbase = 100 M` region fails across all tested discharge and bleed combinations
- next move: treat the `2.2 k` to `4.7 k` base-drive region as the first trustworthy transistor reset pocket and keep the failed `100 M` region as the first anti-pattern reference

### 2026-04-11 - `KiCad reset capture hardening`

- question: can the `p1-reset-output.kicad_sch` sheet graduate from a visually aligned draft into a real electrical fragment
- assumptions: importing the missing `lib_symbols`, then rewiring against actual pin coordinates, is more important than polishing the whole hierarchy at once
- result: yes; standalone netlist export now sees the actual reset pocket parts and the intended internal nets `AGND`, `QBASE`, `QCOL`, `QEMIT`, `RAMP_NODE`, `RESET_CTRL`, and `SAW_OUT`
- next move: bring `p1-threshold-comparator.kicad_sch` to the same standard before trusting more of the top-level hierarchy

### 2026-04-11 - `KiCad threshold capture hardening`

- question: can the `p1-threshold-comparator.kicad_sch` sheet graduate from a visually suggestive draft into a real comparator fragment
- assumptions: a simpler, more explicit comparator sheet is better than preserving every earlier alias net and geometric hint
- result: yes; standalone netlist export now sees the actual comparator parts and the intended external nets `AGND`, `MINUS12`, `PLUS12`, `REFERENCE`, `RAMP_NODE`, `SYNC_IN`, `THRESHOLD_NODE`, `RESET_CTRL`, and `PULSE_OUT`
- next move: treat threshold and reset as the first trustworthy KiCad pair, then decide whether the next promoted block is the integrator or top-level hierarchy cleanup

### 2026-04-11 - `KiCad current integrator promotion`

- question: can the `p1-current-integrator.kicad_sch` sheet graduate from a blank interface box into a real timing-body fragment without prematurely solving the full expo side
- assumptions: the honest first capture is only the timing capacitor, bleed path, ramp probe, and reset observation hook; the discharge transistor remains owned by `p1-reset-output.kicad_sch`
- result: yes; the sheet now exports a real standalone netlist with `R20`, `C20`, `R21`, `TP20`, and `TP21`, and exposes the intended external nets `AGND`, `EXPO_OUT`, `RAMP_NODE`, and `RESET_CTRL`
- next move: hook the sheet back into the top-level hierarchy cleanly, then re-check whether project-level validation is finally tool-limited or merely placeholder-limited

### 2026-04-11 - `KiCad top-level ERC recovery`

- question: after hardening threshold, reset, and the current integrator, is the top-level project still crashing `kicad-cli sch erc`
- assumptions: the remaining problems should now be mostly hierarchy hygiene and intentionally light sheets, not fatal schematic corruption
- result: no crash; the top-level ERC now completes and reports `21` violations, dominated by dangling labels and placeholder hierarchy around still-light blocks such as `input_tune`, `power_reference`, and `trim_test`
- next move: keep the core timing path as the trustworthy capture zone, and only promote the next sheet when it removes real uncertainty instead of just silencing reports

### 2026-04-11 - `KiCad power/reference promotion`

- question: can the `p1-power-reference.kicad_sch` sheet graduate from a declared rail vocabulary box into a real bench-facing support fragment
- assumptions: for this round we only need honest rail taps, light local decoupling, and a low-impedance `REFERENCE` source near `1.0 V`; we do not need a full PSU or buffered precision reference yet
- result: yes; the sheet now exports a real standalone netlist with `C30`, `C31`, `C32`, `R30`, `R31`, `TP30`, `TP31`, `TP32`, and `TP33`, and the top-level project now includes those parts on the shared `PLUS12`, `MINUS12`, `AGND`, and `REFERENCE` nets
- next move: either promote `input_tune`/`expo` or come back and do a true wire-level comparator cleanup so ERC stops reading its power pins as abstract labels instead of an explicit local supply story

### 2026-04-11 - `KiCad input/tune promotion`

- question: can the `p1-input-tune.kicad_sch` sheet graduate from a named-port placeholder into a real front-door fragment without pretending we have already solved final panel law or calibration behavior
- assumptions: for this round the honest move is a passive provisional summer where `CV_IN` dominates, `COARSE_TUNE` and `FINE_TUNE` add smaller offsets, and the node gets a weak home through `AGND`
- result: yes; the sheet now exports a real standalone netlist with `R40`, `R41`, `R42`, `R43`, and `TP40`, and the top-level project now includes explicit `CV_IN`, `COARSE_TUNE`, `FINE_TUNE`, `AGND`, and `TUNE_SUM` participation in the front-door path
- next move: keep the front door provisional but honest, then either clean comparator power semantics or decide whether the next promotion target is `expo_converter`

### 2026-04-11 - `KiCad comparator wire cleanup and rail rollback`

- question: can the comparator sheet be pushed from topology-suggestive into real wiring without leaving a fake rail fix behind
- assumptions: threshold/reset topology is already good enough to preserve, but project-wide rail semantics are still fragile enough that any bad cleanup is worse than an honest blocker
- result: yes on the comparator, no on the rail closure; `p1-threshold-comparator.kicad_sch` now exports the intended `THRESHOLD_NODE`, `RESET_CTRL`, and `PULSE_OUT` nets through actual wires and parts, but the attempted global/top-level rail fixes were rolled back after they started to merge rails incorrectly
- next move: treat the current `22`-violation top-level ERC result as the safe baseline, with the remaining real blocker narrowed to KiCad power semantics for `LM311` `V+` / `V-`, not missing oscillator structure

### 2026-04-11 - `KiCad global rail migration and comparator power closure`

- question: can the remaining comparator rail blocker be closed without going back to ambiguous project-wide rail aliases
- assumptions: the safer long-term move is to standardize the promoted `KiCad` capture on global `+12V` / `-12V` nets, then make the comparator sheet semantics explicit enough that project ERC measures the real topology instead of a hierarchy-only power heuristic
- result: yes; `p1-power-reference.kicad_sch` and `p1-threshold-comparator.kicad_sch` now use shared global `+12V` / `-12V` rails, top-level netlist export still passes, standalone comparator netlist export still passes, and top-level ERC is stable at `19` findings with the old `LM311` `V+` / `V-` `power_pin_not_driven` blocker removed
- note: the embedded `LM311` symbol on the threshold sheet now treats `V+` and `V-` as ordinary rail pins, because that was the only stable way to make `KiCad` stop misclassifying the shared bench rails as undriven inside this hierarchy
- next move: leave rail semantics alone now and spend the next cleanup energy on the remaining placeholder and hierarchy findings rather than reopening the comparator supply story

### 2026-04-11 - `KiCad top-level bench I/O cleanup`

- question: can the root-sheet external I/O vocabulary get an explicit owner without pretending we have already designed the final panel hardware
- assumptions: a dedicated `p1-bench-io.kicad_sch` support sheet with simple headers and only a weak `SYNC_IN` pulldown is enough for this phase
- result: yes; `p1-bench-io.kicad_sch` now owns the bench-facing `CV_IN`, `COARSE_TUNE`, `FINE_TUNE`, `SYNC_IN`, `SAW_OUT`, `PULSE_OUT`, and `AGND` story through `J50`, `J51`, and `R50`, standalone bench-I/O netlist export passes, top-level netlist export still passes, and top-level ERC is now warning-only at `11` findings with the old dangling root-I/O cluster removed
- note: standalone ERC for the new bench sheet is still not a trustworthy acceptance gate, because hierarchical labels are expected to look parentless when the sheet is checked in isolation
- next move: either clean the remaining embedded-symbol `lib_symbol_mismatch` warnings or finally deepen `p1-expo-converter.kicad_sch`

### 2026-04-12 - `KiCad expo converter promotion`

- question: can the `p1-expo-converter.kicad_sch` sheet graduate from a pure interface box into a real control handoff without pretending we already built the final transistor-pair/tempco expo
- assumptions: for this round the honest move is a reference-anchored voltage-domain proxy where `TUNE_SUM` biases an internal `EXPO_PROXY` node and `EXPO_OUT` is a lightly isolated handoff into the timing body
- result: yes; the sheet now exports a real standalone netlist with `R60`, `R61`, `R62`, and `TP60`, the top-level netlist now includes those parts on the `TUNE_SUM` / `REFERENCE` / `EXPO_OUT` path, and top-level ERC stays at `11` warning-only findings with no new error-level regression
- note: this is still the modest KiCad companion to the earlier behavioral expo study, not yet the later matched-pair or tempco-compensated analog stage
- next move: either clean the remaining embedded-symbol `lib_symbol_mismatch` warnings or deepen the expo/integrator path toward the transistor-level learning target

### 2026-04-12 - `KiCad embedded-symbol warning cleanup`

- question: can the remaining top-level `lib_symbol_mismatch` warnings be removed without reopening the already-closed comparator rail blocker
- assumptions: passive `R` / `C` warnings are safe library-sync cleanup, while the comparator needs a formal project-local symbol so the intentional passive `V+` / `V-` semantics stop masquerading as a drifted copy of stock `LM311`
- result: yes; the embedded passive symbols in `p1-input-tune.kicad_sch`, `p1-power-reference.kicad_sch`, and `p1-bench-io.kicad_sch` are now synced to the current KiCad 9 library definitions, `p1-threshold-comparator.kicad_sch` now uses the project-local symbol `mamut-p1-vco:LM311_P1`, and the new `mamut-p1-vco.kicad_sym` plus `sym-lib-table` make that comparator variant explicit at project scope
- verification: standalone netlist export passes for `p1-threshold-comparator.kicad_sch` and `p1-power-reference.kicad_sch`, top-level netlist export passes, and top-level `kicad-cli sch erc` now reports `0` findings
- next move: embedded-symbol hygiene is no longer the blocker; the next substantive choice is whether to deepen `expo_converter` toward a transistor-level/tempco stage or move to the next analog refinement target

### 2026-04-12 - `KiCad expo converter current-source pass`

- question: can the `p1-expo-converter.kicad_sch` sheet deepen from a resistor proxy into a first honest current-facing handoff without reopening project ERC issues
- assumptions: this round should stay modest, with a provisional `Q60` PNP stage, an internal `EXPO_BIAS` control node, resistor placeholders for `OFFSET_TRIM` and `SCALE_TRIM`, and no claim yet that the final matched-pair/tempco story is solved
- result: yes; the sheet now exports a real standalone netlist with `Q60`, `R60`, `R61`, `R62`, `R63`, and `TP60`, the top-level netlist export still passes, and top-level `kicad-cli sch erc` stays at `0` findings
- note: `EXPO_OUT` is now transistor-backed instead of a voltage-domain proxy, while `REFERENCE` and `TUNE_SUM` still enter through intentionally provisional trim and bias structure
- next move: either deepen the expo path again toward matched-pair/tempco realism or refine the current integrator around the new current-facing handoff

### 2026-04-12 - `KiCad current integrator active-buffer pass`

- question: can the `p1-current-integrator.kicad_sch` sheet deepen around the new current-facing `EXPO_OUT` handoff without merging reset ownership back into the same sheet
- assumptions: this round should keep the raw capacitor-reset core intact, then add only a modest active saw buffer so `RAMP_NODE` stays the comparator/reset reference while `SAW_OUT` becomes an explicit buffered export
- result: yes; the sheet now exports a real standalone netlist with `R20`, `C20`, `R21`, `R22`, `U20`, `TP20`, `TP21`, and `TP22`, `p1-reset-output.kicad_sch` is narrowed back to the discharge pocket, and the top-level project now sees `SAW_OUT` owned by `current_integrator`
- verification: standalone netlist export passes for `p1-current-integrator.kicad_sch`, top-level netlist export passes, and top-level `kicad-cli sch erc` reports `0` findings after the active-buffer cleanup
- note: this is still a first-pass TL071 follower around the raw ramp core, not yet a final high-linearity production integrator or the end of expo/integrator refinement
- next move: either deepen the expo block toward matched-pair/tempco realism or revisit the integrator again for a fuller active-core story

### 2026-04-12 - `KiCad expo converter matched-pair tempco pass`

- question: can the `p1-expo-converter.kicad_sch` sheet stop being a provisional single-transistor proxy and become a real rail-aware matched-pair/tempco capture without regressing the now-clean top-level ERC state
- assumptions: this round should make `OFFSET_TRIM` and `SCALE_TRIM` real owned structure, keep `HF_TRIM` reserved, and stay honest about thermal-coupling intent without prematurely locking the final production package or BOM
- result: yes; the sheet now exports a real standalone netlist with `Q60`, `Q61`, `Q62`, `R60` through `R65`, `RV60`, `RV61`, and `TP60`, and the top-level project now sees explicit `+12V`, `-12V`, `AGND`, `TUNE_SUM`, `REFERENCE`, and `EXPO_OUT` participation through a matched-pair transistor stage instead of a first-pass PNP proxy
- verification: standalone `kicad-cli sch export netlist` passes for `p1-expo-converter.kicad_sch`, top-level `kicad-cli sch export netlist` passes, and top-level `kicad-cli sch erc` reports `0` findings after the matched-pair/tempco cleanup
- note: the active expo internals now name `CV_BASE`, `REF_BASE`, `REF_COL`, `PAIR_EMIT`, and `EXPO_CTRL`, so the netlist finally shows where the scale path, offset anchor, collector load, and shared emitter tail actually live
- next move: either deepen `current_integrator` around this more honest current handoff again, or start deciding how much of the expo BOM and compensation story should be locked before layout-facing work
