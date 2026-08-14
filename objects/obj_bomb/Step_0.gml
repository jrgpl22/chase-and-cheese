if (global.game_paused) {
    image_speed = 0;
    
    // Stop the radius sound when paused
    if (bomb_state == "signal" && audio_is_playing(snd_bomb_radius)) {
        audio_stop_sound(snd_bomb_radius);
    }
    
    exit;
}

image_speed = 1;

// Resume the radius sound when unpaused
if (bomb_state == "signal" && !audio_is_playing(snd_bomb_radius)) {
    audio_play_sound(snd_bomb_radius, 1, true);
}