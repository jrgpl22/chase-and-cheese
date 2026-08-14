/// @description Despawn Old & Spawn New Quicksand
show_debug_message("=== DESPAWNING & RESPAWNING QUICKSAND ===");

// Play teleport out sound
audio_play_sound(teleport_in, 1, false);
audio_sound_gain(teleport_in, 0.5, 0);

// Trigger shrink animation on all existing quicksand
with (obj_quicksand) {
    is_teleporting = true;
    teleport_phase = 1; // Shrink out
    teleport_timer = 0;
}

show_debug_message("All quicksand shrinking out");

// Wait for shrink animation, then spawn new quicksand
alarm[1] = 20; // 20 frames delay