if (spd > base_spd) {
    exit;
}

spd = base_spd * 0.5;

if (!audio_is_playing(snd_quicksand)) {
    audio_play_sound(snd_quicksand, 1, false);
}

image_blend = c_yellow;

if (!variable_instance_exists(id, "quicksand_indicator") || !instance_exists(quicksand_indicator)) {
    quicksand_indicator = instance_create_layer(
        x - 9,
        y - 25, 
        "effects_indicator", 
        obj_effect_indicator
    );
    
    quicksand_indicator.target = id;
    quicksand_indicator.sprite_index = spr_effects_slow;
    quicksand_indicator.image_blend = c_red;
    quicksand_indicator.offset_x = -9;
    quicksand_indicator.offset_y = -25;
    quicksand_indicator.image_speed = 1;
}