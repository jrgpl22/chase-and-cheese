
if (global.flash_alpha > 0) {
    draw_set_alpha(global.flash_alpha);
    draw_set_color(global.flash_color);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);
    draw_set_color(c_white);
    
    // fade out here
    global.flash_alpha -= 0.05;
    if (global.flash_alpha < 0) global.flash_alpha = 0;
}