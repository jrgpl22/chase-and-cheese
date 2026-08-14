/// @description Spawn New Quicksand with Grow Animation
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

var padding = 32;
var min_distance = 64;

var quicksand_positions = [];
var quicksand_spawned = 0;
var quicksand_to_spawn = irandom_range(5, 8); // Random 5-8 quicksand
var max_attempts = 1000;

while (quicksand_spawned < quicksand_to_spawn && max_attempts > 0) {
    var grid_x = irandom_range((cam_x + padding) / tile_size, (cam_x + cam_width - padding) / tile_size) * tile_size;
    var grid_y = irandom_range((cam_y + padding) / tile_size, (cam_y + cam_height - padding) / tile_size) * tile_size;
    
    var tile_check = tilemap_get_at_pixel(_tilemap, grid_x, grid_y);
    var tree_check = 0;
    if (_tilemap_tree != -1) {
        tree_check = tilemap_get_at_pixel(_tilemap_tree, grid_x, grid_y);
    }
    
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
    
    if (tile_check == 0 && tree_check == 0 && !too_close) { 
        // Create quicksand with grow animation
        var new_quicksand = instance_create_layer(grid_x, grid_y, "Instances_1", obj_quicksand);
        new_quicksand.is_teleporting = true;
        new_quicksand.teleport_phase = 2; // Grow in
        new_quicksand.teleport_timer = 0;
        new_quicksand.image_xscale = 0;
        new_quicksand.image_yscale = 0;
        new_quicksand.image_alpha = 0;
        
        array_push(quicksand_positions, [grid_x, grid_y]);
        quicksand_spawned += 1;
    }
    
    max_attempts -= 1;
}

// Play teleport in sound
audio_play_sound(teleport_out, 1, false);
audio_sound_gain(teleport_out, 0.5, 0);

show_debug_message("=== SPAWNED " + string(quicksand_spawned) + " NEW QUICKSAND ===");

// Set next respawn (10-20 seconds random)
alarm[0] = irandom_range(10, 20) * room_speed; // 20-30 seconds