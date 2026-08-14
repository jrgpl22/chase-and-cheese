spawn_count = 0;

function spawn_bombs() {
    with (obj_bomb) {
        instance_destroy();
    }
    
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
    
    var padding = 40;
    var min_distance = 80;
    var collision_check_radius = 16;
    var bomb_positions = [];
    
    spawn_count += 1;
    
    var bombs_to_spawn = 5;
    if (spawn_count >= 7) {
        bombs_to_spawn = 10;
    } else if (spawn_count >= 4) {
        bombs_to_spawn = 7;
    }
    
    show_debug_message("=== SPAWN #" + string(spawn_count) + " - Spawning " + string(bombs_to_spawn) + " bombs ===");
    
    var bombs_spawned = 0;
    var max_attempts = 3000;
    
    while (bombs_spawned < bombs_to_spawn && max_attempts > 0) {
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
            for (var i = 0; i < array_length(bomb_positions); i++) {
                var other_x = bomb_positions[i][0];
                var other_y = bomb_positions[i][1];
                var dist = point_distance(grid_x, grid_y, other_x, other_y);
                
                if (dist < min_distance) {
                    is_valid_position = false;
                    break;
                }
            }
        }
        
        if (is_valid_position) {
            instance_create_layer(grid_x, grid_y, "Instances_1", obj_bomb);
            array_push(bomb_positions, [grid_x, grid_y]);
            bombs_spawned += 1;
            show_debug_message("Bomb #" + string(bombs_spawned) + " spawned at (" + string(grid_x) + ", " + string(grid_y) + ")");
        }
        
        max_attempts -= 1;
    }
    
    if (bombs_spawned < bombs_to_spawn) {
        show_debug_message("WARNING: Only spawned " + string(bombs_spawned) + "/" + string(bombs_to_spawn) + " bombs!");
    }
    
    show_debug_message("=== TOTAL SPAWNED: " + string(bombs_spawned) + " bombs ===");
}

alarm[0] = 8 * room_speed;