# InkPulse Rev A prototype wiring

This is a prototype wiring plan, not a certified charging or production schematic. Disconnect the cell before rewiring and verify the holder lead polarity with a multimeter.

## E-paper SPI

| Waveshare 4.2″ pin | XIAO ESP32-C6 | Purpose |
| --- | --- | --- |
| VCC | 3V3 | Display logic and module power |
| GND | GND | Common ground |
| DIN | D10 / GPIO18 | SPI MOSI |
| CLK | D8 / GPIO19 | SPI clock |
| CS | D7 / GPIO17 | Chip select |
| DC | D6 / GPIO16 | Data/command |
| RST | D5 / GPIO23 | Display reset |
| BUSY | D4 / GPIO22 | Display busy input |

The e-paper module does not need MISO. Confirm the purchased board revision and its voltage selector before applying power.

## Buttons

- Use three Omron `B3F-1000` normally-open tactile switches on the internal switch carrier.
- Connect the action button between `D0 / GPIO0` and `GND`.
- Connect the previous half of the navigation rocker between `D1 / GPIO1` and `GND`.
- Connect the next half of the navigation rocker between `D2 / GPIO2` and `GND`.
- Configure all three GPIOs with internal pull-ups and debounce them in firmware.
- GPIO0, GPIO1, and GPIO2 are RTC-capable on ESP32-C6, so all three controls can be configured as deep-sleep wake sources.
- A short action-button press requests a refresh; a 5-second hold clears pairing after a confirmation pattern.
- Previous/next presses move through cached app pages with wraparound navigation.

## Battery and USB-C

```text
MPD BH-18650-W red lead (+) -> PTC fuse -> C&K 1101M2S5AQE2 COM
C&K selected throw ------------------------------------------> XIAO BAT (+)
MPD BH-18650-W black lead (-) ----------------> XIAO BAT (-/GND)
USB-C 5 V ------------------------------------> XIAO USB-C connector
```

Use only one protected, rechargeable 3.7 V Li-ion cell. The battery branch must not be wired to the USB 5 V pin. The XIAO board's battery input and charger are the only intended meeting point for USB and battery power in Rev A. The SPDT switch is used as a simple disconnect: leave its unused throw electrically isolated.

The XIAO documentation states that battery power is supported and that USB-C charges a connected 3.7 V lithium battery. It also states that the 5 V pin is not powered in battery mode. The selected C&K switch uses Q silver contacts rated 6 A at 28 V DC, providing substantial margin over the prototype battery branch, but wiring, insulation, and thermal behavior still require physical validation. Validate the purchased board revision, charge current, cell temperature, and low-voltage behavior on the physical prototype.

## Before first power-on

1. Confirm the MPD holder's lead polarity without the XIAO connected.
2. Confirm that the selected protected cell fits without excessive spring force or damaged insulation.
3. Confirm there is no short between BAT+ and GND in either switch position.
4. Boot from USB-C without the display and verify 3.3 V.
5. Boot from USB-C with the display and show a static test pattern.
6. Connect the protected cell with USB-C disconnected and verify battery-only boot.
7. Verify action, previous, and next each wake the controller from deep sleep.
8. Observe the first USB-C charge on a nonflammable surface and check cell, holder, wiring, and board temperature.
