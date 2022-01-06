
function DukeThrow(){
	with (global.dLifted)
	{
		lifted = false;
		persistent = false;
		thrown = true;
		z = 25;
		throwPeakHeight = z + 10;
		throwDistance = (entityThrowDistance*2);
		throwDistanceTravelled = 0;
		throwStartPercent = (13/throwPeakHeight) * 0.5;
		throwPercent = throwStartPercent;
		direction = other.direction;
		xstart = x;
		ystart = y;
	}
	//Animate throw
	DukeActOutAnimation(sDukeThrowing);
	global.dLifted = noone;
	spriteIdle = sDukeIdle;
	spriteWalk = sDukeWalk;
	localFrame = 0;
	speedWalk += 0.3;
}

