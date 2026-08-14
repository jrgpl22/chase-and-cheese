if (circle_radius < max_radius) {
    circle_radius += transition_speed;
} else {
    if (surface_exists(surf)) surface_free(surf);
    instance_destroy(); // Make sure this is here!
}