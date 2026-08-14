// Gentle bobbing up and down
bob_offset += bob_speed;
y = base_y + sin(bob_offset) * bob_range;

// Slow rotation
