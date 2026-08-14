if (global.game_paused) {
    alarm[0] = 1;
    exit;
}

bomb_state = "exploding";
sprite_index = spr_bomb;
image_speed = 1;
image_index = 0;


if (global.game_paused) {
    alarm[0] = 1;  // Check again next frame
    exit;
}
if (!audio_is_playing(snd_bomb_explode)) {
    audio_play_sound(snd_bomb_explode, 1, false);
}

var hit_mouse = collision_circle(x, y, explosion_radius, obj_mouse, false, true);
var hit_cat = collision_circle(x, y, explosion_radius, obj_cat, false, true);

if (instance_exists(obj_timer_controller)) {
    var timer = obj_timer_controller;
    
    // MOUSE GOT HIT
    if (hit_mouse != noone) {
        // Check if cat was recently hit (within 0.3 seconds = 18 frames at 60fps)
        if (timer.player_hit_by_bomb == "cat" && timer.double_ko_timer > 0) {
            // DOUBLE KO!
            show_debug_message("=== DOUBLE KO DETECTED! ===");
            
            with (hit_mouse) {
                var dir = random(360);
                hspd = lengthdir_x(15, dir);
                vspd = lengthdir_y(15, dir);
                is_flying = true;
                is_double_ko = true;
                spin_speed = 20;
                gravity_y = 0.3;
            }
            
            if (instance_exists(obj_cat) && obj_cat.is_flying) {
                obj_cat.is_double_ko = true;
            }
            
            timer.player_hit_by_bomb = "";
            timer.double_ko_timer = 0;
        } else {
            // First hit or only mouse hit
            with (hit_mouse) {
                var dir = random(360);
                hspd = lengthdir_x(15, dir);
                vspd = lengthdir_y(15, dir);
                is_flying = true;
                is_double_ko = false;
                spin_speed = 20;
                gravity_y = 0.3;
            }
            
            timer.player_hit_by_bomb = "mouse";
            timer.double_ko_timer = 18; // 0.3 seconds at 60fps
            show_debug_message("MOUSE HIT - Waiting for potential double KO...");
        }
    }
    
    // CAT GOT HIT
    if (hit_cat != noone) {
        // Check if mouse was recently hit
        if (timer.player_hit_by_bomb == "mouse" && timer.double_ko_timer > 0) {
            // DOUBLE KO!
            show_debug_message("=== DOUBLE KO DETECTED! ===");
            
            with (hit_cat) {
                var dir = random(360);
                hspd = lengthdir_x(15, dir);
                vspd = lengthdir_y(15, dir);
                is_flying = true;
                is_double_ko = true;
                spin_speed = 20;
                gravity_y = 0.3;
            }
            
            if (instance_exists(obj_mouse) && obj_mouse.is_flying) {
                obj_mouse.is_double_ko = true;
            }
            
            timer.player_hit_by_bomb = "";
            timer.double_ko_timer = 0;
        } else {
            // First hit or only cat hit
            with (hit_cat) {
                var dir = random(360);
                hspd = lengthdir_x(15, dir);
                vspd = lengthdir_y(15, dir);
                is_flying = true;
                is_double_ko = false;
                spin_speed = 20;
                gravity_y = 0.3;
            }
            
            timer.player_hit_by_bomb = "cat";
            timer.double_ko_timer = 18; // 0.3 seconds at 60fps
            show_debug_message("CAT HIT - Waiting for potential double KO...");
        }
    }
}

alarm[1] = 1.1 * room_speed;
audio_stop_sound(snd_bomb_radius);