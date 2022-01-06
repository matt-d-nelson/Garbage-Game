//Whip (before player)
if (state == PlayerWhip) && (CARDINAL_DIR == 1) DrawWhip(6,-6,90,0);

draw_sprite_ext(
	sprite_index,
	image_index,
	floor(x),
	floor(y-z),
	image_xscale,
	image_yscale,
	image_angle,
	image_blend,
	image_alpha);
	
//Whip (after player)
if (state == PlayerWhip) && (CARDINAL_DIR != 1)
{
	switch (CARDINAL_DIR)
	{
		case 0: DrawWhip(-3,-9,0,1); break;
		case 2: DrawWhip(-11,-9,0,0); break;
		case 3: DrawWhip(-7,-6,270,1); break;
	} 
}

