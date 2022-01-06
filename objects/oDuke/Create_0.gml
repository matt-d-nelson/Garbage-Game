image_speed = 0;
path_speed = 1;

localFrame = 0;
animationEnd = false;
actionEnd = false;
activate = noone;
count = 0;

z = 0;
jumping = false;
jumpDistance = 0;
jumpDistanceTravelled = 0;
jumpPercent = 0;
colWidth = bbox_right-bbox_left;
colHeight = bbox_bottom-bbox_top;

spriteIdle = sDukeIdle;
spriteWalk = sDukeWalk;

animationState = DukeStateFollowSprites;
animationStatePrevious = DukeStateFollowSprites;
speedWalk = 1.25;

path = path_add();
targetX = oPlayer.x;
targetY = oPlayer.y;
alarm[0] = 1;
