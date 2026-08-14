bomb_state = "signal";
explosion_radius = 26;
circle_offset_x = 14;
circle_offset_y = 15;

sprite_index = spr_signal;
image_speed = 1;
image_index = 0;

if (!audio_is_playing(snd_bomb_radius)) {
    audio_play_sound(snd_bomb_radius, 1, true);
}

var random_time = irandom_range(3, 5);
alarm[0] = random_time * room_speed;