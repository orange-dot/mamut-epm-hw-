# P1 VCO BOM

This folder holds the working BOM for the first `P1` oscillator build.

`p1-vco-rev-a-starter.csv` is intentionally a starter BOM, not a final purchase
order. It is based on the current KiCad schematic reference/value set and adds
human status columns for early ordering decisions.

Use the `Order status` column as the guardrail:

- `OK to stock` means generic lab parts are reasonable to buy now.
- `Choose before order` means the schematic still needs a package, footprint,
  vendor, or bench-method decision before treating the line as final.
- `Optional` means useful for bring-up but not required by the circuit itself.

The current highest-risk choices are the expo tempco path, matched transistor
pair approach, timing capacitor dielectric, comparator package/model, op-amp
package/model, and bench connector style.

`p1d-full-discrete-delta.csv` adds the extra stock needed for the full-discrete
`P1D` experiment. It is a delta on top of the starter BOM, not a replacement.
Use it when building the no-`LM311`, no-`TL071` learning branch.

Raw KiCad BOM extraction for comparison:

```bash
kicad-cli sch export bom \
  --output /tmp/mamut-p1-bom-current.csv \
  hardware/p1-vco/kicad/mamut-p1-vco.kicad_sch
```
