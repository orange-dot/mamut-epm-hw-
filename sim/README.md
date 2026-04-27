# Simulation Workspace

This directory holds simulation-first work for `Mamut`.

Current intended layout:

- `ngspice/` for the main SPICE workflow
- `qucs/` for optional `Qucs-S` projects

The default assumption is:

- first-pass analog studies happen here
- only validated work should graduate into `hardware/`

Good practice:

- keep one mechanism per study when possible
- keep generated logs and exported data next to the study that produced them
- record what each study was trying to prove before moving on

This directory is the main battlefield for `P1` right now.
