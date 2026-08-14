// Only run if active
if (!active) exit;

// Press any key or click to close win screen
if (keyboard_check_pressed(vk_anykey) || mouse_check_button_pressed(mb_left)) {
    visible = false;
    active = false;
    
    // Optional: Go back to home screen
    // room_goto(Home);
    
    // Optional: Restart the current room
    // room_restart();
}