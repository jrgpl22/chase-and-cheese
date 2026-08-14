/// @description Handle teleport animation
if (is_teleporting) {
    teleport_timer += 1;
    
    if (teleport_phase == 1) {
        // SHRINK OUT (20 frames to disappear)
        var shrink_progress = teleport_timer / 20;
        image_xscale = 1 - shrink_progress;
        image_yscale = 1 - shrink_progress;
        image_alpha = 1 - shrink_progress;
        
        // After shrinking, destroy
        if (teleport_timer >= 20) {
            instance_destroy();
        }
    }
    else if (teleport_phase == 2) {
        // GROW IN (20 frames to appear)
        var grow_progress = teleport_timer / 20;
        image_xscale = grow_progress;
        image_yscale = grow_progress;
        image_alpha = grow_progress;
        
        // After growing, back to normal
        if (teleport_timer >= 20) {
            image_xscale = 1;
            image_yscale = 1;
            image_alpha = 1;
            is_teleporting = false;
            teleport_phase = 0;
        }
    }
}