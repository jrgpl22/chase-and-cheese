if (global.game_paused) {
    exit;
}

global.cat_score += 1;
show_debug_message("Cat scored! Score: " + string(global.cat_score) + "/3");

var fight_x = (x + other.x) / 2;
var fight_y = (y + other.y) / 2;

global.shake_magnitude = 8;
global.shake_duration = 30;
global.freeze_frames = 10;
global.flash_alpha = 0.6;
global.flash_color = c_white;

sprite_index = spr_fight;
image_index = 0;
image_speed = 1;

x = fight_x - 0;
y = fight_y - 0;
image_xscale = 1.2;
image_yscale = 1.2;

other.visible = false;
other.x = 700;
other.y = 600;

audio_play_sound(snd_fight, 0, false);

other.effect_timer = 0;
other.spd = other.base_spd;
other.is_stunned = false;
other.is_confused = false;
other.confusion_shuffled = false;
other.confused_keys = [ord("W"), ord("S"), ord("A"), ord("D")];
other.image_blend = c_white;

effect_timer = 0;
spd = base_spd;
is_stunned = false;
is_confused = false;
confusion_shuffled = false;
confused_keys = [vk_up, vk_down, vk_left, vk_right];
image_blend = c_white;

show_debug_message("All effects cleared from both players");

global.game_paused = true;

if (global.cat_score >= 3) {
    show_debug_message("Cat Champion!");
    show_champion_pending = true;
    alarm[1] = room_speed * 3;
}
else {
    var rooms = [];
    if (room == Map1) {
        rooms = [Map2, Map3, Map4];
    } else if (room == Map2) {
        rooms = [Map1, Map3, Map4];
    } else if (room == Map3) {
        rooms = [Map1, Map2, Map4];
    } else if (room == Map4) {
        rooms = [Map1, Map2, Map3];
    }
    var choice = irandom(array_length(rooms) - 1);
    next_room = rooms[choice];
    
    show_banner_pending = true;
    alarm[1] = room_speed * 3;
}