// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlaceBomb(){
	hSpeed = 0;
	vSpeed = 0;
	
	//If just arriving in this state
	if (sprite_index != sPlayerBombPlace)
	{
		sprite_index = sPlayerBombPlace;
		localFrame = 0;
	}
	PlayerAnimateSprite();
	
	if (animationEnd = true)
	{
		global.playerBombAmmo--;
		switch (CARDINAL_DIR)
		{
			case 0: instance_create_layer(x+5,y,"Instances",oBomb); break;
			case 1: with (instance_create_layer(x,y-5,"Instances",oBomb)) image_xscale = -1; break;
			case 2: with (instance_create_layer(x-5,y,"Instances",oBomb)) image_xscale = -1; break;
			case 3: instance_create_layer(x,y+3,"Instances",oBomb); break;
		}
		
		if (global.playerBombAmmo != 0)
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
	}
}