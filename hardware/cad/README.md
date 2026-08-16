# InkPulse enclosure CAD

`InkPulse.scad` is the parametric source of truth. It models a 125 × 101 × 40 mm landscape, FDM-printable enclosure around specific component envelopes. This is a prototype design: physical print and assembly validation are required before production use.

## Component envelopes

| Part | Envelope / feature |
| --- | --- |
| Waveshare 4.2-inch B/W V2 e-Paper | 103.0 × 78.5 × 8.5 mm PCB envelope; 84.8 × 63.6 mm active area; 90.1 × 77.0 × 1.18 mm raw panel |
| Seeed XIAO ESP32-C6 | 17.8 × 21.0 × 4.0 mm; 11.0 × 5.5 mm USB-C plug opening |
| MPD BH-18650-W | 77.7 × 20.9 × 21.31 mm; Ø3.2 mm mounting holes, 55.61 mm centres |
| Omron B3F-1000 | 6.0 × 6.0 × 4.3 mm; three positions: action, previous, next |
| C&K 1101M2S5AQE2 | 13.21 × 9.53 × 4.72 mm right-angle envelope plus actuator; 10 × 6 mm conservative right-side opening; Q silver contacts rated 6 A at 28 V DC |

The display pocket locates the PCB with 0.30 mm clearance per side. Four electronics-tray lands use 0.5 mm foam squares at PCB corners only; never clamp the e-paper glass. The purchased module revision, FPC bend, protected-cell dimensions and connector height must be measured before final printing.

## Printable parts

- `front_bezel`: viewing frame, display pocket, four M2 insert bosses.
- `rear_shell`: front-open shell, fully through-cut USB-C/power/button openings, four long case-screw standoffs, slide-in switch-carrier guides, power-switch retainer, door insert boss and door rails.
- `electronics_tray`: case-screw capture holes, four PCB foam lands, MPD holder rim and mounting holes, XIAO snap cradle, wire channels and battery-end routes.
- `battery_door`: flush rear door with matching rail tongues, grip ribs, and one positive M2 retaining screw.
- `action_button`: side cap.
- `navigation_rocker`: central pivot bore and two actuator nubs; its stops target 0.35–0.45 mm motion for the B3F's 0.25 mm pretravel.
- `switch_carrier`: three wire-soldered B3F pockets and the rocker's internal alignment backer.

`assembly` and `exploded` are visual inspection views with a TravelCrumb-blue enclosure, matte-black controls, and colored hardware envelopes; do not print them.

## Hardware and assembly

1. Print the seven parts and install four nominal 3.6 mm OD × 4.2 mm deep M2 heat-set inserts in the front-bezel bosses plus one matching insert in the rear-shell battery-door boss.
2. Install the e-paper PCB in the bezel. Apply the 0.5 mm foam squares to the four electronics-tray lands before closing; they must touch only PCB corners.
3. Attach the BH-18650-W to the tray with two #2-56 × 1/4 inch fasteners and nuts, solder and strain-relieve both holder leads, then seat the XIAO in its cradle and route wires through the tray channels.
4. Solder leads to the three B3F-1000 switches, install them in the switch carrier, slide the carrier into the rear-shell guides from the open front, fit the action cap, and use 1.7–1.8 mm steel pin/filament as the rocker axle.
5. Slide the C&K `1101M2S5AQE2` power switch into its internal retainer, insulate and strain-relieve its soldered terminals, then capture the electronics tray between the front bosses and rear standoffs while joining the shell with four M2 × 30 mm screws. Insert a polarity-checked protected cell, engage the door rails, and secure the door with one M2 × 6 mm screw into the fifth heat-set insert.

The holder's open face is at the rear door. A protected cell is mandatory, but protected-cell length and diameter vary: confirm it fits the purchased MPD holder. Verify USB-C insertion and charging current. The XIAO charger is not a substitute for a complete battery safety review or thermal test.

## Export

```sh
mkdir -p stl
openscad -o stl/front-bezel.stl -D 'part="front_bezel"' InkPulse.scad
openscad -o stl/rear-shell.stl -D 'part="rear_shell"' InkPulse.scad
openscad -o stl/electronics-tray.stl -D 'part="electronics_tray"' InkPulse.scad
openscad -o stl/battery-door.stl -D 'part="battery_door"' InkPulse.scad
openscad -o stl/action-button.stl -D 'part="action_button"' InkPulse.scad
openscad -o stl/navigation-rocker.stl -D 'part="navigation_rocker"' InkPulse.scad
openscad -o stl/switch-carrier.stl -D 'part="switch_carrier"' InkPulse.scad
```

## Print setup

- 0.4 mm nozzle, 0.20 mm layers, three walls, four top/bottom layers, 15–20% gyroid infill.
- Bezel: front face down on a smooth plate. Rear shell: rear/back face down; supports may be needed under right-side openings and internal rails.
- Tray: large plate down. Door and caps: visible outer face down. Switch carrier: broad face down.
- Start with 0.0 mm XY compensation. Ream holes only as needed; do not force the rocker pivot.

## CAD verification limits

Watertight STL and slicer checks validate mesh topology and printable geometry only. They do not validate printer tolerance, connector force, antenna performance, electrical safety, battery fit, FPC clearance, screw pull-out, or long-term wear. Physical print, fit and assembly validation are still required.
