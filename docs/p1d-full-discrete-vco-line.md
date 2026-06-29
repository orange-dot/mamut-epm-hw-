# P1D Full Discrete VCO Line

## Purpose

`P1D` is the full-discrete learning branch of the first `P1` oscillator.

The goal is not to make the quickest stable oscillator. The goal is to
understand the oscillator deeply enough that each part of the circuit can be
explained, measured, broken, and repaired.

`P1D` removes the two utility ICs from the current `P1` capture:

- `LM311` comparator
- `TL071` saw buffer

The circuit should use only discrete analog parts on the oscillator board:

- resistors
- trimmers and pots
- capacitors
- diodes and zeners
- BJTs
- optional JFETs
- connectors and test points

No op-amps, IC comparators, logic ICs, microcontrollers, DACs, regulators, or
module-in-a-chip shortcuts belong in this branch.

Bench instruments are still allowed. A lab supply is not part of the oscillator
board.

## Relationship To P1

The existing `P1` line remains the reference path.

`P1D` should be compared against `P1`, not confused with it:

- `P1` teaches the oscillator with utility ICs allowed.
- `P1D` teaches what those ICs were hiding.

This gives us a control reference. If the full-discrete branch fails, the
question should be specific:

- did the threshold detector load the ramp
- did the reset drive fail
- did the saw buffer pull the timing node
- did the expo source drift
- did the reference move

## Target Topology

Keep the same high-level topology:

1. `CV_IN`, `COARSE_TUNE`, and `FINE_TUNE`
2. tune sum and scale trim
3. thermally coupled transistor expo converter
4. current into timing capacitor
5. ramp threshold detection
6. reset transistor discharge path
7. raw saw output
8. pulse output derived from threshold/reset action
9. sync/reset injection later

The topology remains a saw-core VCO because it is the clearest time-domain
teacher:

- current charges a capacitor
- voltage ramps up
- threshold detector fires
- reset switch discharges the capacitor
- the cycle repeats

## Discrete Replacement Blocks

### Saw Buffer Replacement

The current `TL071` exists to keep `SAW_OUT` from loading `RAMP_NODE`.

The discrete branch should test a high-impedance buffer instead:

- first candidate: JFET source follower
- fallback candidate: Darlington or two-transistor emitter follower
- possible output helper: complementary emitter follower after the first buffer

The main lesson is input loading. If the buffer changes ramp amplitude,
frequency, or reset shape, it is part of the oscillator, not a neutral monitor.

Required observations:

- `RAMP_NODE` without buffer load
- `RAMP_NODE` with buffer connected
- `SAW_OUT` amplitude and DC offset
- frequency shift caused by buffer loading

### Comparator Replacement

The current `LM311` exists to turn `RAMP_NODE > THRESHOLD_NODE` into a clean
reset decision.

The discrete branch should replace it with a transistor threshold detector:

- NPN differential pair comparing `RAMP_NODE` and `THRESHOLD_NODE`
- resistor or transistor tail current source
- collector load resistors
- one or two transistor gain/level stages for `RESET_CTRL`
- intentional hysteresis path from output back into the threshold side

This is the most important learning block in `P1D`.

The goal is not a perfect comparator. The goal is to see how threshold gain,
tail current, collector loading, hysteresis, and output swing change the
oscillator.

Required observations:

- threshold transition speed
- reset pulse height
- reset pulse width
- hysteresis window
- ramp loading from the detector input
- temperature sensitivity of the switching point

### Reset Path

The reset path is already mostly discrete in the current `P1` line.

Carry over the known reset pocket as the starting point:

- base drive resistor around the current `4k7` region
- base-emitter bleed around `100k`
- reset-shaping capacitor around `33p`
- ramp discharge resistor around `330`
- emitter resistor around `22`
- fast clamp diode
- 2N3904-class reset transistor

`P1D` should not change this block first. Use it as a known foothold while the
comparator and buffer become discrete.

### Expo Converter

The expo block should stay transistor-first:

- thermally coupled NPN pair or matched NPN pair
- `2k 3300ppm` tempco in physical thermal contact
- scale trim
- offset trim
- PNP or NPN helper current source into `EXPO_OUT`

This block is allowed to remain modest at first. The first full-discrete lesson
is the closed oscillator loop, not final octave accuracy.

Required observations:

- current change versus tune voltage
- warm-up drift
- scale trim range
- how much tuning moves when the transistor pair is touched, warmed, or cooled

### Reference

Avoid a precision reference IC in `P1D`.

Use a simple discrete reference strategy first:

- resistor divider from the rail
- diode or zener clamp if needed
- local decoupling
- test point

The reference does not need to be production-grade. It needs to be visible and
honest. If it moves during reset, that is evidence.

## Study Order

Do not replace everything at once.

The full-discrete destination is fixed, but the evidence path should be staged:

1. `P1D-00`: copy the current `P1` behavioral reference numbers.
2. `P1D-10`: replace only the saw buffer and measure ramp loading.
3. `P1D-20`: replace only the comparator with a discrete threshold detector.
4. `P1D-30`: close the loop with discrete comparator plus existing reset pocket.
5. `P1D-40`: bring the transistor expo path into the loop.
6. `P1D-50`: add sync/reset injection only after free-run behavior is understood.

Each step should have:

- one question
- one schematic or netlist
- one expected behavior note
- one observed result
- one next move

## First Bench Build Recommendation

The first physical `P1D` build should be larger and uglier than a product board.

Use:

- through-hole parts where practical
- real test points
- short local wiring around the timing capacitor, threshold detector, and reset
  transistor
- socketed or swappable transistor positions for learning
- labelled nodes matching the `P1` naming contract

Avoid:

- solderless breadboard for the timing core
- long flying wires on `RAMP_NODE`
- hiding the transistor pair where it cannot be touched or measured
- compactness as a first goal

## Starter Shopping Delta

Compared with the utility-IC `P1` BOM, `P1D` needs more experimental discrete
stock:

- `2N3904` or equivalent NPN small-signal transistors, quantity `25+`
- `2N3906` or equivalent PNP small-signal transistors, quantity `10+`
- optional JFETs for source-follower experiments, quantity `5+`
- `1N4148` or `1N914` small-signal diodes, quantity `25+`
- small zeners or diode-reference candidates
- C0G/NP0 small capacitors around `10p` to `1n`
- stable timing capacitors around `1n`, `2n2`, `4n7`, and `10n`
- multiturn trimmers around `2k`, `10k`, `20k`, and `100k`
- `2k 3300ppm` tempco resistors if available
- extra test points and headers

Buy enough transistors to match and abuse. One perfect transistor is less
useful than twenty ordinary ones that teach spread.

## Success Criteria

`P1D` succeeds when we can say:

- why the ramp starts
- why it resets
- what sets frequency
- what loads the timing node
- what changes with temperature
- why the pulse output looks the way it does
- which part of the circuit makes tuning better or worse

It does not need to beat the utility-IC `P1` on stability.

It needs to make the oscillator legible.
