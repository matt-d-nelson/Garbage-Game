function PlayerWhip(){
	hSpeed = 0;
	vSpeed = 0;
	var _imageDirection = (CARDINAL_DIR*3)
	
	//If just arriving in this state
	if (sprite_index != sPlayerWhipping)
	{
		whip = 0;
		whipX = 0;
		whipY = 0;
		whipStatus = WHIPSTATUS.EXTENDING;
		whippedEntity = noone;
		
		//Update Sprite
		sprite_index = sPlayerWhipping;
		image_index = _imageDirection;
		image_speed = 0;
	}
	//Extend/Retract whip
	var _speedWhipTemp = speedWhip;
	var _whipPercent = (whip/distanceWhip);
	if (whipStatus != WHIPSTATUS.EXTENDING) _speedWhipTemp *= -1;
	whip += _speedWhipTemp;
	switch (_imageDirection)
	{
		case 0: whipX = whip; break;
		case 3: whipY = -whip; break;
		case 6: whipX = -whip; break;
		case 9: whipY = whip; break;
	}
	
	//Whip state machine
	switch (whipStatus)
	{
		case WHIPSTATUS.EXTENDING:
		{
			//Finish extending
			if (whip >= distanceWhip) whipStatus = WHIPSTATUS.MISSED;
			
			//Check for a hit
			var _whipHitEntity = collision_circle(x+whipX,y+whipY,4,oParEntity,false,true);
			var _whipHitWall = place_meeting(x+whipX,y+whipY,oParWallCol);
			if (_whipHitEntity != noone)
			{
				//Act depending on what is hit
				switch (_whipHitEntity.entityWhippable)
				{
					default: //Not a whippable entity
					{
						if (_whipHitEntity.entityWhipScript != -1)
						{
							with (_whipHitEntity) ScriptExecuteArray(entityWhipScript,entityWhipArgs);
							whipStatus = WHIPSTATUS.MISSED;
						}
						else whipStatus = WHIPSTATUS.MISSED;
					} break;
					case 1:
					{
						whipStatus = WHIPSTATUS.PULLTOPLAYER;
						whippedEntity = _whipHitEntity;
					} break;
					case 2:
					{
						whipStatus = WHIPSTATUS.PULLTOENTITY;
						whippedEntity = _whipHitEntity;
					} break;
				}
			}
			if (_whipHitWall) whipStatus = WHIPSTATUS.MISSED;
		} break;
		
		//Pull the entity towards the player
		case WHIPSTATUS.PULLTOPLAYER:
		{
			with (whippedEntity)
			{
				x = other.x + other.whipX;
				y = other.y + other.whipY;
				entityPulled = true;
				if (_whipPercent < 0.1) entityPulled = false;
			}
		} break;
		
		//Pull the player towards the entity
		case WHIPSTATUS.PULLTOENTITY:
		{
			if (_whipPercent > 0.1)
			{
				switch (_imageDirection)
				{
					case 0: x += speedWhip; break;
					case 3: y -= speedWhip; break;
					case 6: x -= speedWhip; break;
					case 9: y += speedWhip; break;
				}
			}
		} break;
	}
	
	//Update animation frame based on whip percent
	if (_whipPercent < 0.33)
	{
		image_index = _imageDirection;
	}
	if (_whipPercent > 0.33) and (_whipPercent < 0.66)
	{
		image_index = (_imageDirection + 1);
	}
	if (_whipPercent > 0.66)
	{
		image_index = (_imageDirection + 2);
	}
	
	//Finish retract and end state
	if (whip <= 0)
	{
		whippedEntity = noone;
		state = PlayerStateWhip;
	}
}

function DrawWhip(_x,_y,_rot,_extra){
	var _originX = x+_x;
	var _originY = y+_y;
	var _chains = (whip div whipSize)+_extra;
	var _whipDirX = sign(whipX);
	var _whipDirY = sign(whipY);
	
	for (var i = 0; i < _chains; i++)
	{
		draw_sprite_ext(
			sWhip,
			0,
			_originX+whipX-(i*whipSize*_whipDirX),
			_originY+whipY-(i*whipSize*_whipDirY),
			image_xscale,
			image_yscale,
			_rot,
			image_blend,
			image_alpha
		);
	}
	draw_sprite(sWhipHead,CARDINAL_DIR,_originX+whipX,_originY+whipY);
}