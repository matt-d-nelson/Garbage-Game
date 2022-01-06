if (!global.gamePaused)
{

	//Calc jump and reset path
	if (position_meeting(x,y,oGapCol)) && (jumping = false)
	{
		var _gap = instance_place(x,y,oGapCol);
		animationState = DukeStateJump;
		jumping = true;
		
		jumpDistanceTravelled = 0;
		jumpPercent = 0;
		
		//change jump target and distance based on direction
		switch (CARDINAL_DIR)
		{
			case 0: jumpDistance = _gap.sprite_width + colWidth*2; targetX = (x+jumpDistance); targetY = y; break;
			case 1: jumpDistance = _gap.sprite_height + colHeight*2; targetX = x; targetY = (y-jumpDistance); break;
			case 2: jumpDistance = _gap.sprite_width + colWidth*2; targetX = (x-jumpDistance); targetY = y; break;
			case 3: jumpDistance = _gap.sprite_height + colHeight*2; targetX = x; targetY = (y+jumpDistance); break;
		}
		
		//Reset path
		path_delete(path);
		path = path_add();

		//Follow path
		mp_grid_path(oPathwaySetup.grid, path, x, y, targetX, targetY, 0);
		path_start(path, speedWalk, path_action_stop, false);
	}
	//Calc z arc
	if (jumping = true)
	{
		path_speed = 1;
		jumpDistanceTravelled = min(jumpDistanceTravelled+(speedWalk),jumpDistance);
		jumpPercent = lerp(0, 1, jumpDistanceTravelled / jumpDistance);
		z = (jumpDistance/4) * sin(jumpPercent*pi);	
	}

	//Set Sprite Index
	script_execute(animationState);

} else path_speed = 0;

depth = -bbox_bottom;
