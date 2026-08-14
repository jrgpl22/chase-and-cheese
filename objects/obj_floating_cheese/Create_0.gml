// Stay at the position where you placed it
// (x and y are already set by where you drag it in the room)

// Random depth (draw behind players)
depth = 50;

// Rotation
image_angle = random(360);


// Size variation
image_xscale = random_range(0.5, 0.8);
image_yscale = image_xscale;

// Transparency
image_alpha = random_range(0.6, 0.9);

// Bobbing effect (gentle up and down float)
base_y = y; // Remember starting Y position
bob_offset = random(100); // Random starting point in wave
bob_speed = random_range(0.03, 0.06); // How fast it bobs
bob_range = random_range(3, 6); // How high/low it moves (in pixels)