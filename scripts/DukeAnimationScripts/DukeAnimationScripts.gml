function DukeAnimateSprite(){
	//Update sprite
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

function DukeActOutAnimation(_sprite){
	animationStatePrevious = animationState;
	animationState = DukeStateAct;
	sprite_index = _sprite;
	localFrame = 0;
	image_index = 0;
	//DukeAnimateSprite(); Potentially Unessesary
}

function DukeStateAct(){
	//Update Sprite
	DukeAnimateSprite();
	
	if (animationEnd = true)
	{
		animationState = animationStatePrevious;
		animationEnd = false;
	}
}

function DukeActOutAnimationJump(_sprite){
	animationStatePrevious = animationState;
	animationState = DukeStateActJump;
	sprite_index = _sprite;
	localFrame = 0;
	image_index = 0;
	//DukeAnimateSprite(); Potentially Unessesary
}

function DukeStateActJump(){
	//Update Sprite
	DukeAnimateSprite();
	
	if (animationEnd = true)
	{
		animationState = animationStatePrevious;
		animationEnd = false;
		actionEnd = true;
	}
}