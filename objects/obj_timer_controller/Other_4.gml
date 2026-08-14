/// @description Restore values after gift teleport

// Check if we just teleported via gift
if (global.teleported_by_gift) {
    show_debug_message("=== TIMER: RESTORING AFTER GIFT TELEPORT ===");
    
    // Restore timer value
    time_left = global.saved_timer;
    show_debug_message("Timer restored to: " + string(time_left) + " seconds");
    
    // Make sure we're in active state (not countdown)
    state = "active";
    countdown_done = true;
    show_debug_message("State set to: active");
    
    // Restore mouse cheese
    var mouse_instance = instance_find(obj_mouse, 0);
    if (instance_exists(mouse_instance)) {
        mouse_instance.cheese_collected = global.mouse_cheese_collected;
        show_debug_message("Mouse cheese restored to: " + string(global.mouse_cheese_collected));
    }
    
    // Unpause the game
    global.game_paused = false;
    
    // Reset the flag
    global.teleported_by_gift = false;
    global.saved_timer = 81;  // Reset to default
    global.mouse_cheese_collected = 0;  // Reset to default
    
    show_debug_message("=== RESTORATION COMPLETE ===");
}