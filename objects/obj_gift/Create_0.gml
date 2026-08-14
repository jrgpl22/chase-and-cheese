/// @description Start hidden, find random position, spawn after 6 seconds

visible = false;
image_alpha = 0;
collected = false;

var _tilemap = layer_tilemap_get_id("Collision");
var _tilemap_tree = -1;
if (layer_exists("Tree_Collision")) {
    _tilemap_tree = layer_tilemap_get_id("Tree_Collision");
}

var tile_size = 16;
var cam = view_camera[0];
var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);
var cam_w = camera_get_view_width(cam);
var cam_h = camera_get_view_height(cam);

var padding = 40;
var collision_check_radius = 16;

var valid_position = false;
var attempts = 0;
var max_attempts = 500;
var new_x = x;
var new_y = y;

while (!valid_position && attempts < max_attempts) {
    var min_x = floor((cam_x + padding) / tile_size);
    var max_x = floor((cam_x + cam_w - padding) / tile_size);
    var min_y = floor((cam_y + padding) / tile_size);
    var max_y = floor((cam_y + cam_h - padding) / tile_size);
    
    new_x = irandom_range(min_x, max_x) * tile_size;
    new_y = irandom_range(min_y, max_y) * tile_size;
    
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
        valid_position = true;
        x = new_x;
        y = new_y;
    }
    
    attempts += 1;
}

if (!valid_position) {
    show_debug_message("WARNING: Couldn't find valid gift position after " + string(max_attempts) + " attempts");
}

show_debug_message("Gift positioned at X:" + string(x) + " Y:" + string(y) + " (Attempts: " + string(attempts) + ")");

alarm[1] = 6 * room_speed;