// Only draw if visible
if (!visible) exit;

// Draw dark overlay over the entire screen
draw_set_alpha(0.7);
draw_rectangle_color(0, 0, room_width, room_height, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);

// Choose which sprite to draw based on winner
var win_sprite;
if (winner == "cat") {
    win_sprite = spr_cat_wins;  // Use cat wins picture
} else if (winner == "mouse") {
    win_sprite = spr_mouse_wins;  // Use mouse wins picture
} else {
    exit; // No winner set, don't draw anything
}

// Draw the win screen sprite (centered)
draw_sprite_ext(
    win_sprite,
    0,
    win_x,
    win_y,
    sprite_scale,
    sprite_scale,
    0,
    c_white,
    1
);

// Set up font for score display
draw_set_font(win_font);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_color(#4A3428);  // Brown color for text

// Draw CAT score (next to the cat icon in the picture)
draw_text_transformed(cat_score_x, cat_score_y, string(cat_score), score_text_scale, score_text_scale, 0);

// Draw MOUSE score (next to the mouse icon in the picture)
draw_text_transformed(mouse_score_x, mouse_score_y, string(mouse_score), score_text_scale, score_text_scale, 0);

// Reset draw settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);