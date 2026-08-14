if (visible) {
    if (!variable_instance_exists(id, "banner_slide_progress")) {
        banner_slide_progress = 0;
    }
    
    if (banner_slide_progress < 1) {
        banner_slide_progress += 0.05;
    }
} else {
    banner_slide_progress = 0;
}

var ease_progress = 1 - power(1 - banner_slide_progress, 3);

var original_y = 15; 
var start_y = -200;   
var current_y = start_y + (original_y - start_y) * ease_progress;

draw_sprite_ext(sprite_index, image_index, x, current_y, 
                image_xscale, image_yscale, image_angle, 
                image_blend, image_alpha);

if (visible) {
    draw_set_font(fnt_lilita_one);
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    
    var cat_score_x = x + 170;
    var cat_score_y = current_y + 199;
    var mouse_score_x = x + 265;
    var mouse_score_y = current_y + 199;
    var cat_score_scale   = 0.6;
    var mouse_score_scale = 0.6; 
    
    draw_set_color(c_black); 
    draw_text_transformed(cat_score_x + 1, cat_score_y + 1, string(global.cat_score), cat_score_scale, cat_score_scale, 0);
    draw_set_color(c_orange);
    draw_text_transformed(cat_score_x, cat_score_y, string(global.cat_score), cat_score_scale, cat_score_scale, 0);
    
    draw_set_color(c_black); 
    draw_text_transformed(mouse_score_x + 1, mouse_score_y + 1, string(global.mouse_score), mouse_score_scale, mouse_score_scale, 0);
    draw_set_color(c_gray);
    draw_text_transformed(mouse_score_x, mouse_score_y, string(global.mouse_score), mouse_score_scale, mouse_score_scale, 0);
    
    if (instance_exists(obj_cat) && obj_cat.show_cat_champion) {
        draw_set_halign(fa_center);
        
        var blink = ((current_time div 500) mod 2 == 0);
        if (blink) {
            var scale = 0.6; 
            draw_set_color(c_black);
            draw_text_transformed(x + 198, current_y + 235, "Press any key", scale, scale, 0);
            draw_set_color(c_white);
            draw_text_transformed(x + 197, current_y + 234, "Press any key", scale, scale, 0);
        }
    }
    
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
