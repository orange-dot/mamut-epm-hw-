# Oscillator Strategy

## Purpose

This document defines the current oscillator strategy direction for `Mamut` in relation to:

- `Horizont`
- `Pec`
- `Baklja`
- `Gravitacija`

The goal is not to choose a single chip or schematic yet. The goal is to define what the oscillator system must do for the instrument.

## Core Requirement

The oscillator system must support three things at once:

- `Horizont` openness
- `Pec` mass
- `Baklja` rupture potential

If it only does one of these well, it is the wrong oscillator strategy for this synth.

## What The Oscillators Must Provide

The oscillator section must be able to produce:

- wide, elegant harmonic openness
- dense low-mid body
- aggressive sync-first rupture potential with crossmod poison available
- enough tuning credibility for polyphonic playing
- enough instability headroom for musical danger

That combination is the whole challenge.

## Recommended Voice Layout

Current recommended voice layout:

- `VCO/DCO 1`
- `VCO/DCO 2`
- `Sub`

With likely supporting features:

- sync
- crossmod or FM-like pressure
- oscillator mix control
- patch-dependent weighting into `Gravitacija`

This is the minimum layout that still gives us room for all three tonal roles.

## Role Of Oscillator 1

Current recommendation:

- oscillator 1 should be the anchor
- it should give pitch confidence
- it should support `Horizont`
- it should remain readable even when `Gravitacija` rises

This oscillator is what keeps the synth from collapsing into mush when the patch gets large.

## Role Of Oscillator 2

Current recommendation:

- oscillator 2 should be the tension source
- it should feed width, beating, pressure, and future rupture
- it is the most likely source of sync and crossmod character

This oscillator is where a large part of the path from `Horizont` to `Baklja` begins.

## Role Of The Sub

The sub is not just bass support.

Its deeper role is:

- reinforce `Pec`
- increase perceived mass
- shift the center of gravity downward
- help chords feel physically loaded

The sub should likely be one of the main things `Gravitacija` can lean on in the middle range.

## Desired Behavior By Tonal Role

### Horizont

For `Horizont`, the oscillator system should give:

- stable spread
- breathing harmonic openness
- chord size without smear
- width without fake chorus dependence

This implies:

- controlled detune
- preserved clarity
- less internal strain

### Pec

For `Pec`, the oscillator system should give:

- stronger mass
- thicker fundamental body
- denser inter-oscillator relationship
- more loaded harmonic center

This implies:

- stronger sub interaction
- more packed mixer relationships
- heavier beating or clustering when desired

### Baklja

For `Baklja`, the oscillator system should give:

- a real rupture path
- tearing harmonics
- sync violence
- crossmod bite

This implies:

- one oscillator must be able to stress the other
- the path must be thresholdable
- the synth must not need a completely different engine just to erupt

## DCO vs VCO Direction

The current realistic choice space is:

- DCO-based architecture
- digitally controlled VCO architecture

## DCO Strengths

Advantages:

- tuning credibility for polyphony
- more stable patch recall
- easier calibration story
- safer behavior for `Horizont`

Risks:

- can become too polite
- can feel too controlled if no instability path is designed in

## VCO Strengths

Advantages:

- stronger inherent movement
- more natural internal life
- potentially richer tension behavior

Risks:

- tuning burden multiplies with polyphony
- `Horizont` can become harder to preserve if instability is too high
- service and calibration get harder fast

## Current Recommended Direction

For V1, the current best direction is:

- a stable core oscillator architecture
- with designed-in instability and rupture paths
- rather than a wildly unstable base oscillator system

In practice, that means:

- preserve polyphonic confidence
- add danger intentionally
- let `Baklja` be designed, not accidental

This still leaves room for either:

- DCO with rich nonlinear behavior
- or digitally controlled VCO with strong autotune support

## Learning Prototype Decision

The long-term instrument architecture is still open, but the immediate learning path is not.

For the near-term prototype sequence, the current recommendation is:

- start with a discrete analog VCO study
- make one oscillator truly understandable before building a full voice
- use that oscillator as the seed for later sync-first `Baklja` experiments

See:

- `docs/analog-learning-roadmap.md`
- `docs/p1-discrete-vco-prototype.md`

## Chosen Rupture Direction

The current chosen rupture direction is:

- `Baklja` is `sync-first`
- but `crossmod-poisoned`

This means:

- sync provides the main rupture spine
- crossmod provides contamination and inner instability
- the oscillator system keeps pitch readability longer before entering true danger

For the detailed rupture logic, see `docs/baklja-rupture-strategy.md`.

## Oscillator Relationship To Gravitacija

`Gravitacija` should influence the oscillator system in stages.

### Low Gravitacija

Expected oscillator behavior:

- stable
- open
- wide
- elegant

Likely influences:

- less sub dominance
- more separation between oscillators
- less sync/crossmod readiness

### Mid Gravitacija

Expected oscillator behavior:

- thicker
- heavier
- closer
- more loaded

Likely influences:

- sub comes forward
- oscillator mix packs tighter
- harmonic center thickens
- low-mid energy rises

### High Gravitacija

Expected oscillator behavior:

- stressed
- pressurized
- on edge
- ready to rupture

Likely influences:

- sync becomes clearly active
- crossmod begins to bleed in
- instability allowance rises
- asymmetry becomes more audible
- harmonic tearing becomes possible

## Recommended Rupture Path

For V1, the oscillator system should probably choose one primary `Baklja` path and do it well.

Current strongest candidates:

- sync-led rupture
- crossmod-led rupture
- hybrid sync + crossmod path

My current recommendation:

- choose a dominant rupture language
- allow the second one as reinforcement, not equal co-leadership

The current chosen direction is:

- sync-led rupture
- with crossmod as toxic reinforcement

That keeps the instrument specific.

## Chosen Oscillator Role Split

The current chosen role split is:

- `osc1` = master / anchor / pitch center
- `osc2` = slave / tension source / rupture carrier
- `sub` = `Pec` anchor / mass protector

This role split should stay stable across patches even if the exact response curves change.

## Voice Individuality

The oscillator system should support controlled voice individuality.

Good kinds of individuality:

- slight phase/personality differences
- slight movement differences
- controlled spread
- optional slop at high stress

Bad kinds:

- poor tuning
- accidental collapse of chords
- unmusical drift

## What The Oscillator System Must Not Become

It must not become:

- too safe to rupture
- too unstable to play chords confidently
- too dependent on effects for scale
- too dependent on distortion for interest
- too complex to calibrate in any realistic way

## V1 Recommendation Summary

The current V1 oscillator recommendation is:

- 2 oscillators plus sub per voice
- stable polyphonic center
- deliberate weight path for `Pec`
- deliberate rupture path for `Baklja`
- strong interaction with `Gravitacija`
- `osc1` as anchor, `osc2` as rupture carrier, `sub` as mass anchor
- sync-led rupture with crossmod poison

This gives the best chance of preserving all three tonal roles in one coherent instrument.
