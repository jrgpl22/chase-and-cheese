alpha = 0;
fade_speed = 0.02;
depth = -9999;
persistent = true;  // ← ADD THIS!

if (!variable_instance_exists(id, "mode")) {
    mode = "in";
}
target_room = -1;
is_gift_teleport = false;
saved_timer_value = 81;
saved_cheese_value = 0;