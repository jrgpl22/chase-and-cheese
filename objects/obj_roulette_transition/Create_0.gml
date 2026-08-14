/// @description Initialize roulette
depth = -10000;

// PAUSE EVERYTHING
global.game_paused = true;
audio_stop_all();
show_debug_message("=== ROULETTE: GAME PAUSED & AUDIO STOPPED ===");

// Room cycling
all_rooms = [Map1, Map2, Map3, Map4];
current_display_index = 0;
target_room = -1;
// Timing (adjusted for 10.4 second SFX)
spin_timer = 0;
spin_duration = 8.6 * room_speed;
current_interval = 3;
interval_timer = 0;
// Spin speed control
min_interval = 3;
max_interval = 30;
// Visual
flash_alpha = 0;
display_scale = 1;
// Sound
tick_sound_delay = 0;
// Save values
is_gift_teleport = global.teleported_by_gift;
saved_timer_value = global.saved_timer;
saved_cheese_value = global.mouse_cheese_collected;
is_complete = false;
// ===== INTRO/OUTRO ANIMATION =====
state = "intro";  // States: "intro", "spinning", "stopped", "outro"
intro_text_y = display_get_gui_height() + 100;
intro_target_y = display_get_gui_height() / 2;
intro_timer = 0;
intro_duration = 60;
outro_timer = 0;
outro_duration = 60;
stopped_timer = 0;  // ADD THIS
stopped_duration = 90;  // ADD THIS - Show final room for 1.5 seconds
show_debug_message("=== ROULETTE START - Target: " + room_get_name(target_room) + " ===");