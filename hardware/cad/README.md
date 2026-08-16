# InkPulse enclosure CAD

`InkPulse.scad` is the source of truth. The dimensions are parameterized near the top of the file.

## Parts

- `front_bezel`: e-paper window and front frame
- `rear_shell`: electronics cavity, USB-C opening, action-button hole, rocker opening, and battery-door recess
- `battery_door`: removable rear panel
- `navigation_rocker`: two-way previous/next rocker cap
- `assembly`: a fit-check view; do not print as one piece

## Export STL

Open the model in OpenSCAD and choose a part, or run:

```sh
mkdir -p stl
openscad -o stl/front-bezel.stl -D 'part="front_bezel"' InkPulse.scad
openscad -o stl/rear-shell.stl -D 'part="rear_shell"' InkPulse.scad
openscad -o stl/battery-door.stl -D 'part="battery_door"' InkPulse.scad
openscad -o stl/navigation-rocker.stl -D 'part="navigation_rocker"' InkPulse.scad
```

## Starting print settings

- 0.4 mm nozzle, 0.20 mm layer height
- 3 walls, 4 top/bottom layers, 15–20% gyroid infill
- Print the bezel face-down on a clean textured plate
- Print the rear shell with its back on the build plate
- Print the battery door flat
- Print the navigation rocker with its outer face on the build plate
- Start with XY dimensional compensation at 0.0 mm; adjust after a small fit test

## Fit checks before final print

Measure the exact module revision. The source currently assumes:

- module PCB: 103.0 × 78.5 mm
- active display: 84.8 × 63.6 mm
- enclosure: 114 × 90 × 27 mm assembled
- wall: 2.0 mm

The JST lead, e-paper FPC bend radius, actual protected-cell length, USB-C plug shell, switch bodies, action-button cap, and rocker pivot still need physical measurements.
