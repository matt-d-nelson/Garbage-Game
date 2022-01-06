/// @description Change Image Index
if (entityGarbage > 50)
{
	image_index = 0;	
}
else image_index = 1;

if (entityGarbage <= 0) instance_destroy();