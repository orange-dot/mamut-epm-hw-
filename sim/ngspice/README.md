# ngspice Workspace

This is the primary simulation area for `Mamut`.

Use this folder for:

- raw SPICE experiments
- scripted sweeps
- bench-prep validation
- oscillator and filter study circuits

The first intended subproject is:

- `p1-vco/`

Once `ngspice` is installed, typical raw-terminal usage is:

```bash
cd sim/ngspice
ngspice your-netlist.cir
```

And for batch-style runs:

```bash
ngspice -b -o run.log your-netlist.cir
```

Project helper:

```bash
cd .
./tools/run-ngspice.sh sim/ngspice/p1-vco/10-ramp-reset-core.cir
```
