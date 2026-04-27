# Analog Learning Roadmap

## Purpose

This document defines the learning-first hardware path for `Mamut`.

The goal is not to reach the fastest possible finished polysynth.
The goal is to build the instrument by actually understanding the hard parts:

- power
- tuning
- waveform generation
- spectral behavior
- nonlinear behavior
- control voltage behavior
- thermal drift

This is the deliberately more painful and more educational track.

## Core Stance

The learning path is:

- discrete where it teaches something real
- integrated where the part is only infrastructure
- one prototype at a time
- one main unknown per prototype if possible

This means we do not need to build a fully discrete op-amp religion.
Using op-amps, comparators, regulators, and utility support ICs is fine.
The point is to understand the synth voice, not to cosplay 1972 for its own sake.

## Why This Path Exists

`Mamut` is aiming at a large analog poly in the long run.

That makes it tempting to jump immediately into voice boards, MCU control, and polyphony.
That would be faster only if the core analog behavior were already well understood.

It is not.

So the learning path is:

1. learn the core analog behaviors in isolation
2. turn them into reliable prototype blocks
3. only then discuss the full voice and polyphonic replication

## Theoretical Pillars

The theory that matters most is not abstract math for its own sake.
It is the small set of ideas that directly explains what the circuit is doing.

### 1. Spectral Thinking

The practical Fourier lesson is:

- saw-like waves are rich harmonic raw material
- square-like waves emphasize odd harmonics
- triangle-like waves are softer and less aggressive
- filter movement changes harmonic balance, not just volume
- sync adds upper harmonic tearing while preserving a pitch spine
- crossmod adds sidebands and poison more easily than sync

This is the fastest route from equations to ears.

### 2. Time-Domain Thinking

Many analog synth blocks are easier to understand in the time domain first.

Important ideas:

- capacitors integrate current into ramp movement
- comparators decide when the state flips
- resets and current reversal define oscillator motion
- envelopes are shaped charge and discharge events

This is the real heartbeat under the panel.

### 3. Exponential Control

Pitch is special.

To get musically useful `1 V/oct`, the oscillator must respond exponentially to control voltage.
That means learning:

- transistor pair behavior
- matched devices
- thermal coupling
- temperature dependence of `Vbe`
- why tempco exists

If this is vague, the oscillator never really becomes an instrument.

### 4. Nonlinearity

`Pec`, `Baklja`, and a large part of `Gravitacija` live here.

We need to understand:

- clipping
- saturation
- asymmetry
- headroom reduction
- overdriven filter input behavior
- why some nonlinearities sound huge and others sound cheap

### 5. Control Voltage Hygiene

Analog synths are not only about audio.
They are also about moving voltages without noise, stepping, drift, and bleed.

We need to understand:

- references
- scaling
- offset trimming
- control smoothing
- decoupling
- analog and digital ground discipline

## Prototype Sequence

The recommended learning sequence is:

### P0: Power, Reference, and Measurement Lab

Purpose:

- build clean rails
- learn decoupling and grounding
- establish how we measure audio and control behavior

What to build:

- bipolar analog supply, likely `+/-12 V`
- digital rail as needed
- reference nodes
- utility test points
- basic input and output protection

What to learn:

- ripple
- rail stability
- return current mistakes
- headroom limits
- why layout matters even before "real audio" exists

### P1: Discrete VCO Core

Purpose:

- build one serious oscillator
- learn pitch behavior, drift, wave generation, and reset behavior

What to build:

- expo converter
- current-controlled core
- comparator/reset loop
- saw output
- pulse output
- optional triangle output
- hard sync input
- simple linear FM or crossmod injection point

What to learn:

- `1 V/oct`
- thermal drift
- waveform integrity
- sync behavior
- why tuning credibility is hard

Detailed spec lives in `docs/p1-discrete-vco-prototype.md`.

### P2: Baklja Lab

Purpose:

- study rupture before building a full voice

What to build:

- two VCOs
- master/slave sync relationship
- crossmod path
- sub generation
- small mixer
- simple output stage

What to learn:

- why sync is our rupture spine
- how crossmod acts like poison rather than the main engine
- where `Baklja` starts to sound alive instead of merely harsh

### P3: Filter Lab

Purpose:

- study the tonal body and stress response of the filter separately

What to build:

- one filter topology at a time
- input drive control
- resonance control
- basic VCA or monitor path

What to learn:

- pole behavior
- resonance
- overload
- where `Horizont` survives
- where `Pec` begins
- where `Baklja` tears the response instead of just clipping it

### P4: Single Voice

Purpose:

- combine the first real voice

What to build:

- VCO system
- mixer
- filter
- VCA
- envelope
- LFO
- simple final stage

What to learn:

- whether the voice actually carries `Horizont`, `Pec`, and `Baklja`
- whether it feels like an instrument instead of a lab setup

### P5: Digital Overlay

Purpose:

- add the nervous system after the analog behavior is worth controlling

What to build:

- MIDI input
- MCU control
- DAC-generated control voltages
- patchable calibration hooks
- first `Gravitacija` experiments

What to learn:

- how much control should remain analog
- how much should be computed and distributed digitally
- where digital convenience helps and where it ruins feel

### P6: Polyphonic Translation

Purpose:

- move from one convincing voice to several repeatable voices

What to learn:

- matching
- scaling pain
- tuning across multiple voices
- bus behavior
- thermal coupling across a full chassis

## Minimum Bench Toolkit

The learning path is much better with proper measurement.

Minimum useful toolkit:

- bench power supply
- decent multimeter
- oscilloscope
- frequency counter or stable tuner workflow
- audio interface for recording and FFT inspection
- soldered prototyping method, not casual breadboard-only work

Recommended software tools:

- LTspice or similar simulator
- KiCad
- DAW plus spectrum analyzer

## Listening As Measurement

The project should treat listening as a real measurement method, not an afterthought.

We should repeatedly ask:

- does the note center remain trustworthy?
- does the waveform feel large or cheap?
- does sync sound like `Baklja` or just like a bright gimmick?
- does added density feel like `Pec` or like mud?
- does strain feel like `Gravitacija` or like broken gain staging?

If the ear and the scope disagree, that is not failure.
That is usually the start of the real lesson.

## Current Recommendation

The best next physical step is:

1. finish `P0` if power and measurement are not yet disciplined
2. build `P1` as one serious discrete VCO
3. use that as the foundation for the later `Baklja` lab

This keeps the project honest.
If the first oscillator cannot stand on its own, the rest of the synth is only stacked confusion.
