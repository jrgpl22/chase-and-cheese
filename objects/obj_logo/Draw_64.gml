// Draw the logo (always fully visible)
draw_sprite_ext(
    spr_logo,
    0,
    300,         
    170,          
    0.4,         
    0.4,         
    0,
    c_white,
    1  // ← Always 1 (fully visible)
);

// Draw black fade overlay
draw_set_alpha(alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);