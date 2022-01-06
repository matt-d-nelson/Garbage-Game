/// @description Draw UI

draw_text(10,10,global.iCamera.y);
draw_text(10,30,global.iCamera.x);
draw_text(10,60,oDuke.path_position);





//Draw Items UI based on what is unlocked
if (!global.playerItemUnlocked[ITEM.BAG])
{
	draw_sprite(sItems1,global.playerEquipped,buffer,RESOLUTION_H-buffer);	
}

if (!global.playerItemUnlocked[ITEM.AXE] && global.playerItemUnlocked[ITEM.BAG])
{
	draw_sprite(sItems2,global.playerEquipped,buffer,RESOLUTION_H-buffer);	
}

if (!global.playerItemUnlocked[ITEM.WHIP] && global.playerItemUnlocked[ITEM.AXE])
{
	draw_sprite(sItems3,global.playerEquipped,buffer,RESOLUTION_H-buffer);	
}

if (!global.playerItemUnlocked[ITEM.BOMB] && global.playerItemUnlocked[ITEM.WHIP])
{
	draw_sprite(sItems4,global.playerEquipped,buffer,RESOLUTION_H-buffer);	
}

if (global.playerItemUnlocked[ITEM.BOMB])
{
	draw_sprite(sItems5,global.playerEquipped,buffer,RESOLUTION_H-buffer);	
}
