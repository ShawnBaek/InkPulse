// InkPulse Model 42 — assembly-oriented FDM enclosure. Units: mm.
// Export: openscad -o stl/front-bezel.stl -D 'part="front_bezel"' InkPulse.scad
$fn=48;
part="assembly"; // front_bezel,rear_shell,electronics_tray,battery_door,action_button,navigation_rocker,switch_carrier,assembly,exploded

// FDM design parameters
outer_w=125; outer_h=101; outer_d=40; front_d=3; wall=2.4; back_wall=2.4; corner_r=7;
fit=0.30; m2_clear=2.25; m2_insert_od=3.6; m2_insert_depth=4.2;
// Locked purchased-component envelopes (measure the actual purchased revision)
epd_pcb=[103,78.5,8.5]; epd_active=[84.8,63.6]; epd_panel=[90.1,77,1.18];
xiao=[21,17.8,4]; battery_holder=[77.7,20.9,21.31]; battery_hole_pitch=55.61;
switch_body=[6,6,4.3]; window=[86,64.8]; boss_xy=[[-56,-43],[56,-43],[-56,43],[56,43]];
power_switch_body=[13.21,9.53,4.72]; power_switch_frame=[14.9,11.2,7.0];
tray_z=12.0; battery_pos=[0,-18]; xiao_pos=[47.8,29.1];
action_y=14; nav_y=-4; switch_z=18; door_center=[0,-20]; door_size=[94,39]; door_t=1.8; door_screw=[42,-20];
rear_local_d=outer_d-front_d; tray_t=2.4; tray_base_z=.5; tray_rear_z=tray_z+tray_base_z+tray_t;
carrier_x=outer_w/2-wall-3.75; switch_center_x=carrier_x+.375;
carrier_h=36; power_switch_x=outer_w/2-wall-power_switch_frame[0]/2+.3; power_switch_y=-33.45;

module rounded_prism(s,r){linear_extrude(height=s[2]) offset(r=r) square([s[0]-2*r,s[1]-2*r],center=true);}
module m2_boss(x,y,z0=front_d,h=9.5){difference(){translate([x,y,z0])cylinder(h=h,d=7.2);translate([x,y,z0+h-m2_insert_depth+.01])cylinder(h=m2_insert_depth+.1,d=m2_insert_od);}}
module side_slot(y,z,len,dia,depth=wall+1){hull()for(yy=[y-len/2+dia/2,y+len/2-dia/2])translate([outer_w/2-wall-.1,yy,z])rotate([0,90,0])cylinder(h=depth,d=dia);}
module rear_standoff(x,y){
 standoff_z=tray_rear_z-front_d;
 difference(){
  translate([x,y,standoff_z])cylinder(h=rear_local_d-standoff_z,d=7.2);
  translate([x,y,standoff_z-.1])cylinder(h=rear_local_d-standoff_z+.3,d=m2_clear);
  translate([x,y,rear_local_d-1.25])cylinder(h=1.4,d=4.5);
 }}
module door_insert_boss(){
 z0=rear_local_d-back_wall-m2_insert_depth;
 difference(){
  translate([door_screw[0],door_screw[1],z0])cylinder(h=back_wall+m2_insert_depth,d=7.2);
  translate([door_screw[0],door_screw[1],z0-.1])cylinder(h=m2_insert_depth+.2,d=m2_insert_od);
  translate([door_screw[0],door_screw[1],rear_local_d-back_wall-.1])cylinder(h=back_wall+.3,d=m2_clear);
 }}
module power_switch_retainer(){
 // Slide-in frame for the C&K 1000-series right-angle body; secure after fit check.
 translate([power_switch_x,power_switch_y,15.5])difference(){
  cube(power_switch_frame,center=true);
  cube([power_switch_frame[0]+.3,power_switch_body[1]+2*fit,power_switch_body[2]+2*fit],center=true);
 }}
module switch_carrier_guides(){
 // The carrier slides in from the open front before the bezel is installed.
 for(yy=[-carrier_h/2-.5,carrier_h/2+.5])translate([carrier_x,yy,switch_z])cube([7.9,.7,18],center=true);
 translate([carrier_x,0,switch_z+9.8])cube([7.9,carrier_h+1.0,1.2],center=true);
}

module front_bezel(){difference(){union(){rounded_prism([outer_w,outer_h,front_d],corner_r);
 translate([0,0,front_d-.01])difference(){rounded_prism([epd_pcb[0]+2*fit+2.4,epd_pcb[1]+2*fit+2.4,3],3);translate([0,0,-.1])rounded_prism([epd_pcb[0]+2*fit,epd_pcb[1]+2*fit,3.2],2);}
 for(p=boss_xy)m2_boss(p[0],p[1]);}
 translate([0,0,-.1])rounded_prism([window[0],window[1],front_d+.2],1.6);
 translate([0,0,front_d-.01])rounded_prism([epd_panel[0]+2*fit,epd_panel[1]+2*fit,2.2],1.6);}}

module rear_shell(){union(){difference(){union(){rounded_prism([outer_w,outer_h,rear_local_d],corner_r);
 // matching door rails
 for(yy=[door_center[1]-door_size[1]/2+2.2,door_center[1]+door_size[1]/2-2.2])translate([door_center[0],yy,rear_local_d-1.9])cube([door_size[0]-8,1.2,2.1],center=true);}
 // front-open main cavity
 translate([0,0,-.1])rounded_prism([outer_w-2*wall,outer_h-2*wall,rear_local_d-back_wall+.2],corner_r-wall);
 // USB-C and right-angle power switch openings
 translate([outer_w/2-wall/2,xiao_pos[1],tray_rear_z-front_d+xiao[2]/2])cube([wall+1,11,5.5],center=true);
 translate([outer_w/2-wall/2,power_switch_y,15.5])cube([wall+1,10,6],center=true);
 side_slot(action_y,switch_z,7.5,7); side_slot(nav_y,switch_z,18,7.2);
 // battery door and flush rebate
 translate([door_center[0],door_center[1],outer_d-front_d-back_wall-.1])rounded_prism([door_size[0]-4,door_size[1]-4,back_wall+.3],3);
 translate([door_center[0],door_center[1],outer_d-front_d-door_t])rounded_prism([door_size[0]+2*fit,door_size[1]+2*fit,door_t+.2],4);
 translate([door_screw[0],door_screw[1],rear_local_d-back_wall-.1])cylinder(h=back_wall+.3,d=m2_clear);}
 for(p=boss_xy)rear_standoff(p[0],p[1]);
 door_insert_boss();
 power_switch_retainer();
 switch_carrier_guides();}}

module electronics_tray(){difference(){union(){translate([0,0,tray_base_z])rounded_prism([117,91,tray_t],3);
 // Printed lands sit 0.5 mm behind the PCB; add 0.5 mm foam at these corners only.
 for(p=[[-47,-34],[47,-34],[-47,34],[47,34]])translate([p[0],p[1],0])cylinder(h=tray_base_z+.15,d=8);
 // holder rim with rear-facing open battery face
 difference(){translate([battery_pos[0],battery_pos[1],tray_base_z+tray_t-.05])rounded_prism([battery_holder[0]+2*fit+3.2,battery_holder[1]+2*fit+3.2,3.5],2);translate([battery_pos[0],battery_pos[1],tray_base_z+tray_t-.15])rounded_prism([battery_holder[0]+2*fit,battery_holder[1]+2*fit,3.7],1);}
 // low XIAO snap cradle; tabs avoid the antenna end
 translate([xiao_pos[0],xiao_pos[1],tray_base_z+tray_t+1.4])difference(){cube([xiao[0]+2*fit+2.4,xiao[1]+2*fit+1.4,3],center=true);cube([xiao[0]+2*fit,xiao[1]+2*fit,3.3],center=true);}
 for(yy=[-7,7])translate([xiao_pos[0]+xiao[0]/2+fit+.4,xiao_pos[1]+yy,tray_base_z+tray_t+1.3])cube([1.1,4,2.2],center=true);}
 for(p=boss_xy)translate([p[0],p[1],-.1])cylinder(h=tray_base_z+tray_t+.3,d=2.7);
 for(x=[-battery_hole_pitch/2,battery_hole_pitch/2])translate([battery_pos[0]+x,battery_pos[1],-.1])cylinder(h=tray_base_z+tray_t+.3,d=3.35);
 // open wiring channels and end strain-relief routes
 translate([-4,2,-.1])cube([48,3.5,tray_base_z+tray_t+.3]); translate([-44,-20,-.1])cube([9,5,tray_base_z+tray_t+.3]);translate([35,-20,-.1])cube([9,5,tray_base_z+tray_t+.3]);}}

module battery_door(){difference(){union(){rounded_prism([door_size[0],door_size[1],door_t],4);for(yy=[-door_size[1]/2+2.2,door_size[1]/2-2.2])translate([0,yy,-1])cube([door_size[0]-9,1,2.1],center=true);for(x=[-14,-7,0,7,14])translate([x,8,door_t])cube([2.5,12,.5],center=true);}translate([door_screw[0],0,-.1])cylinder(h=door_t+.3,d=m2_clear);translate([door_screw[0],0,door_t-.7])cylinder(h=.9,d=4.4);}}
module action_button(){union(){rotate([0,90,0])cylinder(h=4,d=6.1,center=true);translate([-2.2,0,0])cube([1.6,3,3],center=true);}}
module navigation_rocker(){difference(){union(){hull()for(yy=[-6,6])translate([0,yy,0])rotate([0,90,0])cylinder(h=4,d=6.2,center=true);rotate([0,90,0])cylinder(h=6,d=3.5,center=true);for(yy=[-5.5,5.5])translate([-2.5,yy,0])cube([1.5,3.2,2.8],center=true);}translate([0,0,0])rotate([0,90,0])cylinder(h=7,d=1.85,center=true);translate([0,0,2.6])cube([4.5,1,1.2],center=true);}}
module switch_carrier(){difference(){cube([7.5,carrier_h,18],center=true);
 // Open-side pockets retain the switch backs while leaving a 0.75 mm inner web.
 for(yy=[nav_y-5.5,nav_y+5.5,action_y])translate([.375,yy,0])cube([6.75,6.25,4.5],center=true);
 translate([1.8,0,-6])cube([4,30,4],center=true);
 // A shared 1.7–1.8 mm axle passes through this support and the rocker barrel.
 translate([0,nav_y,0])rotate([0,90,0])cylinder(h=9,d=1.85,center=true);}}

// Visual-only solids; never export these component envelopes.
module hardware_envelopes(){
 color([.94,.94,.90])translate([0,0,-.18])rounded_prism([epd_active[0],epd_active[1],.12],.8);
 color([.86,.86,.82,.7])translate([0,0,front_d+epd_pcb[2]/2])cube(epd_pcb,center=true);
 color([.15,.55,.25,.7])translate([xiao_pos[0],xiao_pos[1],tray_rear_z+xiao[2]/2])cube(xiao,center=true);
 color([.15,.25,.8,.55])translate([battery_pos[0],battery_pos[1],tray_rear_z+battery_holder[2]/2])cube(battery_holder,center=true);
 color([.15,.15,.15,.8])for(yy=[nav_y-5.5,nav_y+5.5,action_y])translate([switch_center_x,yy,front_d+switch_z])cube(switch_body,center=true);
 color([.12,.12,.12,.8])translate([power_switch_x,power_switch_y,front_d+15.5])cube(power_switch_body,center=true);}
module assembly(explode=0){
 // TravelCrumb cobalt blue (#2865D9) with matte charcoal controls.
 color([.157,.396,.851])translate([0,0,-explode*4])front_bezel();
 color([.157,.396,.851])translate([0,0,front_d+explode*4])rear_shell();
 color([.157,.396,.851])translate([0,0,tray_z+explode*8])electronics_tray();
 color([.157,.396,.851])translate([door_center[0],door_center[1],outer_d-door_t+explode*12])battery_door();
 color([.06,.07,.08])translate([outer_w/2+.7,action_y,front_d+switch_z])action_button();
 color([.06,.07,.08])translate([outer_w/2+.7,nav_y,front_d+switch_z])navigation_rocker();
 color([.10,.12,.16])translate([carrier_x,0,front_d+switch_z])switch_carrier();hardware_envelopes();}
if(part=="front_bezel")front_bezel();else if(part=="rear_shell")rear_shell();else if(part=="electronics_tray")electronics_tray();else if(part=="battery_door")battery_door();else if(part=="action_button")action_button();else if(part=="navigation_rocker")navigation_rocker();else if(part=="switch_carrier")switch_carrier();else if(part=="exploded")assembly(1);else assembly();
