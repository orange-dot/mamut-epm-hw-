# Open Questions

## Internal EPM Framing

These are now the main shared and `EPM2`-leaning questions to settle as
`Mamut EPM` sharpens its line split.

- `EPM1` already exists as the current software/runtime line in
  `mamut-sint-sw`
- `EPM2` remains the hardware line in this repo
- the questions below are therefore mostly about shared identity choices and
  unresolved `EPM2` hardware direction

These are the main questions to settle before the project moves from concept
docs into real hardware architecture.

## 1. Sonic Identity

Chosen direction:

- `Experimental Performance Monster`

This is no longer the open question. The open question is how to make that identity real without diluting it.

Things to define next:

- how elegant versus savage should `Horizont + Pec` be in practice?
- how much scale versus density should dominate before `Baklja` opens?
- what should be the first thing someone hears and remembers?

## 2. Oscillator Architecture

Already chosen:

- `osc1` is the anchor and pitch center
- `osc2` is the rupture carrier
- `sub` protects `Pec`
- `Baklja` is sync-first and crossmod-poisoned
- the immediate learning path begins with discrete analog prototypes

See:

- `docs/analog-learning-roadmap.md`
- `docs/p1-discrete-vco-prototype.md`

What is still open is implementation style.

Which tradeoff do we want?

- purer analog behavior with more pain
- digitally stabilized analog behavior with better repeatability

The key question is how much tuning behavior, startup drift, and calibration overhead we are willing to accept in V1.
The deeper question is what kind of instability or control actually belongs to this synth.

## 3. Voice Count

Current recommendation is `6 voices`, but this should still be formally confirmed.

Questions:

- is 6 enough for the intended musical positioning?
- is 8 worth the major increase in complexity for this specific synth?

## 4. Filter Character

We still need to decide what kind of instrument the filter should make this synth become.

Questions:

- classic low-pass only, or something wider?
- clean and controlled, or darker and more aggressive?
- one signature filter, or a more flexible but less distinctive path?

## 5. Modulation Scope

How deep should V1 go?

Questions:

- minimal but musical modulation
- moderate performance modulation
- large recallable mod matrix

The main risk is making the synth broad but unfocused, or too generic to justify its own existence.

## 5a. Monster Controls

How many "big gesture" controls should define the instrument?

Questions:

- do we want 3 monster controls or 5 monster controls?
- should these be fixed identities like `Bloom` and `Ruin`, or assignable macro slots?
- should they act globally, per patch, or both?

## 5b. Gravitacija

`Gravitacija` is now a chosen engine-wide behavior, not just a loose concept.

Questions:

- what should be hardwired into the analog path versus resolved in the digital brain?
- how much of it should remain accessible from the future tablet control plane?
- which parts should be per-patch response curves versus fixed global behavior?
- should tube behavior be literal, modeled, or abstracted into a broader sound system?

## 6. Effects and Final Character Stage

Likely yes, but still worth deciding explicitly.

Questions:

- should effects be included in the first real build?
- which effects are essential versus optional?
- are effects part of the synth identity or just finishing tools?
- does the synth need a dedicated final character stage as part of end-to-end ownership?
- if there is a tube stage, does it live inside the synth or as a future companion body?

## 7. Control Surface

How immediate should the front panel be?

Questions:

- one-knob-per-function for core voice shaping?
- small display plus fast direct controls?
- how much menu depth is acceptable?

## 8. Instrument Form

Desktop is the current direction, but the enclosure and usage model still need definition.

Questions:

- compact desktop module
- larger performance desktop unit
- later keyboard variant derived from the same core engine

## 9. Reality Envelope

We have not yet defined:

- target street price
- target BOM range
- acceptable calibration effort
- realistic build scale

These should shape later decisions, but they should not define the soul of the synth too early.

## Suggested Next Discussion

The highest-value next step is to decide:

1. exact `P1` VCO topology and measurement plan
2. filter-lab direction after `P1`
3. first set of monster controls for the later instrument

Those three decisions will narrow the rest of the architecture very quickly.
