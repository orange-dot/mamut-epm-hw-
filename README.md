# Mamut EPM Hardware Lab

This is the public hardware-study repo for the `EPM2` line of `Mamut EPM`.

`EPM2` is not presented here as finished hardware. This repo documents the
current study path for a desktop analog performance synth: simulation first,
then KiCad capture, then bench expectations and measurement.

## Current Focus

The active hardware block is `P1`, a discrete VCO study.

The useful source trail is:

- `sim/ngspice/p1-vco/` - numbered ngspice studies from smoke tests through
  integrated VCO behavior and transistor reset sensitivity
- `docs/p1-vco-simulation-notes.md` - current simulation interpretation and
  result summaries
- `hardware/p1-vco/kicad/` - hierarchical KiCad capture for the promoted P1
  blocks
- `bench/p1-vco/expected-behavior.md` - bench-side expectations before
  physical measurement

## Current P1 Study State

- `60-integrated-vco-chain.cir` is the current integrated
  `CV -> expo -> core -> saw/pulse` reference.
- `70-temp-drift-vco.cir` records the first temperature characterization.
- `80-sync-injection-vco.cir` records the first reset-oriented sync hook.
- `100-threshold-reset-transistor-core.cir` and
  `101-reset-transistor-sensitivity.cir` move the reset path into a more
  bench-facing transistor study.

## Repo Layout

- `docs/` - architecture, simulation, and P1 working notes
- `sim/` - ngspice and optional Qucs workspace
- `hardware/` - KiCad hardware capture that has graduated from pure study
- `bench/` - expected behavior and later measurement evidence
- `models/` - model provenance notes
- `tools/` - local helper scripts

## Running A Simulation

Use ngspice directly:

```bash
cd sim/ngspice/p1-vco
ngspice 60-integrated-vco-chain.cir
```

Or from the repo root with the helper:

```bash
./tools/run-ngspice.sh sim/ngspice/p1-vco/60-integrated-vco-chain.cir
```

## License

Documentation and helper scripts are licensed under MIT. Hardware design
artifacts are licensed under CERN-OHL-S-2.0. See `LICENSE.md` and `LICENSES/`.
