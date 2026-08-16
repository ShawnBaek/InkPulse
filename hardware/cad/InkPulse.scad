// InkPulse Model 42 — v0.1 enclosure
// Units: millimetres
// Export with: openscad -o output.stl -D 'part="front_bezel"' InkPulse.scad

$fn = 64;
part = "assembly"; // assembly, front_bezel, rear_shell, battery_door, navigation_rocker

enclosure_width = 114;
enclosure_height = 90;
bezel_depth = 3;
rear_depth = 24;
corner_radius = 6;
wall = 2;
back_wall = 2.2;

screen_window_width = 86.8;
screen_window_height = 65.6;

battery_door_width = 86;
battery_door_height = 30;
battery_door_depth = 1.8;
battery_door_y = -12;

navigation_y = 2;
navigation_z = 13;
navigation_radius = 3.4;
navigation_span = 12;

module rounded_prism(size, radius) {
    linear_extrude(height = size[2])
        offset(r = radius)
            square([size[0] - 2 * radius, size[1] - 2 * radius], center = true);
}

module front_bezel() {
    difference() {
        rounded_prism([enclosure_width, enclosure_height, bezel_depth], corner_radius);
        translate([0, 0, -0.1])
            rounded_prism(
                [screen_window_width, screen_window_height, bezel_depth + 0.2],
                1.2
            );
    }
}

module rear_shell() {
    difference() {
        rounded_prism([enclosure_width, enclosure_height, rear_depth], corner_radius);

        // Front-open electronics cavity. The rear wall remains intact except for the door.
        translate([0, 0, -0.1])
            rounded_prism(
                [
                    enclosure_width - 2 * wall,
                    enclosure_height - 2 * wall,
                    rear_depth - back_wall + 0.2
                ],
                corner_radius - wall
            );

        // USB-C opening on right side.
        translate([enclosure_width / 2, -25, 8.5])
            cube([wall + 2, 11, 4.8], center = true);

        // Side button opening on right side.
        translate([enclosure_width / 2 - wall - 0.1, 23, 13])
            rotate([0, 90, 0])
                cylinder(h = wall + 2.2, r = 3.1);

        // Two-way navigation rocker opening on the right side.
        hull() {
            for (y = [-navigation_span / 2, navigation_span / 2]) {
                translate([
                    enclosure_width / 2 - wall - 0.1,
                    navigation_y + y,
                    navigation_z
                ])
                    rotate([0, 90, 0])
                        cylinder(h = wall + 2.2, r = navigation_radius);
            }
        }

        // Battery access opening through the rear wall.
        translate([0, battery_door_y, rear_depth - back_wall - 0.1])
            rounded_prism(
                [battery_door_width - 5, battery_door_height - 5, back_wall + 0.3],
                2
            );

        // Shallow recess keeps the battery door flush.
        translate([0, battery_door_y, rear_depth - 1.05])
            rounded_prism(
                [battery_door_width + 0.6, battery_door_height + 0.6, 1.2],
                3
            );
    }
}

module battery_door() {
    union() {
        rounded_prism(
            [battery_door_width, battery_door_height, battery_door_depth],
            3
        );

        // Two simple friction tabs for the v0.1 fit test.
        for (x = [-31, 31]) {
            // A 0.4 mm overlap with the plate keeps each tab manifold.
            translate([x, 0, -1.0])
                cube([8, 1.8, 2.8], center = true);
        }
    }
}

module navigation_rocker() {
    difference() {
        hull() {
            for (y = [-navigation_span / 2, navigation_span / 2]) {
                translate([0, y, 0])
                    cylinder(h = 2.8, r = navigation_radius - 0.35);
            }
        }

        // A center groove separates the previous and next touch surfaces.
        translate([0, 0, 2.45])
            cube([navigation_radius * 2, 0.7, 0.8], center = true);
    }
}

module assembly() {
    color([0.12, 0.12, 0.12]) front_bezel();
    color([0.85, 0.83, 0.78])
        translate([0, 0, bezel_depth]) rear_shell();
    color([0.78, 0.76, 0.70])
        translate([
            0,
            battery_door_y,
            bezel_depth + rear_depth - battery_door_depth
        ]) battery_door();
    color([0.70, 0.68, 0.63])
        translate([
            enclosure_width / 2 + 0.45,
            navigation_y,
            bezel_depth + navigation_z
        ])
            rotate([0, 90, 0]) navigation_rocker();

    // Visual-only e-paper surface for assembly preview.
    color([0.90, 0.90, 0.86])
        translate([0, 0, -0.35])
            rounded_prism([84.8, 63.6, 0.3], 0.8);
}

if (part == "front_bezel") {
    front_bezel();
} else if (part == "rear_shell") {
    rear_shell();
} else if (part == "battery_door") {
    battery_door();
} else if (part == "navigation_rocker") {
    navigation_rocker();
} else {
    assembly();
}
