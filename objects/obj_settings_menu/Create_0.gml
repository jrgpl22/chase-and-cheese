// Create codes for obj_settings_menu
// Store where we came from (Home or game room)
came_from_home = (room == Home);  // Make sure "Home" matches your actual room name
depth = -10000;

// Volume
if (!variable_global_exists("master_volume")) {
    global.master_volume = 1.0;
}

dragging_slider = false;

// UI positions
container_x = display_get_gui_width() / 2;
container_y = display_get_gui_height() / 2;

// Volume bar
bar_x = container_x - 200;
bar_y = container_y - 20;
bar_width = 400;
bar_height = 40;

// Slider
slider_x = bar_x + (global.master_volume * bar_width);
slider_y = bar_y + (bar_height / 2);
slider_radius = 25;

// Back button
back_btn_x = container_x;
back_btn_y = container_y + 120;
back_btn_hover = false;

// Calculate minimum slider position (after the icon)
var icon_right_edge = (container_x - 218) + 40;
slider_min_x = icon_right_edge + 1;

// Slider range
bar_left = slider_min_x;
bar_right = container_x + 230;
bar_width = bar_right - bar_left;

closing = false;
close_timer = 0;