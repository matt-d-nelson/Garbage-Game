/// @description Zoom key
keyZoom = keyboard_check_pressed(ord("Z"));

if (keyZoom) {
	if (global.outside) {
		if (zoomOut) {zoomOut = false;} else {zoomOut = true;}
	} else {
		ScreenShake(4,3);	
	}
} 