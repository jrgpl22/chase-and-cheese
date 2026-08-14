/// @description Spawn 3-4 Quicksand (Inside Camera View)
var _tilemap = layer_tilemap_get_id("Collision");
var _tilemap_tree = -1;
if (layer_exists("Tree_Collision")) {
    _tilemap_tree = layer_tilemap_get_id("Tree_Collision");
}

var tile_size = 16;

// Get camera boundaries
var cam = view_camera[0];
var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);
var cam_width = camera_get_view_width(cam);
var cam_height = camera_get_view_height(cam);

// Add some padding so quicksand aren't at edge
var padding = 32;

// Minimum distance between quicksand
var min_distance = 64;

// List to track spawned quicksand positions
var quicksand_positions = [];
var quicksand_spawned = 0;
var quicksand_to_spawn = irandom_range(5, 8); // Random 5-8 quicksand (adjust numbers as you like)
var max_attempts = 1000;

while (quicksand_spawned < quicksand_to_spawn && max_attempts > 0) {
    // Random position INSIDE camera view
    var grid_x = irandom_range((cam_x + padding) / tile_size, (cam_x + cam_width - padding) / tile_size) * tile_size;
    var grid_y = irandom_range((cam_y + padding) / tile_size, (cam_y + cam_height - padding) / tile_size) * tile_size;
    
    // Check 1: Not in collision tile
    var tile_check = tilemap_get_at_pixel(_tilemap, grid_x, grid_y);
    var tree_check = 0;
    if (_tilemap_tree != -1) {
        tree_check = tilemap_get_at_pixel(_tilemap_tree, grid_x, grid_y);
    }
    
    // Check 2: Not too close to other quicksand
    var too_close = false;
    for (var i = 0; i < array_length(quicksand_positions); i++) {
        var other_x = quicksand_positions[i][0];
        var other_y = quicksand_positions[i][1];
        var dist = point_distance(grid_x, grid_y, other_x, other_y);
        
        if (dist < min_distance) {
            too_close = true;
            break;
        }
    }
    
    // If valid position: spawn quicksand
    if (tile_check == 0 && tree_check == 0 && !too_close) { 
        instance_create_layer(grid_x, grid_y, "Instances_1", obj_quicksand);
        
        // Store position
        array_push(quicksand_positions, [grid_x, grid_y]);
        
        quicksand_spawned += 1;
        show_debug_message("Quicksand #" + string(quicksand_spawned) + " spawned at (" + string(grid_x) + ", " + string(grid_y) + ")");
    }
    
    max_attempts -= 1;
}

show_debug_message("=== TOTAL SPAWNED: " + string(quicksand_spawned) + " quicksand ===");

// Set alarm for next respawn (10-20 seconds random)
alarm[0] = irandom_range(10, 20) * room_speed; // 20-30 seconds