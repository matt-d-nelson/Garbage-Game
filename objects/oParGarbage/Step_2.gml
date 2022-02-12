/// @description Collidable and Throwable
if (!global.gamePaused)
{
	if (global.iLifted = id)
	{
		if (lifted) && (instance_exists(oPlayer))
		{
			if (oPlayer.sprite_index != sPlayerLifting)
			{
				x = oPlayer.x;
				y = oPlayer.y;
				z = 18;
			}
		}
	}
	if (global.dLifted = id)
	{
		if (lifted) && (instance_exists(oDuke))
		{
			if (oDuke.sprite_index != sDukeLifting)
			{
				x = oDuke.x;
				y = oDuke.y;
				z = 25+oDuke.z;
			}
		}
	}
	
	
	if (!lifted)
	{
		if (thrown)
		{
			if (place_meeting(x,y,oPlayer)) depth = oPlayer.depth-1; //fix draw frame where player is in front of thrown object
			entityCollision = false;
			if (place_meeting(x,y,oParWallCol))
			{
				thrown = false;
				grav = 0.1;
				if (place_meeting(x,y,oDumpsterBack)) inDumpster = true; else inDumpster = false;
			}
			else
			{
				throwDistanceTravelled = min(throwDistanceTravelled+3,throwDistance);
				x = xstart + lengthdir_x(throwDistanceTravelled, direction);
				y = ystart + lengthdir_y(throwDistanceTravelled, direction);
				if (place_meeting(x,y,oParEntity))
				{
					thrown = false;
					grav = 0.1;
					if (place_meeting(x,y,oDumpsterBack)) inDumpster = true; else inDumpster = false;
				}
			}
			
			throwPercent = throwStartPercent + lerp(0, 1 - throwStartPercent, throwDistanceTravelled / throwDistance);
			z = throwPeakHeight * sin(throwPercent * pi);
			if (throwDistance == throwDistanceTravelled)
			{
				thrown = false;
				if (entityThrowBreak) instance_destroy();
				if (place_meeting(x,y,oDumpsterBack)) inDumpster = true; else inDumpster = false;
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
					flashShader = shWhiteFlash;
					flash = 1;
					x = oPlayer.x+5;
					y = oPlayer.y+5;
					if (place_meeting(x,y,oGapCol))
					{
						x = oPlayer.x-5;
						y = oPlayer.y-5;
					}
				}
				if (entityCollision = false) && (!place_meeting(x,y,oPlayer)) entityCollision = true;
			}
		}
	}
	if (entityPulled) entityCollision = false;
}
flash = max(flash-0.04,0);

if (global.dLifted = id) && (oDuke.sprite_index != sDukeLifting) {depth = oDuke.depth-1;}
else if (global.iLifted = id) && (oPlayer.sprite_index != sPlayerLifting) {depth = oPlayer.depth-1;}
else depth = -bbox_bottom;
