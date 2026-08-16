# InkPulse v0.1 wiring

This is a prototype wiring plan, not a certified charging or production schematic. Disconnect the cell before rewiring and verify JST polarity with a multimeter.

## E-paper SPI

| Waveshare 4.2″ pin | XIAO ESP32-C6 | Purpose |
| --- | --- | --- |
| VCC | 3V3 | Display logic and module power |
| GND | GND | Common ground |
| DIN | D10 / GPIO18 | SPI MOSI |
| CLK | D8 / GPIO19 | SPI clock |
| CS | D7 / GPIO17 | Chip select |
| DC | D3 / GPIO21 | Data/command |
| RST | D2 / GPIO2 | Display reset |
| BUSY | D1 / GPIO1 | Display busy input |

The e-paper module does not need MISO. Confirm the purchased board revision and its voltage selector before applying power.

## Buttons

- Connect the normally-open action button between `D6 / GPIO16` and `GND`.
- Connect the previous half of the navigation rocker between `D4 / GPIO22` and `GND`.
- Connect the next half of the navigation rocker between `D5 / GPIO23` and `GND`.
- Configure all three GPIOs with internal pull-ups and debounce them in firmware.
- A short action-button press requests a refresh; a 5-second hold clears pairing after a confirmation pattern.
- Previous/next presses move through cached app pages with wraparound navigation.

## Battery and USB-C

```text
Protected 18650 (+) -> PTC fuse -> power switch -> XIAO BAT (+)
Protected 18650 (-) ---------------------------> XIAO BAT (-/GND)
USB-C 5 V ------------------------------------> XIAO USB-C connector
```

Use only one protected, rechargeable 3.7 V Li-ion cell. The battery branch must not be wired to the USB 5 V pin. The XIAO board's battery input and charger are the only intended meeting point for USB and battery power in v0.1.

## Before first power-on

1. Confirm battery holder polarity without the XIAO connected.
2. Confirm there is no short between BAT+ and GND.
3. Boot from USB-C without the display and verify 3.3 V.
4. Boot from USB-C with the display and show a static test pattern.
5. Connect the protected cell with USB-C disconnected and verify battery-only boot.
6. Observe the first USB-C charge on a nonflammable surface and check cell/board temperature.
