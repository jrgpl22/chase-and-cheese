//// Check global flag FIRST
//if (global.menu_is_blocking_buttons) exit;

// Check hover
hover = (mouse_x >= bbox_left && mouse_x <= bbox_right && 
         mouse_y >= bbox_top && mouse_y <= bbox_bottom);

// Open How to Play on click
if (hover && mouse_check_button_released(mb_left)) {
    with (obj_howtoplay_menu) {
        visible = true;
        active = true;
        current_page = 1;
    }
}

// Visual feedback
if (hover && mouse_check_button(mb_left)) {
    target_scale = 0.92;
} else if (hover) {
    target_scale = 1.08;
} else {
    target_scale = 1.0;
}

// Smooth scaling
current_scale = lerp(current_scale, target_scale, 0.2);