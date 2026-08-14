//draw gui code for obj_settings_menu
// Draw semi-transparent overlay
draw_set_alpha(0.7);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);

// Get GUI dimensions
var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();

// Draw settings container
draw_sprite_ext(
    spr_settings_container,
    0,
    container_x,
    container_y,
    0.8,
    0.8,
    0,
    c_white,
    1
);

// Calculate icon boundaries for slider clamping
var icon_x = container_x - 218;
var icon_width = sprite_get_width(spr_sound_icon);
var icon_right_edge = icon_x + (icon_width / 2); // Right edge of icon
var min_slider_x = icon_right_edge + 45; // Minimum slider position (20px padding)

// Calculate bar boundaries
var bar_sprite_width = sprite_get_width(spr_volume_bar);
var bar_left = container_x - (bar_sprite_width / 2);
var bar_right = container_x + (bar_sprite_width / 2);

// Clamp slider_x to stay within proper bounds
slider_x = clamp(slider_x, min_slider_x, bar_right);

// Draw volume bar FIRST
// Draw volume bar with right offset
var bar_offset_x = 20; // Adjust this value to move bar right
draw_sprite_ext(
    spr_volume_bar,
    0,
    container_x + bar_offset_x, // Added offset here
    bar_y + (bar_height / 2),
    1.0,
    1.0,
    0,
    c_white,
    1
);

// Draw sound icon (after bar, before slider)
draw_sprite_ext(
    spr_sound_icon,
    0,
    icon_x,
    container_y - 45,
    1.0,
    1.0,
    0,
    c_white,
    1
);

// Draw volume slider ON TOP
var slider_scale = dragging_slider ? 1.2 : 1.0;
draw_sprite_ext(
    spr_volume_slider,
    0,
    slider_x,
    slider_y,
    slider_scale,
    slider_scale,
    0,
    c_white,
    1
);

// Draw back button
var back_scale = back_btn_hover ? 1.1 : 1.0;
draw_sprite_ext(
    spr_btn_back,
    0,
    back_btn_x,
    back_btn_y,
    back_scale,
    back_scale,
    0,
    c_white,
    1
);

// Draw volume percentage in dark brown
draw_set_font(fnt_pause_menu);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(make_color_rgb(101, 67, 33));
var volume_percent = round(global.master_volume * 100);
draw_text_transformed(container_x, container_y + 60, string(volume_percent) + "%", 0.8, 0.8, 0);

// Reset draw settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);