/// @description Entity Loop
//oPar Garbage has altered code to ensure it is allways collidable (line 61)
if (!global.gamePaused)
{
	if (lifted) && (instance_exists(oPlayer))
	{
		if (oPlayer.sprite_index != sPlayerLifting)
		{
			x = oPlayer.x;
			y = oPlayer.y;
			z = 18;
			depth = oPlayer.depth-1;
		}
	}
	
	if (!lifted)
	{
		if (thrown)
		{
			if place_meeting(x,y,oPlayer) depth = oPlayer.depth-1; //fix draw frame where player is in front of thrown object
			throwDistanceTravelled = min(throwDistanceTravelled+3,throwDistance);
			x = xstart + lengthdir_x(throwDistanceTravelled, direction);
			y = ystart + lengthdir_y(throwDistanceTravelled, direction);
			if (place_meeting(x,y,oParWallCol)) or (place_meeting(x,y,oParEntity))
			{
				thrown = false;
				grav = 0.1;
			}
			
			throwPercent = throwStartPercent + lerp(0, 1 - throwStartPercent, throwDistanceTravelled / throwDistance);
			z = throwPeakHeight * sin(throwPercent * pi);
			if (throwDistance == throwDistanceTravelled)
			{
				thrown = false;
				if (entityThrowBreak) instance_destroy();
			}
		}
		else
		{
			//fall back to earth if z > zero
			if (z > 0)
			{
				z = max(z - grav, 0);
				grav += 0.1;
				if (z == 0) && (entityThrowBreak) instance_destroy();
			}
			else
			{
				grav = 0.1;
				if (place_meeting(x,y,oGapCol)) and (!entityPulled)
				{
					flash = 1;
					x = oPlayer.x+5;
					y = oPlayer.y+5;
				}
			}
		}
	}
}
flash = max(flash-0.04,0);
depth = -bbox_bottom;