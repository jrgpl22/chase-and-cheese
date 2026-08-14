randomize();
// Movement variables
spd = 1.86
base_spd = 1.86
hspd = 0;
vspd = 0;
is_flying = false;
spin_speed = 0;
gravity_y = 0;
is_double_ko = false;
// Power-up variables
is_stunned = false;
effect_timer = 0;
is_confused = false;
confused_keys = [ord("W"), ord("S"), ord("A"), ord("D")];
confusion_shuffled = false;
show_mouse_champion = false
// Start with idle down sprite
show_mouse_winner = false
sprite_index = spr_rat_idle_down;
direction = 270;
speed = 0;

// RESTORE cheese if gift teleport
if (global.teleported_by_gift) {
    cheese_collected = global.mouse_cheese_collected;
    show_debug_message("RESTORED mouse cheese: " + string(cheese_collected));
} else {
    cheese_collected = 0;
}
// DON'T RESET FLAG HERE - Let fade transition do it

image_xscale = 0.9
image_yscale = 0.9
hsp = 0;
vsp = 0;
friction_ice = 0.94;
ice_accel_multiplier = 0.07;
ice_physics_active = true;
teleport_cooldown = 0;