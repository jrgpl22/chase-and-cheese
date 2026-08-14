if (global.game_paused) {
    alarm[1] = 1;  // Check again next frame
    exit;
}

if (instance_exists(obj_cheese)) {
    audio_play_sound(teleport_out, 1, false);
    audio_sound_gain(teleport_out, 0.5, 0);
    show_debug_message("Played teleport IN sound");
}