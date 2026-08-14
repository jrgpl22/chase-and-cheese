if (bomb_state == "signal") {
    audio_play_sound(snd_bomb_radius, 1, false);
    alarm[2] = audio_sound_length(snd_bomb_radius) * room_speed + (0.5 * room_speed);
}