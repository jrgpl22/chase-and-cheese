show_debug_message("=== TIMER CREATE EVENT ===");

// Pre-round countdown
countdown_time = 4;
countdown_done = false;
show_room_refresh = false;
last_count = -1; 

// Round timer
time_left = 80;
loop_count = 0;
timer_done = false;
double_ko_timer = 0;
player_hit_by_bomb = "";

// CHECK IF GIFT TELEPORT
if (global.teleported_by_gift) {
    // Skip countdown, restore saved timer
    state = "active";
    countdown_time = 0;
    countdown_done = true;
    time_left = global.saved_timer;
    show_debug_message("GIFT TELEPORT! Timer restored to: " + string(time_left) + " - NO COUNTDOWN");
} else {
    // Normal start with countdown
    state = "countdown";
    countdown_time = 4;
    countdown_done = false;
    time_left = 80;
    show_debug_message("NORMAL START! Timer set to: " + string(time_left) + " - WITH COUNTDOWN");
}

// DON'T RESET global.saved_timer HERE - Let fade transition do it