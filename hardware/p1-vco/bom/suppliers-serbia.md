# Serbia Supplier Notes For P1 VCO Rev A

Research date: 2026-05-08

This is a practical sourcing map for the first `P1` oscillator BOM. It is not a
final approved vendor list.

## Recommended Sourcing Split

Use Serbian/local suppliers for generic bring-up parts:

- 1% metal-film resistors
- common capacitors and C0G/NP0 small caps
- 2N3904-class transistors for reset experiments
- TL071/LM311-class DIP parts when available
- pin headers, sockets, wiring, perf/proto material, test points, basic tools

Use larger international distributors or synth-specialist shops for parts where
the exact part matters:

- `2k 3300ppm` tempco resistor
- matched NPN pair or same-package matched pair
- production-grade comparator/op-amp package decisions
- timing capacitor dielectric and tolerance if the first bench pass shows it
  matters

## Local Component Shops

### MikroPrinc

Good candidate for ordinary electronics parts and some exact BOM lines.

Observed examples:

- `TL071` DIP8 is listed as available.
- `2N3904` TO-92 is listed as available.
- `LM311` DIP8 was listed as unavailable, but `LM311 TO` was listed as
  available.

Useful for: quick local sourcing of TL071, 2N3904, resistors, capacitors,
connectors, tools, and measurement gear.

Sources:

- https://www.mikroprinc.com/sr/proizvod/tl071
- https://www.mikroprinc.com/sr/proizvod/2n3904
- https://www.mikroprinc.com/sr/proizvod/lm311
- https://www.mikroprinc.com/sr/proizvod/lm311-to

### Kelco

Good candidate for general lab stock and quick Beograd pickup/order.

Observed examples:

- broad categories include resistors, trimmers, capacitors, transistors, ICs,
  connectors, power supplies, tools, and measurement instruments
- `TL071CP` appears in the FET/JFET op-amp category
- `MMBT3904` SOT-23 is listed as in stock

Useful for: passives, trimmers, headers/connectors, TL07x op-amps, support
parts, tools, bench odds and ends.

Sources:

- https://www.kelco.rs/
- https://www.kelco.rs/katalog/komponente.php?IDgroupweb=4140
- https://www.kelco.rs/katalog/detalji.php?ID=15534
- https://www.kelco.rs/kontakt/

### M&G Electronic

Good candidate for broad local electronics stock, especially if ordering from
or near Nis.

Observed examples:

- site claims a catalogue of more than `30,000` electronic components
- `2N3904` TO-92 is listed as available
- categories cover active/passive components, connectors, tools, soldering
  supplies, instruments, and power supplies

Useful for: generic passives, 2N3904-class transistors, connectors, tools,
power and lab supplies.

Sources:

- https://www.mgelectronic.rs/about-us
- https://www.mgelectronic.rs/pasivne
- https://www.mgelectronic.rs/tranzistor-2n-3904
- https://mgelectronic.rs/

### Elementa

Good candidate for common components and low-cost lab/accessory items.

Observed examples:

- active and passive component categories
- `TL071` DIP8 listed as available
- component tester listed as available

Useful for: common ICs, passives, tools, simple testers, consumables.

Sources:

- https://www.elementa.rs/katalog/elektronske-komponente
- https://www.elementa.rs/proizvod/operacioni-pojacivac-tl071-1096
- https://www.elementa.rs/proizvod/tester-elektronskih-komponenti-lcr-t7-62826

### Elektroleum

Good candidate for opportunistic sourcing of specific parts and bench
equipment.

Observed examples:

- `TL071` DIP8 listed
- `2N3904` listed
- Rigol scopes and Voltcraft/GW Instek bench supplies are listed

Useful for: TL071/2N3904-class parts, bench power supplies, scopes if pricing
and availability make sense.

Sources:

- https://elektroleum.rs/product/tl071/
- https://elektroleum.rs/product/2n3904/
- https://elektroleum.rs/product/digitalni-osciloskop-rigol-ds1054z-5x50mhz/
- https://elektroleum.rs/product/laboratorijsko-napajanje-gw-instek-gpr-3060d-0-30v-0-6a-180w/

### Proelectronic / Silken / Electronic Center

Secondary local options for common parts.

Observed examples:

- Proelectronic lists `LM311` DIP8 and `2N3904`
- Silken lists `2N3904`
- Electronic Center lists `2N3904`

Useful for: filling local gaps when MikroPrinc/Kelco/M&G do not have a common
part.

Sources:

- https://www.proelectronic.rs/shop/integralna-kola/lc-l/lm/ic-lm311/
- https://www.proelectronic.rs/shop/tranzistori/2n/tranzistor-2n3904/
- https://silken.co.rs/proizvod/2n3904/
- https://www.electronic-center.rs/kupi/tranzistor-2n3904-2282

## Larger Distributors

### TME Serbia

Good candidate for more disciplined sourcing than local hobby/repair shops,
especially once package and manufacturer matter.

Observed examples:

- Serbia-facing TME site exists.
- catalogue claims more than `1,300,000` products.
- `LM311P`, `LM311N/NOPB`, `TL071IP`, `TL071CDR`, and `2N3904` pages exist,
  though stock must be checked at order time.

Useful for: authorized-ish distributor flow, exact packages, lower counterfeit
risk, connectors, passives, lab gear, production-adjacent parts.

Sources:

- https://www.tme.eu/rs/en/
- https://www.tme.eu/rs/en/about-us/
- https://www.tme.eu/en/details/lm311p/tht-comparators/texas-instruments/
- https://www.tme.eu/en/details/tl071ip/tht-operational-amplifiers/texas-instruments/
- https://www.tme.eu/en/details/tl071cdr/smd-operational-amplifiers/texas-instruments/
- https://www.tme.eu/en/details/2n3904-dio/npn-tht-transistors/diotec-semiconductor/2n3904/

### Mouser / Digi-Key

Best candidates when exact manufacturer, traceability, and datasheet-matching
matter more than local convenience.

Use for:

- matched transistor pairs such as `SSM2212` or `MAT12`
- comparator/op-amp variants if we lock exact packages
- precision passives and harder-to-find analog parts

Sources:

- https://www.mouser.com/
- https://www.digikey.com/
- https://www.analog.com/en/products/ssm2212.html
- https://www.analog.com/en/products/mat12.html

## Synth-Specific Parts

The `2k 3300ppm` tempco resistor is the part most likely to be annoying through
ordinary Serbian shops.

Candidates to check:

- Soundtronics lists a linear PTC `2k 1% 3300ppm` tempco resistor.
- Modular Addict lists Akaneohm `+3300ppm/C` tempcos in common synth values,
  including `2K`.

These are not Serbian suppliers. Treat them as fallback or specialist sources
for the first VCO experiment.

Sources:

- https://www.soundtronics.co.uk/linear-ptc-2k-1-3300ppm-1-6w-tempco-resistor.html
- https://modularaddict.com/parts/synth-diy-parts/akaneohm-tempco-3300ppm

## PCB / PCBA / Prototype Help In Serbia

For the first oscillator, we probably do not need production PCBA yet. Still,
these are useful if the circuit moves from bench prototype to a small board.

### FIDTech, Novi Sad

Lists PCB design, PCB manufacturing, PCB assembly/prototyping, embedded work,
and consulting.

Source:

- https://fidtech.rs/

### Instrumenta

Lists electronics rapid prototyping, schematic design, PCB design, prototype
boards, small series, component sourcing and assembly.

Sources:

- https://instrumenta.rs/usluge/rapid-prototyping/
- https://instrumenta.rs/kontakt/

### PCB Design / Hi-Tech Corp channel

Serbian CAM/preparation presence for PCB production, with Beograd contact
listed through public directories and company profiles.

Sources:

- https://www.planplus.rs/pcb-design-proizvodnja-stampanih-ploca/98335
- https://poslovi.infostud.com/poslodavac/pcb-design.d.o.o.-novi-beograd-beograd/72480

### GRAH Automotive Serbia

More industrial PCBA option, not the first stop for a hobby-scale P1 board.
They list SMT, THT, wave soldering, AOI, ICT, and functional testing.

Source:

- https://grahgroup.rs/pcba/

## Measurement / Bench Equipment

For P1 VCO bring-up, the practical minimum remains:

- dual or triple bench supply suitable for `+12V`, `-12V`, and any logic/helper
  rail if needed
- oscilloscope, ideally 2 to 4 channels
- multimeter
- component tester or LCR meter
- audio monitor path

Candidate suppliers:

- Metroteh: Siglent scopes and measurement gear
- MikroPrinc: measurement categories include oscilloscopes, function
  generators, frequency counters, bench supplies, logic analyzers
- Elektroleum: Rigol scopes and Voltcraft/GW Instek bench supplies
- Elementa/Kelco: lower-cost tools, testers, soldering consumables

Sources:

- https://www.metroteh.rs/proizvodi/osciloskopi/63/siglent-sds1102cml-13262/
- https://www.metroteh.rs/proizvodi/osciloskopi/63/siglent-sds-1104x-u-15742/
- https://www.mikroprinc.com/
- https://elektroleum.rs/product/digitalni-osciloskop-rigol-ds1054z-5x50mhz/
- https://elektroleum.rs/product/laboratorijsko-napajanje-voltcraft-dlp-3306-0-30v-0-6a-378w/

## Practical First Order

For the first local order, buy cheap multiples:

- all `OK to stock` resistors from the starter BOM
- `33p`, `100p`, `100n` C0G/NP0/ceramic support values
- several `2N3904` / `MMBT3904`
- several TL071/TL072/TL074 DIP parts for experiments
- pin headers, IC sockets, hook-up wire, test points, trimmers

Do not lock the final order yet for:

- `2k 3300ppm` tempco
- matched NPN pair
- final `LM311` package/source
- final timing capacitor
- PCB connector system

Those should be chosen after the bench topology and package style are decided.

## P1D Full-Discrete Adjustment

For the `P1D` branch, do not buy around `LM311` and `TL071` as mandatory parts.
Instead, buy more ordinary discrete stock:

- `2N3904` or equivalent NPN, at least `25`
- `2N3906` or equivalent PNP, at least `10`
- `1N4148` or `1N914`, at least `25`
- optional JFETs such as J201/2N5457/BF245-class parts if available
- extra C0G/NP0 small caps from `10p` through `1n`
- several timing capacitor values around `1n` to `10n`
- more test points, headers, and sockets than seems necessary

The full-discrete line should use local suppliers aggressively for cheap
transistor and passive quantities. Save Mouser/Digi-Key/TME for the special
parts that teach a specific lesson: matched pair, tempco, precision timing cap,
or a part you want to compare against ordinary local stock.
