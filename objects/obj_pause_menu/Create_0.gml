// Pause menu state
selected = 0; // 0=Resume, 1=Restart, 2=Settings, 3=Quit
menu_options = 4;

// Get GUI dimensions for positioning
var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();

// Container position (EXACT CENTER of screen)
container_x = gui_width / 2;
container_y = gui_height / 2;

// CENTERED text X position
text_x = container_x;

// Menu option Y positions (MOVED UP for better spacing)
resume_y = container_y - 66;
restart_y = container_y - 16;
settings_y = container_y + 35;
quit_y = container_y + 85;

// Click detection areas (height of each button)
button_height = 40;
button_width = 200;

// Arrow distance from text
arrow_offset = 100;

// Mouse hover tracking
mouse_over = -1;

// ADD THESE - Prevent immediate clicking
menu_active_timer = 0; // Timer before menu becomes clickable
menu_ready = false; // Menu ready for input
mouse_released = false; // Track if mouse was released after opening menu