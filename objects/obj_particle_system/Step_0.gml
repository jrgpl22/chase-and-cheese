// Keep emitter region covering entire room
// (Updates if room size changes)
part_emitter_region(
    particle_sys,
    part_emit,
    0, room_width,      
    0, room_height,     
    ps_shape_rectangle,
    ps_distr_linear
);

// Optional: Randomly spawn particles to fill gaps
if (random(1) < 0.2) { // 20% chance each step
    part_emitter_burst(particle_sys, part_emit, part_firefly, 2);
}