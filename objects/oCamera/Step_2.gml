/// @description Update Camera

//Update destination
if (instance_exists(follow))
{
	xTo = follow.x;	
	yTo = follow.y - (viewHeightHalf/2);
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

//Zoom out/in when outside
if (zoomOut)
{
	camW = min(camW+2.66,640);
	camH = min(camH+1.5,360);
} else {
	camW = max(320,camW-2.66);
	camH = max(180,camH-1.5);
}

viewWidthHalf = camW * 0.5;
viewHeightHalf = camH * 0.5;
camera_set_view_size(cam,camW,camH);

//Screenshake and camera commit
shakeRemain = max(0, shakeRemain - ((1/shakeLength) * shakeMagnitude));
camera_set_view_pos(cam,x - viewWidthHalf, y - viewHeightHalf);