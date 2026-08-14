timer += 1;

// After delay
if (timer > 300) {
    // Just activate buttons - NO transition!
    instance_activate_object(obj_button_start);
    instance_activate_object(obj_button_howtoplay);
    instance_activate_object(obj_button_exit);
    instance_activate_object(obj_button_settings);
    
    // DON'T create transition here - just destroy the delay object
    instance_destroy();
}