/// @description Update position target


//Update target position
if (path_position >= 0.99)
{
	count = 0;
	if (global.dLifted == noone)
	{
		if (activate == noone)
		{
			var _garbList = ds_list_create();
			var _garbFound = (collision_circle_list(x,y,50,oParGarbage,false,true,_garbList,true));
			if (_garbFound > 0)
			{
				for (var i = 0; i < _garbFound; i++)
				{
					var _garb = _garbList[| i];
					if (_garb.entityGlovesScript = ActivateLiftable) && (global.iLifted != _garb) && (global.dLifted != _garb) && (_garb.inDumpster = false)
					{
						activate = _garb;
						break;
					}
				}
			}
			if (activate == noone) DukeStateFollow();
			ds_list_destroy(_garbList);
		}
		else
		{
			if (targetX != activate.x) && (targetY != activate.y)
			{
				targetX = activate.x;
				targetY = activate.y;
			}
			else
			{
				if (activate != global.iLifted) && place_meeting(x,y,activate)
				{
					//Pick up garbage
					ScriptExecuteArray(activate.entityGlovesScript,activate.entityGlovesArgs);
					activate = noone;
				}
				else 
				{
					DukeStateFollow();
					activate = noone;	
				}
			} 
		}
	}
	else
	{
		var _dump = (collision_circle(x,y,200,oDumpsterTarget,false,true));
		if (_dump = noone)
		{
			DukeStateFollow();
		}
		else
		{
			if (!place_meeting(targetX-(global.dLifted.entityThrowDistance*2),targetY,oDumpsterTarget))
			{
				targetX = irandom_range(oDumpsterTarget.bbox_left,oDumpsterTarget.bbox_right)+(global.dLifted.entityThrowDistance*2);
				targetY = irandom_range(oDumpsterTarget.bbox_top,oDumpsterTarget.bbox_bottom);
			}
			else
			{
				direction = 180;
				DukeThrow();
			}
		}
	}
} else count++;

//Reset Duke if he gets stuck for too long
if (count >= 10) path_position = 1;

//Reset path
path_delete(path);
path = path_add();

//Follow path
mp_grid_path(oPathwaySetup.grid, path, x, y, targetX, targetY, false);
path_start(path, speedWalk, path_action_stop, false);


//Loop
alarm_set(0,60);