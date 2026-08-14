if (room == Map3) {
    if (other.x < x) other.hsp = -abs(other.hsp); 
    else if (other.x > x) other.hsp = abs(other.hsp);
    if (other.y < y) other.vsp = -abs(other.vsp); 
    else if (other.y > y) other.vsp = abs(other.vsp); 
} else {
	other.speed = 0;
}
