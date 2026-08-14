
if (is_teleporting) {
    teleport_timer += 1;
    
    if (teleport_phase == 1) {
        image_alpha -= 0.05;  
        image_xscale -= 0.03; 
        image_yscale -= 0.03;
        
        if (teleport_timer >= 20) {
            x = target_x;
            y = target_y;
            
            teleport_phase = 3;
            teleport_timer = 0;
            image_alpha = 0;
            image_xscale = 0;
            image_yscale = 0;
        }
    }
    
    else if (teleport_phase == 3) {
        image_alpha += 0.05; 
        image_xscale += 0.03;  
        image_yscale += 0.03;
        
        if (teleport_timer >= 20) {
            image_alpha = 1;
            image_xscale = 0.6;
            image_yscale = 0.6;
            is_teleporting = false;
            teleport_phase = 0;
            teleport_timer = 0;
        }
    }
}