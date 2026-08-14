/// @description Room Refresh Transition
show_room_refresh = false;
global.game_paused = false;

var rooms = [Map1, Map2, Map3, Map4];
var choice = irandom(array_length(rooms) - 1);
room_goto(rooms[choice]);