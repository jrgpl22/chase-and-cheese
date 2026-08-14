/// @description Draw roulette display with intro/outro text
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var center_x = gui_w / 2;
var center_y = gui_h / 2;

// Darken background
draw_set_alpha(0.8);
draw_set_color(c_black);
draw_rectangle(0, 0, gui_w, gui_h, false);
draw_set_alpha(1);

// ===== INTRO STATE - Show "CHANGING ROOM!" text =====
if (state == "intro") {
    draw_set_font(-1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var text_scale = 3;
    
    // Text shadow
    draw_set_color(c_black);
    for (var i = 0; i < 8; i++) {
        draw_text_transformed(
            center_x + lengthdir_x(4, i * 45),
            intro_text_y + lengthdir_y(4, i * 45),
            "CHANGING ROOM!",
            text_scale,
            text_scale,
            0
        );
    }
    
    // Main text with rainbow/pulse effect
    var pulse = 1 + sin(intro_timer * 0.2) * 0.1;
    draw_set_color(c_yellow);
    draw_text_transformed(center_x, intro_text_y, "CHANGING ROOM!", text_scale * pulse, text_scale * pulse, 0);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    exit;
}

// ===== SPINNING & STOPPED STATE - Show map images =====
if (state == "spinning" || state == "stopped") {
    // Flash effect (only during spinning)
    if (state == "spinning" && flash_alpha > 0) {
        draw_set_alpha(flash_alpha);
        draw_set_color(c_yellow);
        draw_rectangle(0, 0, gui_w, gui_h, false);
        draw_set_alpha(1);
    }
    
    // Get current room and sprite
    var current_room = all_rooms[current_display_index];
    var map_sprite = noone;
    
    switch(current_room) {
        case Map1: 
            map_sprite = spr_map1_preview; 
            break;
        case Map2: 
            map_sprite = spr_map2_preview; 
            break;
        case Map3: 
            map_sprite = spr_map3_preview; 
            break;
        case Map4:
            map_sprite = spr_map4_preview;
            break;
    }
    
    // Draw map preview
    if (sprite_exists(map_sprite)) {
        var img_scale = display_scale * 0.3;
        
        // Extra glow when stopped on final room
        if (state == "stopped") {
            draw_sprite_ext(map_sprite, 0, center_x, center_y, img_scale + 0.1, img_scale + 0.1, 0, c_lime, 0.8);
        }
        
        // Glow
        draw_sprite_ext(map_sprite, 0, center_x, center_y, img_scale + 0.05, img_scale + 0.05, 0, c_yellow, 0.5);
        
        // Main image
        draw_sprite_ext(map_sprite, 0, center_x, center_y, img_scale, img_scale, 0, c_white, 1);
    }
    
    // Bottom text - only show "SELECTED!" when stopped
    if (state == "stopped") {
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);
        
        // Pulsing "SELECTED!" text
        var pulse = 1 + sin(stopped_timer * 0.3) * 0.2;
        draw_set_color(c_lime);
        draw_text_transformed(center_x, center_y + 150, "SELECTED!", 1.5 * pulse, 1.5 * pulse, 0);
    }
}

// ===== OUTRO STATE - Slide text down =====
if (state == "outro") {
    draw_set_font(-1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var text_scale = 3;
    
    // Text shadow
    draw_set_color(c_black);
    for (var i = 0; i < 8; i++) {
        draw_text_transformed(
            center_x + lengthdir_x(4, i * 45),
            intro_text_y + lengthdir_y(4, i * 45),
            "GET READY!",
            text_scale,
            text_scale,
            0
        );
    }
    
    // Main text
    draw_set_color(c_lime);
    draw_text_transformed(center_x, intro_text_y, "GET READY!", text_scale, text_scale, 0);
}

// Reset
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);