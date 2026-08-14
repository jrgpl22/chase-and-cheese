//if (effect_timer > 0) {
//    var seconds_left = ceil(effect_timer / room_speed);
//    var effect_text = "";
//    var effect_color = c_white;
    
//    if (spd > base_spd) {
//        effect_text = "SPEED BOOST";
//        effect_color = c_lime;
//    }
//    else if (spd < base_spd && !is_stunned) {
//        effect_text = "SLOWED";
//        effect_color = c_red;
//    }
//    else if (is_stunned) {
//        effect_text = "STUNNED";
//        effect_color = c_yellow;
//    }
//    else if (is_confused) {
//        effect_text = "CONFUSED";
//        effect_color = c_purple;
//    }
    
//    var gui_width = display_get_gui_width();
//    var gui_height = display_get_gui_height();
    
//    draw_set_font(fnt_lilita_one); 
//    draw_set_halign(fa_right);
//    draw_set_valign(fa_bottom);
    
//    var text_x = gui_width - 10; 
//    var text_y = gui_height - 10;
    
//    var full_text = "Cat: " + effect_text + " " + string(seconds_left) + "s";
    
//    var outline_color = c_black;
//    var stroke = 2;
//    draw_set_color(outline_color);
//    for (var ox = -stroke; ox <= stroke; ox++) {
//        for (var oy = -stroke; oy <= stroke; oy++) {
//            if (ox != 0 || oy != 0) {
//                draw_text(text_x + ox, text_y + oy, full_text);
//            }
//        }
//    }
    
//    draw_set_color(effect_color);
//    draw_text(text_x, text_y, full_text);
//    draw_set_halign(fa_left);
//    draw_set_valign(fa_top);
//    draw_set_color(c_white);
//}

//{
//    draw_set_font(fnt_lilita_one);
//    draw_set_halign(fa_right);
//    draw_set_valign(fa_top);
//    var score_text = "CAT: " + string(global.cat_score);
//    var draw_x = room_width - 20;
//    var draw_y = 20;
    
//    var outline_color = c_black;
//    var stroke = 2;
//    draw_set_color(outline_color);
//    for (var ox = -stroke; ox <= stroke; ox++) {
//        for (var oy = -stroke; oy <= stroke; oy++) {
//            if (ox != 0 || oy != 0) {
//                draw_text(draw_x + ox, draw_y + oy, score_text);
//            }
//        }
//    }
//    var main_color = make_color_rgb(255, 140, 0);
//    draw_set_color(main_color);
//    draw_text(draw_x, draw_y, score_text);
//    draw_set_halign(fa_left);
//}