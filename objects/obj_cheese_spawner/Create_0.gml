

var _tilemap = layer_tilemap_get_id("Collision");
var _tilemap_tree = -1;
if (layer_exists("Tree_Collision")) {
    _tilemap_tree = layer_tilemap_get_id("Tree_Collision");
}

var tile_size = 16;

var cam = view_camera[0];
var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);
var cam_width = camera_get_view_width(cam);
var cam_height = camera_get_view_height(cam);

var padding = 32;
var min_distance = 40;
var collision_check_radius = 8;

var cheese_positions = [];

var cheese_to_spawn = 10;
if (global.teleported_by_gift && global.mouse_cheese_collected > 0) {
    cheese_to_spawn = 10 - global.mouse_cheese_collected;
    show_debug_message("=== GIFT TELEPORT DETECTED ===");
    show_debug_message("Mouse already has: " + string(global.mouse_cheese_collected));
    show_debug_message("Spawning only: " + string(cheese_to_spawn) + " cheese");
}

var cheese_spawned = 0;
var max_attempts = 5000;

while (cheese_spawned < cheese_to_spawn && max_attempts > 0) {
    var min_x = floor((cam_x + padding) / tile_size);
    var max_x = floor((cam_x + cam_width - padding) / tile_size);
    var min_y = floor((cam_y + padding) / tile_size);
    var max_y = floor((cam_y + cam_height - padding) / tile_size);
    
    var grid_x = irandom_range(min_x, max_x) * tile_size;
    var grid_y = irandom_range(min_y, max_y) * tile_size;
    
    var is_valid_position = true;
    
    for (var check_x = -collision_check_radius; check_x <= collision_check_radius; check_x += tile_size) {
        for (var check_y = -collision_check_radius; check_y <= collision_check_radius; check_y += tile_size) {
            var test_x = grid_x + check_x;
            var test_y = grid_y + check_y;
            
            var tile_check = tilemap_get_at_pixel(_tilemap, test_x, test_y);
            if (tile_check != 0) {
                is_valid_position = false;
                break;
            }
            
            if (_tilemap_tree != -1) {
                var tree_check = tilemap_get_at_pixel(_tilemap_tree, test_x, test_y);
                if (tree_check != 0) {
                    is_valid_position = false;
                    break;
                }
            }
        }
        if (!is_valid_position) break;
    }
    
    if (is_valid_position) {
        for (var i = 0; i < array_length(cheese_positions); i++) {
            var other_x = cheese_positions[i][0];
            var other_y = cheese_positions[i][1];
            var dist = point_distance(grid_x, grid_y, other_x, other_y);
            
            if (dist < min_distance) {
                is_valid_position = false;
                break;
            }
        }
    }
    
    if (is_valid_position) {
        instance_create_layer(grid_x, grid_y, "Instances_1", obj_cheese);
        array_push(cheese_positions, [grid_x, grid_y]);
        cheese_spawned += 1;
        show_debug_message("Cheese #" + string(cheese_spawned) + " spawned at (" + string(grid_x) + ", " + string(grid_y) + ")");
    }
    
    max_attempts -= 1;
}

if (cheese_spawned < cheese_to_spawn) {
    show_debug_message("WARNING: Only spawned " + string(cheese_spawned) + "/" + string(cheese_to_spawn) + " cheese!");
}

show_debug_message("=== TOTAL SPAWNED: " + string(cheese_spawned) + " cheese ===");
alarm[0] = 10 * room_speed;