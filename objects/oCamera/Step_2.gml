/// @description Update Camera

//Update destination
if (instance_exists(follow))
{
	xTo = floor(follow.x);	
	yTo = floor(follow.y) - (viewHeightHalf/2);
}

//Update Object Position
x += (xTo-x)/15;
y += (yTo-y)/15;

//Keep camera center inside room
x = clamp(x, viewWidthHalf, room_width-viewWidthHalf);
y = clamp(y, viewHeightHalf, room_height-viewHeightHalf);

//Screenshake
x += random_range(-shakeRemain,shakeRemain);
y += random_range(-shakeRemain,shakeRemain);

shakeRemain = max(0, shakeRemain - ((1/shakeLength) * shakeMagnitude));

camera_set_view_pos(cam,x - viewWidthHalf, y - viewHeightHalf);
