/// @description Insert description here
// You can write your code in this editor

// If target doesn't exist or effect ended, destroy this indicator
if (!instance_exists(target) || target.effect_timer <= 0) {
    instance_destroy();
    exit;
}

// Follow the target with offset
x = target.x + offset_x;
y = target.y + offset_y;








































































