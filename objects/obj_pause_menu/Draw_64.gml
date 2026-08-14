// Draw semi-transparent overlay
draw_set_alpha(0.6);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);

// Get GUI dimensions
var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();

// Container position (EXACT CENTER of screen)
var container_x = gui_width / 2;
var container_y = gui_height / 2;

// Draw pause container at 80% size
draw_sprite_ext(spr_pause_container, 0, container_x, container_y, 0.8, 0.8, 0, c_white, 1);

// USE LILITA ONE FONT - High Quality!
draw_set_font(fnt_pause_menu);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Orange color for selected items
var orange = make_color_rgb(255, 140, 0);

// CENTERED text X position
var text_x = container_x;

// Menu option Y positions (MOVED UP for better spacing)
var resume_y = container_y - 66;
var restart_y = container_y - 16;
var settings_y = container_y + 35;
var quit_y = container_y + 85;

// Draw RESUME (highlight if selected OR hovered)
draw_set_color((selected == 0 || mouse_over == 0) ? orange : c_black);
draw_text_transformed(text_x, resume_y, "RESUME", 1.2, 1.2, 0);

// Draw RESTART
draw_set_color((selected == 1 || mouse_over == 1) ? orange : c_black);
draw_text_transformed(text_x, restart_y, "RESTART", 1.2, 1.2, 0);

// Draw SETTINGS
draw_set_color((selected == 2 || mouse_over == 2) ? orange : c_black);
draw_text_transformed(text_x, settings_y, "SETTINGS", 1.2, 1.2, 0);

// Draw QUIT
draw_set_color((selected == 3 || mouse_over == 3) ? orange : c_black);
draw_text_transformed(text_x, quit_y, "QUIT", 1.2, 1.2, 0);

// Get arrow Y position based on selection
var arrow_y;
switch(selected) {
    case 0: arrow_y = resume_y; break;
    case 1: arrow_y = restart_y; break;
    case 2: arrow_y = settings_y; break;
    case 3: arrow_y = quit_y; break;
}

// Animated arrow movement
var arrow_animation = sin(current_time / 200) * 10;
var arrow_offset = 100; // CLOSER to text

// Draw LEFT arrow - SMALLER and CLOSER
var left_arrow_x = text_x - arrow_offset - arrow_animation;
draw_sprite_ext(spr_arrow_left, 0, left_arrow_x, arrow_y, 0.5, 0.5, 0, orange, 1);

// Draw RIGHT arrow - SMALLER and CLOSER
var right_arrow_x = text_x + arrow_offset + arrow_animation;
draw_sprite_ext(spr_arrow_right, 0, right_arrow_x, arrow_y, 0.5, 0.5, 0, orange, 1);

// Optional: Draw visual feedback when hovering with mouse
if (mouse_over != -1) {
    draw_set_alpha(0.1);
    draw_set_color(c_orange);
    var hover_y;
    switch(mouse_over) {
        case 0: hover_y = resume_y; break;
        case 1: hover_y = restart_y; break;
        case 2: hover_y = settings_y; break;
        case 3: hover_y = quit_y; break;
    }
    draw_rectangle(text_x - 120, hover_y - 20, text_x + 120, hover_y + 20, false);
    draw_set_alpha(1);
}

// Reset draw settings
draw_set_font(-1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);