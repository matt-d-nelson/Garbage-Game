/// @description Initialize camera

//Set view size
camW = 320;
camH = 180;
viewWidthHalf = 320 * 0.5;
viewHeightHalf = 180 * 0.5;
camera_set_view_size(cam,camW,camH);

//Set position
if (instance_exists(oPlayer))
{
	x = follow.x;
	y = follow.y - viewHeightHalf/2;
}

