/// @description Collision with obj_quicksand
// If cat has fast effect, ignore quicksand
if (spd > base_spd) {
    exit; // Don't apply slowdown if moving faster than normal
}

// Slow down the cat while touching
spd = base_spd * 0.5; // Reduces speed to 70%

// Play sound effect only once
if (!audio_is_playing(snd_quicksand)) {
    audio_play_sound(snd_quicksand, 1, false);
}

// Visual feedback - tint yellow/brown while in quicksand
image_blend = c_yellow;

// Create slow indicator only once
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