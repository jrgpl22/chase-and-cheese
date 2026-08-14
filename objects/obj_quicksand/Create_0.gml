/// @description Initialize
image_speed = 0.5; // Animate the sprite

// Set depth (higher number = further back/below)
depth = 100; // Adjust this - higher = more behind other objects

// Teleport animation variables
is_teleporting = false;
teleport_phase = 0; // 0 = normal, 1 = shrinking out, 2 = growing in
teleport_timer = 0;
target_scale = 1; // Final scale when fully grown