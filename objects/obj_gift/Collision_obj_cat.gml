/// @description Insert description here
// You can write your code in this editor
if (global.game_paused) {
    exit;
}
// Collected by cat
if (!visible || image_alpha == 0) {
    exit;
}

// Check if already collected
if (collected) {
    exit;
}

show_debug_message("Cat hit gift!");
collected = true;

// Weighted effect pool
var effects = [
	"mouse_fast", 
    "mouse_slow", "mouse_slow",
    "mouse_stun",                  
    "mouse_confused", "mouse_confused",          
    "cat_fast", "cat_fast",
    "cat_slow",
    "cat_stun", 
    "cat_confused", 
	"change_room", 
];

// Pick random entry
var chosen = effects[irandom(array_length(effects) - 1)];
var indicator_sprite = noone;
var indicator_color = c_white;
var target_player = noone;
var indicator_offset_x = 0; // X offset
var indicator_offset_y = -32; // Y offset (default above head)

// Apply chosen effect
switch(chosen) {
   case "mouse_fast":
    indicator_sprite = spr_effects_fast;
    indicator_color = c_lime;
    indicator_offset_y = -25;
    indicator_offset_x = -8;
    
    // Find the mouse instance
    var mouse_instance = instance_find(obj_mouse, 0);
    
    if (instance_exists(mouse_instance)) {
        // Disable ice physics and use normal speed
        mouse_instance.ice_physics_active = false;
        mouse_instance.spd = mouse_instance.base_spd + 1.2;
        mouse_instance.effect_timer = 3 * room_speed;
        target_player = mouse_instance;
    }
    
    audio_play_sound(snd_effects_fast, 0, false);
    show_debug_message("Mouse: Speed Boost!");
    break;
        
   case "mouse_slow":
    indicator_sprite = spr_effects_slow;
    indicator_color = c_red;
    indicator_offset_y = -25;
    indicator_offset_x = -8;
    
    // Find the mouse instance
    var mouse_instance = instance_find(obj_mouse, 0);
    
    if (instance_exists(mouse_instance)) {
        // Disable ice physics and use normal speed
        mouse_instance.ice_physics_active = false;
        mouse_instance.spd = mouse_instance.base_spd - 4;
        if (mouse_instance.spd < 1) mouse_instance.spd = 0.8;
        mouse_instance.effect_timer = 3 * room_speed;
        target_player = mouse_instance;
    }
    
    audio_play_sound(snd_effects_slow, 0, false);
    show_debug_message("Mouse: Slowed Down!");
    break;
        
    case "mouse_stun":
        indicator_sprite = spr_effects_stun;
		indicator_offset_y = -25;
		indicator_offset_x = -8;
        
        // Find the mouse instance
		var mouse_instance = instance_find(obj_mouse, 0);
		
		if (instance_exists(mouse_instance)) {
             mouse_instance.is_stunned = true;
            mouse_instance.spd = 0;
            mouse_instance.effect_timer = 2 * room_speed;
            target_player = mouse_instance;
        }
        
        
        audio_play_sound(snd_effects_stun, 0, false);
        show_debug_message("Mouse: Stunned!");
        break;
        
    case "mouse_confused":
        indicator_sprite = spr_effects_confuse;
      indicator_offset_x = -15; // Move right by 12 pixels
        indicator_offset_y = -25;
        
        // Find the mouse instance
        var mouse_instance = instance_find(obj_mouse, 0);
        
        if (instance_exists(mouse_instance)) {
            mouse_instance.is_confused = true;
            mouse_instance.effect_timer = 5 * room_speed;
            target_player = mouse_instance;
        }
        
        audio_play_sound(snd_effects_confuse, 0, false);
        show_debug_message("Mouse: Confused!");
        break;
        
   case "cat_fast":
    indicator_sprite = spr_effects_fast;
    indicator_color = c_lime;
    target_player = other.id;
    indicator_offset_y = -25;
    indicator_offset_x = -9;
    
    // Disable ice physics and use normal speed
    other.ice_physics_active = false;
    other.spd = other.base_spd + 1;
    other.effect_timer = 3 * room_speed;
    
    audio_play_sound(snd_effects_fast, 0, false);
    show_debug_message("Cat: Speed Boost!");
    break;
        
    case "cat_slow":
    indicator_sprite = spr_effects_slow;
    indicator_color = c_red;
    target_player = other.id;
    indicator_offset_y = -25;
    indicator_offset_x = -9;
    
    // Disable ice physics and use normal speed
    other.ice_physics_active = false;
    other.spd = other.base_spd - 4;
    if (other.spd < 1) other.spd = 0.8;
    other.effect_timer = 3 * room_speed;
    
    audio_play_sound(snd_effects_slow, 0, false);
    show_debug_message("Cat: Slowed Down!");
    break;
        
    case "cat_stun":
        other.is_stunned = true;
        other.spd = 0;
        other.effect_timer = 2 * room_speed;
        
        indicator_sprite = spr_effects_stun;
        target_player = other.id;
		indicator_offset_y = -25; // Move right by 12 pixels
		indicator_offset_x = -9
        
        audio_play_sound(snd_effects_stun, 0, false);
        show_debug_message("Cat: Stunned!");
        break;
        
    case "cat_confused":
        other.is_confused = true;
        other.effect_timer = 5 * room_speed;
        
        indicator_sprite = spr_effects_confuse;
        indicator_offset_x = -16; // Move right by 12 pixels
        indicator_offset_y = -20
        target_player = other.id;
        
        audio_play_sound(snd_effects_confuse, 0, false);
        show_debug_message("Cat: Confused!");
        break;
		
		
	case "change_room":
    show_debug_message("=== GIFT TELEPORT START ===");
    
    var mouse_instance = instance_find(obj_mouse, 0);
    if (instance_exists(mouse_instance)) {
        global.mouse_cheese_collected = mouse_instance.cheese_collected;
        show_debug_message("Saved cheese: " + string(global.mouse_cheese_collected));
    }
    
    if (instance_exists(obj_timer_controller)) {
        var timer_instance = instance_find(obj_timer_controller, 0);
        if (timer_instance != noone) {
            global.saved_timer = timer_instance.time_left;
            show_debug_message("Saved timer: " + string(global.saved_timer) + " seconds");
        }
    }
    
    global.teleported_by_gift = true;
    
    // FIXED - ADD MAP4
    var available_rooms = [];
    if (room == Map1) {
        available_rooms = [Map2, Map3, Map4];
    } else if (room == Map2) {
        available_rooms = [Map1, Map3, Map4];
    } else if (room == Map3) {
        available_rooms = [Map1, Map2, Map4];
    } else if (room == Map4) {
        available_rooms = [Map1, Map2, Map3];
    }
    
    var random_map = available_rooms[irandom(array_length(available_rooms) - 1)];
    show_debug_message("Target room: " + room_get_name(random_map));
    
    var roulette = instance_create_depth(0, 0, -10000, obj_roulette_transition);
    roulette.target_room = random_map;
    
    global.game_paused = true;
    
    audio_play_sound(snd_effects_confuse, 0, false);
    
    indicator_sprite = noone;
    target_player = noone;
    break;
}

// CREATE THE VISUAL INDICATOR
if (indicator_sprite != noone && instance_exists(target_player)) {
    var indicator = instance_create_layer(
        target_player.x + indicator_offset_x,
        target_player.y + indicator_offset_y, 
        "effects_indicator", 
        obj_effect_indicator
    );
    
    indicator.target = target_player;
    indicator.sprite_index = indicator_sprite;
    indicator.image_blend = indicator_color;
    indicator.offset_x = indicator_offset_x; // Pass offset to indicator
    indicator.offset_y = indicator_offset_y; // Pass offset to indicator
    
    show_debug_message("Created effect indicator at offset: " + string(indicator_offset_x) + ", " + string(indicator_offset_y));
}

// Hide gift
visible = false;
image_alpha = 0;

// Set respawn timer
alarm[0] = 6 * room_speed;
show_debug_message("Gift collected. Will respawn in 15 seconds");