/// @description Hit LEFT teleporter → Go to RIGHT side
var right_teleport = instance_find(obj_teleport_right, 0);
if (instance_exists(right_teleport)) {
    x = right_teleport.x - 16;  // Appear at RIGHT teleporter
}