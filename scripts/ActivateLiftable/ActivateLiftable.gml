function ActivateLiftable(_id){
	if (global.iLifted == noone) && (id = oPlayer.id) && (global.dLifted != _id)
	{
		PlayerActOutAnimation(sPlayerLifting, -1);
		
		spriteIdle = sPlayerLiftedIdle;
		spriteWalk = sPlayerLiftedWalk;
		localFrame = 0;
		global.playerSpeedWalk -= 0.25;
		
		global.iLifted = _id;
		with (global.iLifted)
		{
			lifted = true;	
			persistent = true;
		}
	}
	if (global.dLifted == noone) && (id = oDuke.id)
	{
		DukeActOutAnimation(sDukeLifting);
		
		spriteIdle = sDukeLiftedIdle;
		spriteWalk = sDukeLiftedWalk;
		localFrame = 0;
		speedWalk -= 0.3;
		
		global.dLifted = _id;
		with (global.dLifted)
		{
			lifted = true;	
			persistent = true;
		}	
	}
}