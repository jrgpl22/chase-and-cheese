/// @description Initialize Alternating Spike System (3 Patterns)
// Get the collision tilemap
collision_tilemap = layer_tilemap_get_id("Collision");

// Tile indices
spike_tile_index = 16;          // Spike graphic (with collision)
no_spike_tile_index = 0;        // Empty tile (no collision)
horizontal_marker = 17;         // Tile 17 = horizontal spike lanes
vertical_marker = 15;           // Tile 15 = vertical spike lanes
always_on_marker = 14;          // Tile 14 = always on (both patterns)

base_switch_time = 8; // seconds

// State
current_pattern = "horizontal";  // Start with horizontal

// Find spike positions
horizontal_spikes = [];
vertical_spikes = [];
always_on_spikes = [];

// Scan the tilemap
var tilemap_w = tilemap_get_width(collision_tilemap);
var tilemap_h = tilemap_get_height(collision_tilemap);

for (var tx = 0; tx < tilemap_w; tx++) {
    for (var ty = 0; ty < tilemap_h; ty++) {
        var tile_data = tilemap_get(collision_tilemap, tx, ty);
        var tile_index = tile_data & tile_index_mask;
        
        // Sort into lists based on marker
        if (tile_index == horizontal_marker) {
            array_push(horizontal_spikes, [tx, ty]);
        }
        else if (tile_index == vertical_marker) {
            array_push(vertical_spikes, [tx, ty]);
        }
        else if (tile_index == always_on_marker) {
            array_push(always_on_spikes, [tx, ty]);
        }
    }
}

show_debug_message("Found " + string(array_length(horizontal_spikes)) + " horizontal spikes");
show_debug_message("Found " + string(array_length(vertical_spikes)) + " vertical spikes");
show_debug_message("Found " + string(array_length(always_on_spikes)) + " always-on spikes");

// Functions
function show_horizontal_spikes() {
    // Show horizontal spikes (tile 16)
    for (var i = 0; i < array_length(horizontal_spikes); i++) {
        var tx = horizontal_spikes[i][0];
        var ty = horizontal_spikes[i][1];
        tilemap_set(collision_tilemap, spike_tile_index, tx, ty);
    }
    
    // Hide vertical spikes (tile 0)
    for (var i = 0; i < array_length(vertical_spikes); i++) {
        var tx = vertical_spikes[i][0];
        var ty = vertical_spikes[i][1];
        tilemap_set(collision_tilemap, no_spike_tile_index, tx, ty);
    }
    
    // Always-on spikes stay up (tile 16)
    for (var i = 0; i < array_length(always_on_spikes); i++) {
        var tx = always_on_spikes[i][0];
        var ty = always_on_spikes[i][1];
        tilemap_set(collision_tilemap, spike_tile_index, tx, ty);
    }
    
    current_pattern = "horizontal";
    audio_play_sound(spikesfx, 1, false);
    show_debug_message("HORIZONTAL SPIKES UP!");
}

function show_vertical_spikes() {
    // Hide horizontal spikes (tile 0)
    for (var i = 0; i < array_length(horizontal_spikes); i++) {
        var tx = horizontal_spikes[i][0];
        var ty = horizontal_spikes[i][1];
        tilemap_set(collision_tilemap, no_spike_tile_index, tx, ty);
    }
    
    // Show vertical spikes (tile 16)
    for (var i = 0; i < array_length(vertical_spikes); i++) {
        var tx = vertical_spikes[i][0];
        var ty = vertical_spikes[i][1];
        tilemap_set(collision_tilemap, spike_tile_index, tx, ty);
    }
    
    // Always-on spikes stay up (tile 16)
    for (var i = 0; i < array_length(always_on_spikes); i++) {
        var tx = always_on_spikes[i][0];
        var ty = always_on_spikes[i][1];
        tilemap_set(collision_tilemap, spike_tile_index, tx, ty);
    }
    
    current_pattern = "vertical";
    audio_play_sound(spikesfx, 1, false);
    show_debug_message("VERTICAL SPIKES UP!");
}

// Start with horizontal spikes up
show_horizontal_spikes();

// Set alarm for 8 seconds
alarm[0] = 8 * room_speed;