if (!global.gamePaused)
{
//Progress text key
keyProgress = keyboard_check_pressed(vk_shift);

//Gradually update textbox position
xTo = speaker.x - textboxW/2;
yTo = (speaker.y-speaker.z) - (speaker.sprite_height+textboxH);

//Keep textbox inside camera
if (stayInCam)
{
	var _camX = camera_get_view_x(cam);
	var _camY = camera_get_view_y(cam);

	var _clampBord = 1;
	xTo = clamp(xTo, _camX+_clampBord, _camX + camW - textboxW-_clampBord);
	yTo = clamp(yTo, _camY+6+_clampBord, _camY + camH - textboxH-_clampBord); //+6 for speaker name bubble
}

//Update position
textboxX += (xTo - textboxX)/15;
textboxY += (yTo - textboxY)/15;

//Setup
if (setup == false)
{
	setup = true;
	draw_set_font(global.fntMain);
	draw_set_color(c_black);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	//loop through pages
	for(var p = 0; p < pageNumber; p++)
	{
		//find how many characters are on each page and store in textLength array
		textLength[p] = string_length(text[p]);
		
		//Indent text if there is an emote
		
		if (emote[p] != -1) 
		{
			textOffsetX[p] = 16; 
			lineW -= 16;
		} else textOffsetX[p] = 0;
		
		//Setting individual characters and where lines should break
		for (var c = 0; c < textLength[p]; c++)
		{
			var _charPos = c+1;
			
			//Store individual characters in the "char" array
			char[c, p] = string_char_at(text[p],_charPos);
			
			//Get current width of line
			var _textUpToChar = string_copy(text[p], 1, _charPos);
			var _currentTextW = string_width(_textUpToChar) - string_width(char[c,p]);
			
			//Get the last free space
			if (char[c,p] == " ") {lastFreeSpace = _charPos+1;}
			
			//Get the line breaks
			if (_currentTextW - lineBreakOffset[p] > lineW)
			{
				lineBreakPos[lineBreakNum[p], p] = lastFreeSpace;
				lineBreakNum[p]++;
				var _textUpToLastFreeSpace = string_copy(text[p], 1, lastFreeSpace);
				var _lastFreeSpaceString = string_char_at(text[p], lastFreeSpace);
				lineBreakOffset[p] = string_width(_textUpToLastFreeSpace) - string_width(_lastFreeSpaceString);
			}
		}
		
		//Getting each character's coordinates
		for (var c = 0; c < textLength[p]; c++)
		{
			var _charPos = c+1;

			
			//Get current width of line
			var _textUpToChar = string_copy(text[p], 1, _charPos);
			var _currentTextW = string_width(_textUpToChar) - string_width(char[c,p]);
			var _textLine = 0;
			
			//Compensate for line breaks
			for (var lb = 0; lb < lineBreakNum[p]; lb++)
			{
				if (_charPos >= lineBreakPos[lb, p])
				{
					var _strCopy = string_copy(text[p], lineBreakPos[lb,p], _charPos-lineBreakPos[lb,p]);
					_currentTextW = string_width(_strCopy);
					
					//Record the "line" this character should be on
					_textLine = lb+1; //+1 to compansate lb starting at 0
				}
			}
			
			//Add to x and y based on new info
			charX[c,p] = _currentTextW;
			charY[c,p] = _textLine*lineSep;
		}
	}
}

//Typing the text
if (textPauseTimer <= 0)
{
	if (drawChar < textLength[page])
	{
		drawChar += textSpd;
		drawChar = clamp(drawChar, 0, textLength[page]);
		var _checkChar = string_char_at(text[page], drawChar);
		if _checkChar == "." || _checkChar == "?" || _checkChar == "!" || _checkChar == ","
		{
			textPauseTimer = textPauseTime;	
		}
	}
} else textPauseTimer--;

//Flip through pages
if (keyProgress)
{
	//If the typing is done
	if (drawChar == textLength[page])
	{
		//Next page
		if (page < pageNumber-1)
		{
			page++;
			drawChar = 0;
		}
		//Destroy textbox
		else
		{
			//Link text for options
			if (optionNumber > 0)
			{
				CreateTextbox(optionLinkID[optionPos], speakerID, stayInCam, true, -1);
			}
			with (oPlayer)
			{
				if (state = PlayerStateFreeze) state = statePrevious;
			}
			instance_destroy();
		}
	}
	//If not done typing
	else
	{
		drawChar = textLength[page];	
	}
}
}