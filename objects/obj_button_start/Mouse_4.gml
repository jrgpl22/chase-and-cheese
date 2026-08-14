var fade = instance_create_depth(0, 0, -9999, obj_fade_transition);
fade.mode = "out";
fade.alpha = 1;
fade.target_room = choose(Map1, Map2, Map3, Map4);
audio_stop_all();