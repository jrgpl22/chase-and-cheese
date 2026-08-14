draw_set_circle_precision(64);

var cam = view_camera[0];
var view_x = camera_get_view_x(cam);
var view_y = camera_get_view_y(cam);
var view_w = camera_get_view_width(cam);
var view_h = camera_get_view_height(cam);

var cx = view_x + view_w / 2;
var cy = view_y + view_h / 2;

// Create surface if it doesn't exist
if (!surface_exists(surf)) {
    surf = surface_create(view_w, view_h);
}

// Draw to surface
surface_set_target(surf);
draw_clear_alpha(c_black, 1); // Fill with black
gpu_set_blendmode(bm_subtract); // Subtract mode
draw_set_color(c_white);
draw_circle(view_w / 2, view_h / 2, circle_radius, false); // Draw circle hole
gpu_set_blendmode(bm_normal);
surface_reset_target();

// Draw the surface to screen
draw_surface(surf, 0, 0);