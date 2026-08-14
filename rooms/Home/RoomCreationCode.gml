surface_resize(application_surface, 1280, 720);
window_set_size(1280, 720);
window_center();
display_reset(0, false);
gpu_set_tex_filter(false);

// Hide all buttons at start
instance_deactivate_object(obj_button_start);
instance_deactivate_object(obj_button_howtoplay);
instance_deactivate_object(obj_button_exit);


// Don't create transition yet
instance_create_depth(0, 0, -10000, obj_transition);