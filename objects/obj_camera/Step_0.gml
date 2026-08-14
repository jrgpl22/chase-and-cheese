if (global.freeze_frames > 0) {
    global.freeze_frames--;
    exit;
}

if (global.shake_duration > 0) {
    global.shake_duration--;
    shake_x = random_range(-global.shake_magnitude, global.shake_magnitude);
    shake_y = random_range(-global.shake_magnitude, global.shake_magnitude);
    
    camera_set_view_pos(camera, original_cam_x + shake_x, original_cam_y + shake_y);
} else {
    camera_set_view_pos(camera, original_cam_x, original_cam_y);
}