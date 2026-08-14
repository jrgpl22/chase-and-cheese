/// @description Teleport All Remaining Cheese with Effects (Improved)
if (global.game_paused) {
    alarm[0] = 1;  // Check again next frame
    exit;
}

show_debug_message("=== TELEPORTING REMAINING CHEESE ===");

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

var cheese_list = [];
with (obj_cheese) {
    array_push(cheese_list, id);
}

var cheese_count = array_length(cheese_list);
show_debug_message("Found " + string(cheese_count) + " remaining cheese to teleport");

if (cheese_count == 0) {
    show_debug_message("=== NO CHEESE LEFT - STOPPING TELEPORT ===");
    exit;
}

audio_play_sound(teleport_in, 1, false);
audio_sound_gain(teleport_in, 0.5, 0);

for (var i = 0; i < cheese_count; i++) {
    var cheese_id = cheese_list[i];
    
    if (instance_exists(cheese_id)) {
        var valid_position = false;
        var attempts = 0;
        var max_attempts = 500;
        
        while (!valid_position && attempts < max_attempts) {
            var min_x = floor((cam_x + padding) / tile_size);
            var max_x = floor((cam_x + cam_width - padding) / tile_size);
            var min_y = floor((cam_y + padding) / tile_size);
            var max_y = floor((cam_y + cam_height - padding) / tile_size);
            
            var new_x = irandom_range(min_x, max_x) * tile_size;
            var new_y = irandom_range(min_y, max_y) * tile_size;
            
            var is_clear = true;
            
            for (var check_x = -collision_check_radius; check_x <= collision_check_radius; check_x += tile_size) {
                for (var check_y = -collision_check_radius; check_y <= collision_check_radius; check_y += tile_size) {
                    var test_x = new_x + check_x;
                    var test_y = new_y + check_y;
                    
                    var tile_check = tilemap_get_at_pixel(_tilemap, test_x, test_y);
                    if (tile_check != 0) {
                        is_clear = false;
                        break;
                    }
                    
                    if (_tilemap_tree != -1) {
                        var tree_check = tilemap_get_at_pixel(_tilemap_tree, test_x, test_y);
                        if (tree_check != 0) {
                            is_clear = false;
                            break;
                        }
                    }
                }
                if (!is_clear) break;
            }
            
            if (is_clear) {
                var too_close = false;
                with (obj_cheese) {
                    if (id != cheese_id) {
                        var dist = point_distance(new_x, new_y, x, y);
                        if (dist < min_distance) {
                            too_close = true;
                            break;
                        }
                    }
                }
                
                if (!too_close) {
                    cheese_id.is_teleporting = true;
                    cheese_id.teleport_phase = 1;
                    cheese_id.teleport_timer = 0;
                    cheese_id.target_x = new_x;
                    cheese_id.target_y = new_y;
                    
                    valid_position = true;
                    show_debug_message("Cheese will teleport to (" + string(new_x) + ", " + string(new_y) + ")");
                }
            }
            
            attempts += 1;
        }
        
        if (!valid_position) {
            show_debug_message("WARNING: Couldn't find valid position for cheese after " + string(max_attempts) + " attempts");
        }
    }
}

show_debug_message("=== TELEPORT INITIATED ===");
alarm[1] = 20;
alarm[0] = 10 * room_speed;