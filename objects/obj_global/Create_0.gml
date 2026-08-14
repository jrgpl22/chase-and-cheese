/// @description Initialize globals (ONCE ONLY - PROTECTED)
randomize();

show_debug_message("=== GAME MANAGER CREATE EVENT RUNNING ===");

// CRITICAL: Check if already initialized to prevent re-initialization
if (!variable_global_exists("globals_initialized")) {
    global.globals_initialized = true;
    global.mouse_score = 0;
    global.cat_score = 0;
    global.round = 1;
    global.mouse_cheese_collected = 0;
    global.teleported_by_gift = false;
    global.saved_timer = 81;
    
    show_debug_message("=== GLOBALS INITIALIZED FOR FIRST TIME ===");
    show_debug_message("Flag initialized to: " + string(global.teleported_by_gift));
} else {
    show_debug_message("=== GLOBALS ALREADY EXIST - SKIPPING INIT ===");
    show_debug_message("Flag value: " + string(global.teleported_by_gift));
}

persistent = true;