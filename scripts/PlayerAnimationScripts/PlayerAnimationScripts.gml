// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerAnimateSprite()
{
	//Update Sprite
	var _totalFrames = sprite_get_number(sprite_index) / 4;
	image_index = localFrame + (CARDINAL_DIR * _totalFrames);
	localFrame += sprite_get_speed(sprite_index) / FRAME_RATE;
	
	//If animation would loop on next game step
	if (localFrame >= _totalFrames)
	{
		animationEnd = true;	
		localFrame -= _totalFrames
	}
	else animationEnd = false;
}

function PlayerActOutAnimation(_sprite, _endScript)
{
	statePrevious = state;
	state = PlayerStateAct;
	sprite_index = _sprite;
	if (_endScript != -1) 
	{
		animationEndScript = _endScript;
	}
	else
	{
		animationEndScript = -1;	
	}
	localFrame = 0;
	image_index = 0;
	PlayerAnimateSprite();	
}

function PlayerStateAct()
{
	//Update Sprite
	PlayerAnimateSprite();
	
	if (animationEnd)
	{
		state = statePrevious;
		animationEnd = false;
		if (animationEndScript != -1)
		{
			script_execute(animationEndScript)
			animationEnd = -1;
		}
	}
}