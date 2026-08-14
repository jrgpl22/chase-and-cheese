
// ===== PAUSE CHECK =====
if (global.game_paused) {
    exit;
}

// ===== COUNTDOWN STATE =====
if (state == "countdown") {
    // Decrease countdown
    countdown_time -= 1 / room_speed;
    // When countdown finishes, switch to active round
    if (countdown_time <= 0 && !countdown_done) {
        countdown_done = true;
        state = "active";
		 last_count = -1;
    }
}
// ===== ACTIVE ROUND STATE =====
else if (state == "active") {
    // Decrease timer
    if (time_left > 0) {
        time_left -= 1 / room_speed;
        time_left = max(0, time_left);
    }
    // Trigger warning sound when time hits 10
    if (time_left <= 11) {
        if (loop_count < 3) {
            if (!audio_is_playing(snd_warning)) {
                audio_play_sound(snd_warning, 1, false);
                loop_count += 1;
            }
        }
    }
    // Handle timer end
    if (time_left <= 0) {
        time_left = 0;
        if (!timer_done) {
            timer_done = true;
            
            // Set up room refresh display
			audio_stop_all()
			audio_play_sound(snd_refresh, 0, false)
            show_room_refresh = true;
            global.game_paused = true;
            alarm[0] = room_speed * 3; // Show message for 3 seconds
        }
    }
}

if (double_ko_timer > 0) {
    double_ko_timer -= 1;
    if (double_ko_timer <= 0) {
        player_hit_by_bomb = "";
    }
}