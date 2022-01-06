//Get Controller Input
keyLeft = keyboard_check(vk_left);
keyRight = keyboard_check(vk_right);
keyUp = keyboard_check(vk_up);
keyDown = keyboard_check(vk_down);
keyItem = keyboard_check_pressed(vk_space);
keyItemSelectLeft = keyboard_check_pressed(ord("X"));
keyItemSelectRight = keyboard_check_pressed(ord("C"));

inputDirection = point_direction(0,0,keyRight-keyLeft,keyDown-keyUp);
inputMagnitude = (keyRight-keyLeft != 0) || (keyDown-keyUp != 0);

if (!global.gamePaused) script_execute(state);
depth = -bbox_bottom;