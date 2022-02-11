/// @description Initialise & Globals
randomize();

global.gamePaused = false;

global.iCamera = instance_create_layer(0,0,layer,oCamera);
global.iUI = instance_create_layer(0,0,layer,oUI);
global.fntMain = fTextMain;

//Items
global.playerHasAnyItems = true;
global.playerEquipped = ITEM.NONE;
global.playerItemUnlocked = array_create(ITEM.TYPE_COUNT, false);
global.playerItemUnlocked[ITEM.NONE] = true;

//Player Values
global.playerSpeedWalk = 1.4;
global.playerGarbage = 0;
global.playerGather = 10;
global.playerAxe = 10;
global.playerBombAmmo = 3;


//Lifting
global.iLifted = noone;
global.dLifted = noone;

//Temp
global.playerItemUnlocked[ITEM.GLOVES] = true;
global.playerItemUnlocked[ITEM.BAG] = true;
global.playerItemUnlocked[ITEM.AXE] = true;
global.playerItemUnlocked[ITEM.WHIP] = true;
global.playerItemUnlocked[ITEM.BOMB] = true;

surface_resize(application_surface, RESOLUTION_W, RESOLUTION_H);
display_set_gui_size(GUI_RESOLUTION_W,GUI_RESOLUTION_H);
room_goto(ROOM_START)
