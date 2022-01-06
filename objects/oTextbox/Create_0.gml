depth = -9999;

//Textbox parameters
textboxW = 160;
textboxH = 40;
border = 12;
lineSep = 12;
lineW = textboxW - border*2;

textboxImage = 0;

//Text
page = 0;
pageNumber = 0;
text[0] = "";
textLength[0] = string_length(text[0]);
char[0,0] = "";
charX[0,0] = 0;
charY[0,0] = 0;
drawChar = 0;
textSpd = 0.5;

//Options
option[0] = "";
optionLinkID[0] = -1;
optionPos = 0;
optionNumber = 0;
optionSpr = sTextOption;

setup = false;

//Text effects
ScrSetDefaultsForText();
lastFreeSpace = 0;
textPauseTimer = 0;
textPauseTime = 16;

//Emote Effects
emoteWave = 1;

//Speaker
speakerID = noone;
speaker = noone;
speakerName = "";
speakerNameW = 0;

//Position
textboxX = x;
textboxY = y;
xTo = xstart;
yTo = ystart;
stayInCam = false;

cam = view_camera[0];
camW = RESOLUTION_W;
camH = RESOLUTION_H;