/// STEP EVENT - obj_pause_menu

// Increase timer
menu_active_timer++;

// Menu becomes ready after 15 frames (quarter second)
if (menu_active_timer >= 15) {
    menu_ready = true;
}

// Arrow key navigation - UP
if (keyboard_check_pressed(vk_up) && menu_ready) {
    if (audio_exists(snd_hovered)) audio_play_sound(snd_hovered, 1, false);
    selected--;
    if (selected < 0) {
        selected = menu_options - 1;
    }
}

// Arrow key navigation - DOWN
if (keyboard_check_pressed(vk_down) && menu_ready) {
    if (audio_exists(snd_hovered)) audio_play_sound(snd_hovered, 1, false);
    selected++;
    if (selected >= menu_options) {
        selected = 0;
    }
}

// ENTER or SPACE to select
if ((keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) && menu_ready) {
    // Play click sound
    if (audio_exists(snd_enter)) audio_play_sound(snd_enter, 1, false);
    
    switch(selected) {
        case 0: // Resume
            global.game_paused = false;
            instance_destroy();
            break;
            
        case 1: // Restart
            with (obj_settings_menu) instance_destroy();
            with (obj_howtoplay_menu) instance_destroy();
            global.game_paused = false;
            room_restart();
            break;
            
        case 2: // Settings
            // Create settings menu if it doesn't exist
            if (!instance_exists(obj_settings_menu)) {
                instance_create_depth(0, 0, -11000, obj_settings_menu);
            }
            
            // Show settings menu
            with (obj_settings_menu) {
                visible = true;
                active = true;
            }
            
            instance_destroy();
            break;
            
        case 3: // Quit to main menu
            with (obj_settings_menu) instance_destroy();
            with (obj_howtoplay_menu) instance_destroy();
            
            // RESET ALL GAME STATES
            global.game_paused = false;
            global.mouse_score = 0;
            global.cat_score = 0;
            global.round = 1;
            global.mouse_cheese_collected = 0;
            global.saved_timer = 81;
            global.teleported_by_gift = false;
            
            audio_stop_all();
            
            // Go to Home room immediately
            room_goto(Home);
            break;
    }
}

// ESC key to resume
if (keyboard_check_pressed(vk_escape) && menu_ready) {
    global.game_paused = false;
    instance_destroy();
}