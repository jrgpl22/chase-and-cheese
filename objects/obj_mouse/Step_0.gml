
// ===== PAUSE CHECK =====
if (show_mouse_champion) {
    // Initialize wait timer if it doesn't exist
    if (!variable_instance_exists(id, "champion_wait_timer")) {
        champion_wait_timer = room_speed * 2; // 3 seconds
    }
    
    // Countdown the timer
    if (champion_wait_timer > 0) {
        champion_wait_timer -= 1;
    }
    
    // Only allow key press after timer reaches 0
    if (champion_wait_timer <= 0 && keyboard_check_pressed(vk_anykey)) {
        show_mouse_champion = false;
        champion_wait_timer = 0; // Reset for next time
        
        if (instance_exists(obj_mouse_banner)) {
            obj_mouse_banner.visible = false;
        }
        
        global.game_paused = false;
        audio_stop_all();
        audio_play_sound(snd_hover, 0, false);
        room_goto(Home);
        global.cat_score = 0;
        global.mouse_score = 0;
        global.round = 1;
    }
    exit; // Don't process any other input while waiting for key press
}


if (global.game_paused) {
    exit;
}

// ===== DISABLE MOVEMENT DURING COUNTDOWN =====
if (instance_exists(obj_timer_controller)) {
    if (obj_timer_controller.state == "countdown") {
        // Force idle sprite while waiting
        if (direction == 90) sprite_index = spr_rat_idle_up;
        else if (direction == 270) sprite_index = spr_rat_idle_down;
        else if (direction == 180) sprite_index = spr_rat_idle_left;
        else if (direction == 0) sprite_index = spr_rat_idle_right;
        exit;
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
            show_debug_message("=== MOUSE OFF SCREEN - DOUBLE KO DETECTED ===");
            if (instance_exists(obj_timer_controller)) {
                obj_timer_controller.show_room_refresh = true;
                obj_timer_controller.alarm[0] = room_speed * 3;
                global.game_paused = true;
                audio_stop_all();
                audio_play_sound(snd_refresh, 0, false);
            }
        } else {
            // NORMAL - CAT WINS
            global.cat_score += 1;
            show_debug_message("Mouse bombed off screen! Cat score: " + string(global.cat_score) + "/3");
            
            if (global.cat_score >= 3) {
                show_debug_message("Cat Champion!");
                global.game_paused = true;
                
                if (instance_exists(obj_cat)) {
                    obj_cat.show_champion_pending = true;
                    obj_cat.alarm[1] = room_speed * 3;
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
                    
                    if (instance_exists(obj_cat)) {
                        obj_cat.next_room = rooms[choice];
                        obj_cat.show_banner_pending = true;
                        obj_cat.alarm[1] = room_speed * 1;
                    }
                }
                
                global.game_paused = true;
            }
        }
        
        instance_destroy();
    }
    exit;
}

/// @description Movement with Collision
// ===== EFFECT TIMER COUNTDOWN =====
if (effect_timer > 0) {
    effect_timer -= 1;
    
    if (effect_timer == 0) {
        spd = base_spd;
        is_stunned = false;
        is_confused = false;
        confused_keys = [ord("W"), ord("S"), ord("A"), ord("D")];
        confusion_shuffled = false;
        image_blend = c_white;
        
        // Reset ice physics to default
        ice_physics_active = true;
        
        show_debug_message("Mouse: Effect ended - back to normal");
    }
}

// ===== CONFUSION SETUP (ONLY SHUFFLE ONCE) =====
// ===== CONFUSION SETUP (ONLY SHUFFLE ONCE) =====
if (is_confused && !confusion_shuffled) {
    var original_keys = [ord("W"), ord("S"), ord("A"), ord("D")];
    var is_same = true;
    
    // Keep shuffling until we get a DIFFERENT arrangement
    while (is_same) {
        confused_keys = [ord("W"), ord("S"), ord("A"), ord("D")];
        
        // Shuffle the array
        var n = array_length(confused_keys);
        for (var i = n - 1; i > 0; i--) {
            var j = irandom(i);
            var temp = confused_keys[i];
            confused_keys[i] = confused_keys[j];
            confused_keys[j] = temp;
        }
        
        // Check if shuffled array is DIFFERENT from original
        is_same = true;
        for (var i = 0; i < array_length(confused_keys); i++) {
            if (confused_keys[i] != original_keys[i]) {
                is_same = false;
                break;
            }
        }
    }
    
    confusion_shuffled = true;
    show_debug_message("Mouse keys confused! New mapping: " + 
        chr(confused_keys[0]) + chr(confused_keys[1]) + 
        chr(confused_keys[2]) + chr(confused_keys[3]));
}

// ===== IF STUNNED, STOP ALL MOVEMENT =====
if (is_stunned) {
    speed = 0;
    
    if (direction == 90) sprite_index = spr_rat_idle_up;
    else if (direction == 270) sprite_index = spr_rat_idle_down;
    else if (direction == 180) sprite_index = spr_rat_idle_left;
    else if (direction == 0) sprite_index = spr_rat_idle_right;
    
    exit;
}

// ===== GET TILEMAP FOR COLLISION =====
var _tilemap = layer_tilemap_get_id("Collision");
var _tilemap_tree = -1;
if (layer_exists("Tree_Collision")) {
    _tilemap_tree = layer_tilemap_get_id("Tree_Collision");
}

// ===== NORMAL MOVEMENT WITH COLLISION =====
speed = 0;

// Use confused mapping if active
var up_key    = is_confused ? confused_keys[0] : ord("W");
var down_key  = is_confused ? confused_keys[1] : ord("S");
var left_key  = is_confused ? confused_keys[2] : ord("A");
var right_key = is_confused ? confused_keys[3] : ord("D");

var move_x = 0;
var move_y = 0;
var moving = false;

// UP (90 degrees)
if (keyboard_check(up_key)) {
    direction = 90;
    move_y = -spd;
    sprite_index = spr_rat_walk_up;
    moving = true;
}
// DOWN (270 degrees)
else if (keyboard_check(down_key)) {
    direction = 270;
    move_y = spd;
    sprite_index = spr_rat_walk_down;
    moving = true;
}
// LEFT (180 degrees)
else if (keyboard_check(left_key)) {
    direction = 180;
    move_x = -spd;
    sprite_index = spr_rat_walk_left;
    moving = true;
}
// RIGHT (0 degrees)
else if (keyboard_check(right_key)) {
    direction = 0;
    move_x = spd;
    sprite_index = spr_rat_walk_right;
    moving = true;
}

// ===== APPLY MOVEMENT WITH COLLISION CHECK =====
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

// Apply friction
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

// Store old position
var old_x = x;
var old_y = y;

// Try to move using velocity
x += hsp;
y += vsp;

// Check collision
var collision_check = tilemap_get_at_pixel(_tilemap, x, y + 2);

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

// ===== UPDATE DIRECTION BASED ON ACTUAL VELOCITY =====
var actually_moving = (abs(hsp) > 0.1 || abs(vsp) > 0.1);

if (actually_moving) {
    if (abs(vsp) > abs(hsp)) {
        if (vsp < 0) {
            direction = 90;
            sprite_index = spr_rat_walk_up;
        } else {
            direction = 270;
            sprite_index = spr_rat_walk_down;
        }
    } else {
        if (hsp < 0) {
            direction = 180;
            sprite_index = spr_rat_walk_left;
        } else {
            direction = 0;
            sprite_index = spr_rat_walk_right;
        }
    }
}

// ===== IDLE ANIMATIONS =====
if (!actually_moving) {
    if (direction == 90) sprite_index = spr_rat_idle_up;
    else if (direction == 270) sprite_index = spr_rat_idle_down;
    else if (direction == 180) sprite_index = spr_rat_idle_left;
    else if (direction == 0) sprite_index = spr_rat_idle_right;
}
if (teleport_cooldown > 0) {
    teleport_cooldown--;
}

if (object_exists(obj_quicksand)) {
    // If NOT touching quicksand, restore normal speed
    if (!place_meeting(x, y, obj_quicksand)) {
        // Only restore speed if there's NO active gift effect
        if (effect_timer <= 0) {
            // Return to normal speed immediately
            spd = base_spd;
            
            // Reset color
            image_blend = c_white;
        }
        
        // Stop the quicksand sound immediately
        if (audio_is_playing(snd_quicksandsfx)) {
            audio_stop_sound(snd_quicksandsfx);
        }
        
        // Destroy the slow indicator
        if (variable_instance_exists(id, "quicksand_indicator") && instance_exists(quicksand_indicator)) {
            instance_destroy(quicksand_indicator);
            quicksand_indicator = noone;
        }
    }
} else {
    // If obj_quicksand doesn't exist, make sure speed is normal
    // BUT only if no gift effect is active
    if (spd < base_spd && effect_timer <= 0) {
        spd = base_spd;
    }
}
