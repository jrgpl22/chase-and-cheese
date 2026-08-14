/// @description Initial spawn (make visible)

show_debug_message("=== GIFT INITIAL SPAWN ===");
visible = true;
image_alpha = 1;
audio_play_sound(snd_gift_spawn, 0, false);
show_debug_message("Gift now visible at X:" + string(x) + " Y:" + string(y));