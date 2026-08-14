/// @description Insert description here
// You can write your code in this editor
if(room==Map1){
	audio_stop_all();
	audio_play_sound(snd_gameplay_bg, 0, true);
} else if (room==Map2){
	audio_stop_all();
	audio_play_sound(snd_gameplay_bg2, 0, true);
} else if (room==Map3){
	audio_stop_all();
	audio_play_sound(snd_gameplay_bg3, 0, true);
}else if (room==Map4){
	audio_stop_all();
	audio_play_sound(snd_gameplay_bg4, 0, true);
}
