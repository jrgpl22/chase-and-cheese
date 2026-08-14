draw_self();

if (bomb_state == "signal") {
    draw_set_circle_precision(32);
    draw_set_alpha(0.2);
    draw_set_color(c_red);
    draw_circle(x + circle_offset_x, y + circle_offset_y, explosion_radius, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}