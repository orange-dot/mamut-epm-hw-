# Tonal Architecture

## Purpose

`Horizont`, `Pec`, and `Baklja` are not just poetic names.

They are the three main tonal roles inside the instrument.

They answer different questions:

- `Horizont` answers: how does the synth feel when it is open, vast, and expensive?
- `Pec` answers: where do density, heat, and low-mid authority come from?
- `Baklja` answers: how does the synth tear open without turning into meaningless chaos?

These are not independent modes. They are overlapping roles that live in different parts of the system and become more or less audible depending on the patch and on `Gravitacija`.

## High-Level Relationship

The intended tonal logic is:

- `Horizont` is the open state
- `Pec` is the loaded state
- `Baklja` is the eruptive state

And:

- `Horizont + Pec` form the core tone
- `Baklja` is introduced through pressure, performance, and threshold behavior

The synth should not sound like three unrelated engines. The point is one coherent voice with three distinct faces.

## Horizont

## Sonic Role

`Horizont` is the spatial, distant, architectural side of the instrument.

It is where the synth feels:

- open
- dark
- expensive
- wide
- physically large
- calm but enormous

This is the part of the sound that makes a chord feel like it has a sky around it.

## System Role

`Horizont` is primarily a base-state role.

It should dominate when:

- `Gravitacija` is low
- the patch is designed for openness
- the player is not pushing toward rupture

It gives the synth:

- scale
- air
- separation
- headroom

## Where It Lives

Primary homes in the system:

- oscillator spacing and harmonic openness
- filter openness and lack of clogging
- envelope response that preserves air
- stereo or spatial body where appropriate
- final-stage headroom and lack of compression

It should not depend on fake spatial tricks alone. The feeling of scale has to begin in the core tone.

## Implementation Candidates

Current likely implementation areas:

- oscillator detune relationships that feel wide but stable
- controlled harmonic openness rather than narrow dense stacking
- less pre-filter saturation
- filter behavior that preserves top-end air without sounding thin
- more apparent headroom in the voice and output path
- less bus loading

## What Horizont Must Not Become

`Horizont` must not become:

- a reverb preset
- a thin hi-fi mode
- nostalgic softness
- weak bass with fake width
- digital emptiness

It needs to feel large because the instrument is large, not because the effects are pretending.

## Pec

## Sonic Role

`Pec` is the furnace at the center of the synth.

It is where the instrument gets:

- heat
- low-mid authority
- compression feel
- density
- harmonic thickness
- internal push

If `Horizont` is the scale, `Pec` is the mass.

## System Role

`Pec` is part of the core tone, not an optional distortion mode.

It should begin to appear as soon as the sound stops being purely open.

It dominates when:

- `Gravitacija` enters the middle range
- chords need to feel like one loaded body
- the synth needs to feel close and physical

`Pec` is what prevents the instrument from becoming only elegant.

## Where It Lives

Primary homes in the system:

- oscillator and sub balance
- mixer density
- pre-filter drive
- filter input load
- sustain body
- voice summing
- final-stage low-mid shaping

## Implementation Candidates

Current likely implementation areas:

- stronger sub integration
- harmonic reinforcement in the lower mids
- pre-filter saturation
- loaded filter input behavior
- slight envelope heaviness
- bus saturation or summing density
- final-stage saturation, transformer-like thickness, or tube-like stress

## What Pec Must Not Become

`Pec` must not become:

- mud
- fake warmth
- blurry compression
- disconnected bass boost
- constant overdrive

It should feel loaded and hot, not smeared.

## Baklja

## Sonic Role

`Baklja` is the eruption layer.

It is where the synth can become:

- ripping
- torn
- dangerous
- exposed
- unstable on purpose

This is not the base state and should not be always on.

## System Role

`Baklja` is a threshold event role.

It should dominate only when:

- `Gravitacija` is high enough
- performance gestures push it open
- the patch is designed to expose rupture behavior

`Baklja` exists so the synth has a real edge state, not just a louder state.

## Where It Lives

Primary homes in the system:

- sync backbone
- crossmod poison
- pre-filter harmonic tearing
- filter strain near collapse
- final-stage asymmetry and edge
- unstable but controlled overtone emergence

`Baklja` should be available in multiple blocks, but gated so it feels like one event.

## Implementation Candidates

Current likely implementation areas:

- primary oscillator sync activation or intensification
- secondary crossmod bleed into the rupture path
- harsher asymmetric saturation
- fast harmonic tearing under pressure
- threshold-based edge behavior on the output stage
- intentional voice-to-voice divergence at high stress

For the detailed rupture logic, see `docs/baklja-rupture-strategy.md`.

## What Baklja Must Not Become

`Baklja` must not become:

- random noise
- instant unusable chaos
- permanent harshness
- a preset gimmick
- a replacement for musical articulation

The point is not destruction. The point is controlled rupture.

## Relation Between The Three

The important system rule is:

- `Horizont` gives scale
- `Pec` gives body
- `Baklja` gives danger

Or more mechanically:

- `Horizont` should live mostly in openness, spacing, and preserved headroom
- `Pec` should live mostly in density, load, and heated tone mass
- `Baklja` should live mostly in thresholded rupture behavior

The instrument must be able to move through all three without sounding like it switched products.

## Relationship To Gravitacija

`Gravitacija` is the main control force that determines how much each role is exposed.

The rough logic should be:

- low `Gravitacija` favors `Horizont`
- mid `Gravitacija` favors `Pec`
- high `Gravitacija` prepares or opens `Baklja`

This does not mean a hard mode switch. It means a weighted reveal.

## Patch Design Implication

Patches should not just store oscillator and filter values.

They should implicitly decide:

- how much `Horizont` they preserve
- how quickly `Pec` arrives
- how late or early `Baklja` can open

In practice, that means patch structure should be able to rebalance:

- openness
- density
- threshold
- edge

without breaking the identity of the instrument.

## Implementation Priority For V1

The first implementation should aim for:

### Horizont

- convincing open scale
- headroom-rich tone
- wide but not washed-out pad/chord behavior

### Pec

- believable low-mid body
- controlled furnace heat
- chord density that feels expensive rather than muddy

### Baklja

- one truly convincing eruptive behavior path
- likely through sync as the spine, with crossmod and strain as contamination layers
- gated by `Gravitacija` rather than always available at full force

## Design Test

The design is on track if:

- a low-pressure chord sounds immense
- a mid-pressure chord sounds loaded and hot
- a high-pressure gesture sounds like the instrument is tearing open

without any of those three feeling like unrelated effects.
