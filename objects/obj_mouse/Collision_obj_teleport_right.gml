/// @description Hit RIGHT teleporter → Go to LEFT side
var left_teleport = instance_find(obj_teleport_left, 0);
if (instance_exists(left_teleport)) {
    x = left_teleport.x + 50;  // Appear at LEFT teleporter
}