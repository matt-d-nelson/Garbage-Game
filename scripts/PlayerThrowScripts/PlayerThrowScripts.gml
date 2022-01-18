
function PlayerThrow(){
	with (global.iLifted)
	{
		lifted = false;
		persistent = false;
		thrown = true;
		z = 18;
		throwPeakHeight = z + 10;
		throwDistance = entityThrowDistance;
		throwDistanceTravelled = 0;
		throwStartPercent = (13/throwPeakHeight) * 0.5;
		throwPercent = throwStartPercent;
		direction = other.direction;
		xstart = x;
		ystart = y;
	}
	//Animate throw
	PlayerActOutAnimation(sPlayerThrowing,-1);
	global.iLifted = noone;
	spriteIdle = sPlayerLiftIdle;
	spriteWalk = sPlayerLiftWalk;
	localFrame = 0;
	global.playerSpeedWalk += 0.3;
}