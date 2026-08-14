/// MOUSE EVENT (or Step Event) - obj_howtoplay_menu

// If not active, reactivate all buttons and exit
if (!active) {
    instance_activate_object(obj_button_start);
    instance_activate_object(obj_button_howtoplay);
    instance_activate_object(obj_button_exit);
    instance_activate_object(obj_button_settings);
    exit;
}

// Menu is active - deactivate ALL buttons
instance_deactivate_object(obj_button_start);
instance_deactivate_object(obj_button_howtoplay);
instance_deactivate_object(obj_button_exit);
instance_deactivate_object(obj_button_settings);
// mouse position
var mx = mouse_x;
var my = mouse_y;
mouse_over_button = "";

// ===== LEFT ARROW =====
if (point_distance(mx, my, left_arrow_x, left_arrow_y) < left_arrow_radius) {
    mouse_over_button = "left";
    
    if (mouse_check_button_pressed(mb_left)) {
        audio_play_sound(snd_enter, 1, false);
        current_page -= 1;
        if (current_page < 1) {
            current_page = total_pages;
        }
    }
}

// ===== RIGHT ARROW =====
if (point_distance(mx, my, right_arrow_x, right_arrow_y) < right_arrow_radius) {
    mouse_over_button = "right";
    
    if (mouse_check_button_pressed(mb_left)) {
        audio_play_sound(snd_enter, 1, false);
        current_page += 1;
        if (current_page > total_pages) {
            current_page = 1;
        }
    }
}

// ===== BACK BUTTON =====
if (point_distance(mx, my, back_btn_x, back_btn_y) < back_btn_radius) {
    mouse_over_button = "back";
    
    if (mouse_check_button_pressed(mb_left)) {
        audio_play_sound(snd_enter, 1, false);
        visible = false;
        active = false;
        current_page = 1;
    }
}

// Hover sound
if (mouse_over_button != "" && mouse_over_button != mouse_over_button_previous) {
    audio_play_sound(snd_hover, 1, false);
}
mouse_over_button_previous = mouse_over_button;

// ===== KEYBOARD CONTROLS =====
if (keyboard_check_pressed(vk_left)) {
    current_page -= 1;
    if (current_page < 1) current_page = total_pages;
}

if (keyboard_check_pressed(vk_right)) {
    current_page += 1;
    if (current_page > total_pages) current_page = 1;
}

if (keyboard_check_pressed(vk_escape)) {
    visible = false;
    active = false;
    current_page = 1;
}