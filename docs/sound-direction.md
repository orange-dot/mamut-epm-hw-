# Sound Direction

## Internal EPM Framing

This document defines the shared tonal language for `Mamut EPM`.

- `EPM1` uses it as the current software/runtime expression
- `EPM2` uses it as the hardware target carried in this repo

The vocabulary below is therefore shared, even when the implementation path is
different.

## Chosen Tonal Stack

The current sound direction of `Mamut` is now explicitly defined as:

- base: `Horizont + Pec`
- rupture layer: `Baklja`
- global organism axis: `Gravitacija`

This is the tonal language of `Mamut EPM` across both lines.

## Horizont

`Horizont` is the large, distant, gravitational part of the sound.

It should feel like:

- air
- scale
- width
- gravitational pull
- headroom
- dark elegance

It is not meant to be nostalgic or soft. It is meant to feel physically vast and serious, like you are hearing the edge of something too large to hold.

Typical emotional read:

- sacred
- imposing
- cinematic
- cold but beautiful

## Pec

`Pec` is the furnace at the center of the instrument.

It should feel like:

- heat
- density
- pressure
- low-mid authority
- harmonic thickness
- internal compression

This is what stops the synth from becoming only beautiful or only spacious. It gives it body, push, and a sense that something is burning inside.

Typical emotional read:

- muscular
- loaded
- hot
- heavy
- dangerous when pushed

## Baklja

`Baklja` is not the default state of the synth.

`Baklja` is what erupts when performance pushes the instrument into damage, mutation, or edge.

The chosen rupture language is:

- sync-first
- crossmod-poisoned
- finished by filter strain and final-stage asymmetry

It should feel like:

- tearing harmonics
- sync violence
- crossmod bite
- instability on purpose
- near-collapse
- exposed circuitry

This is important: `Baklja` is not random chaos. It is a musically steerable eruption in the instrument.

Typical emotional read:

- feral
- incandescent
- unstable
- urgent
- thrilling

## Gravitacija

`Gravitacija` is the main nontraditional sound axis currently chosen for the project.

It is not:

- a Leslie story
- a rotary motion story
- a simple effect
- a single distortion knob

It is:

- the sensation that the whole synth is being pulled inward
- a way to move from open headroom toward mass, bend, and internal stress
- a control that can reshape tone, body, saturation, and intensity together

## Gravitacija Curve

At low values:

- open
- expensive
- wide
- headroom-rich
- more `Horizont`

At medium values:

- denser
- warmer
- more body
- more `Pec`
- less empty air, more internal mass

At high values:

- compressed
- saturated
- harmonically bent
- urgent
- starting to lean toward `Baklja`

At extreme values:

- near-collapse
- ripped edges
- dangerous
- still playable if designed correctly

## Performance Trajectory

The intended musical journey is:

1. begin from beauty and scale
2. add body and heat
3. increase internal pressure
4. trigger `Baklja`
5. pull back without losing control

That journey is central to the synth. The instrument should have somewhere meaningful to go.

## End-to-End Ownership

The project currently values end-to-end ownership of the sound.

That means the final character of the instrument should not be treated as an afterthought. If the synth wants a final stage with tube behavior, output saturation, or other large-scale nonlinear character, that should be considered part of the instrument voice.

At the same time, the project is explicitly not chasing a Hammond/Leslie-style rotary identity.

If a final character stage exists, it should serve:

- `Gravitacija`
- body
- saturation
- stress
- harmonic personality

Not organ nostalgia.

## Design Consequence

This tonal stack gives the project a usable rule:

- the synth should start powerful before it starts unstable
- it should become dangerous only when the player asks for it
- every macro and architecture decision should preserve the path from `Horizont` to `Pec` to `Baklja`

For system placement and implementation detail of these three tonal roles, see `docs/tonal-architecture.md`.
