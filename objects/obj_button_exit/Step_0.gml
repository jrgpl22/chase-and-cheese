//// Check global flag FIRST
//if (global.menu_is_blocking_buttons) exit;

// Rest of your button code continues below...

// Check hover
hover = (mouse_x >= bbox_left && mouse_x <= bbox_right && 
         mouse_y >= bbox_top && mouse_y <= bbox_bottom);

// Exit game on click
if (hover && mouse_check_button_released(mb_left)) {
    game_end();
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