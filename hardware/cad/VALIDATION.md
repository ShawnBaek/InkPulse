# CAD and slicing validation

Validation date: 2026-08-16

## Result

The seven STL files are valid, single-part, watertight meshes and all seven slice successfully with a generic 0.4 mm FDM profile. The enclosure stack is dimensioned around selected manufacturer component envelopes and is suitable for a first engineering print.

This is not physical-fit or production validation. No enclosure in this repository has yet been printed and assembled with the purchased display, controller, protected cell, switches, wiring, and fasteners.

## Hardware envelope checks

| Check | Result |
| --- | --- |
| Display PCB | 103.0 × 78.5 mm inside a pocket with 0.30 mm clearance per side |
| Display stack | Conservative 8.5 mm module envelope from global Z 3.0 to 11.5 mm |
| Foam / tray interface | 0.5 mm between the module rear envelope and the four tray lands |
| MPD BH-18650-W | 77.7 × 20.9 × 21.31 mm; rear stack from Z 14.9 to 36.21 mm |
| Battery-holder rear clearance | 1.39 mm to the nominal inside face of the rear wall |
| XIAO ESP32-C6 | 17.8 × 21.0 × 4.0 mm; USB-C opening centered on the board envelope |
| XIAO cradle neighbors | Nominal 0.30 mm to the inner side wall, 0.35 mm to the switch-carrier guide, and 0.40 mm to the upper-right case standoff |
| Power switch | C&K 1101M2S5AQE2 in a 13.21 × 9.53 × 4.72 mm right-angle body envelope, with a 10 × 6 mm side opening and slide-in retainer |
| Power-switch retainer | Nominal 0.35 mm separation from the lower-right case standoff |
| Case joints | Four rear standoffs capture the tray against front bosses; M2 × 30 mm screws provide about 2.5 mm nominal insert engagement |
| Battery door | Two rails plus one M2 × 6 mm screw into a dedicated heat-set insert |
| Navigation control | Two B3F-1000 switch pockets, a carrier axle bore, rocker barrel, actuator nubs, and motion stops |

The 8.5 mm display depth is deliberately conservative because Waveshare publishes the PCB and panel outline but not a single maximum assembled height covering every module revision and connector. Measure the purchased module before the full print.

## Mesh validation

OpenSCAD 2021.01 exported the models. ADMesh 0.98.5 reported one connected part, zero disconnected facets, zero bad edges, and zero degenerate facets for every file.

| STL | Bounding box (mm) | Connected parts |
| --- | --- | --- |
| `front-bezel.stl` | 125.0 × 101.0 × 12.5 | 1 |
| `rear-shell.stl` | 125.0 × 101.0 × 37.0 | 1 |
| `electronics-tray.stl` | 118.3 × 91.0 × 6.35 | 1 |
| `battery-door.stl` | 94.0 × 39.0 × 4.10 | 1 |
| `action-button.stl` | 5.0 × 6.10 × 6.10 | 1 |
| `navigation-rocker.stl` | 6.25 × 18.2 × 6.20 | 1 |
| `switch-carrier.stl` | 7.5 × 36.0 × 18.0 | 1 |

## Slicing validation

PrusaSlicer 2.9.6 sliced each part with a generic 250 × 210 mm FDM bed, 0.4 mm nozzle, 0.20 mm layer height, three perimeters, four top/bottom layers, 15% gyroid infill, and automatic supports.

| Part | Test orientation | Estimated time | Filament | Automatic support generated |
| --- | --- | ---: | ---: | --- |
| Front bezel | Front face on bed | 2 h 26 m 15 s | 7,107.58 mm | No |
| Rear shell | Back face on bed | 6 h 37 m 16 s | 24,450.40 mm | Yes |
| Electronics tray | Main plate on bed | 3 h 0 m 19 s | 9,423.69 mm | Yes |
| Battery door | Outer face on bed | 54 m 59 s | 2,901.35 mm | Yes |
| Action button | Outer round face on bed | 2 m 2 s | 54.97 mm | No |
| Navigation rocker | Outer face on bed | 6 m 13 s | 260.95 mm | Yes |
| Switch carrier | Broad face on bed | 23 m 8 s | 1,232.24 mm | Yes |
| **Total** | Separate jobs | **13 h 30 m 12 s** | **45,431.18 mm** | — |

Estimates depend on printer, PETG profile, speeds, support settings, and cooling. The generated G-code was temporary and is not committed because it is printer-specific.

## Required physical validation

1. Print the action button, rocker, switch carrier, and a short side-wall fit coupon first. Verify switch preload and 0.35–0.45 mm rocker motion.
2. Dry-fit the unpowered Waveshare module, FPC/connector, XIAO board, MPD holder, protected cell, power switch, and fasteners.
3. Check that foam lands touch PCB corners only and never load the e-paper glass.
4. Confirm USB-C plug insertion, battery removal, door screw engagement, carrier-guide retention, and all wire bend radii.
5. Run battery-only boot and supervised USB-C charging on a nonflammable surface. Measure current and cell, holder, controller, and enclosure temperatures.
6. Check Wi-Fi/BLE performance with the final cell and wiring installed before freezing the enclosure material or antenna-side wall thickness.

Only after those checks pass should the model be described as physically validated or production-ready.
