if (!global.gamePaused)
{
	bombTick--;
	if (bombTick == 0)
	{
		flash = 0.75;
		bombStage++;
		bombTick = bombTickRate[bombStage];
	}
	if (bombStage > 2) && (bombStage < 7) image_index = 1;
	if (bombStage >= 7) image_index = 2;
	if (bombTick < 0)
	{
		instance_destroy();	
	}
}

depth = -bbox_bottom;
