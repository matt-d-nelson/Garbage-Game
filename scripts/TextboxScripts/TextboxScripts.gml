function ScrSetDefaultsForText(){
	lineBreakPos[0, pageNumber] = 999;
	lineBreakNum[pageNumber] = 0;
	lineBreakOffset[pageNumber] = 0;
	
	//Variables for every letter/character
	for (var c = 0; c < 500; c++)
	{
		col1[c, pageNumber] = c_black;	
		col2[c, pageNumber] = c_black;	
		col3[c, pageNumber] = c_black;	
		col4[c, pageNumber] = c_black;	
		
		floatText[c, pageNumber] = false;
		floatDir[c, pageNumber] = c*20;
		
	}
	
	textboxSpr[pageNumber] = sTextBubble;
	emote[pageNumber] = -1;
}	

/// @param 1st_char
/// @param last_char
/// @param col1
/// @param col2
/// @param col3
/// @param col4
function ScrTextColor(_start,_end,_col1,_col2,_col3,_col4){
	
	for (var c = _start; c <= _end; c++)
	{
		col1[c, pageNumber-1] = _col1;
		col2[c, pageNumber-1] = _col2;
		col3[c, pageNumber-1] = _col3;
		col4[c, pageNumber-1] = _col4;
	}
		
}

/// @param 1st_char
/// @param last_char
function ScrTextFloat(_start,_end){
	
	for (var c = _start; c <= _end; c++)
	{
		floatText[c, pageNumber-1] = true;
	}
}

/// @param text
function ScrText(_text){
	ScrSetDefaultsForText();
	text[pageNumber] = _text;
	
	//Add emote
	if (argument_count > 1)
	{
		emote[pageNumber] = argument[1];
	}
	
	//Change TB sprite
	if (argument_count > 2)
	{
		textboxSpr[pageNumber] = sTextCloud;	
	}
	
	pageNumber++;
}

/// @param option
/// @param linkID
function ScrTextOption(_option, _linkID){
	option[optionNumber] = _option;
	optionLinkID[optionNumber] = _linkID;
	
	optionNumber++;
}

/// @param textID
function CreateTextbox(_textID,_speakerID,_stayInCam,_keepOtherTB){
	if (!instance_exists(oTextbox)) || (_keepOtherTB)
	{
		with(instance_create_depth(x,y,-9999,oTextbox))
		{
			switch(_speakerID)
			{
				case CHAR.DUKE:
					speakerID = CHAR.DUKE;
					speaker = oDuke;
					speakerName = "Duke";
					break;
				case CHAR.ZACH:
					speakerID = CHAR.ZACH;
					speaker = oPlayer;
					speakerName = "Zach";
					break;
			}
			//keep other TB X,Y if option
			if (argument_count > 4)
			{
				textboxX = other.textboxX;
				textboxY = other.textboxY;
			}
			else
			{
				textboxX = (speaker.x - textboxW/2);
				textboxY = (speaker.y-speaker.z) - (speaker.sprite_height+textboxH);
			}
			stayInCam = _stayInCam;
		
			GameText(_textID);
		}
	}
}

