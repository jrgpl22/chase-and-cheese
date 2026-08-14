/// @description Roulette spinning logic with intro/outro

// ===== INTRO STATE =====
if (state == "intro") {
    intro_timer++;
    
    // Slide text up
    intro_text_y = lerp(intro_text_y, intro_target_y, 0.15);
    
    // After intro finishes, switch to spinning
    if (intro_timer >= intro_duration) {
        state = "spinning";
		 audio_play_sound(snd_roulette, 0, false);
        show_debug_message("=== INTRO COMPLETE - Starting spin ===");
    }
    
    exit;  // Don't do anything else during intro
}

// ===== SPINNING STATE =====
if (state == "spinning") {
    if (is_complete) {
        exit;
    }
    
    spin_timer++;
    
    var progress = spin_timer / spin_duration;
    current_interval = lerp(min_interval, max_interval, power(progress, 2));
    
    // STOP CYCLING when very close to target room and near the end
    var should_cycle = true;
    if (progress > 0.95) {  // In last 5% of spin
        // Check if we're on the target room
        if (all_rooms[current_display_index] == target_room) {
            should_cycle = false;  // Stop cycling - we're on the target!
        }
    }
    
    // Cycle through rooms
    if (should_cycle) {
        interval_timer++;
        if (interval_timer >= current_interval) {
            interval_timer = 0;
            
            current_display_index++;
            if (current_display_index >= array_length(all_rooms)) {
                current_display_index = 0;
            }
            
            flash_alpha = 0.3;
            display_scale = 1.2;
            
            if (tick_sound_delay <= 0) {
                tick_sound_delay = max(current_interval, 5);
            }
        }
    }
    
    // Decay visual effects
    flash_alpha = lerp(flash_alpha, 0, 0.3);
    display_scale = lerp(display_scale, 1, 0.2);
    tick_sound_delay--;
    
    // FINISH: Switch to stopped
    if (spin_timer >= spin_duration) {
        is_complete = true;
        
        // Make sure we're showing the target room (safety check)
        for (var i = 0; i < array_length(all_rooms); i++) {
            if (all_rooms[i] == target_room) {
                current_display_index = i;
                break;
            }
        }
        
        state = "stopped";
        show_debug_message("=== ROULETTE COMPLETE - Showing final room ===");
    }
    
    exit;
}

// ===== STOPPED STATE - Show final room =====
if (state == "stopped") {
    stopped_timer++;
    
    // Keep displaying the final room (drawing handled in Draw event)
    
    // After showing final room, go to outro
    if (stopped_timer >= stopped_duration) {
        state = "outro";
        show_debug_message("=== Starting outro ===");
    }
    
    exit;
}

// ===== OUTRO STATE =====
// ===== OUTRO STATE =====
if (state == "outro") {
    outro_timer++;
    
    // Slide text down
    intro_text_y = lerp(intro_text_y, display_get_gui_height() + 100, 0.2);
    
    // After outro finishes, transition to room
    if (outro_timer >= outro_duration) {
        show_debug_message("=== OUTRO COMPLETE - Transitioning ===");
        
        // Unpause
        global.game_paused = false;
        
        // Create fade transition
        var fade = instance_create_depth(0, 0, -9999, obj_fade_transition);
        fade.mode = "out";
        fade.alpha = 0;
        fade.target_room = target_room;
        fade.is_gift_teleport = is_gift_teleport;
        fade.saved_timer_value = saved_timer_value;
        fade.saved_cheese_value = saved_cheese_value;
        
        show_debug_message("=== STARTING FADE TO: " + room_get_name(target_room) + " ===");
        
        instance_destroy();  // Destroy immediately after creating fade
        exit;  // Exit to prevent any more drawing
    }
}