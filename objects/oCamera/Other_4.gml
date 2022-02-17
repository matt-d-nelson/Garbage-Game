/// @description Position/Cam Zoom

if (global.outside = true) 
{
	zoomOut = true;
} else 
{
	camW = 320;
	camH = 180;
	viewWidthHalf = 320 * 0.5;
	viewHeightHalf = 180 * 0.5;
	camera_set_view_size(cam,camW,camH);
}

if (instance_exists(oPlayer))
{
	x = follow.x;
	y = follow.y - viewHeightHalf/2;
}

