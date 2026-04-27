# P1 Discrete VCO Prototype

## Purpose

`P1` is the first learning prototype for `Mamut`.

It is not a full synth voice.
It is not the fastest path to a demo.
It is the point where we learn whether we can make one oscillator behave like the start of an instrument.

## Why P1 Comes First

If the first oscillator is vague, unstable, or sonically weak, every later prototype becomes harder to interpret.

A bad oscillator poisons:

- filter evaluation
- sync evaluation
- crossmod evaluation
- envelope feel
- tuning expectations

So the first commitment is:

- build one VCO that can be measured and evaluated
- measure it properly
- understand why it behaves the way it does

## Recommended P1 Stance

For `P1`, the recommended stance is:

- discrete analog core
- utility ICs allowed
- no solderless breadboard as the main audio platform
- optimize for understanding, not miniaturization

This means:

- op-amps are fine
- comparators are fine
- regulators are fine
- trimmers are fine
- matched transistor pairs or tightly coupled discrete transistors are fine

The core learning target is the oscillator behavior itself.

## Recommended Core Topology

For `P1`, the current recommendation is:

- saw-core VCO

Why:

- easy to reason about in the time domain
- naturally aligned with hard sync experiments
- saw output is directly useful
- pulse output is easy to derive
- a later `Baklja` lab benefits from a sync-friendly core

Triangle-core is still worth studying later, but saw-core is the better first teacher for this project.

## Functional Blocks

Recommended `P1` block diagram:

1. pitch CV input and scaling
2. tuning controls
3. expo converter
4. current source into timing capacitor
5. comparator or threshold detector
6. reset switch path
7. raw saw output
8. pulse generation
9. optional triangle shaper
10. hard sync input
11. simple FM or modulation injection point
12. output buffer and monitor path

## Minimum Features

`P1` should have at least:

- `1 V/oct` input
- coarse tune
- fine tune
- raw saw output
- pulse output
- hard sync input
- stable power entry and local decoupling
- accessible test points

Strongly recommended:

- optional triangle output
- linear FM or simple modulation injection input
- sync amount or sync conditioning option
- temperature-aware transistor placement

## Theory Targets

`P1` is where we should make these ideas real:

### Exponential Conversion

We need to see why `1 V/oct` is difficult.

That means learning:

- how current changes with control voltage
- why matched transistors matter
- why thermal coupling matters
- why trimming exists

### Time-Domain Core Motion

We need to see:

- current charging a capacitor
- voltage ramp formation
- threshold comparison
- reset action

This is the real shape logic of the oscillator.

### Waveform Consequences

We need to hear and see:

- what a healthy saw looks like
- how pulse changes the harmonic story
- how reset behavior affects sharpness and bleed

### Hard Sync Behavior

We need to understand:

- how the slave waveform is forcibly reset
- why harmonic tearing appears
- why sync preserves a pitch spine better than crossmod

This is important because `Baklja` will grow out of this.

## Suggested Core Components

This is not yet a fixed BOM, but the prototype likely wants:

- matched transistor pair or thermally coupled NPN pair for expo work
- precision reference strategy
- stable timing capacitor
- low-noise op-amps for support functions
- comparator with clean switching behavior
- multiturn trimmers for scale and offset
- decent panel pots for tune controls

Important:

- use parts stable enough to teach clearly
- do not choose junk parts and call the resulting confusion "analog character"

## Power And Layout Guidance

Recommended assumptions:

- analog rails around `+/-12 V`
- short local return paths
- local decoupling near active devices
- oscillator core physically compact
- expo pair and temp-sensitive parts placed intentionally

Avoid:

- long random flying wires in the core
- casual breadboard parasitics
- digital lines running through the analog core area

`P1` should teach the circuit, not the chaos of a bad bench setup.

## Instrumentation

Minimum useful measurement stack:

- scope
- multimeter
- stable reference tuner or frequency counter
- audio monitor path
- audio interface plus FFT if available

Helpful measurements:

- control voltage at input
- expo node behavior
- ramp amplitude
- reset event shape
- output amplitude over frequency range

## Success Criteria

`P1` is successful if it can do all of the following:

- start reliably
- hold musically credible tuning over several octaves
- produce a clean, recognizable raw waveform
- respond meaningfully to sync
- survive tuning and sync tests without becoming erratic garbage

Reasonable early target:

- musically credible tracking over `3 to 4 octaves`
- stable enough to hear interval structure clearly
- repeatable behavior after warm-up

This is not yet "shipping synth" accuracy.
It is "real instrument lessons begin here" accuracy.

## Failure Modes Worth Expecting

Common early failures:

- scale trim never really settles
- temperature drift is worse than expected
- waveform amplitude changes too much with pitch
- reset path injects ugly artifacts
- sync works but sounds cheap
- oscillator stalls or misbehaves at range edges

These are not reasons to abandon the prototype.
They are the content of the prototype.

## Listening Checklist

When listening to `P1`, ask:

- does the oscillator feel alive or merely unstable?
- does the saw feel large enough to become `Horizont` later?
- does the lower register already hint at `Pec`?
- does sync sound like the first honest trace of `Baklja`?
- does the oscillator still feel like it has a center under stress?

If the answer to the last question is no, the later rupture story gets much harder.

## What P1 Deliberately Does Not Solve

`P1` is not trying to solve:

- full voice architecture
- envelopes
- filter identity
- polyphony
- patch memory
- final `Gravitacija` engine

It is only solving the first moving heart.

## Exit Condition To P2

We should move from `P1` to `P2` when:

- the oscillator can be tuned and trusted
- the sync input behaves repeatably
- the waveform is musically useful
- the test setup is no longer the main source of uncertainty

At that point the next step is clear:

- build a second oscillator
- create the first real `Baklja` lab
- study sync-first rupture with crossmod poison on purpose
