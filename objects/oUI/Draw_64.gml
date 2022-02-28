/// @description Draw UI

draw_text(10,10,oCamera.zoomOut);
draw_text(10,30,oCamera.keyZoom);

//Draw Items UI based on what is unlocked
if (!global.playerItemUnlocked[ITEM.BAG])
{
	draw_sprite(sItems1,global.playerEquipped,buffer,GUI_RESOLUTION_H-buffer);	
}

if (!global.playerItemUnlocked[ITEM.AXE] && global.playerItemUnlocked[ITEM.BAG])
{
	draw_sprite(sItems2,global.playerEquipped,buffer,GUI_RESOLUTION_H-buffer);	
}

if (!global.playerItemUnlocked[ITEM.WHIP] && global.playerItemUnlocked[ITEM.AXE])
{
	draw_sprite(sItems3,global.playerEquipped,buffer,GUI_RESOLUTION_H-buffer);	
}

if (!global.playerItemUnlocked[ITEM.BOMB] && global.playerItemUnlocked[ITEM.WHIP])
{
	draw_sprite(sItems4,global.playerEquipped,buffer,GUI_RESOLUTION_H-buffer);	
}

if (global.playerItemUnlocked[ITEM.BOMB])
{
	draw_sprite(sItems5,global.playerEquipped,buffer,GUI_RESOLUTION_H-buffer);	
}
