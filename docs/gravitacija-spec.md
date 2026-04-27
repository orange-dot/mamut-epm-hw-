# Gravitacija Spec

## Purpose

`Gravitacija` is not a normal macro.

It is the main organism-scale control concept of the synth. Its purpose is to move the instrument from the open, vast state of `Horizont`, through the mass and heat of `Pec`, toward the eruptive threshold of `Baklja`.

Short version:

- `Horizont` is the open state
- `Pec` is the loaded state
- `Baklja` is the eruptive state
- `Gravitacija` is the force that pulls the synth through that journey

## Core Definition

`Gravitacija` should feel like the whole synth is being pulled inward toward mass, load, and internal stress.

It is not:

- a simple distortion knob
- a cutoff shortcut
- a space effect
- a rotary simulation
- random chaos

It is:

- increased mass
- reduced apparent headroom
- harmonic bending
- denser body
- stronger low-mid authority
- more proximity to rupture

## Conceptual Role

The key rule is:

- `Gravitacija` is the path
- `Baklja` is the event

The synth should not live in rupture by default. It should become dangerous only when `Gravitacija` and performance pressure take it there.

## Behavioral Zones

The current recommended response is non-linear, with four expressive zones.

### Zone 1: 0-25

Primary identity:

- `Horizont`

Expected feel:

- open
- expensive
- high-headroom
- wide
- dark but elegant

Behavior:

- less saturation
- more air
- more spatial scale
- less strain

### Zone 2: 25-55

Primary identity:

- transition from `Horizont` into `Pec`

Expected feel:

- more body
- warmer
- denser
- less empty air

Behavior:

- increased low-mid weight
- stronger oscillator mass
- more loaded filter input
- more physical presence

### Zone 3: 55-80

Primary identity:

- `Pec` under load

Expected feel:

- compressed
- hot
- harmonically stressed
- dense and close

Behavior:

- rising saturation
- reduced apparent headroom
- more strain in filter and output stages
- more readiness for rupture

### Zone 4: 80-100

Primary identity:

- `Baklja` threshold

Expected feel:

- dangerous
- ripping
- near-collapse
- still steerable

Behavior:

- tearing harmonics can emerge
- sync aggression opens first and crossmod poison can follow
- output character becomes more unstable
- the player should feel that the synth is near the edge

## Internal Layering

Externally, `Gravitacija` should appear as one control.

Internally, it should be implemented as multiple hidden response layers so that different patches can shape the meaning of the same gesture.

Current recommended hidden layers:

### 1. Mass

Controls:

- oscillator weight
- sub presence
- low-mid reinforcement
- tone density

### 2. Strain

Controls:

- saturation amount
- asymmetry
- harmonic stress
- pre-rupture tension

### 3. Headroom

Controls:

- apparent openness
- dynamic ceiling
- compression feel
- bus loading

### 4. Baklja Threshold

Controls:

- how early rupture behaviors begin
- how aggressively edge behavior appears
- how much the player can push before the sound tears open

Patch design should be able to rebalance these layers while keeping `Gravitacija` as the main visible axis.

## Where Gravitacija Should Act

The current recommended implementation spans the whole instrument rather than one single block.

### 1. Voice Tone Layer

`Gravitacija` should influence:

- oscillator weight
- oscillator-to-sub relationship
- harmonic mass
- readiness for sync-first rupture and crossmod bleed

Goal:

- make the voice feel denser before it feels broken

### 2. Filter Layer

`Gravitacija` should influence:

- pre-filter drive
- tonal bias toward mass
- filter strain or harmonic pressure
- transition from open to loaded behavior

Goal:

- avoid simple darkening
- make the filter feel more loaded, not merely more closed

### 3. Envelope / Amp Feel

`Gravitacija` should influence:

- envelope density feel
- sustain body
- transient weight
- the sense that the sound has physical mass

Goal:

- make the synth feel heavier under the fingers

### 4. Voice Summing / Mix Body

`Gravitacija` should influence:

- voice summing density
- bus saturation
- group compression feel
- collective pressure when chords stack

Goal:

- make polyphony feel like one organism rather than six separate polite voices

### 5. Final Character Stage

If the synth includes a final nonlinear stage, `Gravitacija` should influence:

- output saturation
- bias behavior
- asymmetry
- low-mid push
- apparent headroom

Goal:

- make the end of the chain part of the instrument voice

### 6. Baklja Gate

`Gravitacija` should influence:

- when rupture behaviors become available
- how much edge emerges under pressure
- how dangerous the top zone becomes

Goal:

- preserve the distinction between loaded and eruptive

## Control Sources

`Gravitacija` should be controllable from several layers of performance.

### 1. Main Panel Control

The synth should have one primary visible `Gravitacija` control on the hardware side.

Purpose:

- define the patch's base state
- establish the player-facing identity of the instrument

### 2. Aftertouch

External keyboard aftertouch should be able to add momentary `Gravitacija`.

Purpose:

- immediate live pressure
- dynamic push into `Pec` or `Baklja`

This is especially important because the current controller assumption is a `Kurzweil PC4`.

### 3. Expression Pedal

Expression pedal should be able to ride `Gravitacija` continuously.

Purpose:

- large transitions
- slow pulls into mass
- performance arcs across sections

### 4. MIDI CC / NRPN

The digital brain should expose `Gravitacija` to remote control.

Purpose:

- external sequencing
- automation
- future tablet UI
- external control surfaces

### 5. Scene / Morph System

Scene states should be able to store different `Gravitacija` values or response profiles.

Purpose:

- performance contrast
- immediate macro state changes
- transitions between open and loaded worlds

## Recommended Control Hierarchy

Current recommended hierarchy:

- hardware control sets the base state
- aftertouch adds momentary pressure
- expression pedal handles long-form movement
- scenes handle state jumps or morph destinations
- digital external control allows automation and future UI expansion

This gives the player:

- one stable baseline
- one immediate expressive push
- one continuous foot-based movement
- one recallable performance layer

## Patch Memory Model

Patches should not store only a single `Gravitacija` value.

They should store the patch-specific meaning of `Gravitacija`.

Current recommended stored fields:

- default `Gravitacija` position
- `Mass` response amount
- `Strain` response amount
- `Headroom` response amount
- `Baklja` threshold position
- which control sources are allowed to modulate it
- depth scaling for aftertouch and pedal

This allows one patch to use `Gravitacija` elegantly while another uses it brutally.

## Relation To Tubes And Final Character

The current direction does not require a Hammond/Leslie identity.

If tube behavior enters the design, it should serve `Gravitacija`, not become a separate gimmick.

That means tube or tube-like behavior is most useful when it contributes to:

- body
- compression feel
- saturation
- asymmetry
- harmonic strain
- loaded output character

In other words:

- tube behavior is welcome
- organ nostalgia is not the point

## What Gravitacija Must Not Become

`Gravitacija` must not degrade into:

- a disguised distortion amount
- a fake "analog warmth" switch
- a generic macro with no identity
- a simple darkening control
- immediate chaos with no usable middle range

If it does, the concept has failed.

## Minimum Viable V1 Mapping

For the first serious implementation pass, the recommended V1 mapping is:

- oscillator mix weight
- sub emphasis
- pre-filter drive
- filter strain / bias
- envelope density feel
- mix-bus saturation
- final-stage headroom / asymmetry
- `Baklja` threshold opening

That is enough to make `Gravitacija` feel like a real system identity without over-spreading the first implementation.

## UI Note

Detailed tablet or touchscreen UI design is intentionally deferred.

The direction that is now locked is:

- `Gravitacija` is the main organism-scale control concept
- it must exist independently of any one control surface
- later UI work should express this concept rather than redefine it
