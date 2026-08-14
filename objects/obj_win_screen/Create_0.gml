// Draw on top of everything
depth = -10000;

// Start hidden
visible = false;
active = false;

// Winner ("cat" or "mouse")
winner = "";

// Scores
cat_score = 0;
mouse_score = 0;

// Position for win screen (centered)
win_x = 325;
win_y = 175;

// Scale the sprite to fit nicely
target_width = room_width * 0.35;  // 60% of screen width
sprite_scale = target_width / sprite_get_width(spr_cat_wins);

// Font
win_font = fnt_lilita_one;

// Score display positions (adjust these based on your sprite layout)
// These numbers position the score text next to the icons
cat_score_x = win_x - 20;   // Adjust left/right as needed
cat_score_y = win_y + 29;    // Adjust up/down as needed
mouse_score_x = win_x - 20; // Adjust left/right as needed
mouse_score_y = win_y + 40;  // Adjust up/down as needed

// Text size
score_text_scale = .60;