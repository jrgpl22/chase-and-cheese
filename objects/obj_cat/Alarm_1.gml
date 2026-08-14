if (instance_exists(obj_mouse)) {
    obj_mouse.visible = true;
    obj_mouse.x = 700;
    obj_mouse.y = 600;
}

if (show_champion_pending) {
    obj_cat_champion.visible = true;
    audio_stop_all();
    audio_play_sound(snd_victory, 0, false);
    show_cat_champion = true;
    show_champion_pending = false;
}
else if (show_banner_pending) {
    audio_stop_all();
    audio_play_sound(snd_win_round, 0, false);
    audio_play_sound(snd_cat_meow, 0, false);
    
    obj_cat_banner.visible = true;
    obj_cat_banner.image_xscale = 0.6;
    obj_cat_banner.image_yscale = 0.6;
    alarm[0] = room_speed * 5;
    show_banner_pending = false;
}