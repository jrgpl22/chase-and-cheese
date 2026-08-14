randomize();

spd = 1.8
base_spd = 1.8
hspd = 0;
vspd = 0;
is_flying = false;
spin_speed = 0;
gravity_y = 0;
is_double_ko = false;
// power-up vars
is_stunned = false;
effect_timer = 0;
is_confused = false;
confused_keys = [vk_up, vk_down, vk_left, vk_right]; //arrow keys
confusion_shuffled = false;
show_champion_pending = false;
show_banner_pending = false;
show_cat_champion = false;

original_sprite = sprite_index;

sprite_index = spr_cat_idle_down;
direction = 270;
speed = 0;

image_xscale = 1.37
image_yscale = 1.37

//ice map vars
hsp = 0;
vsp = 0; 
friction_ice = 0.94;  
ice_accel_multiplier = 0.07; 
ice_physics_active = true; 
teleport_cooldown = 0;