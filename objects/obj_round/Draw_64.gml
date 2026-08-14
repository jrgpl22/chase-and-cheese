///// DRAW GUI EVENT for obj_round

//draw_set_font(fnt_lilita_one);
//draw_set_halign(fa_center);
//draw_set_valign(fa_top);

//// Build the text
//var text = "Round " + string(global.round);

//// Position at top center
//var cx = display_get_gui_width() / 2;
//var cy = 20; // small margin from top

//// Outline for readability
//var outline_color = c_black;
//var stroke = 2; // thin outline
//var scale = 1.5; // moderate size increase

//draw_set_color(outline_color);
//for (var ox = -stroke; ox <= stroke; ox++) {
//    for (var oy = -stroke; oy <= stroke; oy++) {
//        if (ox != 0 || oy != 0) {
//            draw_text_transformed(cx + ox, cy + oy, text, scale, scale, 0);
//        }
//    }
//}

//// Main fill
//draw_set_color(c_white);
//draw_text_transformed(cx, cy, text, scale, scale, 0);
