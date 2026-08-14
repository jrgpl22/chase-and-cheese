/// @description Respawn gift within camera view
show_debug_message("=== ALARM 0 TRIGGERED ===");

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
var min_distance_from_players = 100; 

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
    
    // Check collision tiles
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
    
    // ADD THIS - Check distance from players
    if (is_clear) {
        if (instance_exists(obj_mouse)) {
            var dist_to_mouse = point_distance(new_x, new_y, obj_mouse.x, obj_mouse.y);
            if (dist_to_mouse < min_distance_from_players) {
                is_clear = false;
            }
        }
        
        if (is_clear && instance_exists(obj_cat)) {
            var dist_to_cat = point_distance(new_x, new_y, obj_cat.x, obj_cat.y);
            if (dist_to_cat < min_distance_from_players) {
                is_clear = false;
            }
        }
    }
    
    if (is_clear) {
        valid_position = true;
        x = new_x;
        y = new_y;
    }
    
    attempts += 1;
}

if (!valid_position) {
    show_debug_message("WARNING: Couldn't find valid spawn position after " + string(max_attempts) + " attempts");
}

visible = true;
image_alpha = 1;
collected = false;

audio_play_sound(snd_gift_spawn, 0, false);

show_debug_message("Gift respawned at X:" + string(x) + " Y:" + string(y));
show_debug_message("Camera at X:" + string(cam_x) + " Y:" + string(cam_y));
show_debug_message("Visible: " + string(visible) + " Alpha: " + string(image_alpha));
show_debug_message("Attempts needed: " + string(attempts));