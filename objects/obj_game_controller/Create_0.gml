// Initialize game paused state
global.game_paused = false;
// Your existing code here...

// ADD THESE LINES for win screen system:
// Initialize global scores

// Game timer (60 seconds at 60 FPS = 3600 frames)
game_time = 60 * 60;  // Change the first number to adjust seconds
game_over = false;

// How many points needed to win (adjust as needed)
win_score = 10;  // First to 10 points wins