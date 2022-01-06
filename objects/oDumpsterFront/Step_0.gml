/// @description See through if player collision
if (place_meeting(x,y,oPlayer))
{
	invisible = max(0.5, (invisible - 0.1));
} else invisible = min(1, invisible + 0.1);

depth = -bbox_bottom;
