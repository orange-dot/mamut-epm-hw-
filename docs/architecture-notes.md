# Architecture Notes

## Internal EPM Framing

This file records the current `EPM2` hardware architecture posture.

- `EPM1` runtime architecture lives in `mamut-sint-sw`
- `EPM1` source architecture docs remain in this repo under the software docs
- `EPM2` hardware execution and bench direction remain the primary concern here

## High-Level Architecture

The current architectural direction is:

- analog audio path
- digital control brain
- external MIDI keyboard/controller
- desktop chassis

This is the most practical way to build a first serious polysynth.

This split is not meant to force the synth into a conservative box. It is just the current best way to make an ambitious instrument without wasting energy on the wrong problems.

For the selected `Experimental Performance Monster` direction, this split has a more specific meaning:

- analog core for weight, nonlinearity, and voice character
- digital nervous system for morphing, macro control, recall, calibration, and performance behavior
- enough end-to-end ownership that the final sound character is not treated as an afterthought

## Working System Split

### Analog domain

Per voice, the analog side is expected to contain:

- oscillator section
- mixer section
- filter
- VCA
- analog signal conditioning and output gain staging
- a sync-first rupture spine with crossmod, overload, filter strain, and output stress available as escalation layers

At the instrument level, the analog side may also include a final character stage that participates in `Gravitacija`.

### Digital domain

The digital side is expected to manage:

- MIDI input handling
- voice allocation
- patch storage and recall
- calibration and autotune routines
- parameter scanning and UI logic
- modulation control generation where appropriate
- system startup and service tooling
- performance macros
- scene morphing or state interpolation where musically appropriate
- global `Gravitacija` coordination if the sound axis spans multiple subsystems

## Polyphony Strategy

Current recommendation:

- start with 6 voices
- keep the voice architecture regular and calibratable

Six voices feels like the current sweet spot between ambition and survivability. It is enough to feel genuinely polyphonic without instantly exploding the project.

## Tonal Architecture

The currently chosen tonal architecture is:

- `Horizont` as the large, open, distant base
- `Pec` as the heated, dense, low-mid force
- `Baklja` as the rupture layer that opens under performance pressure through a sync-first, crossmod-poisoned path

This suggests a synth that does not start broken. It starts huge and weighty, then gets more dangerous as the player leans in.

For the detailed rupture logic, see `docs/baklja-rupture-strategy.md`.

## Oscillator Direction

There are now two different questions here and they should not be confused.

### Learning Track

For the immediate learning prototypes, the chosen direction is:

- discrete analog studies first
- begin with one serious VCO
- understand drift, scaling, sync, and spectral behavior directly

This is the intentionally more painful path because the point is to learn the voice, not to skip to control integration.

See:

- `docs/analog-learning-roadmap.md`
- `docs/p1-discrete-vco-prototype.md`

### Instrument Track

For the eventual full poly architecture, the implementation style is still open.

The later instrument may still favor one of these two approaches:

- DCO-based architecture
- digitally controlled VCO architecture with strong autotune support

Reason:

- true polyphonic analog instruments are much harder to finish well when tuning stability is weak
- the user experience is better if tuning and startup behavior are predictable
- controlled drift can be added intentionally later

This is still a later architectural decision, not a command to make the learning path polite.

## Modulation Direction

The current bias is:

- keep the audio path analog
- allow the control layer to be digitally managed where that improves precision, memory, and repeatability

This supports:

- patch memory
- consistent envelopes
- modulation recall
- per-voice calibration workflows
- monster-layer performance gestures that can move many things at once

## Performance Layer

The `Experimental Performance Monster` identity likely needs a dedicated performance layer above the normal synth parameters.

Working candidates:

- `Bloom` - opens, widens, lengthens, and makes the sound feel larger
- `Ruin` - adds instability, violence, crossmod, drift, and near-collapse behavior
- `Swarm` - increases voice spread, density, detune, and collective motion
- `Tilt` - shifts the whole patch brighter/darker or tighter/looser
- `Heat` - adds saturation, compression feel, density, and internal pressure

These are not fixed implementations yet. They are anchors for the kind of instrument behavior we want.

## Gravitacija Axis

`Gravitacija` is currently the most important nontraditional system behavior in the concept.

It is explicitly preferred over a rotary/Leslie-style identity story.

Instead of spatial spin, the sound should gain:

- load
- heat
- density
- saturation
- harmonic strain
- reduced apparent headroom
- inward pull

Possible implementation layers for `Gravitacija` include:

- output-stage saturation behavior
- dynamic gain staging
- tube-stage or tube-like nonlinear behavior
- bias movement
- asymmetry
- compression feel
- low-mid emphasis shifts

The external behavior should feel like one musical control even if it moves several hidden subsystems.

For the current detailed direction, see `docs/gravitacija-spec.md`.

## Effects Direction

The current recommendation is:

- analog core voice path
- digital effects after the analog engine

This is a high-leverage product decision because effects make the synth feel finished without multiplying the analog complexity inside each voice.

Good V1 candidates:

- chorus
- delay
- reverb

For this synth, effects should be treated as part of the performance body, not just polish. Wide modulation and post-voice motion may be essential to the monster character.

At the same time, the project is no longer pursuing a Hammond/Leslie-inspired rotary identity. If there is an end-of-chain character stage, it should serve `Gravitacija`, not imitate organ tradition.

## Voice Individuality

The synth should not necessarily behave like six perfectly identical lab voices.

Working direction:

- controlled drift
- slight envelope variation if desirable
- voice-to-voice character spread
- optional slop as a musical control, not an accident

The point is not poor calibration. The point is controlled individuality.

## Reality Constraints

These need to be treated as first-class architecture constraints:

- thermal stability
- calibration time per unit
- component matching and availability
- power supply noise
- analog and digital ground strategy
- serviceability
- production test hooks

These are not here to make the project boring. They are here so the bold version of the synth can survive contact with reality.

## V1 Constraint Summary

The current technical posture is:

- ambitious on sound and voice count
- selective about architecture risk
- intentional about calibration
- strict about scope

That combination gives the best chance of building a real synth instead of a permanently unfinished fantasy.
