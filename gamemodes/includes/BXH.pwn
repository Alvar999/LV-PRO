#include <YSI\y_hooks>

#define         DIALOG_BANGXEPHANG          (10412)


//npcbangxephang = CreateActor(60,2027.7423,1003.1175,10.8131,271.3488);


hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_BANGXEPHANG)
    {
		if(response)
        {
            if(listitem == 0) // Money
            {
                new Cache:Result, NamePlayer[MAX_PLAYER_NAME], Urani, String[2000], string1[2000];
                Result = mysql_query(MainPipeline, "SELECT `Urani`, `Username` FROM `accounts` ORDER BY `Urani` DESC LIMIT 10");
                if(cache_num_rows())
                {
                    for(new i = 0; i < cache_num_rows(); ++ i)
                    {
                        cache_get_field_content(i, "Username", NamePlayer);
                        Urani = cache_get_field_content_int(i, "Urani");
                        format(String, sizeof(String), "{FF0000}%d \t{FFFFFF}%s\t{3CFF14}%s [DA QUY]\n", i+1, NamePlayer, number_format(Urani));
                        strcat(string1, String, sizeof(string1));
                    }
                }
                format(String, sizeof(String), "{FF0000}TOP 10\t{FFFFFF}PLAYERS\t{3CFF14}SO LUONG DA QUY\n%s", string1);
                cache_delete(Result);
                ShowPlayerDialog(playerid, 1, DIALOG_STYLE_TABLIST_HEADERS, "TOP MONEY", String, "OK","");
            }
        }
    }
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(PRESSED(KEY_WALK))
	{
        if(IsPlayerInRangeOfActor(playerid, npcbangxephang))
	    {
			if(PlayerInfo[playerid][pCash] >= 1)
			{
			    ShowPlayerDialog(playerid, DIALOG_BANGXEPHANG, DIALOG_STYLE_LIST, "BANG XEP HANG", "Da Quy", "Dong y", "Huy bo");
			}
			else
			{
			   SendClientMessageEx( playerid, COLOR_WHITE, "Khong the su dung lenh nay" );
			}
		}
	}
	return 1;
}
