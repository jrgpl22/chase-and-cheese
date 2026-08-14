/// DRAW GUI EVENT - obj_ui_hud_complete

draw_set_alpha(0.94);
draw_sprite(spr_ui_hud_complete, 0, 0, 0);
draw_set_font(fnt_lilita_one);
draw_set_color(c_white);

// ===== MOUSE SCORE (TOP LEFT) =====
draw_set_halign(fa_left);
draw_set_valign(fa_top);
var mouse_score_text = string(global.mouse_score);
draw_set_color(c_yellow);
// ADJUST POSITION: Change 70 (X) and 25 (Y)
// X: Bigger = more right, Smaller = more left
// Y: Bigger = more down, Smaller = more up
draw_text_transformed(145, 12, mouse_score_text, 0.9, 0.9, 0);

// ===== ROUND TEXT (TOP CENTER) =====
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);
var round_text = "ROUND " + string(global.round);
// ADJUST POSITION: Change the Y value (25)
// To move UP: Use smaller number (example: 15, 10, 5)
// To move DOWN: Use bigger number (example: 35, 40, 50)
var round_y = 17; // CHANGE THIS to move up/down
draw_text_transformed(display_get_gui_width() / 2, round_y, round_text, 0.8, 0.8, 0);

// ===== CAT SCORE (TOP RIGHT) =====
draw_set_halign(fa_right);
draw_set_valign(fa_top);
var cat_score_text = string(global.cat_score);
draw_set_color(c_yellow);
// ADJUST POSITION: Change 70 (offset from right) and 25 (Y)
draw_text_transformed(display_get_gui_width() - 115, 11, cat_score_text, 0.9, 0.9, 0);

// ===== CHEESE COUNTER (BOTTOM LEFT) =====
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
var cheese_text = "0/10";
if (instance_exists(obj_mouse)) {
    cheese_text = string(obj_mouse.cheese_collected) + "/10";
}
draw_set_color(c_white);
// ADJUST POSITION: Change 70 (X) and 25 (offset from bottom)
draw_text_transformed(70, display_get_gui_height() - 10, cheese_text, 0.7, 0.7, 0);

// ===== TIMER (BOTTOM CENTER) =====
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
var timer_text = "0:00";
var timer_color = c_white;
var timer_scale = 0.75;

if (instance_exists(obj_timer_controller)) {
    var minutes = floor(obj_timer_controller.time_left / 60);
    var seconds = floor(obj_timer_controller.time_left mod 60);
    var sec_text = (seconds < 10) ? "0" + string(seconds) : string(seconds);
    timer_text = string(minutes) + ":" + sec_text;
    
    // BLINKING RED IF 11 SECONDS OR LESS
    if (obj_timer_controller.time_left <= 11) {
        var blink = ((current_time div 500) mod 2 == 0);
        timer_color = blink ? c_red : c_white;
        timer_scale = 0.85;
    }
}

draw_set_color(timer_color);
// ADJUST POSITION: Change the Y offset (25)
var timer_y_offset = 12; // CHANGE THIS to move timer up/down from bottom
draw_text_transformed(display_get_gui_width() / 2, display_get_gui_height() - timer_y_offset, timer_text, timer_scale, timer_scale, 0);

// ===== STATUS EFFECTS (BOTTOM RIGHT) =====
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);
var status_text = "";
var status_color = c_white;

// Check cat effects
if (instance_exists(obj_cat)) {
    var cat = instance_find(obj_cat, 0);
    if (cat != noone && cat.effect_timer > 0) {
        var seconds_left = ceil(cat.effect_timer / room_speed);
        
        if (cat.spd > cat.base_spd) {
            status_text = "CAT: SPEED BOOST " + string(seconds_left) + "s";
            status_color = c_white;
        }
        else if (cat.spd < cat.base_spd && !cat.is_stunned) {
            status_text = "CAT: SLOWED " + string(seconds_left) + "s";
            status_color = c_white;
        }
        else if (cat.is_stunned) {
            status_text = "CAT: STUNNED " + string(seconds_left) + "s";
            status_color = c_white;
        }
        else if (cat.is_confused) {
            status_text = "CAT: CONFUSED " + string(seconds_left) + "s";
            status_color = c_white;
        }
    }
}

// Check mouse effects if no cat effects
if (status_text == "" && instance_exists(obj_mouse)) {
    var mouse = instance_find(obj_mouse, 0);
    if (mouse != noone && mouse.effect_timer > 0) {
        var seconds_left = ceil(mouse.effect_timer / room_speed);
        
        if (mouse.spd > mouse.base_spd) {
            status_text = "MOUSE: SPEED BOOST " + string(seconds_left) + "s";
            status_color = c_white;
        }
        else if (mouse.spd < mouse.base_spd && !mouse.is_stunned) {
            status_text = "MOUSE: SLOWED " + string(seconds_left) + "s";
            status_color = c_white;
        }
        else if (mouse.is_stunned) {
            status_text = "MOUSE: STUNNED " + string(seconds_left) + "s";
            status_color = c_white;
        }
        else if (mouse.is_confused) {
            status_text = "MOUSE: CONFUSED " + string(seconds_left) + "s";
            status_color = c_white;
        }
    }
}

draw_set_color(status_color);
// ADJUST POSITION: Change 70 (X offset) and 25 (Y offset)
// To move LEFT: Use bigger X offset (example: 80, 100, 120)
// To move RIGHT: Use smaller X offset (example: 50, 40, 30)
// To move UP: Use bigger Y offset (example: 35, 45, 55)
// To move DOWN: Use smaller Y offset (example: 15, 10, 5)
var status_x_offset = 70; // CHANGE THIS to move left/right
var status_y_offset = 10; // CHANGE THIS to move up/down
draw_text_transformed(display_get_gui_width() - status_x_offset, display_get_gui_height() - status_y_offset, status_text, 0.6, 0.6, 0);

draw_set_alpha(1.0);