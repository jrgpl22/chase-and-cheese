///// DRAW GUI EVENT

//// ===== ROOM REFRESH DISPLAY (CHECK FIRST) =====
if (show_room_refresh) {
    // ===== REMATCH SPRITE POSITION =====
    var rematch_x = 405;  // ADJUST THIS
    var rematch_y = 90;  // ADJUST THIS
    var sprite_scale = 1;  // ADJUST THIS
    
    // Blinking effect - alternate between white and normal
    var blink = ((current_time div 500) mod 2 == 0);
    var blink_color = blink ? c_white : c_yellow;
    var blink_alpha = blink ? 1 : 0.7;
    
    // Draw sprite with blinking effect
    draw_sprite_ext(
        spr_rematch,
        0,
        rematch_x,
        rematch_y,
        sprite_scale,
        sprite_scale,
        0,
        blink_color,
        blink_alpha
    );
    
    exit; // Don't draw anything else
}

//// ... rest of your Draw GUI code stays the same ...

//// ===== PAUSE CHECK =====
//if (global.game_paused) {
//    draw_set_font(fnt_lilita_one);
//    draw_set_halign(fa_center);
//    draw_set_valign(fa_middle);
//    draw_set_color(c_white);
//    draw_text(675, 650, "");
//    exit; // skip drawing timer/countdown
//}

//// ===== COUNTDOWN DISPLAY WITH SPRITES =====
if (state == "countdown") {
    var count = ceil(countdown_time);
    
    // ===== MANUAL SIZE (CHANGE THIS!) =====
    var sprite_scale = 0.9;
    
    // DETERMINE WHICH SPRITE TO SHOW
    if (count > 1) {
        // ===== READY SPRITE POSITION =====
        var ready_x = 440;
        var ready_y = 135;
        
        draw_sprite_ext(
            spr_ready,
            0,
            ready_x,
            ready_y,
            sprite_scale,
            sprite_scale,
            0,
            c_white,
            1
        );
        
        if (last_count == -1) {
            audio_play_sound(snd_ready, 0, false);
            last_count = 1;
        }
    } 
    else {
        // ===== GO SPRITE POSITION =====
        var go_x = 420;
        var go_y = 120;
        
        draw_sprite_ext(
            spr_go,
            0,
            go_x,
            go_y,
            sprite_scale,
            sprite_scale,
            0,
            c_white,
            1
        );
        
        if (last_count != 0) {
            audio_play_sound(snd_go, 0, false);
            last_count = 0;
        }
    }
}
//else if (state == "active") {
//    // ===== ROUND TIMER =====
//    var minutes = floor(time_left / 60);
//    var seconds = floor(time_left mod 60);
//    var sec_text = (seconds < 10) ? "0" + string(seconds) : string(seconds);
//    var timer_text = string(minutes) + ":" + sec_text;

//    // Position (shifted right by 75 total)
//    var draw_x = 635;
//    var draw_y = 650;

//    draw_set_font(fnt_lilita_one);
//    draw_set_halign(fa_center);
//    draw_set_valign(fa_middle);

//    // Outline
//    draw_set_color(c_black);
//    for (var ox = -2; ox <= 2; ox++) {
//        for (var oy = -2; oy <= 2; oy++) {
//            if (ox != 0 || oy != 0) {
//                draw_text_transformed(draw_x + ox, draw_y + oy, timer_text, 1.3, 1.3, 0);
//            }
//        }
//    }

//    // ===== MAIN FILL =====
//    if (time_left < 30) {
//        // Blinking effect: alternate between gradient and red
//        var blink = ((current_time div 500) mod 2 == 0);

//        if (blink) {
//            // Gradient yellow–orange
//            var gradient_top = make_color_rgb(255, 240, 120);
//            var gradient_bottom = make_color_rgb(255, 128, 0);

//            draw_set_color(gradient_top);
//            draw_text_transformed(draw_x, draw_y - 1, timer_text, 1.3, 1.3, 0);

//            draw_set_color(gradient_bottom);
//            draw_text_transformed(draw_x, draw_y + 2, timer_text, 1.3, 1.3, 0);

//            draw_set_color(make_color_rgb(255, 220, 100));
//            draw_text_transformed(draw_x, draw_y, timer_text, 1.3, 1.3, 0);
//        } else {
//            // Solid red
//            draw_set_color(make_color_rgb(200, 0, 0));
//            draw_text_transformed(draw_x, draw_y, timer_text, 1.3, 1.3, 0);
//        }
//    } else {
//        // Normal gradient look
//        var gradient_top = make_color_rgb(255, 240, 120);
//        var gradient_bottom = make_color_rgb(255, 128, 0);

//        draw_set_color(gradient_top);
//        draw_text_transformed(draw_x, draw_y - 1, timer_text, 1.3, 1.3, 0);

//        draw_set_color(gradient_bottom);
//        draw_set_color(gradient_bottom);
//        draw_text_transformed(draw_x, draw_y + 2, timer_text, 1.3, 1.3, 0);

//        draw_set_color(make_color_rgb(255, 220, 100));
//        draw_text_transformed(draw_x, draw_y, timer_text, 1.3, 1.3, 0);
//    }
//}