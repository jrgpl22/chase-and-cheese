
// Get mouse position for GUI
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// If closing, just wait for timer
if (closing) {
    close_timer--;
    if (close_timer <= 0) {
        // Reactivate buttons before destroying
        instance_activate_object(obj_button_start);
        instance_activate_object(obj_button_howtoplay);
        instance_activate_object(obj_button_exit);
        instance_activate_object(obj_button_settings);
        
        // Now destroy
        if (came_from_home) {
            instance_destroy();
        } else {
            instance_destroy();
            instance_create_depth(0, 0, -9999, obj_pause_menu);
        }
    }
    exit;
}

// DEACTIVATE all buttons when settings menu is open
instance_deactivate_object(obj_button_start);
instance_deactivate_object(obj_button_howtoplay);
instance_deactivate_object(obj_button_exit);
instance_deactivate_object(obj_button_settings);

// Click slider
if (mouse_check_button_pressed(mb_left)) {
    if (point_distance(mx, my, slider_x, slider_y) < slider_radius) {
        dragging_slider = true;
    }
}

// Release slider
if (mouse_check_button_released(mb_left)) {
    dragging_slider = false;
}

// Drag slider
if (dragging_slider) {
    var relative_x = mx - bar_left;
    global.master_volume = clamp(relative_x / bar_width, 0, 1);
    slider_x = bar_left + (global.master_volume * bar_width);
    audio_master_gain(global.master_volume);
}

// Back button hover
back_btn_hover = (point_distance(mx, my, back_btn_x, back_btn_y) < 80);

// Back button click
if (back_btn_hover && mouse_check_button_released(mb_left)) {
    audio_play_sound(snd_enter, 1, false);
    // Start closing sequence with delay
    closing = true;
    close_timer = 5; // Wait 5 frames before closing
}

// Escape key
if (keyboard_check_pressed(vk_escape)) {
    // Start closing sequence with delay
    closing = true;
    close_timer = 5; // Wait 5 frames before closing
}

