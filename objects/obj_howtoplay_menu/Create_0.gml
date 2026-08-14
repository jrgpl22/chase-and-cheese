// CREATE EVENT obj_howtoplay_menu
// Draw on top of everything
depth = -10000;

// Start hidden
visible = false;
active = false;

// Current page (1, 2, or 3)
current_page = 1;
total_pages = 3;

// Store all page sprites in an array
page_sprites[0] = spr_howtoplay_page1;
page_sprites[1] = spr_howtoplay_page2;
page_sprites[2] = spr_howtoplay_page3;

// Position for the main image (centered)
page_x = room_width / 2;
page_y = room_height / 2;

// Scale the sprite to fit the screen
target_width = room_width * 0.9;
sprite_scale = target_width / sprite_get_width(spr_howtoplay_page1);

// Button positions
left_arrow_x = room_width * 0.47;
left_arrow_y = room_height * 0.75;
left_arrow_radius = 40;

right_arrow_x = room_width * 0.53;
right_arrow_y = room_height * 0.75;
right_arrow_radius = 40;

back_btn_x = room_width * 0.73;
back_btn_y = room_height * 0.31;
back_btn_radius = 50;

mouse_over_button = "";
mouse_over_button_previous = "";