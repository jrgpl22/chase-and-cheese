if (mode == "out") {
    // Fade out (screen goes black)
    if (alpha < 1) {
        alpha += fade_speed;
    } else {
        // Fade complete, change room
        if (target_room != -1) {
            show_debug_message("=== CHANGING ROOM ===");
            room_goto(target_room);
            mode = "in";
        }
    }
}
else if (mode == "in") {
    // Fade in (black disappears)
    if (alpha > 0) {
        alpha -= fade_speed;
    } else {
        // Fade complete
        show_debug_message("=== FADE COMPLETE ===");
        
        if (global.teleported_by_gift) {
            global.teleported_by_gift = false;
            global.saved_timer = 81;
        }
        
        instance_destroy();
    }
}