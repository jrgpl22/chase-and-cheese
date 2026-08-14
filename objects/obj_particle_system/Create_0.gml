// Create particle system
particle_sys = part_system_create();
part_system_depth(particle_sys, 100); // Draw behind most objects

// Create firefly/glowing particle type
part_firefly = part_type_create();

// Particle appearance - glowing effect
part_type_shape(part_firefly, pt_shape_flare); // Soft glowing shape
part_type_size(part_firefly, 0.15, 0.4, 0, 0); // Small, constant size
part_type_color3(part_firefly, c_yellow, c_white, c_orange); // Glowing colors
part_type_alpha3(part_firefly, 0, 0.8, 0); // Fade in, glow bright, fade out (pulsing effect)
part_type_speed(part_firefly, 0.1, 0.5, 0, 0); // Slow drifting movement
part_type_direction(part_firefly, 0, 360, 0, 0.5); // Move in random directions, change direction slowly
part_type_gravity(part_firefly, 0, 0); // NO gravity - float in place
part_type_life(part_firefly, 120, 240); // Live 2-4 seconds, then respawn
part_type_blend(part_firefly, true); // Additive blending for glow

// Create emitter that covers ENTIRE SCREEN
part_emit = part_emitter_create(particle_sys);

// Set emitter to spawn across ENTIRE room (width AND height)
part_emitter_region(
    particle_sys,
    part_emit,
    0, room_width,      // X: Full width (left to right)
    0, room_height,     // Y: Full height (top to bottom)
    ps_shape_rectangle,
    ps_distr_linear     // Evenly distributed everywhere
);

// Create initial burst to fill entire screen immediately
part_emitter_burst(particle_sys, part_emit, part_firefly,1); // 100 fireflies instantly

// Keep spawning to maintain particle count
part_emitter_stream(particle_sys, part_emit, part_firefly, 0);

// Add 3 more per step