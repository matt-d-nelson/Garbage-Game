function DukeStateFollow(){
	if (!collision_circle(x,y,50,oPlayer,false,true))
	{
		targetX = (oPlayer.x + irandom_range(-30,30));
		targetY = (oPlayer.y + irandom_range(-30,30));
	}
	else
	{
		targetX = choose((x + irandom_range(15,25)),(x + irandom_range(-25,-15)),x,x,x,x,x,x);
		targetY = choose((y + irandom_range(15,25)),(y + irandom_range(-25,-15)),y,y,y,y,y,y);
	}
	
	//Avoid targeting gaps
	if (place_meeting(targetX,targetY,oGapCol))
	{
		targetX = x;
		targetY = y;
	}
}

function DukeStateFollowSprites(){
	if (path_position < 0.99) && (path_speed != 0)
	{
		sprite_index = spriteWalk; 
	}
	else 
	{
		sprite_index = spriteIdle;
		localFrame = 0;
	}
	//Update Sprite
	DukeAnimateSprite();
}

function DukeStateJump(){
	
	if (global.dLifted = noone)
	{
		//Start jump
		if (sprite_index != sDukeJumpUp) && (sprite_index != sDukeJumping) && (sprite_index != sDukeJumpDown)
		{
			DukeActOutAnimationJump(sDukeJumpUp);
		}
		//Innitiate movement
		if (sprite_index = sDukeJumpUp) && (actionEnd)
		{
			sprite_index = sDukeJumping;
			localFrame = 0;
			actionEnd = false;
		}

		//Innitiate landing
		if jumpDistanceTravelled = jumpDistance
		{
			path_speed = 0;
			jumping = false;
			DukeActOutAnimationJump(sDukeJumpDown);
		}
		//End jump
		if (sprite_index = sDukeJumpDown) && (actionEnd) 
		{
			path_speed = 1;
			localFrame = 0;
			actionEnd = false;
			z = 0;
			animationState = DukeStateFollowSprites;
		}
	}
	else
	{
		//Start jump
		if (sprite_index != sDukeLiftedJumpUp) && (sprite_index != sDukeLiftedJumping) && (sprite_index != sDukeLiftedJumpDown)
		{
			DukeActOutAnimationJump(sDukeLiftedJumpUp);
		}
		//Innitiate movement
		if (sprite_index = sDukeLiftedJumpUp) && (actionEnd)
		{
			sprite_index = sDukeLiftedJumping;
			localFrame = 0;
			actionEnd = false;
		}

		//Innitiate landing
		if jumpDistanceTravelled = jumpDistance
		{
			path_speed = 0;
			jumping = false;
			DukeActOutAnimationJump(sDukeLiftedJumpDown);
		}
		//End jump
		if (sprite_index = sDukeLiftedJumpDown) && (actionEnd) 
		{
			path_speed = 1;
			localFrame = 0;
			actionEnd = false;
			z = 0;
			animationState = DukeStateFollowSprites;
		}
	}
	DukeAnimateSprite();
}
