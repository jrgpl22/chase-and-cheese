if (show_cat_champion) {
    if (!variable_instance_exists(id, "champion_wait_timer")) {
        champion_wait_timer = room_speed * 2;
    }
    
    if (champion_wait_timer > 0) {
        champion_wait_timer -= 1;
    }
    
    if (champion_wait_timer <= 0 && keyboard_check_pressed(vk_anykey)) {
        show_cat_champion = false;
        champion_wait_timer = 0; 
        
        if (instance_exists(obj_cat_banner)) {
            obj_cat_banner.visible = false;
        }
        
        global.game_paused = false;
        audio_stop_all();
        audio_play_sound(snd_hover, 0, false);
        room_goto(Home);
        global.cat_score = 0;
        global.mouse_score = 0;
        global.round = 1;
    }
    exit;
}


if (global.game_paused) {
    exit;
}

if (instance_exists(obj_timer_controller)) { 
	if (obj_timer_controller.state == "countdown") { 
		if (direction == 90) sprite_index = spr_cat_idle_up; 
		else if (direction == 270) sprite_index = spr_cat_idle_down; 
		else if (direction == 180) sprite_index = spr_cat_idle_left; 
		else if (direction == 0) sprite_index = spr_cat_idle_right; exit; 
	} 
}

if (is_flying) {
    x += hspd;
    y += vspd;
    vspd += gravity_y;
    image_angle += spin_speed;
    
    if (y > room_height + 100 || x < -100 || x > room_width + 100) {
        if (is_double_ko) {
            // DOUBLE KO - REMATCH
            show_debug_message("=== CAT OFF SCREEN - DOUBLE KO DETECTED ===");
            if (instance_exists(obj_timer_controller)) {
                obj_timer_controller.show_room_refresh = true;
                obj_timer_controller.alarm[0] = room_speed * 3;
                global.game_paused = true;
                audio_stop_all();
                audio_play_sound(snd_refresh, 0, false);
            }
        } else {
            // NORMAL - MOUSE WINS
            global.mouse_score += 1;
            show_debug_message("Cat bombed off screen! Mouse score: " + string(global.mouse_score) + "/3");
            
            global.teleported_by_gift = false;
            global.saved_timer = 81;
            global.mouse_cheese_collected = 0;
            
            if (global.mouse_score >= 3) {
                show_debug_message("Mouse Champion!");
                global.game_paused = true;
                
                if (instance_exists(obj_mouse)) {
                    obj_mouse.show_mouse_champion = true;
                    obj_mouse_champion.visible = true;
                    audio_stop_all();
                    audio_play_sound(snd_victory, 0, false);
                }
            } else {
                var rooms = [];
                if (room == Map1) {
                    rooms = [Map2, Map3, Map4];
                } else if (room == Map2) {
                    rooms = [Map1, Map3, Map4];
                } else if (room == Map3) {
                    rooms = [Map1, Map2, Map4];
                } else if (room == Map4) {
                    rooms = [Map1, Map2, Map3];
                } else {
                    rooms = [Map1, Map2, Map3, Map4];
                }
                
                if (array_length(rooms) > 0) {
                    var choice = irandom(array_length(rooms) - 1);
                    
                    if (instance_exists(obj_mouse)) {
                        obj_mouse.next_room = rooms[choice];
                        obj_mouse.alarm[1] = room_speed * 3;
                        obj_mouse_banner.visible = true;
                        audio_stop_all();
                        audio_play_sound(snd_win_round, 0, false);
                        audio_play_sound(snd_mouse_squeak, 0, false);
                    }
                }
                
                global.game_paused = true;
            }
        }
        
        instance_destroy();
    }
    exit;
}

if (effect_timer > 0) {
    effect_timer -= 1;
    
   if (effect_timer == 0) {
    spd = base_spd;
    is_stunned = false;
    is_confused = false;
    confused_keys = [vk_up, vk_down, vk_left, vk_right];
    confusion_shuffled = false;
    image_blend = c_white;
    
   ice_physics_active = true;
    
    show_debug_message("Cat: Effect ended - back to normal");
}
}

if (is_confused && !confusion_shuffled) {
    var original_keys = [vk_up, vk_down, vk_left, vk_right];
    var is_same = true;
   
    while (is_same) {
        confused_keys = [vk_up, vk_down, vk_left, vk_right];
        
        var n = array_length(confused_keys);
        for (var i = n - 1; i > 0; i--) {
            var j = irandom(i);
            var temp = confused_keys[i];
            confused_keys[i] = confused_keys[j];
            confused_keys[j] = temp;
        }
        
        is_same = true;
        for (var i = 0; i < array_length(confused_keys); i++) {
            if (confused_keys[i] != original_keys[i]) {
                is_same = false;
                break;
            }
        }
    }
    
    confusion_shuffled = true;
    show_debug_message("Cat keys confused! Arrow keys scrambled!");
}
if (is_stunned) {
    speed = 0;
    
    if (direction == 90) sprite_index = spr_cat_idle_up;
    else if (direction == 270) sprite_index = spr_cat_idle_down;
    else if (direction == 180) sprite_index = spr_cat_idle_left;
    else if (direction == 0) sprite_index = spr_cat_idle_right;
    
    exit;
}

var _tilemap = layer_tilemap_get_id("Collision");
var _tilemap_tree = -1;
if (layer_exists("Tree_Collision")) {
    _tilemap_tree = layer_tilemap_get_id("Tree_Collision");
}

speed = 0;

var up_key    = is_confused ? confused_keys[0] : vk_up;
var down_key  = is_confused ? confused_keys[1] : vk_down;
var left_key  = is_confused ? confused_keys[2] : vk_left;
var right_key = is_confused ? confused_keys[3] : vk_right;

var move_x = 0;
var move_y = 0;
var moving = false;

if (keyboard_check(up_key)) {
    direction = 90;
    move_y = -spd;
    sprite_index = spr_cat_walk_up;
    moving = true;
}
else if (keyboard_check(down_key)) {
    direction = 270;
    move_y = spd;
    sprite_index = spr_cat_walk_down;
    moving = true;
}
else if (keyboard_check(left_key)) {
    direction = 180;
    move_x = -spd;
    sprite_index = spr_cat_walk_left;
    moving = true;
}
else if (keyboard_check(right_key)) {
    direction = 0;
    move_x = spd;
    sprite_index = spr_cat_walk_right;
    moving = true;
}
var is_ice_map = (room == Map3);
var use_ice_physics = (is_ice_map && ice_physics_active);

if (moving) {
    if (use_ice_physics) {
        hsp += move_x * ice_accel_multiplier;
        vsp += move_y * ice_accel_multiplier;
    } else {
        hsp = move_x;
        vsp = move_y;
    }
}

if (use_ice_physics) {
    hsp *= friction_ice;
    vsp *= friction_ice;
    
    if (abs(hsp) < 0.1) hsp = 0;
    if (abs(vsp) < 0.1) vsp = 0;
} else {
    if (!moving) {
        hsp = 0;
        vsp = 0;
    }
}
var old_x = x;
var old_y = y;

x += hsp;
y += vsp;

var collision_check = tilemap_get_at_pixel(_tilemap, x, y + 10);

var tree_collision_check = 0;
if (_tilemap_tree != -1) {
    tree_collision_check = tilemap_get_at_pixel(_tilemap_tree, x, y);
}

if (collision_check != 0 || tree_collision_check != 0) {
    x = old_x;
    y = old_y;
    hsp = 0;
    vsp = 0;
}
var actually_moving = (abs(hsp) > 0.1 || abs(vsp) > 0.1);

if (actually_moving) {
    if (abs(vsp) > abs(hsp)) {
        if (vsp < 0) {
            direction = 90;
            sprite_index = spr_cat_walk_up;  
        } else {
            direction = 270;
            sprite_index = spr_cat_walk_down;  
        }
    } else {
        if (hsp < 0) {
            direction = 180;
            sprite_index = spr_cat_walk_left;  
        } else {
            direction = 0;
            sprite_index = spr_cat_walk_right; 
        }
    }
}

if (!actually_moving) {
    if (direction == 90) sprite_index = spr_cat_idle_up; 
    else if (direction == 270) sprite_index = spr_cat_idle_down;
    else if (direction == 180) sprite_index = spr_cat_idle_left;
    else if (direction == 0) sprite_index = spr_cat_idle_right;
}

if (teleport_cooldown > 0) {
    teleport_cooldown--;
}

///

///

//
/// 


if (object_exists(obj_quicksand)) {
    if (!place_meeting(x, y, obj_quicksand)) {
        if (effect_timer <= 0) {
            spd = base_spd;
            image_blend = c_white;
        }
        if (audio_is_playing(snd_quicksandsfx)) {
            audio_stop_sound(snd_quicksandsfx);
        }
        if (variable_instance_exists(id, "quicksand_indicator") && instance_exists(quicksand_indicator)) {
            instance_destroy(quicksand_indicator);
            quicksand_indicator = noone;
        }
    }
} else {
    if (spd < base_spd && effect_timer <= 0) {
        spd = base_spd;
    }
}
