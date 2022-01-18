function PlayerCollision()
{
	var _collision = false;
	var _entityList = ds_list_create();
	
	//Remove Horizontal Coordinate Fractions
	hSpeed += hSFrac; //Add previous fraction
	hSFrac = hSpeed - (floor(abs(hSpeed)) * sign(hSpeed)); //Store new fraction
	hSpeed -= hSFrac; // Remove new fraction
	
	//Horizontal Walls
	if (place_meeting(x+hSpeed,y,oParWallCol))
	{
		while(!place_meeting(x+sign(hSpeed),y,oParWallCol))
		{
			x = x + sign(hSpeed);
		}
		hSpeed = 0;
		_collision = true;
	}
	
	//Horizontal Entities
	var _entityCount = instance_position_list(x + hSpeed, y, oParEntity, _entityList, false);
	var _snapX;
	while (_entityCount > 0)
	{
		var _entityCheck = _entityList[| 0];
		if (_entityCheck.entityCollision == true) && (_entityCheck.lifted == false) 
		{
			//Move as close as possible
			if (sign(hSpeed) == 1) _snapX = _entityCheck.bbox_left-1;
			else _snapX = _entityCheck.bbox_right+1;
			x = _snapX;
			hSpeed = 0;
			_collision = true;
			_entityCount = 0;
		}
		ds_list_delete(_entityList,0);
		_entityCount--;
	}
	
	//Horizontal Gap
	if (place_meeting(x+hSpeed,y,oGapCol))
	{
		while(!place_meeting(x+sign(hSpeed),y,oGapCol))
		{
			x = x + sign(hSpeed);
		}
		hSpeed = 0;
		_collision = true;
	}
	
	//Horizontal Move Commit  
	x += hSpeed;
	
	//Remove Vertical Coordinate Fractions
	vSpeed += vSFrac; //Add previous fraction
	vSFrac = vSpeed - (floor(abs(vSpeed)) * sign(vSpeed)); //Store new fraction
	vSpeed -= vSFrac; // Remove new fraction
	
	//Vertical Walls
	if (place_meeting(x,y+vSpeed,oParWallCol))
	{
		while(!place_meeting(x,y+sign(vSpeed),oParWallCol))
		{
			y = y + sign(vSpeed);
		}
		vSpeed = 0;
		_collision = true;
	}
	
	//Vertical Entities
	var _entityCount = instance_position_list(x, y + vSpeed, oParEntity, _entityList, false);
	var _snapY;
	while (_entityCount > 0)
	{
		var _entityCheck = _entityList[| 0];
		if (_entityCheck.entityCollision == true) && (_entityCheck.lifted == false)
		{
			//Move as close as we can
			if (sign(vSpeed) == 1) _snapY = _entityCheck.bbox_top-1;
			else _snapY = _entityCheck.bbox_bottom+1;
			y = _snapY;
			vSpeed = 0;
			_collision = true;
			_entityCount = 0;
		}
		ds_list_delete(_entityList,0);
		_entityCount--;
	}
	
	//Vertical Gap
	if (place_meeting(x,y+vSpeed,oGapCol))
	{
		while(!place_meeting(x,y+sign(vSpeed),oGapCol))
		{
			y = y + sign(vSpeed);
		}
		vSpeed = 0;
		_collision = true;
	}
	
	//Vertical Move Commit
	
	y += vSpeed;
	
	ds_list_destroy(_entityList);

	return _collision;
}

function PlayerMovement(){
	//Fix for lift/throw issues
	if (global.iLifted != noone)
	{
		if (!place_meeting(x,y,oParWallCol)) && (!place_meeting(x,y,oGapCol))
		{
			mask_index = global.iLifted.mask_index;	
		}
		else
		{
			mask_index = sPlayerIdle;	
		}
	}
	else
	{
		if (!place_meeting(x,y,oParGarbage))
		{
			mask_index = sPlayerIdle;	
		}
	}
	//Movement
	hSpeed = lengthdir_x(inputMagnitude * global.playerSpeedWalk, inputDirection);
	vSpeed = lengthdir_y(inputMagnitude * global.playerSpeedWalk, inputDirection);

	PlayerCollision();

	//Update Sprite Index
	var _oldSprite = sprite_index;
	if (inputMagnitude != 0)
	{
		direction = inputDirection;
		sprite_index = spriteWalk;
	} else sprite_index = spriteIdle;
	if (_oldSprite != sprite_index) localFrame = 0;

	//Update Image Index
	PlayerAnimateSprite();
	
	//Change State/Equipped Item
	if (global.playerHasAnyItems) & (global.iLifted = noone)
	{
		var _cycleDirection = keyItemSelectRight - keyItemSelectLeft;
		if (_cycleDirection != 0)
		{
			do
			{
				global.playerEquipped += _cycleDirection;
				if (global.playerEquipped < 0) global.playerEquipped = ITEM.TYPE_COUNT-1;
				if (global.playerEquipped >= ITEM.TYPE_COUNT) global.playerEquipped = 0;
			}
			until (global.playerItemUnlocked[global.playerEquipped]);
			//Update State
			switch (global.playerEquipped)
			{
				case ITEM.NONE: 
				{
					spriteIdle = sPlayerIdle;
					spriteWalk = sPlayerWalk;
					localFrame = 0;
					state = PlayerStateNone; 
				}break;
				case ITEM.GLOVES: 
				{
					spriteIdle = sPlayerLiftIdle;
					spriteWalk = sPlayerLiftWalk;
					localFrame = 0;
					state = PlayerStateGloves; 
				}break;
				case ITEM.BAG: 
				{
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
					localFrame = 0;
					state = PlayerStateBag; 	
				}break;
				case ITEM.AXE: 
				{
					spriteIdle = sPlayerAxeIdle;
					spriteWalk = sPlayerAxeWalk;
					localFrame = 0;
					state = PlayerStateAxe; 
				}break;
				case ITEM.WHIP:
				{
					spriteIdle = sPlayerWhipIdle;
					spriteWalk = sPlayerWhipWalk;
					localFrame = 0;
					state = PlayerStateWhip; 
				}break;
				case ITEM.BOMB: 
				{
					if (global.playerBombAmmo > 0)
					{
						spriteIdle = sPlayerBombIdle;
						spriteWalk = sPlayerBombWalk;
					}
					else
					{
						spriteIdle = sPlayerIdle;
						spriteWalk = sPlayerWalk;
					}
					localFrame = 0;
					state = PlayerStateBomb; 
				}break;
				default: break;
			}
		}
	}
}

function PlayerStateFreeze(){
	//Freeze the player	
}

function PlayerStateNone(){
	//Movement/selection/exc.
	PlayerMovement();
	
}

function PlayerStateGloves(){
	//Movement/selection/exc.
	PlayerMovement();
	if (keyItem)
	{
		activate = noone;
		if (global.iLifted = noone)
		{
			var _activateX = x + lengthdir_x(10, direction);
			var _activateY = y + lengthdir_y(10, direction);
			var _activateSize = 4;
			var _activateList = ds_list_create();
			
			var _entitiesFound = collision_rectangle_list(
				_activateX - _activateSize,
				_activateY - _activateSize,
				_activateX + _activateSize,
				_activateY + _activateSize,
				oParEntity,
				false,
				true,
				_activateList,
				true
			);
			while (_entitiesFound > 0)
			{
				var _check = _activateList[| --_entitiesFound]
				if (_check != global.iLifted) && (_check != global.dLifted) && (_check.entityGlovesScript != -1)
				{
					activate = _check;
					break;
				}
			}
			ds_list_destroy(_activateList);
		}
		
		if (activate == noone) 
		{
			if (global.iLifted != noone)
			{
				PlayerThrow();
			}
		}
		else
		{
			//Activate the Entity
			ScriptExecuteArray(activate.entityGlovesScript, activate.entityGlovesArgs);
		
			//Make NPC face the player
			if (activate.entityNPC)
			{
				with (activate)
				{
					direction = point_direction(x,y,other.x,other.y);
					image_index = CARDINAL_DIR;
				}
			}
		}
	}
	
}

function PlayerStateBag(){
	//Movement/selection/exc.
	PlayerMovement();
	
	//Gather Garbage
	if (keyItem)
	{
		state = PlayerStateStrike;
		strikeType = StrikeGather;
	}
}

function PlayerStateAxe(){
	//Movement/selection/exc.
	PlayerMovement();
	
	//Axe Garbage
	if (keyItem)
	{
		state = PlayerStateStrike;
		strikeType = StrikeAxe;
	}
}

function PlayerStateWhip(){
	//Movement/selection/exc.
	PlayerMovement();
	
	//Use Whip
	if (keyItem)
	{
		state = PlayerWhip;
	}
}

function PlayerStateBomb(){
	//Movement/selection/exc.
	PlayerMovement();
	
	//Place Bomb
	if (keyItem) and (global.playerBombAmmo > 0)
	{
		state = PlaceBomb;
	}
}