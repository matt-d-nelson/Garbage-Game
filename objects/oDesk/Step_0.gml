/// @description Change Image Index
if (entityGarbage > 50) image_index = 0;	

if (entityGarbage < 50) && (entityGarbage > 0) image_index = 1;

if (entityGarbage <= 0) 
{
	image_index = 2;
	entityAxable = true;
	entityBombArgs = [oDeskLeft,oDeskRight,-1,-1]
}

if (entityHP <=0)
{
	SplitIntoPieces(oDeskLeft,oDeskRight,-1,-1);
}

