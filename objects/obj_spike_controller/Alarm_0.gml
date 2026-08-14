// Switch pattern
if (current_pattern == "horizontal") {
    show_vertical_spikes();
}
else {
    show_horizontal_spikes();
}

// Randomize next switch time
// Range: -3 to +2 seconds
var random_offset = irandom_range(-5, 2);
var next_time = max(1, base_switch_time + random_offset);

// Set next alarm
alarm[0] = next_time * room_speed;

show_debug_message(
    "Next spike switch in " + string(next_time) + " seconds"
);
