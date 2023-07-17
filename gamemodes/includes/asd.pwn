// Login/Register
#define         DIALOG_INSERT_USERNAME      (5160)
#define         DIALOG_INSERT_PASSWORD      (5161)

// Login/Register
#define			PLCHECKUSERNAME					25
#define			PLCHECKPASSWORD					26
#define			PLCHECKREGISTER					27

// Login/Register
new Text:LR_Main[42];
new Text:LR_LoginRegister[14][MAX_PLAYERS];
new Text:LR_Updates[10];
new Text:LR_Events[10];
new Text:LR_Credits[10];
enum PlayerLoginData
{
	PLUsername[32],
	PLPassword[32],
	PLSelecting
}
new PLInfo[MAX_PLAYERS][PlayerLoginData];

// Login/Register
		case LOGIN_THREAD:
		{
			for(new i;i < rows;i++)
			{
				new
					szPass[129],
					szResult[129],
					szBuffer[129],
					szEmail[256];

				cache_get_field_content(i, "Username", szResult, MainPipeline);
				if(strcmp(szResult, GetPlayerNameExt(extraid), true) != 0)
				{
					//g_mysql_AccountAuthCheck(extraid);
					return 1;
				}

				cache_get_field_content(i, "Email", szEmail, MainPipeline);
				cache_get_field_content(i, "Key", szResult, MainPipeline);
				GetPVarString(extraid, "PassAuth", szBuffer, sizeof(szBuffer));
				WP_Hash(szPass, sizeof(szPass), szBuffer);

				if(isnull(szEmail)) SetPVarInt(extraid, "NullEmail", 1);

				if((isnull(szPass)) || (isnull(szResult)) || (strcmp(szPass, szResult) != 0))
				{
					// Invalid Password - Try Again!
					//ShowMainMenuDialog(extraid, 3);
					HideNoticeGUIFrame(extraid);
					/*if(++gPlayerLogTries[extraid] == 2)
					{
						SendClientMessage(extraid, COLOR_RED, "{AA3333}M26:RP System{FFFFFF}: Sai mat khau, ban tu dong bi kich ra khoi may chu.");
						Kick(extraid);
					}*/
					return 1;
				}
				DeletePVar(extraid, "PassAuth");
				break;
			}
			HideNoticeGUIFrame(extraid);
			//g_mysql_LoadAccount(extraid);
			return 1;
		}
		case PLCHECKUSERNAME:
		{
		    new name[24];
			for(new i;i < rows;i++)
			{
				cache_get_field_content(i, "Username", name, MainPipeline, MAX_PLAYER_NAME);
				if(strcmp(name, PLInfo[extraid][PLUsername], true) == 0)
				{
					LRFuckThatShit(extraid, 2);
					return 1;
				}
			}
		 	TextDrawSetString(LR_LoginRegister[13][extraid], "~r~Ten nhan vat khong ton tai !");
		 	return 1;
		}
		case PLCHECKREGISTER:
		{
		    new name[24];
			for(new i;i < rows;i++)
			{
				cache_get_field_content(i, "Username", name, MainPipeline, MAX_PLAYER_NAME);
				if(strcmp(name, PLInfo[extraid][PLUsername], true) == 0)
				{
					TextDrawSetString(LR_LoginRegister[13][extraid], "~r~Ten nhan vat da ton tai !");
					return 1;
				}
			}
   			TextDrawSetString(LR_LoginRegister[13][extraid], "~g~Dang ky thanh cong !");
  			g_mysql_CreateAccount(extraid, PLInfo[extraid][PLPassword]);
  			return 1;
		}
		case PLCHECKPASSWORD:
		{
			for(new i;i < rows;i++)
			{
				new
					szPass[129],
					szResult[129];
				cache_get_field_content(i, "Key", szResult, MainPipeline);
				WP_Hash(szPass, sizeof(szPass), PLInfo[extraid][PLPassword]);
				if((strcmp(szPass, szResult) != 0))
				{
					TextDrawSetString(LR_LoginRegister[13][extraid], "~r~Sai mat khau !");
					return 1;
				}
			}
			SetPlayerName(extraid, PLInfo[extraid][PLUsername]);
			g_mysql_LoadAccount(extraid);
			LoginRegisterTextDraws(extraid, 7);
   			return 1;
		}

// Login/Register
stock g_mysql_AccountLoginCheck(playerid)
{
	//ShowNoticeGUIFrame(playerid, 2);

	new string[128];

	format(string, sizeof(string), "SELECT `Username`,`Key`,`Email` from accounts WHERE Username = '%s'", GetPlayerNameExt(playerid));
	mysql_function_query(MainPipeline, string, true, "OnQueryFinish", "iii", LOGIN_THREAD, playerid, g_arrQueryHandle{playerid});
	return 1;
}

// Login/Register
stock g_mysql_CreateAccount(playerid, accountPassword[])
{
	new string[256];
	new passbuffer[129];
	WP_Hash(passbuffer, sizeof(passbuffer), accountPassword);

	format(string, sizeof(string), "INSERT INTO `accounts` ( `Username`, `Key`) VALUES ('%s','%s')", PLInfo[playerid][PLUsername], passbuffer);
	mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "iii", REGISTER_THREAD, playerid, g_arrQueryHandle{playerid});
	return 1;
}

// OnPlayerClickTextDraw
// Login/Register
    if(_:clickedid != INVALID_TEXT_DRAW)
    {
    	if(clickedid == LR_Main[26]) PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0), SetTimerEx("LoginRegisterTextDraws", 90, false, "ii", playerid, 2), LoginRegisterTextDraws(playerid, 9);
    	else if(clickedid == LR_Main[27]) PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0), SetTimerEx("LoginRegisterTextDraws", 90, false, "ii", playerid, 3), LoginRegisterTextDraws(playerid, 9);
    	else if(clickedid == LR_Main[28]) PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0), SetTimerEx("LoginRegisterTextDraws", 90, false, "ii", playerid, 4), LoginRegisterTextDraws(playerid, 9);
    	else if(clickedid == LR_Main[29]) PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0), SetTimerEx("LoginRegisterTextDraws", 90, false, "ii", playerid, 5), LoginRegisterTextDraws(playerid, 9);
    	else if(clickedid == LR_Main[30]) PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0), SetTimerEx("LoginRegisterTextDraws", 90, false, "ii", playerid, 6), LoginRegisterTextDraws(playerid, 9);
    	else if(clickedid == LR_Main[31]) PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0), SetTimerEx("KickEx", 850, 0, "i", playerid), SetTimerEx("LoginRegisterTextDraws", 90, false, "ii", playerid, 7), LoginRegisterTextDraws(playerid, 9);
        else if(clickedid == LR_LoginRegister[6][playerid])
        {
            if(PLInfo[playerid][PLSelecting] == 1)
            {
	            PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
	            ShowPlayerDialog(playerid, DIALOG_INSERT_USERNAME, DIALOG_STYLE_INPUT,"{ff0000}Dang nhap","Hay ghi ten nhan vat cua ban vao day.\nTen nhan vat phai dai tu 3-24 ky tu.","Chap nhan","Thoat");
			}
			else if(PLInfo[playerid][PLSelecting] == 2)
			{
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
	            ShowPlayerDialog(playerid, DIALOG_INSERT_USERNAME, DIALOG_STYLE_INPUT,"{ff0000}Dang ky","Hay ghi ten nhan vat cua ban vao day.\nTen nhan vat phai dai tu 3-24 ky tu.","Chap nhan","Thoat");
			}
		}
        else if(clickedid == LR_LoginRegister[7][playerid])
        {
            if(PLInfo[playerid][PLSelecting] == 1)
            {
	            PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
            	ShowPlayerDialog(playerid, DIALOG_INSERT_PASSWORD, DIALOG_STYLE_PASSWORD,"{ff0000}Dang nhap","Hay ghi mat khau cua ban vao day.\nMat khau phai dai tu 6-24 ky tu.","Chap nhan","Thoat");
			}
			else if(PLInfo[playerid][PLSelecting] == 2)
			{
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
	            ShowPlayerDialog(playerid, DIALOG_INSERT_PASSWORD, DIALOG_STYLE_PASSWORD,"{ff0000}Dang ky","Hay ghi mat khau cua ban vao day.\nMat khau phai dai tu 6-24 ky tu.","Chap nhan","Thoat");
			}
        }
        else if(clickedid == LR_LoginRegister[12][playerid])
        {
            if(PLInfo[playerid][PLSelecting] == 1)
            {
                PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
                if(~strfind(PLInfo[playerid][PLUsername], "NONE")) return TextDrawSetString(LR_LoginRegister[13][playerid], "~r~Hay nhap ten nhan vat !");
				if(~strfind(PLInfo[playerid][PLPassword], "NONE")) return TextDrawSetString(LR_LoginRegister[13][playerid], "~r~Hay nhap mat khau !");
				LRFuckThatShit(playerid, 1);
			}
			else if(PLInfo[playerid][PLSelecting] == 2)
			{
			    PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			    if(~strfind(PLInfo[playerid][PLUsername], "NONE")) return TextDrawSetString(LR_LoginRegister[13][playerid], "~r~Hay nhap ten nhan vat !");
				if(~strfind(PLInfo[playerid][PLPassword], "NONE")) return TextDrawSetString(LR_LoginRegister[13][playerid], "~r~Hay nhap mat khau !");
				LRFuckThatShit(playerid, 3);
			}
        }
	}

// OnPlayerConnect
// Login/Register
    format(PLInfo[playerid][PLUsername], 100, "NONE");
	format(PLInfo[playerid][PLPassword], 100, "NONE");
	TextDrawSetString(LR_LoginRegister[8][playerid], "Ten nhan vat");
	TextDrawSetString(LR_LoginRegister[9][playerid], "]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]");

// LoadTextDraws
    // Login/Register
	LR_Main[0] = TextDrawCreate(210.000000, 115.000000, "_");
	TextDrawBackgroundColor(LR_Main[0], 255);
	TextDrawFont(LR_Main[0], 1);
	TextDrawLetterSize(LR_Main[0], 0.500000, 0.999998);
	TextDrawColor(LR_Main[0], -1);
	TextDrawSetOutline(LR_Main[0], 0);
	TextDrawSetProportional(LR_Main[0], 1);
	TextDrawSetShadow(LR_Main[0], 1);
	TextDrawUseBox(LR_Main[0], 1);
	TextDrawBoxColor(LR_Main[0], -16777116);
	TextDrawTextSize(LR_Main[0], 444.000000, 18.000000);
	TextDrawSetSelectable(LR_Main[0], 0);

	LR_Main[1] = TextDrawCreate(210.000000, 121.000000, "_");
	TextDrawBackgroundColor(LR_Main[1], 255);
	TextDrawFont(LR_Main[1], 1);
	TextDrawLetterSize(LR_Main[1], 0.500000, 0.299998);
	TextDrawColor(LR_Main[1], -1);
	TextDrawSetOutline(LR_Main[1], 0);
	TextDrawSetProportional(LR_Main[1], 1);
	TextDrawSetShadow(LR_Main[1], 1);
	TextDrawUseBox(LR_Main[1], 1);
	TextDrawBoxColor(LR_Main[1], -16777116);
	TextDrawTextSize(LR_Main[1], 444.000000, 18.000000);
	TextDrawSetSelectable(LR_Main[1], 0);

	LR_Main[2] = TextDrawCreate(210.000000, 128.000000, "_");
	TextDrawBackgroundColor(LR_Main[2], 255);
	TextDrawFont(LR_Main[2], 1);
	TextDrawLetterSize(LR_Main[2], 0.500000, 25.299999);
	TextDrawColor(LR_Main[2], -1);
	TextDrawSetOutline(LR_Main[2], 0);
	TextDrawSetProportional(LR_Main[2], 1);
	TextDrawSetShadow(LR_Main[2], 1);
	TextDrawUseBox(LR_Main[2], 1);
	TextDrawBoxColor(LR_Main[2], -1);
	TextDrawTextSize(LR_Main[2], 444.000000, 18.000000);
	TextDrawSetSelectable(LR_Main[2], 0);

	LR_Main[3] = TextDrawCreate(210.500000, 128.000000, "_");
	TextDrawBackgroundColor(LR_Main[3], 255);
	TextDrawFont(LR_Main[3], 1);
	TextDrawLetterSize(LR_Main[3], 0.500000, 25.199998);
	TextDrawColor(LR_Main[3], -1);
	TextDrawSetOutline(LR_Main[3], 0);
	TextDrawSetProportional(LR_Main[3], 1);
	TextDrawSetShadow(LR_Main[3], 1);
	TextDrawUseBox(LR_Main[3], 1);
	TextDrawBoxColor(LR_Main[3], 255);
	TextDrawTextSize(LR_Main[3], 443.000000, 18.000000);
	TextDrawSetSelectable(LR_Main[3], 0);

	LR_Main[4] = TextDrawCreate(327.000000, 112.000000, "~w~M26:RP - Main menu");
	TextDrawAlignment(LR_Main[4], 2);
	TextDrawBackgroundColor(LR_Main[4], 255);
	TextDrawFont(LR_Main[4], 2);
	TextDrawLetterSize(LR_Main[4], 0.270000, 1.500000);
	TextDrawColor(LR_Main[4], -26);
	TextDrawSetOutline(LR_Main[4], 0);
	TextDrawSetProportional(LR_Main[4], 1);
	TextDrawSetShadow(LR_Main[4], 1);
	TextDrawSetSelectable(LR_Main[4], 0);

	LR_Main[5] = TextDrawCreate(217.500000, 137.000000, "__");
	TextDrawBackgroundColor(LR_Main[5], 255);
	TextDrawFont(LR_Main[5], 1);
	TextDrawLetterSize(LR_Main[5], 0.490000, 2.699999);
	TextDrawColor(LR_Main[5], -1);
	TextDrawSetOutline(LR_Main[5], 0);
	TextDrawSetProportional(LR_Main[5], 1);
	TextDrawSetShadow(LR_Main[5], 1);
	TextDrawUseBox(LR_Main[5], 1);
	TextDrawBoxColor(LR_Main[5], -241);
	TextDrawTextSize(LR_Main[5], 436.000000, 18.000000);
	TextDrawSetSelectable(LR_Main[5], 0);

	LR_Main[6] = TextDrawCreate(217.500000, 176.000000, "__");
	TextDrawBackgroundColor(LR_Main[6], 255);
	TextDrawFont(LR_Main[6], 1);
	TextDrawLetterSize(LR_Main[6], 0.490000, 14.500000);
	TextDrawColor(LR_Main[6], -1);
	TextDrawSetOutline(LR_Main[6], 0);
	TextDrawSetProportional(LR_Main[6], 1);
	TextDrawSetShadow(LR_Main[6], 1);
	TextDrawUseBox(LR_Main[6], 1);
	TextDrawBoxColor(LR_Main[6], -241);
	TextDrawTextSize(LR_Main[6], 289.000000, 18.000000);
	TextDrawSetSelectable(LR_Main[6], 0);

	LR_Main[7] = TextDrawCreate(297.500000, 176.000000, "__");
	TextDrawBackgroundColor(LR_Main[7], 255);
	TextDrawFont(LR_Main[7], 1);
	TextDrawLetterSize(LR_Main[7], 0.490000, 14.499996);
	TextDrawColor(LR_Main[7], -1);
	TextDrawSetOutline(LR_Main[7], 0);
	TextDrawSetProportional(LR_Main[7], 1);
	TextDrawSetShadow(LR_Main[7], 1);
	TextDrawUseBox(LR_Main[7], 1);
	TextDrawBoxColor(LR_Main[7], -241);
	TextDrawTextSize(LR_Main[7], 436.000000, 18.000000);
	TextDrawSetSelectable(LR_Main[7], 0);

	LR_Main[8] = TextDrawCreate(217.000000, 135.000000, "~w~Chao mung den voi M26:Gaming Roleplay.~n~Day la main menu chinh duy nhat tai may chu.~n~Hay~g~ Dang nhap~w~ hoac ~g~Dang ky");
	TextDrawBackgroundColor(LR_Main[8], 255);
	TextDrawFont(LR_Main[8], 2);
	TextDrawLetterSize(LR_Main[8], 0.189999, 1.000000);
	TextDrawColor(LR_Main[8], -26);
	TextDrawSetOutline(LR_Main[8], 0);
	TextDrawSetProportional(LR_Main[8], 1);
	TextDrawSetShadow(LR_Main[8], 1);
	TextDrawSetSelectable(LR_Main[8], 0);

	LR_Main[9] = TextDrawCreate(217.500000, 170.000000, "__");
	TextDrawBackgroundColor(LR_Main[9], 255);
	TextDrawFont(LR_Main[9], 1);
	TextDrawLetterSize(LR_Main[9], 0.490000, -0.200000);
	TextDrawColor(LR_Main[9], -1);
	TextDrawSetOutline(LR_Main[9], 0);
	TextDrawSetProportional(LR_Main[9], 1);
	TextDrawSetShadow(LR_Main[9], 1);
	TextDrawUseBox(LR_Main[9], 1);
	TextDrawBoxColor(LR_Main[9], 16711730);
	TextDrawTextSize(LR_Main[9], 436.000000, 18.000000);
	TextDrawSetSelectable(LR_Main[9], 0);

	LR_Main[10] = TextDrawCreate(220.500000, 180.000000, "___");
	TextDrawBackgroundColor(LR_Main[10], 255);
	TextDrawFont(LR_Main[10], 1);
	TextDrawLetterSize(LR_Main[10], 0.490000, 1.800001);
	TextDrawColor(LR_Main[10], -1);
	TextDrawSetOutline(LR_Main[10], 0);
	TextDrawSetProportional(LR_Main[10], 1);
	TextDrawSetShadow(LR_Main[10], 1);
	TextDrawUseBox(LR_Main[10], 1);
	TextDrawBoxColor(LR_Main[10], -156);
	TextDrawTextSize(LR_Main[10], 286.000000, 18.000000);
	TextDrawSetSelectable(LR_Main[10], 0);

	LR_Main[11] = TextDrawCreate(220.500000, 190.000000, "___");
	TextDrawBackgroundColor(LR_Main[11], 255);
	TextDrawFont(LR_Main[11], 1);
	TextDrawLetterSize(LR_Main[11], 0.490000, 0.700001);
	TextDrawColor(LR_Main[11], -1);
	TextDrawSetOutline(LR_Main[11], 0);
	TextDrawSetProportional(LR_Main[11], 1);
	TextDrawSetShadow(LR_Main[11], 1);
	TextDrawUseBox(LR_Main[11], 1);
	TextDrawBoxColor(LR_Main[11], -156);
	TextDrawTextSize(LR_Main[11], 286.000000, 18.000000);
	TextDrawSetSelectable(LR_Main[11], 0);

	LR_Main[12] = TextDrawCreate(220.500000, 206.000000, "___");
	TextDrawBackgroundColor(LR_Main[12], 255);
	TextDrawFont(LR_Main[12], 1);
	TextDrawLetterSize(LR_Main[12], 0.490000, 1.800001);
	TextDrawColor(LR_Main[12], -1);
	TextDrawSetOutline(LR_Main[12], 0);
	TextDrawSetProportional(LR_Main[12], 1);
	TextDrawSetShadow(LR_Main[12], 1);
	TextDrawUseBox(LR_Main[12], 1);
	TextDrawBoxColor(LR_Main[12], -156);
	TextDrawTextSize(LR_Main[12], 286.000000, 18.000000);
	TextDrawSetSelectable(LR_Main[12], 0);

	LR_Main[13] = TextDrawCreate(220.500000, 216.000000, "___");
	TextDrawBackgroundColor(LR_Main[13], 255);
	TextDrawFont(LR_Main[13], 1);
	TextDrawLetterSize(LR_Main[13], 0.490000, 0.700001);
	TextDrawColor(LR_Main[13], -1);
	TextDrawSetOutline(LR_Main[13], 0);
	TextDrawSetProportional(LR_Main[13], 1);
	TextDrawSetShadow(LR_Main[13], 1);
	TextDrawUseBox(LR_Main[13], 1);
	TextDrawBoxColor(LR_Main[13], -156);
	TextDrawTextSize(LR_Main[13], 286.000000, 18.000000);
	TextDrawSetSelectable(LR_Main[13], 0);

	LR_Main[14] = TextDrawCreate(220.500000, 232.000000, "___");
	TextDrawBackgroundColor(LR_Main[14], 255);
	TextDrawFont(LR_Main[14], 1);
	TextDrawLetterSize(LR_Main[14], 0.490000, 1.800001);
	TextDrawColor(LR_Main[14], -1);
	TextDrawSetOutline(LR_Main[14], 0);
	TextDrawSetProportional(LR_Main[14], 1);
	TextDrawSetShadow(LR_Main[14], 1);
	TextDrawUseBox(LR_Main[14], 1);
	TextDrawBoxColor(LR_Main[14], -156);
	TextDrawTextSize(LR_Main[14], 286.000000, 18.000000);
	TextDrawSetSelectable(LR_Main[14], 0);

	LR_Main[15] = TextDrawCreate(220.500000, 242.000000, "___");
	TextDrawBackgroundColor(LR_Main[15], 255);
	TextDrawFont(LR_Main[15], 1);
	TextDrawLetterSize(LR_Main[15], 0.490000, 0.700001);
	TextDrawColor(LR_Main[15], -1);
	TextDrawSetOutline(LR_Main[15], 0);
	TextDrawSetProportional(LR_Main[15], 1);
	TextDrawSetShadow(LR_Main[15], 1);
	TextDrawUseBox(LR_Main[15], 1);
	TextDrawBoxColor(LR_Main[15], -156);
	TextDrawTextSize(LR_Main[15], 286.000000, 18.000000);
	TextDrawSetSelectable(LR_Main[15], 0);

	LR_Main[16] = TextDrawCreate(220.500000, 258.000000, "___");
	TextDrawBackgroundColor(LR_Main[16], 255);
	TextDrawFont(LR_Main[16], 1);
	TextDrawLetterSize(LR_Main[16], 0.490000, 1.800001);
	TextDrawColor(LR_Main[16], -1);
	TextDrawSetOutline(LR_Main[16], 0);
	TextDrawSetProportional(LR_Main[16], 1);
	TextDrawSetShadow(LR_Main[16], 1);
	TextDrawUseBox(LR_Main[16], 1);
	TextDrawBoxColor(LR_Main[16], -156);
	TextDrawTextSize(LR_Main[16], 286.000000, 18.000000);
	TextDrawSetSelectable(LR_Main[16], 0);

	LR_Main[17] = TextDrawCreate(220.500000, 268.000000, "___");
	TextDrawBackgroundColor(LR_Main[17], 255);
	TextDrawFont(LR_Main[17], 1);
	TextDrawLetterSize(LR_Main[17], 0.490000, 0.700001);
	TextDrawColor(LR_Main[17], -1);
	TextDrawSetOutline(LR_Main[17], 0);
	TextDrawSetProportional(LR_Main[17], 1);
	TextDrawSetShadow(LR_Main[17], 1);
	TextDrawUseBox(LR_Main[17], 1);
	TextDrawBoxColor(LR_Main[17], -156);
	TextDrawTextSize(LR_Main[17], 286.000000, 18.000000);
	TextDrawSetSelectable(LR_Main[17], 0);

	LR_Main[18] = TextDrawCreate(220.500000, 285.000000, "___");
	TextDrawBackgroundColor(LR_Main[18], 255);
	TextDrawFont(LR_Main[18], 1);
	TextDrawLetterSize(LR_Main[18], 0.490000, 1.800001);
	TextDrawColor(LR_Main[18], -1);
	TextDrawSetOutline(LR_Main[18], 0);
	TextDrawSetProportional(LR_Main[18], 1);
	TextDrawSetShadow(LR_Main[18], 1);
	TextDrawUseBox(LR_Main[18], 1);
	TextDrawBoxColor(LR_Main[18], -156);
	TextDrawTextSize(LR_Main[18], 286.000000, 18.000000);
	TextDrawSetSelectable(LR_Main[18], 0);

	LR_Main[19] = TextDrawCreate(220.500000, 295.000000, "___");
	TextDrawBackgroundColor(LR_Main[19], 255);
	TextDrawFont(LR_Main[19], 1);
	TextDrawLetterSize(LR_Main[19], 0.490000, 0.700001);
	TextDrawColor(LR_Main[19], -1);
	TextDrawSetOutline(LR_Main[19], 0);
	TextDrawSetProportional(LR_Main[19], 1);
	TextDrawSetShadow(LR_Main[19], 1);
	TextDrawUseBox(LR_Main[19], 1);
	TextDrawBoxColor(LR_Main[19], -156);
	TextDrawTextSize(LR_Main[19], 286.000000, 18.000000);
	TextDrawSetSelectable(LR_Main[19], 0);

	LR_Main[20] = TextDrawCreate(217.500000, 316.000000, "__");
	TextDrawBackgroundColor(LR_Main[20], 255);
	TextDrawFont(LR_Main[20], 1);
	TextDrawLetterSize(LR_Main[20], 0.490000, 3.349998);
	TextDrawColor(LR_Main[20], -1);
	TextDrawSetOutline(LR_Main[20], 0);
	TextDrawSetProportional(LR_Main[20], 1);
	TextDrawSetShadow(LR_Main[20], 1);
	TextDrawUseBox(LR_Main[20], 1);
	TextDrawBoxColor(LR_Main[20], -241);
	TextDrawTextSize(LR_Main[20], 289.000000, 18.000000);
	TextDrawSetSelectable(LR_Main[20], 0);

	LR_Main[21] = TextDrawCreate(220.500000, 320.000000, "___");
	TextDrawBackgroundColor(LR_Main[21], 255);
	TextDrawFont(LR_Main[21], 1);
	TextDrawLetterSize(LR_Main[21], 0.490000, 2.400001);
	TextDrawColor(LR_Main[21], -1);
	TextDrawSetOutline(LR_Main[21], 0);
	TextDrawSetProportional(LR_Main[21], 1);
	TextDrawSetShadow(LR_Main[21], 1);
	TextDrawUseBox(LR_Main[21], 1);
	TextDrawBoxColor(LR_Main[21], -156);
	TextDrawTextSize(LR_Main[21], 286.000000, 18.000000);
	TextDrawSetSelectable(LR_Main[21], 0);

	LR_Main[22] = TextDrawCreate(220.500000, 333.000000, "___");
	TextDrawBackgroundColor(LR_Main[22], 255);
	TextDrawFont(LR_Main[22], 1);
	TextDrawLetterSize(LR_Main[22], 0.490000, 0.900000);
	TextDrawColor(LR_Main[22], -1);
	TextDrawSetOutline(LR_Main[22], 0);
	TextDrawSetProportional(LR_Main[22], 1);
	TextDrawSetShadow(LR_Main[22], 1);
	TextDrawUseBox(LR_Main[22], 1);
	TextDrawBoxColor(LR_Main[22], -156);
	TextDrawTextSize(LR_Main[22], 286.000000, 18.000000);
	TextDrawSetSelectable(LR_Main[22], 0);

	LR_Main[23] = TextDrawCreate(299.000000, 185.000000, "ld_pool:ball");
	TextDrawBackgroundColor(LR_Main[23], 255);
	TextDrawFont(LR_Main[23], 4);
	TextDrawLetterSize(LR_Main[23], 0.500000, 1.000000);
	TextDrawColor(LR_Main[23], -156);
	TextDrawSetOutline(LR_Main[23], 0);
	TextDrawSetProportional(LR_Main[23], 1);
	TextDrawSetShadow(LR_Main[23], 1);
	TextDrawUseBox(LR_Main[23], 1);
	TextDrawBoxColor(LR_Main[23], 255);
	TextDrawTextSize(LR_Main[23], 5.000000, 5.000000);
	TextDrawSetSelectable(LR_Main[23], 0);

	LR_Main[24] = TextDrawCreate(297.489990, 316.000000, "__");
	TextDrawBackgroundColor(LR_Main[24], 255);
	TextDrawFont(LR_Main[24], 1);
	TextDrawLetterSize(LR_Main[24], 0.490000, 3.349998);
	TextDrawColor(LR_Main[24], -1);
	TextDrawSetOutline(LR_Main[24], 0);
	TextDrawSetProportional(LR_Main[24], 1);
	TextDrawSetShadow(LR_Main[24], 1);
	TextDrawUseBox(LR_Main[24], 1);
	TextDrawBoxColor(LR_Main[24], -241);
	TextDrawTextSize(LR_Main[24], 436.000000, 18.000000);
	TextDrawSetSelectable(LR_Main[24], 0);

	LR_Main[25] = TextDrawCreate(299.000000, 211.000000, "ld_pool:ball");
	TextDrawBackgroundColor(LR_Main[25], 255);
	TextDrawFont(LR_Main[25], 4);
	TextDrawLetterSize(LR_Main[25], 0.500000, 1.000000);
	TextDrawColor(LR_Main[25], -156);
	TextDrawSetOutline(LR_Main[25], 0);
	TextDrawSetProportional(LR_Main[25], 1);
	TextDrawSetShadow(LR_Main[25], 1);
	TextDrawUseBox(LR_Main[25], 1);
	TextDrawBoxColor(LR_Main[25], 255);
	TextDrawTextSize(LR_Main[25], 5.000000, 5.000000);
	TextDrawSetSelectable(LR_Main[25], 0);

	LR_Main[26] = TextDrawCreate(253.000000, 180.000000, "Dang nhap");
	TextDrawTextSize(LR_Main[26], 13.000000, 64.000000);
	TextDrawAlignment(LR_Main[26], 2);
	TextDrawBackgroundColor(LR_Main[26], 255);
	TextDrawFont(LR_Main[26], 2);
	TextDrawLetterSize(LR_Main[26], 0.239999, 1.500000);
	TextDrawColor(LR_Main[26], -1762000716);
	TextDrawSetOutline(LR_Main[26], 1);
	TextDrawSetProportional(LR_Main[26], 1);
	TextDrawSetSelectable(LR_Main[26], 1);

	LR_Main[27] = TextDrawCreate(253.000000, 206.000000, "Dang ky");
	TextDrawTextSize(LR_Main[27], 13.000000, 64.000000);
	TextDrawAlignment(LR_Main[27], 2);
	TextDrawBackgroundColor(LR_Main[27], 255);
	TextDrawFont(LR_Main[27], 2);
	TextDrawLetterSize(LR_Main[27], 0.239999, 1.500000);
	TextDrawColor(LR_Main[27], -1762000716);
	TextDrawSetOutline(LR_Main[27], 1);
	TextDrawSetProportional(LR_Main[27], 1);
	TextDrawSetSelectable(LR_Main[27], 1);

	LR_Main[28] = TextDrawCreate(253.000000, 232.000000, "Updates");
	TextDrawTextSize(LR_Main[28], 13.000000, 64.000000);
	TextDrawAlignment(LR_Main[28], 2);
	TextDrawBackgroundColor(LR_Main[28], 255);
	TextDrawFont(LR_Main[28], 2);
	TextDrawLetterSize(LR_Main[28], 0.239999, 1.500000);
	TextDrawColor(LR_Main[28], -1762000716);
	TextDrawSetOutline(LR_Main[28], 1);
	TextDrawSetProportional(LR_Main[28], 1);
	TextDrawSetSelectable(LR_Main[28], 1);

	LR_Main[29] = TextDrawCreate(253.000000, 258.000000, "Events");
	TextDrawTextSize(LR_Main[29], 13.000000, 64.000000);
	TextDrawAlignment(LR_Main[29], 2);
	TextDrawBackgroundColor(LR_Main[29], 255);
	TextDrawFont(LR_Main[29], 2);
	TextDrawLetterSize(LR_Main[29], 0.239999, 1.500000);
	TextDrawColor(LR_Main[29], -1762000716);
	TextDrawSetOutline(LR_Main[29], 1);
	TextDrawSetProportional(LR_Main[29], 1);
	TextDrawSetSelectable(LR_Main[29], 1);

	LR_Main[30] = TextDrawCreate(253.000000, 285.000000, "Credits");
	TextDrawTextSize(LR_Main[30], 13.000000, 64.000000);
	TextDrawAlignment(LR_Main[30], 2);
	TextDrawBackgroundColor(LR_Main[30], 255);
	TextDrawFont(LR_Main[30], 2);
	TextDrawLetterSize(LR_Main[30], 0.239999, 1.500000);
	TextDrawColor(LR_Main[30], -1762000716);
	TextDrawSetOutline(LR_Main[30], 1);
	TextDrawSetProportional(LR_Main[30], 1);
	TextDrawSetSelectable(LR_Main[30], 1);

	LR_Main[31] = TextDrawCreate(253.000000, 320.000000, "Thoat ra");
	TextDrawTextSize(LR_Main[31], 20.100000, 64.000000);
	TextDrawAlignment(LR_Main[31], 2);
	TextDrawBackgroundColor(LR_Main[31], 255);
	TextDrawFont(LR_Main[31], 2);
	TextDrawLetterSize(LR_Main[31], 0.300000, 2.099999);
	TextDrawColor(LR_Main[31], -1762000716);
	TextDrawSetOutline(LR_Main[31], 1);
	TextDrawSetProportional(LR_Main[31], 1);
	TextDrawSetSelectable(LR_Main[31], 1);

	LR_Main[32] = TextDrawCreate(299.000000, 237.000000, "ld_pool:ball");
	TextDrawBackgroundColor(LR_Main[32], 255);
	TextDrawFont(LR_Main[32], 4);
	TextDrawLetterSize(LR_Main[32], 0.500000, 1.000000);
	TextDrawColor(LR_Main[32], -156);
	TextDrawSetOutline(LR_Main[32], 0);
	TextDrawSetProportional(LR_Main[32], 1);
	TextDrawSetShadow(LR_Main[32], 1);
	TextDrawUseBox(LR_Main[32], 1);
	TextDrawBoxColor(LR_Main[32], 255);
	TextDrawTextSize(LR_Main[32], 5.000000, 5.000000);
	TextDrawSetSelectable(LR_Main[32], 0);

	LR_Main[33] = TextDrawCreate(299.000000, 263.000000, "ld_pool:ball");
	TextDrawBackgroundColor(LR_Main[33], 255);
	TextDrawFont(LR_Main[33], 4);
	TextDrawLetterSize(LR_Main[33], 0.500000, 1.000000);
	TextDrawColor(LR_Main[33], -156);
	TextDrawSetOutline(LR_Main[33], 0);
	TextDrawSetProportional(LR_Main[33], 1);
	TextDrawSetShadow(LR_Main[33], 1);
	TextDrawUseBox(LR_Main[33], 1);
	TextDrawBoxColor(LR_Main[33], 255);
	TextDrawTextSize(LR_Main[33], 5.000000, 5.000000);
	TextDrawSetSelectable(LR_Main[33], 0);

	LR_Main[34] = TextDrawCreate(299.000000, 290.000000, "ld_pool:ball");
	TextDrawBackgroundColor(LR_Main[34], 255);
	TextDrawFont(LR_Main[34], 4);
	TextDrawLetterSize(LR_Main[34], 0.500000, 1.000000);
	TextDrawColor(LR_Main[34], -156);
	TextDrawSetOutline(LR_Main[34], 0);
	TextDrawSetProportional(LR_Main[34], 1);
	TextDrawSetShadow(LR_Main[34], 1);
	TextDrawUseBox(LR_Main[34], 1);
	TextDrawBoxColor(LR_Main[34], 255);
	TextDrawTextSize(LR_Main[34], 5.000000, 5.000000);
	TextDrawSetSelectable(LR_Main[34], 0);

	LR_Main[35] = TextDrawCreate(299.000000, 328.000000, "ld_pool:ball");
	TextDrawBackgroundColor(LR_Main[35], 255);
	TextDrawFont(LR_Main[35], 4);
	TextDrawLetterSize(LR_Main[35], 0.500000, 1.000000);
	TextDrawColor(LR_Main[35], -156);
	TextDrawSetOutline(LR_Main[35], 0);
	TextDrawSetProportional(LR_Main[35], 1);
	TextDrawSetShadow(LR_Main[35], 1);
	TextDrawUseBox(LR_Main[35], 1);
	TextDrawBoxColor(LR_Main[35], 255);
	TextDrawTextSize(LR_Main[35], 5.000000, 5.000000);
	TextDrawSetSelectable(LR_Main[35], 0);

	LR_Main[36] = TextDrawCreate(308.000000, 178.000000, "~w~Dang nhap vao may chu voi~n~tai khoan da co san.");
	TextDrawBackgroundColor(LR_Main[36], 255);
	TextDrawFont(LR_Main[36], 2);
	TextDrawLetterSize(LR_Main[36], 0.189998, 1.000000);
	TextDrawColor(LR_Main[36], -26);
	TextDrawSetOutline(LR_Main[36], 0);
	TextDrawSetProportional(LR_Main[36], 1);
	TextDrawSetShadow(LR_Main[36], 1);
	TextDrawSetSelectable(LR_Main[36], 0);

	LR_Main[37] = TextDrawCreate(308.000000, 204.000000, "~w~Dang ky mot tai khoan moi de~n~tham gia may chu.");
	TextDrawBackgroundColor(LR_Main[37], 255);
	TextDrawFont(LR_Main[37], 2);
	TextDrawLetterSize(LR_Main[37], 0.189998, 1.000000);
	TextDrawColor(LR_Main[37], -26);
	TextDrawSetOutline(LR_Main[37], 0);
	TextDrawSetProportional(LR_Main[37], 1);
	TextDrawSetShadow(LR_Main[37], 1);
	TextDrawSetSelectable(LR_Main[37], 0);

	LR_Main[38] = TextDrawCreate(308.000000, 230.000000, "~w~Xem cac cap nhat moi nhu:~n~Code/Script/Map/...");
	TextDrawBackgroundColor(LR_Main[38], 255);
	TextDrawFont(LR_Main[38], 2);
	TextDrawLetterSize(LR_Main[38], 0.189998, 1.000000);
	TextDrawColor(LR_Main[38], -26);
	TextDrawSetOutline(LR_Main[38], 0);
	TextDrawSetProportional(LR_Main[38], 1);
	TextDrawSetShadow(LR_Main[38], 1);
	TextDrawSetSelectable(LR_Main[38], 0);

	LR_Main[39] = TextDrawCreate(308.000000, 256.000000, "~w~Xem cac thong tin su kien ma~n~may chu dang co.");
	TextDrawBackgroundColor(LR_Main[39], 255);
	TextDrawFont(LR_Main[39], 2);
	TextDrawLetterSize(LR_Main[39], 0.189998, 1.000000);
	TextDrawColor(LR_Main[39], -26);
	TextDrawSetOutline(LR_Main[39], 0);
	TextDrawSetProportional(LR_Main[39], 1);
	TextDrawSetShadow(LR_Main[39], 1);
	TextDrawSetSelectable(LR_Main[39], 0);

	LR_Main[40] = TextDrawCreate(308.000000, 283.000000, "~w~Xem ten va vai tro cua cac~n~thanh vien trong team staff.");
	TextDrawBackgroundColor(LR_Main[40], 255);
	TextDrawFont(LR_Main[40], 2);
	TextDrawLetterSize(LR_Main[40], 0.189998, 1.000000);
	TextDrawColor(LR_Main[40], -26);
	TextDrawSetOutline(LR_Main[40], 0);
	TextDrawSetProportional(LR_Main[40], 1);
	TextDrawSetShadow(LR_Main[40], 1);
	TextDrawSetSelectable(LR_Main[40], 0);

	LR_Main[41] = TextDrawCreate(308.000000, 316.000000, "~w~Thoat khoi may chu M26:RP.~n~Mong ban dung quen M26:RP :D.~n~Hen gap lai...");
	TextDrawBackgroundColor(LR_Main[41], 255);
	TextDrawFont(LR_Main[41], 2);
	TextDrawLetterSize(LR_Main[41], 0.189998, 1.000000);
	TextDrawColor(LR_Main[41], -26);
	TextDrawSetOutline(LR_Main[41], 0);
	TextDrawSetProportional(LR_Main[41], 1);
	TextDrawSetShadow(LR_Main[41], 1);
	TextDrawSetSelectable(LR_Main[41], 0);

	LR_Updates[0] = TextDrawCreate(298.000000, 177.000000, "____");
	TextDrawBackgroundColor(LR_Updates[0], 255);
	TextDrawFont(LR_Updates[0], 1);
	TextDrawLetterSize(LR_Updates[0], 0.679998, 1.800001);
	TextDrawColor(LR_Updates[0], -1);
	TextDrawSetOutline(LR_Updates[0], 0);
	TextDrawSetProportional(LR_Updates[0], 1);
	TextDrawSetShadow(LR_Updates[0], 1);
	TextDrawUseBox(LR_Updates[0], 1);
	TextDrawBoxColor(LR_Updates[0], -156);
	TextDrawTextSize(LR_Updates[0], 360.000000, 18.000000);
	TextDrawSetSelectable(LR_Updates[0], 0);

	LR_Updates[1] = TextDrawCreate(298.000000, 187.000000, "____");
	TextDrawBackgroundColor(LR_Updates[1], 255);
	TextDrawFont(LR_Updates[1], 1);
	TextDrawLetterSize(LR_Updates[1], 1.090000, 0.700001);
	TextDrawColor(LR_Updates[1], -1);
	TextDrawSetOutline(LR_Updates[1], 0);
	TextDrawSetProportional(LR_Updates[1], 1);
	TextDrawSetShadow(LR_Updates[1], 1);
	TextDrawUseBox(LR_Updates[1], 1);
	TextDrawBoxColor(LR_Updates[1], -156);
	TextDrawTextSize(LR_Updates[1], 360.000000, 18.000000);
	TextDrawSetSelectable(LR_Updates[1], 0);

	LR_Updates[2] = TextDrawCreate(329.000000, 177.000000, "Updates");
	TextDrawAlignment(LR_Updates[2], 2);
	TextDrawBackgroundColor(LR_Updates[2], 255);
	TextDrawFont(LR_Updates[2], 2);
	TextDrawLetterSize(LR_Updates[2], 0.239998, 1.500000);
	TextDrawColor(LR_Updates[2], -1762000716);
	TextDrawSetOutline(LR_Updates[2], 1);
	TextDrawSetProportional(LR_Updates[2], 1);
	TextDrawSetSelectable(LR_Updates[2], 0);

	LR_Updates[3] = TextDrawCreate(312.500000, 203.000000, "__");
	TextDrawBackgroundColor(LR_Updates[3], 255);
	TextDrawFont(LR_Updates[3], 1);
	TextDrawLetterSize(LR_Updates[3], 0.090000, -0.200000);
	TextDrawColor(LR_Updates[3], -1);
	TextDrawSetOutline(LR_Updates[3], 0);
	TextDrawSetProportional(LR_Updates[3], 1);
	TextDrawSetShadow(LR_Updates[3], 1);
	TextDrawUseBox(LR_Updates[3], 1);
	TextDrawBoxColor(LR_Updates[3], 16711730);
	TextDrawTextSize(LR_Updates[3], 421.000000, 18.000000);
	TextDrawSetSelectable(LR_Updates[3], 0);

	LR_Updates[4] = TextDrawCreate(299.000000, 215.000000, "~w~- Chua co thong tin.~n~- Chua co thong tin.");
	TextDrawBackgroundColor(LR_Updates[4], 255);
	TextDrawFont(LR_Updates[4], 2);
	TextDrawLetterSize(LR_Updates[4], 0.189998, 1.000000);
	TextDrawColor(LR_Updates[4], -26);
	TextDrawSetOutline(LR_Updates[4], 0);
	TextDrawSetProportional(LR_Updates[4], 1);
	TextDrawSetShadow(LR_Updates[4], 1);
	TextDrawSetSelectable(LR_Updates[4], 0);

	LR_Updates[5] = TextDrawCreate(299.000000, 233.000000, "~w~- Chua co thong tin.~n~- Chua co thong tin.");
	TextDrawBackgroundColor(LR_Updates[5], 255);
	TextDrawFont(LR_Updates[5], 2);
	TextDrawLetterSize(LR_Updates[5], 0.189998, 1.000000);
	TextDrawColor(LR_Updates[5], -26);
	TextDrawSetOutline(LR_Updates[5], 0);
	TextDrawSetProportional(LR_Updates[5], 1);
	TextDrawSetShadow(LR_Updates[5], 1);
	TextDrawSetSelectable(LR_Updates[5], 0);

	LR_Updates[6] = TextDrawCreate(299.000000, 251.000000, "~w~- Chua co thong tin.~n~- Chua co thong tin.");
	TextDrawBackgroundColor(LR_Updates[6], 255);
	TextDrawFont(LR_Updates[6], 2);
	TextDrawLetterSize(LR_Updates[6], 0.189998, 1.000000);
	TextDrawColor(LR_Updates[6], -26);
	TextDrawSetOutline(LR_Updates[6], 0);
	TextDrawSetProportional(LR_Updates[6], 1);
	TextDrawSetShadow(LR_Updates[6], 1);
	TextDrawSetSelectable(LR_Updates[6], 0);

	LR_Updates[7] = TextDrawCreate(299.000000, 269.000000, "~w~- Chua co thong tin.~n~- Chua co thong tin.");
	TextDrawBackgroundColor(LR_Updates[7], 255);
	TextDrawFont(LR_Updates[7], 2);
	TextDrawLetterSize(LR_Updates[7], 0.189998, 1.000000);
	TextDrawColor(LR_Updates[7], -26);
	TextDrawSetOutline(LR_Updates[7], 0);
	TextDrawSetProportional(LR_Updates[7], 1);
	TextDrawSetShadow(LR_Updates[7], 1);
	TextDrawSetSelectable(LR_Updates[7], 0);

	LR_Updates[8] = TextDrawCreate(299.000000, 287.000000, "~w~- Chua co thong tin.~n~- Chua co thong tin.");
	TextDrawBackgroundColor(LR_Updates[8], 255);
	TextDrawFont(LR_Updates[8], 2);
	TextDrawLetterSize(LR_Updates[8], 0.189998, 1.000000);
	TextDrawColor(LR_Updates[8], -26);
	TextDrawSetOutline(LR_Updates[8], 0);
	TextDrawSetProportional(LR_Updates[8], 1);
	TextDrawSetShadow(LR_Updates[8], 1);
	TextDrawSetSelectable(LR_Updates[8], 0);

	LR_Updates[9] = TextDrawCreate(299.000000, 205.000000, "~g~Cac thong tin cap nhat:");
	TextDrawBackgroundColor(LR_Updates[9], 255);
	TextDrawFont(LR_Updates[9], 2);
	TextDrawLetterSize(LR_Updates[9], 0.189998, 1.000000);
	TextDrawColor(LR_Updates[9], -26);
	TextDrawSetOutline(LR_Updates[9], 0);
	TextDrawSetProportional(LR_Updates[9], 1);
	TextDrawSetShadow(LR_Updates[9], 1);
	TextDrawSetSelectable(LR_Updates[9], 0);

	LR_Events[0] = TextDrawCreate(298.000000, 177.000000, "____");
	TextDrawBackgroundColor(LR_Events[0], 255);
	TextDrawFont(LR_Events[0], 1);
	TextDrawLetterSize(LR_Events[0], 0.679998, 1.800001);
	TextDrawColor(LR_Events[0], -1);
	TextDrawSetOutline(LR_Events[0], 0);
	TextDrawSetProportional(LR_Events[0], 1);
	TextDrawSetShadow(LR_Events[0], 1);
	TextDrawUseBox(LR_Events[0], 1);
	TextDrawBoxColor(LR_Events[0], -156);
	TextDrawTextSize(LR_Events[0], 360.000000, 18.000000);
	TextDrawSetSelectable(LR_Events[0], 0);

	LR_Events[1] = TextDrawCreate(298.000000, 187.000000, "____");
	TextDrawBackgroundColor(LR_Events[1], 255);
	TextDrawFont(LR_Events[1], 1);
	TextDrawLetterSize(LR_Events[1], 1.090000, 0.700001);
	TextDrawColor(LR_Events[1], -1);
	TextDrawSetOutline(LR_Events[1], 0);
	TextDrawSetProportional(LR_Events[1], 1);
	TextDrawSetShadow(LR_Events[1], 1);
	TextDrawUseBox(LR_Events[1], 1);
	TextDrawBoxColor(LR_Events[1], -156);
	TextDrawTextSize(LR_Events[1], 360.000000, 18.000000);
	TextDrawSetSelectable(LR_Events[1], 0);

	LR_Events[2] = TextDrawCreate(329.000000, 177.000000, "Events");
	TextDrawAlignment(LR_Events[2], 2);
	TextDrawBackgroundColor(LR_Events[2], 255);
	TextDrawFont(LR_Events[2], 2);
	TextDrawLetterSize(LR_Events[2], 0.239998, 1.500000);
	TextDrawColor(LR_Events[2], -1762000716);
	TextDrawSetOutline(LR_Events[2], 1);
	TextDrawSetProportional(LR_Events[2], 1);
	TextDrawSetSelectable(LR_Events[2], 0);

	LR_Events[3] = TextDrawCreate(312.500000, 203.000000, "__");
	TextDrawBackgroundColor(LR_Events[3], 255);
	TextDrawFont(LR_Events[3], 1);
	TextDrawLetterSize(LR_Events[3], 0.090000, -0.200000);
	TextDrawColor(LR_Events[3], -1);
	TextDrawSetOutline(LR_Events[3], 0);
	TextDrawSetProportional(LR_Events[3], 1);
	TextDrawSetShadow(LR_Events[3], 1);
	TextDrawUseBox(LR_Events[3], 1);
	TextDrawBoxColor(LR_Events[3], 16711730);
	TextDrawTextSize(LR_Events[3], 421.000000, 18.000000);
	TextDrawSetSelectable(LR_Events[3], 0);

	LR_Events[4] = TextDrawCreate(299.000000, 215.000000, "~w~- Chua co thong tin.~n~- Chua co thong tin.");
	TextDrawBackgroundColor(LR_Events[4], 255);
	TextDrawFont(LR_Events[4], 2);
	TextDrawLetterSize(LR_Events[4], 0.189998, 1.000000);
	TextDrawColor(LR_Events[4], -26);
	TextDrawSetOutline(LR_Events[4], 0);
	TextDrawSetProportional(LR_Events[4], 1);
	TextDrawSetShadow(LR_Events[4], 1);
	TextDrawSetSelectable(LR_Events[4], 0);

	LR_Events[5] = TextDrawCreate(299.000000, 233.000000, "~w~- Chua co thong tin.~n~- Chua co thong tin.");
	TextDrawBackgroundColor(LR_Events[5], 255);
	TextDrawFont(LR_Events[5], 2);
	TextDrawLetterSize(LR_Events[5], 0.189998, 1.000000);
	TextDrawColor(LR_Events[5], -26);
	TextDrawSetOutline(LR_Events[5], 0);
	TextDrawSetProportional(LR_Events[5], 1);
	TextDrawSetShadow(LR_Events[5], 1);
	TextDrawSetSelectable(LR_Events[5], 0);

	LR_Events[6] = TextDrawCreate(299.000000, 251.000000, "~w~- Chua co thong tin.~n~- Chua co thong tin.");
	TextDrawBackgroundColor(LR_Events[6], 255);
	TextDrawFont(LR_Events[6], 2);
	TextDrawLetterSize(LR_Events[6], 0.189998, 1.000000);
	TextDrawColor(LR_Events[6], -26);
	TextDrawSetOutline(LR_Events[6], 0);
	TextDrawSetProportional(LR_Events[6], 1);
	TextDrawSetShadow(LR_Events[6], 1);
	TextDrawSetSelectable(LR_Events[6], 0);

	LR_Events[7] = TextDrawCreate(299.000000, 269.000000, "~w~- Chua co thong tin.~n~- Chua co thong tin.");
	TextDrawBackgroundColor(LR_Events[7], 255);
	TextDrawFont(LR_Events[7], 2);
	TextDrawLetterSize(LR_Events[7], 0.189998, 1.000000);
	TextDrawColor(LR_Events[7], -26);
	TextDrawSetOutline(LR_Events[7], 0);
	TextDrawSetProportional(LR_Events[7], 1);
	TextDrawSetShadow(LR_Events[7], 1);
	TextDrawSetSelectable(LR_Events[7], 0);

	LR_Events[8] = TextDrawCreate(299.000000, 287.000000, "~w~- Chua co thong tin.~n~- Chua co thong tin.");
	TextDrawBackgroundColor(LR_Events[8], 255);
	TextDrawFont(LR_Events[8], 2);
	TextDrawLetterSize(LR_Events[8], 0.189998, 1.000000);
	TextDrawColor(LR_Events[8], -26);
	TextDrawSetOutline(LR_Events[8], 0);
	TextDrawSetProportional(LR_Events[8], 1);
	TextDrawSetShadow(LR_Events[8], 1);
	TextDrawSetSelectable(LR_Events[8], 0);

	LR_Events[9] = TextDrawCreate(299.000000, 205.000000, "~g~Cac thong tin su kien:");
	TextDrawBackgroundColor(LR_Events[9], 255);
	TextDrawFont(LR_Events[9], 2);
	TextDrawLetterSize(LR_Events[9], 0.189998, 1.000000);
	TextDrawColor(LR_Events[9], -26);
	TextDrawSetOutline(LR_Events[9], 0);
	TextDrawSetProportional(LR_Events[9], 1);
	TextDrawSetShadow(LR_Events[9], 1);
	TextDrawSetSelectable(LR_Events[9], 0);

	LR_Credits[0] = TextDrawCreate(298.000000, 177.000000, "____");
	TextDrawBackgroundColor(LR_Credits[0], 255);
	TextDrawFont(LR_Credits[0], 1);
	TextDrawLetterSize(LR_Credits[0], 0.679998, 1.800001);
	TextDrawColor(LR_Credits[0], -1);
	TextDrawSetOutline(LR_Credits[0], 0);
	TextDrawSetProportional(LR_Credits[0], 1);
	TextDrawSetShadow(LR_Credits[0], 1);
	TextDrawUseBox(LR_Credits[0], 1);
	TextDrawBoxColor(LR_Credits[0], -156);
	TextDrawTextSize(LR_Credits[0], 360.000000, 18.000000);
	TextDrawSetSelectable(LR_Credits[0], 0);

	LR_Credits[1] = TextDrawCreate(298.000000, 187.000000, "____");
	TextDrawBackgroundColor(LR_Credits[1], 255);
	TextDrawFont(LR_Credits[1], 1);
	TextDrawLetterSize(LR_Credits[1], 1.090000, 0.700001);
	TextDrawColor(LR_Credits[1], -1);
	TextDrawSetOutline(LR_Credits[1], 0);
	TextDrawSetProportional(LR_Credits[1], 1);
	TextDrawSetShadow(LR_Credits[1], 1);
	TextDrawUseBox(LR_Credits[1], 1);
	TextDrawBoxColor(LR_Credits[1], -156);
	TextDrawTextSize(LR_Credits[1], 360.000000, 18.000000);
	TextDrawSetSelectable(LR_Credits[1], 0);

	LR_Credits[2] = TextDrawCreate(329.000000, 177.000000, "Credits");
	TextDrawAlignment(LR_Credits[2], 2);
	TextDrawBackgroundColor(LR_Credits[2], 255);
	TextDrawFont(LR_Credits[2], 2);
	TextDrawLetterSize(LR_Credits[2], 0.239998, 1.500000);
	TextDrawColor(LR_Credits[2], -1762000716);
	TextDrawSetOutline(LR_Credits[2], 1);
	TextDrawSetProportional(LR_Credits[2], 1);
	TextDrawSetSelectable(LR_Credits[2], 0);

	LR_Credits[3] = TextDrawCreate(312.500000, 203.000000, "__");
	TextDrawBackgroundColor(LR_Credits[3], 255);
	TextDrawFont(LR_Credits[3], 1);
	TextDrawLetterSize(LR_Credits[3], 0.090000, -0.200000);
	TextDrawColor(LR_Credits[3], -1);
	TextDrawSetOutline(LR_Credits[3], 0);
	TextDrawSetProportional(LR_Credits[3], 1);
	TextDrawSetShadow(LR_Credits[3], 1);
	TextDrawUseBox(LR_Credits[3], 1);
	TextDrawBoxColor(LR_Credits[3], 16711730);
	TextDrawTextSize(LR_Credits[3], 421.000000, 18.000000);
	TextDrawSetSelectable(LR_Credits[3], 0);

	LR_Credits[4] = TextDrawCreate(299.000000, 215.000000, "~w~- ~y~M26~w~: Scripter.~n~- Chua co thong tin.");
	TextDrawBackgroundColor(LR_Credits[4], 255);
	TextDrawFont(LR_Credits[4], 2);
	TextDrawLetterSize(LR_Credits[4], 0.189998, 1.000000);
	TextDrawColor(LR_Credits[4], -26);
	TextDrawSetOutline(LR_Credits[4], 0);
	TextDrawSetProportional(LR_Credits[4], 1);
	TextDrawSetShadow(LR_Credits[4], 1);
	TextDrawSetSelectable(LR_Credits[4], 0);

	LR_Credits[5] = TextDrawCreate(299.000000, 233.000000, "~w~- Chua co thong tin.~n~- Chua co thong tin.");
	TextDrawBackgroundColor(LR_Credits[5], 255);
	TextDrawFont(LR_Credits[5], 2);
	TextDrawLetterSize(LR_Credits[5], 0.189998, 1.000000);
	TextDrawColor(LR_Credits[5], -26);
	TextDrawSetOutline(LR_Credits[5], 0);
	TextDrawSetProportional(LR_Credits[5], 1);
	TextDrawSetShadow(LR_Credits[5], 1);
	TextDrawSetSelectable(LR_Credits[5], 0);

	LR_Credits[6] = TextDrawCreate(299.000000, 251.000000, "~w~- Chua co thong tin.~n~- Chua co thong tin.");
	TextDrawBackgroundColor(LR_Credits[6], 255);
	TextDrawFont(LR_Credits[6], 2);
	TextDrawLetterSize(LR_Credits[6], 0.189998, 1.000000);
	TextDrawColor(LR_Credits[6], -26);
	TextDrawSetOutline(LR_Credits[6], 0);
	TextDrawSetProportional(LR_Credits[6], 1);
	TextDrawSetShadow(LR_Credits[6], 1);
	TextDrawSetSelectable(LR_Credits[6], 0);

	LR_Credits[7] = TextDrawCreate(299.000000, 269.000000, "~w~- Chua co thong tin.~n~- Chua co thong tin.");
	TextDrawBackgroundColor(LR_Credits[7], 255);
	TextDrawFont(LR_Credits[7], 2);
	TextDrawLetterSize(LR_Credits[7], 0.189998, 1.000000);
	TextDrawColor(LR_Credits[7], -26);
	TextDrawSetOutline(LR_Credits[7], 0);
	TextDrawSetProportional(LR_Credits[7], 1);
	TextDrawSetShadow(LR_Credits[7], 1);
	TextDrawSetSelectable(LR_Credits[7], 0);

	LR_Credits[8] = TextDrawCreate(299.000000, 287.000000, "~w~- Chua co thong tin.~n~- Chua co thong tin.");
	TextDrawBackgroundColor(LR_Credits[8], 255);
	TextDrawFont(LR_Credits[8], 2);
	TextDrawLetterSize(LR_Credits[8], 0.189998, 1.000000);
	TextDrawColor(LR_Credits[8], -26);
	TextDrawSetOutline(LR_Credits[8], 0);
	TextDrawSetProportional(LR_Credits[8], 1);
	TextDrawSetShadow(LR_Credits[8], 1);
	TextDrawSetSelectable(LR_Credits[8], 0);

	LR_Credits[9] = TextDrawCreate(299.000000, 205.000000, "~y~Cac thanh vien team staff:");
	TextDrawBackgroundColor(LR_Credits[9], 255);
	TextDrawFont(LR_Credits[9], 2);
	TextDrawLetterSize(LR_Credits[9], 0.189998, 1.000000);
	TextDrawColor(LR_Credits[9], -26);
	TextDrawSetOutline(LR_Credits[9], 0);
	TextDrawSetProportional(LR_Credits[9], 1);
	TextDrawSetShadow(LR_Credits[9], 1);
	TextDrawSetSelectable(LR_Credits[9], 0);
    for(new i; i < MAX_PLAYERS; i ++)
	{
		// Login/Register
		LR_LoginRegister[0][i] = TextDrawCreate(298.000000, 177.000000, "____");
		TextDrawBackgroundColor(LR_LoginRegister[0][i], 255);
		TextDrawFont(LR_LoginRegister[0][i], 1);
		TextDrawLetterSize(LR_LoginRegister[0][i], 0.679998, 1.800001);
		TextDrawColor(LR_LoginRegister[0][i], -1);
		TextDrawSetOutline(LR_LoginRegister[0][i], 0);
		TextDrawSetProportional(LR_LoginRegister[0][i], 1);
		TextDrawSetShadow(LR_LoginRegister[0][i], 1);
		TextDrawUseBox(LR_LoginRegister[0][i], 1);
		TextDrawBoxColor(LR_LoginRegister[0][i], -156);
		TextDrawTextSize(LR_LoginRegister[0][i], 360.000000, 18.000000);
		TextDrawSetSelectable(LR_LoginRegister[0][i], 0);

		LR_LoginRegister[1][i] = TextDrawCreate(298.000000, 187.000000, "____");
		TextDrawBackgroundColor(LR_LoginRegister[1][i], 255);
		TextDrawFont(LR_LoginRegister[1][i], 1);
		TextDrawLetterSize(LR_LoginRegister[1][i], 1.090000, 0.700001);
		TextDrawColor(LR_LoginRegister[1][i], -1);
		TextDrawSetOutline(LR_LoginRegister[1][i], 0);
		TextDrawSetProportional(LR_LoginRegister[1][i], 1);
		TextDrawSetShadow(LR_LoginRegister[1][i], 1);
		TextDrawUseBox(LR_LoginRegister[1][i], 1);
		TextDrawBoxColor(LR_LoginRegister[1][i], -156);
		TextDrawTextSize(LR_LoginRegister[1][i], 360.000000, 18.000000);
		TextDrawSetSelectable(LR_LoginRegister[1][i], 0);

		LR_LoginRegister[2][i] = TextDrawCreate(329.000000, 177.000000, "Dang nhap");
		TextDrawAlignment(LR_LoginRegister[2][i], 2);
		TextDrawBackgroundColor(LR_LoginRegister[2][i], 255);
		TextDrawFont(LR_LoginRegister[2][i], 2);
		TextDrawLetterSize(LR_LoginRegister[2][i], 0.239998, 1.500000);
		TextDrawColor(LR_LoginRegister[2][i], -1762000716);
		TextDrawSetOutline(LR_LoginRegister[2][i], 1);
		TextDrawSetProportional(LR_LoginRegister[2][i], 1);
		TextDrawSetSelectable(LR_LoginRegister[2][i], 0);

		LR_LoginRegister[3][i] = TextDrawCreate(312.500000, 203.000000, "__");
		TextDrawBackgroundColor(LR_LoginRegister[3][i], 255);
		TextDrawFont(LR_LoginRegister[3][i], 1);
		TextDrawLetterSize(LR_LoginRegister[3][i], 0.090000, -0.200000);
		TextDrawColor(LR_LoginRegister[3][i], -1);
		TextDrawSetOutline(LR_LoginRegister[3][i], 0);
		TextDrawSetProportional(LR_LoginRegister[3][i], 1);
		TextDrawSetShadow(LR_LoginRegister[3][i], 1);
		TextDrawUseBox(LR_LoginRegister[3][i], 1);
		TextDrawBoxColor(LR_LoginRegister[3][i], 16711730);
		TextDrawTextSize(LR_LoginRegister[3][i], 421.000000, 18.000000);
		TextDrawSetSelectable(LR_LoginRegister[3][i], 0);

		LR_LoginRegister[4][i] = TextDrawCreate(299.000000, 209.000000, "~w~Ten nhan vat:");
		TextDrawBackgroundColor(LR_LoginRegister[4][i], 255);
		TextDrawFont(LR_LoginRegister[4][i], 2);
		TextDrawLetterSize(LR_LoginRegister[4][i], 0.189998, 1.000000);
		TextDrawColor(LR_LoginRegister[4][i], -26);
		TextDrawSetOutline(LR_LoginRegister[4][i], 0);
		TextDrawSetProportional(LR_LoginRegister[4][i], 1);
		TextDrawSetShadow(LR_LoginRegister[4][i], 1);
		TextDrawSetSelectable(LR_LoginRegister[4][i], 0);

		LR_LoginRegister[5][i] = TextDrawCreate(299.000000, 239.000000, "~w~Mat khau:");
		TextDrawBackgroundColor(LR_LoginRegister[5][i], 255);
		TextDrawFont(LR_LoginRegister[5][i], 2);
		TextDrawLetterSize(LR_LoginRegister[5][i], 0.189998, 1.000000);
		TextDrawColor(LR_LoginRegister[5][i], -26);
		TextDrawSetOutline(LR_LoginRegister[5][i], 0);
		TextDrawSetProportional(LR_LoginRegister[5][i], 1);
		TextDrawSetShadow(LR_LoginRegister[5][i], 1);
		TextDrawSetSelectable(LR_LoginRegister[5][i], 0);

		LR_LoginRegister[6][i] = TextDrawCreate(300.000000, 222.000000, "ld_spac:white");
		TextDrawBackgroundColor(LR_LoginRegister[6][i], 255);
		TextDrawFont(LR_LoginRegister[6][i], 4);
		TextDrawLetterSize(LR_LoginRegister[6][i], 0.500000, 1.000000);
		TextDrawColor(LR_LoginRegister[6][i], -56);
		TextDrawSetOutline(LR_LoginRegister[6][i], 0);
		TextDrawSetProportional(LR_LoginRegister[6][i], 1);
		TextDrawSetShadow(LR_LoginRegister[6][i], 1);
		TextDrawUseBox(LR_LoginRegister[6][i], 1);
		TextDrawBoxColor(LR_LoginRegister[6][i], -156);
		TextDrawTextSize(LR_LoginRegister[6][i], 134.000000, 14.000000);
		TextDrawSetSelectable(LR_LoginRegister[6][i], 1);

		LR_LoginRegister[7][i] = TextDrawCreate(300.000000, 252.000000, "ld_spac:white");
		TextDrawBackgroundColor(LR_LoginRegister[7][i], 255);
		TextDrawFont(LR_LoginRegister[7][i], 4);
		TextDrawLetterSize(LR_LoginRegister[7][i], 0.500000, 1.000000);
		TextDrawColor(LR_LoginRegister[7][i], -56);
		TextDrawSetOutline(LR_LoginRegister[7][i], 0);
		TextDrawSetProportional(LR_LoginRegister[7][i], 1);
		TextDrawSetShadow(LR_LoginRegister[7][i], 1);
		TextDrawUseBox(LR_LoginRegister[7][i], 1);
		TextDrawBoxColor(LR_LoginRegister[7][i], -156);
		TextDrawTextSize(LR_LoginRegister[7][i], 134.000000, 14.000000);
		TextDrawSetSelectable(LR_LoginRegister[7][i], 1);

		LR_LoginRegister[8][i] = TextDrawCreate(302.000000, 223.000000, "Ten nhan vat");
		TextDrawBackgroundColor(LR_LoginRegister[8][i], -1);
		TextDrawFont(LR_LoginRegister[8][i], 1);
		TextDrawLetterSize(LR_LoginRegister[8][i], 0.189998, 1.000000);
		TextDrawColor(LR_LoginRegister[8][i], 255);
		TextDrawSetOutline(LR_LoginRegister[8][i], 0);
		TextDrawSetProportional(LR_LoginRegister[8][i], 1);
		TextDrawSetShadow(LR_LoginRegister[8][i], 0);
		TextDrawSetSelectable(LR_LoginRegister[8][i], 0);

		LR_LoginRegister[9][i] = TextDrawCreate(302.000000, 255.000000, "]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]");
		TextDrawBackgroundColor(LR_LoginRegister[9][i], -1);
		TextDrawFont(LR_LoginRegister[9][i], 2);
		TextDrawLetterSize(LR_LoginRegister[9][i], 0.109998, 0.699998);
		TextDrawColor(LR_LoginRegister[9][i], 255);
		TextDrawSetOutline(LR_LoginRegister[9][i], 0);
		TextDrawSetProportional(LR_LoginRegister[9][i], 1);
		TextDrawSetShadow(LR_LoginRegister[9][i], 0);
		TextDrawSetSelectable(LR_LoginRegister[9][i], 0);

		LR_LoginRegister[10][i] = TextDrawCreate(333.000000, 284.000000, "____");
		TextDrawBackgroundColor(LR_LoginRegister[10][i], 255);
		TextDrawFont(LR_LoginRegister[10][i], 1);
		TextDrawLetterSize(LR_LoginRegister[10][i], 0.679998, 1.800001);
		TextDrawColor(LR_LoginRegister[10][i], -1);
		TextDrawSetOutline(LR_LoginRegister[10][i], 0);
		TextDrawSetProportional(LR_LoginRegister[10][i], 1);
		TextDrawSetShadow(LR_LoginRegister[10][i], 1);
		TextDrawUseBox(LR_LoginRegister[10][i], 1);
		TextDrawBoxColor(LR_LoginRegister[10][i], -156);
		TextDrawTextSize(LR_LoginRegister[10][i], 400.000000, 18.000000);
		TextDrawSetSelectable(LR_LoginRegister[10][i], 0);

		LR_LoginRegister[11][i] = TextDrawCreate(333.000000, 294.000000, "____");
		TextDrawBackgroundColor(LR_LoginRegister[11][i], 255);
		TextDrawFont(LR_LoginRegister[11][i], 1);
		TextDrawLetterSize(LR_LoginRegister[11][i], 1.090000, 0.700001);
		TextDrawColor(LR_LoginRegister[11][i], -1);
		TextDrawSetOutline(LR_LoginRegister[11][i], 0);
		TextDrawSetProportional(LR_LoginRegister[11][i], 1);
		TextDrawSetShadow(LR_LoginRegister[11][i], 1);
		TextDrawUseBox(LR_LoginRegister[11][i], 1);
		TextDrawBoxColor(LR_LoginRegister[11][i], -156);
		TextDrawTextSize(LR_LoginRegister[11][i], 400.000000, 18.000000);
		TextDrawSetSelectable(LR_LoginRegister[11][i], 0);

		LR_LoginRegister[12][i] = TextDrawCreate(367.000000, 284.000000, "Dang nhap");
		TextDrawTextSize(LR_LoginRegister[12][i], 13.000000, 64.000000);
		TextDrawAlignment(LR_LoginRegister[12][i], 2);
		TextDrawBackgroundColor(LR_LoginRegister[12][i], 255);
		TextDrawFont(LR_LoginRegister[12][i], 2);
		TextDrawLetterSize(LR_LoginRegister[12][i], 0.239998, 1.500000);
		TextDrawColor(LR_LoginRegister[12][i], -1762000716);
		TextDrawSetOutline(LR_LoginRegister[12][i], 1);
		TextDrawSetProportional(LR_LoginRegister[12][i], 1);
		TextDrawSetSelectable(LR_LoginRegister[12][i], 1);

		LR_LoginRegister[13][i] = TextDrawCreate(365.000000, 269.000000, "~r~Sai mat khau !");
		TextDrawAlignment(LR_LoginRegister[13][i], 2);
		TextDrawBackgroundColor(LR_LoginRegister[13][i], 255);
		TextDrawFont(LR_LoginRegister[13][i], 2);
		TextDrawLetterSize(LR_LoginRegister[13][i], 0.189998, 1.000000);
		TextDrawColor(LR_LoginRegister[13][i], -26);
		TextDrawSetOutline(LR_LoginRegister[13][i], 0);
		TextDrawSetProportional(LR_LoginRegister[13][i], 1);
		TextDrawSetShadow(LR_LoginRegister[13][i], 1);
		TextDrawSetSelectable(LR_LoginRegister[13][i], 0);
  	}
  	return 1;
}

// OnDialogResponse
// Login/Register
	if(dialogid == DIALOG_INSERT_USERNAME)
	{
		if(!response) PlayerPlaySound(playerid,1145,0.0,0.0,0.0);
		if(response)
		{
		    if(strlen(inputtext) > 24 || strlen(inputtext) < 3) return ShowPlayerDialog(playerid, DIALOG_INSERT_USERNAME, DIALOG_STYLE_INPUT,"{ff0000}[!]","{ff0000}Ten nhan vat phai dai tu 3-24 ky tu.\n{FFFFFF}Vui long ghi lai ten nhan vat cua ban vao day.","Chap nhan","Thoat");
			if(~strfind(inputtext, ";") || ~strfind(inputtext, ",") || ~strfind(inputtext, "'") || ~strfind(inputtext, ":") ||
			~strfind(inputtext, "|") || ~strfind(inputtext, "{") || ~strfind(inputtext, "}") || ~strfind(inputtext, "+") ||
			~strfind(inputtext, "?") || ~strfind(inputtext, "/") || ~strfind(inputtext, "-") || ~strfind(inputtext, " ") ||
			~strfind(inputtext, "@") || ~strfind(inputtext, "[") || ~strfind(inputtext, "]") || ~strfind(inputtext, "<") ||
			~strfind(inputtext, ">") || ~strfind(inputtext, "!") || ~strfind(inputtext, "#") || ~strfind(inputtext, "^") ||
			~strfind(inputtext, "*") || ~strfind(inputtext, "&") || ~strfind(inputtext, "0") || ~strfind(inputtext, "1") ||
			~strfind(inputtext, "2") || ~strfind(inputtext, "3") || ~strfind(inputtext, "4") || ~strfind(inputtext, "5") ||
			~strfind(inputtext, "6") || ~strfind(inputtext, "7") || ~strfind(inputtext, "8") || ~strfind(inputtext, "9") ||
			~strfind(inputtext, "(") || ~strfind(inputtext, ")") || ~strfind(inputtext, ".") || ~strfind(inputtext, "%")) return ShowPlayerDialog(playerid, DIALOG_INSERT_USERNAME, DIALOG_STYLE_INPUT,"{ff0000}[!]","{ff0000}Ten nhan vat khong duoc chua cac ky tu dac biet.\n{FFFFFF}Ban phai dat theo: {00CC00}Ho_Ten{FFFFFF}.","Chap nhan","Thoat");
			if(~strfind(inputtext, "_"))
			{
	            format(PLInfo[playerid][PLUsername], 100, "%s", inputtext);
				TextDrawSetString(LR_LoginRegister[8][playerid], PLInfo[playerid][PLUsername]);
			}
			else ShowPlayerDialog(playerid, DIALOG_INSERT_USERNAME, DIALOG_STYLE_INPUT,"{ff0000}[!]","{ff0000}Ten nhan vat khong hop le.\n{FFFFFF}Ban phai dat theo: {00CC00}Ho_Ten{FFFFFF}.","Chap nhan","Thoat");
		}
	}
	if(dialogid == DIALOG_INSERT_PASSWORD)
	{
		if(!response) PlayerPlaySound(playerid,1145,0.0,0.0,0.0);
		if(response)
		{
		    if(strlen(inputtext) > 24 || strlen(inputtext) < 6) return ShowPlayerDialog(playerid, DIALOG_INSERT_PASSWORD, DIALOG_STYLE_PASSWORD,"{ff0000}[!]","{ff0000}Mat khau phai dai tu 6-24 ky tu.\n{FFFFFF}Vui long ghi lai mat khau cua ban vao day.","Chap nhan","Thoat");
			new passwordka[64];
			format(PLInfo[playerid][PLPassword], 256, "%s", inputtext);
			PasswordEncode(passwordka, strlen(inputtext));
			TextDrawSetString(LR_LoginRegister[9][playerid], passwordka);
		}
	}

// Login/Register
PasswordEncode(string[], size)
{
	for(new s; s <= size; s++)
	{
	    if(size >= 36) format(string,34,"]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]");
	    else
	    {
			if(s ^ size) string[s] = ']';
			else string[s] = EOS;
		}
	}
	return 1;
}

forward LRFuckThatShit(playerid, value);
public LRFuckThatShit(playerid, value)
{
	if(value == 1)
	{
	    new string[256];
	    format(string, sizeof(string), "SELECT `Username` FROM `accounts` WHERE `Username` = '%s'", PLInfo[playerid][PLUsername]);
		mysql_function_query(MainPipeline, string, true, "OnQueryFinish", "iii", PLCHECKUSERNAME, playerid, g_arrQueryHandle{playerid});
	}
	else if(value == 2)
	{
	    new string[256];
	    format(string, sizeof(string), "SELECT `Username`,`Key`,`Email` from accounts WHERE Username = '%s'", PLInfo[playerid][PLUsername]);
		mysql_function_query(MainPipeline, string, true, "OnQueryFinish", "iii", PLCHECKPASSWORD, playerid, g_arrQueryHandle{playerid});
	}
	else if(value == 3)
	{
	    new string[256];
		format(string, sizeof(string), "SELECT `Username` FROM `accounts` WHERE `Username` = '%s'", PLInfo[playerid][PLUsername]);
		mysql_function_query(MainPipeline, string, true, "OnQueryFinish", "iii", PLCHECKREGISTER, playerid, g_arrQueryHandle{playerid});
	}
	return 1;
}

forward LoginRegisterTextDraws(playerid, value);
public LoginRegisterTextDraws(playerid, value)
{
    SelectTextDraw(playerid, -16776961);
	if(value == 1) for(new i=0; i <= 41; i++) TextDrawShowForPlayer(playerid, LR_Main[i]); // Main
	else if(value == 2) // Login
	{
	    PLInfo[playerid][PLSelecting] = 1;
	    TextDrawSetString(LR_LoginRegister[2][playerid], "Dang nhap");
	    TextDrawSetString(LR_LoginRegister[12][playerid], "Dang nhap");
	    TextDrawSetString(LR_LoginRegister[13][playerid], "~r~Hay nhap day du cac thong tin !");
	    for(new i=0; i <= 13; i++) TextDrawShowForPlayer(playerid, LR_LoginRegister[i][playerid]);
	}
	else if(value == 3) // Register
	{
	    PLInfo[playerid][PLSelecting] = 2;
	    TextDrawSetString(LR_LoginRegister[2][playerid], "Dang ky");
	    TextDrawSetString(LR_LoginRegister[12][playerid], "Dang ky");
	    TextDrawSetString(LR_LoginRegister[13][playerid], "~r~Hay nhap day du cac thong tin !");
	    for(new i=0; i <= 13; i++) TextDrawShowForPlayer(playerid, LR_LoginRegister[i][playerid]);
	}
	else if(value == 4) // Updates
	{
		for(new i=0; i <= 10; i++) TextDrawShowForPlayer(playerid, LR_Updates[i]);
	}
	else if(value == 5) // Events
	{
	    for(new i=0; i <= 10; i++) TextDrawShowForPlayer(playerid, LR_Events[i]);
	}
	else if(value == 6)  // Credits
	{
		for(new i=0; i <= 10; i++) TextDrawShowForPlayer(playerid, LR_Credits[i]);
	}
	else if(value == 7) // Thoat ra
	{
	    PLInfo[playerid][PLSelecting] = 0;
	    CancelSelectTextDraw(playerid);
	    for(new i=0; i <= 41; i++) TextDrawHideForPlayer(playerid, LR_Main[i]);
	    for(new i=0; i <= 13; i++) TextDrawHideForPlayer(playerid, LR_LoginRegister[i][playerid]);
	    for(new i=0; i <= 10; i++) TextDrawHideForPlayer(playerid, LR_Updates[i]), TextDrawHideForPlayer(playerid, LR_Events[i]), TextDrawHideForPlayer(playerid, LR_Credits[i]);
	}
    else if(value == 8) // Right TextDraws
	{
	    TextDrawHideForPlayer(playerid, LR_Main[23]);
	    TextDrawHideForPlayer(playerid, LR_Main[25]);
	    TextDrawHideForPlayer(playerid, LR_Main[36]);
	    TextDrawHideForPlayer(playerid, LR_Main[37]);
	    TextDrawHideForPlayer(playerid, LR_Main[38]);
	    TextDrawHideForPlayer(playerid, LR_Main[39]);
	    TextDrawHideForPlayer(playerid, LR_Main[40]);
	    for(new i=32; i <= 34; i++) TextDrawHideForPlayer(playerid, LR_Main[i]);
	}
	else if(value == 9)
	{
	    SetTimerEx("LoginRegisterTextDraws", 1, false, "ii", playerid, 7);
	    SetTimerEx("LoginRegisterTextDraws", 30, false, "ii", playerid, 1);
	    SetTimerEx("LoginRegisterTextDraws", 60, false, "ii", playerid, 8);
	}
	return 1;
}
