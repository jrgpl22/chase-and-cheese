camera = view_camera[0];
follow = obj_cat;  
view_w_half = camera_get_view_width(camera) * 0.5;
view_h_half = camera_get_view_height(camera) * 0.5;

shake_x = 0;
shake_y = 0;

original_cam_x = camera_get_view_x(camera);
original_cam_y = camera_get_view_y(camera);

global.shake_magnitude = 0;
global.shake_duration = 0;
global.freeze_frames = 0;
global.flash_alpha = 0;
global.flash_color = c_white;