# System Block Diagram

## Internal EPM Framing

This is the current `EPM2` hardware-side system view for `Mamut EPM`.

`EPM1` mirrors the same identity language in software, but this document is
about the hardware/control partition carried in `mamut-sint-hw`.

## Purpose

This document describes the current working `EPM2` system structure of `Mamut`
as a desktop analog polysynth built around:

- `Horizont`
- `Pec`
- `Baklja`
- `Gravitacija`

This is not a final schematic. It is a design diagram for architecture decisions.

## Top-Level Signal Model

Current high-level signal flow:

1. external control enters from keyboard, panel, pedal, or future tablet
2. digital brain interprets control intent
3. per-voice control signals are generated
4. analog voice path produces tone
5. voice summing and final character stages shape the body
6. optional digital effects finish the performance image
7. stereo output leaves the instrument

## Control Plane

### External Control Inputs

Current expected control sources:

- `PC4` note input
- velocity
- aftertouch
- sustain / pedal inputs
- hardware panel controls
- expression pedal
- MIDI CC / NRPN
- future `IdeaPad` touch interface

## Digital Brain

The digital brain is responsible for:

- MIDI parsing
- voice allocation
- patch recall
- parameter smoothing
- calibration support
- macro engine
- `Gravitacija` distribution
- scene state handling
- panel scan logic
- future tablet protocol bridge

This is the control center of the instrument, not the source of the core audio identity.

## Main Macro Distribution

The digital brain should distribute:

- direct parameters
- patch-defined macro sensitivity
- global `Gravitacija`
- `Baklja` threshold logic
- future performance-layer macros

Current internal flow:

1. player moves `Gravitacija`
2. digital brain resolves patch-specific response
3. hidden layers are computed:
   - `Mass`
   - `Strain`
   - `Headroom`
   - `Baklja Threshold`
4. those layers are sent to voice-level and global destinations

## Per-Voice Audio Path

Current conceptual voice chain:

1. oscillator section
2. voice mixer
3. pre-filter load stage
4. filter
5. VCA / amplitude shaping
6. optional per-voice nonlinear accent path
7. voice output to summing bus

## Per-Voice Control Path

Each voice should receive:

- pitch control
- oscillator relationship control
- envelope control
- filter control
- VCA control
- `Gravitacija` response components
- voice individuality offsets

This allows the synth to feel like one instrument while still preserving voice character.

## Tonal Role Placement

### Horizont Placement

`Horizont` should primarily live in:

- oscillator openness
- spacing and harmonic spread
- headroom-preserving filter behavior
- air in the envelope feel
- openness in the final stage

This means `Horizont` is mostly expressed in:

- early voice formation
- preserved openness later in the chain

### Pec Placement

`Pec` should primarily live in:

- oscillator/sub mass
- mixer density
- pre-filter load
- filter input pressure
- sustain body
- summing density
- final-stage low-mid force

This means `Pec` is expressed across:

- voice creation
- voice processing
- global output body

### Baklja Placement

`Baklja` should primarily live in:

- oscillator sync backbone with crossmod bleed
- rupture-enabled filter behavior
- harsh asymmetry
- edge states in final saturation
- stress-dependent overtone emergence

This means `Baklja` is not a single block. It is a coordinated threshold event across several blocks.

## Global Structure

The synth should be thought of as two overlapping systems:

### 1. Voice System

What each voice does individually:

- pitch
- harmonic shape
- filter behavior
- envelope articulation
- local stress behavior

### 2. Organism System

What the instrument does as one body:

- `Gravitacija`
- summing density
- final-stage headroom
- collective weight
- `Baklja` readiness

This split is critical. If everything is only per voice, the synth feels fragmented. If everything is only global, the synth feels fake.

## Summing And Final Stage

Current recommendation:

- voices should sum into a body-building stage
- the final stage may include nonlinear behavior
- that stage should respond to `Gravitacija`
- that stage may be where part of `Pec` and late-stage `Baklja` become audible

Possible functions here:

- saturation
- asymmetry
- bus compression feel
- harmonic strain
- low-mid shaping
- headroom reduction

## Digital Effects Block

If included in V1, digital effects should sit after the core analog identity is already established.

Current likely role:

- extend space
- widen or animate image
- support performance scenes
- reinforce, not replace, `Horizont`

Effects should not be responsible for creating the entire identity.

## Future IdeaPad Control Plane

The future tablet should sit in the control plane, not the audio plane.

Recommended flow:

1. `IdeaPad` app sends high-level control data
2. digital brain receives and interprets it
3. synth internal macro engine resolves it
4. voice and global systems respond

This keeps the instrument coherent even if the UI changes later.

## Minimal V1 Block Diagram

Recommended minimum viable block diagram:

1. External controls
2. Digital brain
3. Voice allocation + macro engine
4. Per-voice oscillators
5. Voice mixer
6. Pre-filter load
7. Filter
8. VCA
9. Voice summing
10. Final character stage
11. Optional digital effects
12. Stereo output

With `Gravitacija` touching:

- oscillator weight
- pre-filter load
- filter strain
- envelope density feel
- summing density
- final-stage headroom
- `Baklja` threshold behavior

## Design Test

The block diagram is working if:

- `Horizont`, `Pec`, and `Baklja` can each be heard as distinct roles
- `Gravitacija` can move the synth across those roles
- the player still feels one instrument, not a set of disconnected tricks
