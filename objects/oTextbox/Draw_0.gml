//Draw the textbox

//Back of the textbox
draw_sprite_ext(textboxSpr[page], textboxImage, textboxX, textboxY, textboxW/32, textboxH/32, 0, c_white, 1); //32 is sprite width of Text bubble

//Options
if (drawChar == textLength[page]) && (page == pageNumber - 1)
{
	//Freeze player if there are options
	if (optionNumber > 0) && instance_exists(oPlayer)
	{
		with (oPlayer)
		{
			if (state != PlayerStateFreeze)
			{
				statePrevious = state;
				state = PlayerStateFreeze;
			}
		}
	}
	
	//Option selection
	if (!global.gamePaused) optionPos += keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
	optionPos = clamp(optionPos, 0, optionNumber-1);
	
	var _opSpace = 15;
	var _opBord = 4;
	for (var op = 0; op < optionNumber; op++)
	{
		//Draw option box highlighted if selected
		var _opW = string_width(option[op]) + _opBord*2;
		
		if (optionPos == op)
		{
			draw_sprite_ext(optionSpr, 1, (textboxX+16), (textboxY+textboxH+1+(_opSpace*op)), (_opW-1)/12, (_opSpace-1)/12, 0, c_white, 1); //12 is sprite width of option sprite
		}	
		else
		{
			draw_sprite_ext(optionSpr, 0, (textboxX+16), (textboxY+textboxH+1+(_opSpace*op)), (_opW-1)/12, (_opSpace-1)/12, 0, c_white, 1);	
		}	
		
		//Draw option text
		draw_text((textboxX+16+_opBord), (textboxY+textboxH+(_opSpace*op)), option[op]);
		
	}
}

//Draw Emote
if (emote[page] != -1)
{
	var _emoteX = textboxX + 16;
	var _emoteY = textboxY + textboxH/2;
	if (emote[page] = EMOTE.EXC)
	{
		emoteWave = max(1,sin(get_timer()*0.0000025*pi)*1.5);
		draw_sprite_ext(sEmote,0,_emoteX,_emoteY,emoteWave,emoteWave,0,c_white,1);
	}
	if (emote[page] = EMOTE.QUEST)
	{
		emoteWave = sin(get_timer()*0.000001*pi)*2
		var _emoteWave2 = sin(get_timer()*0.000002*pi)*2
		draw_sprite_ext(sEmote,1,floor(_emoteX+emoteWave),floor(_emoteY+_emoteWave2),1,1,emoteWave,c_white,1)
	}
	if (emote[page] = EMOTE.HATE)
	{
		draw_sprite_ext(sEmote,2,_emoteX+random_range(-2,2),_emoteY+random_range(-2,2),emoteWave,emoteWave,0,c_white,1);
	}
	if (emote[page] = EMOTE.LOVE)
	{
		emoteWave = max(1,sin(get_timer()*0.000001*pi)*1.25);
		var _emoteWave3 = abs(sin(get_timer()*0.0000005*pi));
		draw_sprite_ext(sEmote,3,_emoteX,_emoteY,emoteWave,emoteWave,0,c_white,_emoteWave3);
	}
}

//Back of speaker textbox 
if (speakerName != "none")
{
	var _nameBord = 4;
	speakerNameW = string_width(speakerName) + _nameBord*2;
	draw_sprite_ext(sTextSpeaker,0,(textboxX+16),(textboxY-6),(speakerNameW-1)/12,14/12,0,c_white,1); //Magic numbers for TextSpeaker bubble sprite dimentions (unlikely to change)

	//Draw speaker name
	draw_text((textboxX+16+_nameBord),(textboxY-7),speakerName);
}

//Draw the text and calculate effects
for (var c = 0; c < drawChar; c++)
{
	//Special effects
	//Floating text
	var _floatY = 0;
	if (floatText[c, page] == true)
	{
		floatDir[c,page] -= 6;
		_floatY = dsin(floatDir[c,page]);
	}

	//Draw text
	var _textX = textboxX+border+textOffsetX[page];
	var _textY = (textboxY+border/2)+_floatY;
	draw_text_color(charX[c,page]+_textX, charY[c,page]+_textY, char[c,page], col1[c,page], col2[c,page], col3[c,page], col4[c,page], 1);	
}