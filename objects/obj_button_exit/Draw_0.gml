//draw code for obj_button_exit

var draw_scale_x = image_xscale;
var draw_scale_y = image_yscale;

if (hover && mouse_check_button(mb_left)) {
    draw_scale_x *= 0.95;
    draw_scale_y *= 0.95;
} else if (hover) {
    draw_scale_x *= 1.05;
    draw_scale_y *= 1.05;
}

if (hover) {
    draw_sprite_ext(sprite_index, 0, x + 4, y + 4, draw_scale_x, draw_scale_y, 0, c_black, 0.4);
}

draw_sprite_ext(sprite_index, 0, x, y, draw_scale_x, draw_scale_y, 0, c_white, 1);

if (hover) {
    gpu_set_blendmode(bm_add);
    draw_sprite_ext(sprite_index, 0, x, y, draw_scale_x * 1.02, draw_scale_y * 1.02, 0, c_orange, 0.3);
    gpu_set_blendmode(bm_normal);
}