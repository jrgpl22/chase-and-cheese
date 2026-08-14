//DRAW EVENT obj_howtoplay_menu
// Only draw if visible
if (!visible) exit;

// Draw dark overlay
draw_set_alpha(0.7);
draw_rectangle_color(0, 0, room_width, room_height, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);

// Get current page sprite
if (current_page == 1) {
    var current_sprite = spr_howtoplay_page1;
} else if (current_page == 2) {
    var current_sprite = spr_howtoplay_page2;
} else {
    var current_sprite = spr_howtoplay_page3;
}

// Draw the page
draw_sprite_ext(
    current_sprite,
    0,
    page_x,
    page_y,
    sprite_scale,
    sprite_scale,
    0,
    c_white,
    1
);

// Draw LEFT arrow
var left_scale = (mouse_over_button == "left") ? 1.15 : 1.0;
draw_sprite_ext(
    spr_btn_left_arrow,
    0,
    left_arrow_x,
    left_arrow_y,
    left_scale,
    left_scale,
    0,
    c_white,
    1
);

// Draw RIGHT arrow
var right_scale = (mouse_over_button == "right") ? 1.15 : 1.0;
draw_sprite_ext(
    spr_btn_right_arrow,
    0,
    right_arrow_x,
    right_arrow_y,
    right_scale,
    right_scale,
    0,
    c_white,
    1
);

// Draw BACK button
var back_scale = (mouse_over_button == "back") ? 1.1 : 1.0;
draw_sprite_ext(
    spr_btn_back,
    0,
    back_btn_x - 30,  // Subtract 50 pixels to move left
    back_btn_y + 17,
    back_scale,
    back_scale,
    0,
    c_white,
    1
);

// Page indicator
draw_set_font(fnt_lilita_one);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_color(c_white);
draw_text_transformed(page_x, room_height - 40, "Page " + string(current_page) + " of " + string(total_pages), 0.6, 0.6, 0);

// Reset
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);