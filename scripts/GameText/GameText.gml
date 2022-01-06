
function GameText(_textID){

switch(_textID)
{
	case "axe paper":
		ScrText("Woah Zach, you tryin' to chop up paper?",EMOTE.EXC);
			ScrTextColor(5,8,c_blue,c_fuchsia,c_lime,c_maroon);
		ScrText("I got a shredder at home. Do you want to borrow it?",EMOTE.QUEST);
			ScrTextOption("Yes", "axe paper - Yes");
			ScrTextOption("No", "axe paper - No");
		break;
		case "axe paper - Yes":
			ScrText("Solid, come on over after work.",EMOTE.LOVE);
				ScrTextFloat(0,5);
			break;
		case "axe paper - No":
			ScrText("Well shit, get back to work then!",EMOTE.HATE);
			break;
		
	case "axe paper desk":
		ScrText("Zach, you gotta clear that thing off before you go choppin away!");
		break;
		
	case "cant lift":
		ScrText("This is way to heavy to lift!",EMOTE.HATE,-1);
		break;
}
}