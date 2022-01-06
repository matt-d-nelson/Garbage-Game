if (!global.gamePaused)
{
	image_speed = 1.0;
	//Hit things
	if (image_index < 4)
	{
		var _entityList = ds_list_create();
		var _entityCount = instance_place_list(x,y,oParEntity,_entityList,false);
		var _entity = noone;
		while (_entityCount > 0)
		{
			_entity = _entityList[| 0];
			if (ds_list_find_index(collisionHistory, _entity) == -1)
			{
				with (_entity)
				{
					if (object_is_ancestor(object_index,oParGarbage))
					{
						//Knockback
						if (entityBombScript = -1)
						{
							var _knockDirection = point_direction(other.x,other.y,x,y);
							direction = _knockDirection;
							thrown = true;
							z = 5;
							throwPeakHeight = z + 5;
							throwDistance = (entityThrowDistance/4) + random(3);
							throwDistanceTravelled = 0;
							throwStartPercent = (5/throwPeakHeight) * 0.5;
							throwPercent = throwStartPercent;
							xstart = x;
							ystart = y;
							flashShader = shWhiteFlash;
							flash = 1;
						}
						//Hit script
						else ScriptExecuteArray(entityBombScript,entityBombArgs);
					}
					else
					{
						if (entityBombScript != -1) ScriptExecuteArray(entityBombScript,entityBombArgs);
					}
				}
				ds_list_add(collisionHistory, _entity);
			}
			ds_list_delete(_entityList,0);
			_entityCount--;
		}
		ds_list_destroy(_entityList);
	}
}
else
{
	image_speed = 0.0;
}
