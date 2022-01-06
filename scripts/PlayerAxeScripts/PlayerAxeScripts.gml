function StrikeAxe(){
	//Strike just started
	if (sprite_index != sPlayerAxeStrike)
	{
		//Set up correct animation
		sprite_index = sPlayerAxeStrike;
		localFrame = 0;
		
		//Clear Hit List
		if (!ds_exists(hitByStrike, ds_type_list)) hitByStrike = ds_list_create();
		ds_list_clear(hitByStrike);
	}
	
	CalcAxe(sPlayerStrikeHB);
	
	//Update sprite
	PlayerAnimateSprite();
	
	if (animationEnd)
	{
		state = PlayerStateAxe;
		animationEnd = false;
	}
}

function CalcAxe(_mask)
{
	//Use strike hitbox & check for hits
	mask_index = _mask;
	var hitByAxeNow = ds_list_create();
	var hits = instance_place_list(x,y,oParEntity,hitByAxeNow,false);
	if (hits > 0)
	{
		for (var i = 0; i < hits; i++)
		{
			//If this instance has not yet been hit, hit it
			var hitID = hitByAxeNow[| i];
			if (ds_list_find_index(hitByStrike, hitID) == -1)
			{
				ds_list_add(hitByStrike, hitID);
				with (hitID)
				{
					if (object_is_ancestor(object_index, oParGarbage))
					{
						if (entityHP > 0) && (entityAxable)
						{
							entityHP -= global.playerAxe;
							flashShader = shRedFlash;
							flash = 1;
						}
						else
						{
							flashShader = shWhiteFlash;
							flash = 1;
							if (entityAxeScript != -1) ScriptExecuteArray(entityAxeScript,entityAxeArgs);
						}
					}
					else if (entityAxeScript != -1) ScriptExecuteArray(entityAxeScript,entityAxeArgs);
				}
			}
		}
	}
	ds_list_destroy(hitByAxeNow);
	mask_index = sPlayerIdle;
}

function SplitIntoPieces(_leftObject, _rightObject, _upObject, _downObject){
	var _angle0 = random_range(90,270)
	var _angle1 = random_range(0,180)
	if (_leftObject != -1)
	{
		with (instance_create_layer(x,y,"Instances",_leftObject))
		{
			direction = _angle0;
			thrown = true;
			z = 5;
			throwPeakHeight = z + 5;
			throwDistance = random(entityThrowDistance-1);
			throwDistanceTravelled = 0;
			throwStartPercent = (5/throwPeakHeight) * 0.5;
			throwPercent = throwStartPercent;
			xstart = x - sprite_get_width(_leftObject/2);
			ystart = y;
			flashShader = shRedFlash;
			flash = 1;
		}
	}
	if (_rightObject != -1)
	{
		with (instance_create_layer(x,y,"Instances",_rightObject))
		{
			direction = -_angle0;
			thrown = true;
			z = 5;
			throwPeakHeight = z + 5;
			throwDistance = random(entityThrowDistance-1);
			throwDistanceTravelled = 0;
			throwStartPercent = (5/throwPeakHeight) * 0.5;
			throwPercent = throwStartPercent;
			xstart = x + sprite_get_width(_rightObject/2);
			ystart = y;
			flashShader = shRedFlash;
			flash = 1;
		}
	}
	if (_upObject != -1)
	{
		with (instance_create_layer(x,y,"Instances",_upObject))
		{
			direction = _angle1;
			thrown = true;
			z = 5;
			throwPeakHeight = z + 5;
			throwDistance = random(entityThrowDistance-1);
			throwDistanceTravelled = 0;
			throwStartPercent = (5/throwPeakHeight) * 0.5;
			throwPercent = throwStartPercent;
			xstart = x;
			ystart = y - sprite_get_height(_upObject/2);
			flashShader = shRedFlash;
			flash = 1;
		}
	}
	if (_downObject != -1)
	{
		with (instance_create_layer(x,y,"Instances",_downObject))
		{
			direction = -_angle1;
			thrown = true;
			z = 5;
			throwPeakHeight = z + 5;
			throwDistance = random(entityThrowDistance-1);
			throwDistanceTravelled = 0;
			throwStartPercent = (5/throwPeakHeight) * 0.5;
			throwPercent = throwStartPercent;
			xstart = x;
			ystart = y + sprite_get_height(_downObject/2);
			flashShader = shRedFlash;
			flash = 1;
		}
	}
	instance_destroy();
}