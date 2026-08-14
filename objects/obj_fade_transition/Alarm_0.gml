/// @description Alarm 0 - Restore saved values after gift teleport
if (is_gift_teleport) {
    show_debug_message("=== RESTORING SAVED VALUES ===");
    
    // Restore mouse cheese count
    var mouse_instance = instance_find(obj_mouse, 0);
    if (instance_exists(mouse_instance)) {
        mouse_instance.cheese_collected = saved_cheese_value;
        show_debug_message("Restored cheese: " + string(saved_cheese_value));
    }
    
    // Restore timer
    if (instance_exists(obj_timer_controller)) {
        var timer_instance = instance_find(obj_timer_controller, 0);
        if (timer_instance != noone) {
            timer_instance.time_left = saved_timer_value;
            show_debug_message("Restored timer: " + string(saved_timer_value));
        }
    }
}