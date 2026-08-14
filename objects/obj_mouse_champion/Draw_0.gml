/// @description Draw banner with slide animation and scores
// Calculate slide animation
if (visible) {
    if (!variable_instance_exists(id, "banner_slide_progress")) {
        banner_slide_progress = 0;
    }
    
    // Animate slide progress (0 to 1)
    if (banner_slide_progress < 1) {
        banner_slide_progress += 0.05; // Speed of slide (adjust for faster/slower)
    }
} else {
    // Reset animation when not visible
    banner_slide_progress = 0;
}

// Easing function for smooth animation (ease-out)
var ease_progress = 1 - power(1 - banner_slide_progress, 3);

// Calculate Y position with slide effect
var original_y = 15; // Your target Y position
var start_y = -200;   // Starting position (off-screen above)
var current_y = start_y + (original_y - start_y) * ease_progress;

// Draw the banner sprite at animated position
draw_sprite_ext(sprite_index, image_index, x, current_y, 
                image_xscale, image_yscale, image_angle, 
                image_blend, image_alpha);

// Draw the scores if banner is visible
if (visible) {
    draw_set_font(fnt_lilita_one);
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    
    // Score positions
    var cat_score_x = x + 170;
    var cat_score_y = current_y + 199;
    var mouse_score_x = x + 265;
    var mouse_score_y = current_y + 199;
    
    // === Editable scale values ===
    var cat_score_scale   = 0.6; // adjust size of cat score
    var mouse_score_scale = 0.6; // adjust size of mouse score
    
    // Draw Cat score
    draw_set_color(c_black); // Outline
    draw_text_transformed(cat_score_x + 1, cat_score_y + 1, string(global.cat_score), cat_score_scale, cat_score_scale, 0);
    draw_set_color(c_orange);
    draw_text_transformed(cat_score_x, cat_score_y, string(global.cat_score), cat_score_scale, cat_score_scale, 0);
    
    // Draw Mouse score
    draw_set_color(c_black); // Outline
    draw_text_transformed(mouse_score_x + 1, mouse_score_y + 1, string(global.mouse_score), mouse_score_scale, mouse_score_scale, 0);
    draw_set_color(c_gray);
    draw_text_transformed(mouse_score_x, mouse_score_y, string(global.mouse_score), mouse_score_scale, mouse_score_scale, 0);
    
    // Optional: "Press any key" prompt
    if (instance_exists(obj_mouse) && obj_mouse.show_mouse_champion) {
        draw_set_halign(fa_center);
        
        var blink = ((current_time div 500) mod 2 == 0);
        if (blink) {
            var scale = 0.6; // Smaller text size
            draw_set_color(c_black);
            draw_text_transformed(x + 198, current_y + 235, "Press any key", scale, scale, 0);
            draw_set_color(c_white);
            draw_text_transformed(x + 197, current_y + 234, "Press any key", scale, scale, 0);
        }
    }
    
    // Reset draw settings
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
