function StrikeGather(){
	//Gather Just Started
	if (sprite_index != sPlayerGather1) && (sprite_index != sPlayerGather2)
	{
		//Set up correct animation
		if (global.playerGarbage < 50)
		{
			sprite_index = sPlayerGather1;
		}
		else
		{
			sprite_index = sPlayerGather2;
		}
		localFrame = 0;
		
		//Clear hit list
		if (!ds_exists(hitByStrike, ds_type_list)) hitByStrike = ds_list_create();
		ds_list_clear(hitByStrike);
	}
	
	CalcGather(sPlayerStrikeHB);
	PlayerAnimateSprite();
	if (global.playerGarbage >= 100)
	{
		var _angle = random(360)
		with (instance_create_layer(x,y,"Instances",oGarbageBag))
		{
			direction = _angle;
			thrown = true;
			z = 5;
			throwPeakHeight = z + 10;
			throwDistance = (entityThrowDistance/3) + random(3);
			throwDistanceTravelled = 0;
			throwStartPercent = (5/throwPeakHeight) * 0.5;
			throwPercent = throwStartPercent;
			xstart = x;
			ystart = y;
		}
		global.playerGarbage = 0;
	}
	if (global.playerGarbage >= 50)
	{
		spriteIdle = sPlayerGatherIdle2;
		spriteWalk = sPlayerGatherWalk2;
	}
	else
	{
		spriteIdle = sPlayerGatherIdle1;
		spriteWalk = sPlayerGatherWalk1;
	}
	if (animationEnd)
	{
		localFrame = 0;
		state = PlayerStateBag;
		animationEnd = false;
	}
}

function CalcGather(_mask)
{
	//Use Strike hitbox to check for hits
	mask_index = _mask;
	var hitByGatherNow = ds_list_create();
	var hits = instance_place_list(x,y,oParEntity,hitByGatherNow,false);
	if (hits > 0)
	{
		for (var i = 0; i < hits; i++)
		{
			//Hit instances
			var hitID = hitByGatherNow[| i];
			if (ds_list_find_index(hitByStrike, hitID) == -1)
			{
				ds_list_add(hitByStrike, hitID);
				with (hitID)
				{
					if (object_is_ancestor(object_index, oParGarbage))
					{
						if (entityGarbage > 0)
						{
							entityGarbage -= global.playerGather;
							global.playerGarbage += global.playerGather;
							flashShader = shRedFlash;
							flash = 1;
						}
						else
						{
							flashShader = shWhiteFlash;
							flash = 1;
						}
					}
					else 
					{
						if (entityBagScript != -1) ScriptExecuteArray(entityBagScript,entityBagArgs);
					}
				}
			}
		}
	}
	ds_list_destroy(hitByGatherNow);
	mask_index = sPlayerIdle
}