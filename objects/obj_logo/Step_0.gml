if (state == "fade_in") {
    // Fade in (black disappears)
    alpha -= fade_speed;
    if (alpha <= 0) {
        alpha = 0;
        state = "hold";
    }
}
else if (state == "hold") {
    hold_timer++;
    if (hold_timer >= hold_duration) {
        state = "fade_out";
    }
}
else if (state == "fade_out") {
    // Fade out (black appears)
    alpha += fade_speed;
    if (alpha >= 1) {
        room_goto_next();
    }
}