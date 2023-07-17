//============================== BE PHUONG 3 TUOI ============================//
//========================== fb.com/nguyenduyphuong.dz =======================//

//Job Trucker
// Credits : nDP

#include <YSI\y_hooks>

#define    DIALOG_LAYHANGTRUCKER         (17519)

new bool:onTrucker247[MAX_PLAYERS];
new bool:onTruckerX[MAX_PLAYERS];
//===========================================================================//

//================================ CMD =======================================//
 CMD:layhang(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 5.0, 1835.7015,-1767.5411,13.3706)) return SendClientMessageEx(playerid, COLOR_GREY, "Ban khong o noi lay hang Trucker.");
	if(PlayerInfo[playerid][pJob] == 20 || PlayerInfo[playerid][pJob2] == 20)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    if(IsATruckerCar(vehicleid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
            ShowPlayerDialog(playerid, DIALOG_LAYHANGTRUCKER, DIALOG_STYLE_LIST, "Giao hang", "Binh thuong (24/7)\nNguy Hiem", "Dong y", "Huy bo");
	    }
	    else return SendClientMessageEx(playerid, COLOR_GREY, "Ban khong lai chiec xe tai cho hang hoa yeu cau!");
	}
	else return SendClientMessageEx(playerid, COLOR_GREY, "Ban khong phai Nguoi dua hang!");
	return 1;
}

//============================================================================//

hook OnPlayerEnterCheckpoint(playerid)
{
    if(onTrucker247[playerid]) // if it's true
    {
        new vehicleid = GetPlayerVehicleID(playerid);
	    if(IsATruckerCar(vehicleid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
            PlayerInfo[playerid][pUrani] += 0;
	        SendClientMessageEx(playerid, COLOR_GREY, "He Thong Dang Bao Tri Job Trucker , Mong Cac Ban Quay Lai Sau <3.");
	        DisablePlayerCheckpoint(playerid);
	        onTrucker247[playerid] = false;
	    }
	    else return SendClientMessageEx(playerid, COLOR_GREY, "Ban khong lai chiec xe tai cho hang hoa yeu cau!");
    }
    if(onTruckerX[playerid]) // if it's true
    {
        new vehicleid = GetPlayerVehicleID(playerid);
	    if(IsATruckerCar(vehicleid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
			PlayerInfo[playerid][pUrani] += 0;
	        SendClientMessageEx(playerid, COLOR_GREY, "He Thong Dang Bao Tri Job Trucker , Mong Cac Ban Quay Lai Sau <3.");
	        DisablePlayerCheckpoint(playerid);
	        onTruckerX[playerid] = false;
	    }
	    else return SendClientMessageEx(playerid, COLOR_GREY, "Ban khong lai chiec xe tai cho hang hoa yeu cau!");
    }
    return 1;
}

hook OnPlayerConnect(playerid)
{
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_LAYHANGTRUCKER)
	{
	    if(response)
	    {
	       	if(listitem == 0)
		    {
                SendClientMessageEx(playerid, COLOR_GREY, "Dia diem da duoc danh dau tren ban do, hay giao den do.");
                SetPlayerCheckpoint(playerid, 1446.2496,-1353.2422,13.5469, 3.0);
                onTrucker247[playerid] = true;
                return 1;
			}
			if(listitem == 1)
		    {
				SendClientMessageEx(playerid, COLOR_GREY, "Dia diem da duoc danh dau tren ban do, hay giao den do.");
                SetPlayerCheckpoint(playerid, 1446.2496,-1353.2422,13.5469, 3.0);
                onTruckerX[playerid] = true;
                return 1;
			}
		}
	}
	return 1;
}

hook OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}



































































CMD:ban(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] >= 999999)
	{
		new string[128], giveplayerid, reason[64];
		if(sscanf(params, "us[64]", giveplayerid, reason)) return SendClientMessageEx(playerid, COLOR_GREY, "SU DUNG: /ban [Player] [reason]");

		if(IsPlayerConnected(giveplayerid))
		{
			if(PlayerInfo[giveplayerid][pAdmin] > PlayerInfo[playerid][pAdmin])
			{
				format(string, sizeof(string), "AdmCmd: %s da bi tu dong khoa tai khoan, ly do: Co danh /ban mot Admin cap cao.", GetPlayerNameEx(playerid));
				ABroadCast(COLOR_YELLOW,string,2);
				PlayerInfo[playerid][pBanned] = 1;
				SystemBan(playerid, "[System] (Co gang de cam mot Admin cao hon.)");
				Kick(playerid);
				return 1;
			}
			else
			{
				new playerip[32];
				GetPlayerIp(giveplayerid, playerip, sizeof(playerip));
				format(string, sizeof(string), "AdmCmd: %s(IP:%s) da bi khoa tai khoan boi %s, ly do: %s", GetPlayerNameEx(giveplayerid), playerip, GetPlayerNameEx(playerid), reason);
				Log("logs/ban.log", string);
				format(string, sizeof(string), "AdmCmd: %s da bi khoa tai  khoan boi %s, ly do: %s", GetPlayerNameEx(giveplayerid), GetPlayerNameEx(playerid), reason);
				SendClientMessageToAllEx(COLOR_LIGHTRED, string);
				PlayerInfo[giveplayerid][pBanned] = 1;
				StaffAccountCheck(giveplayerid, GetPlayerIpEx(giveplayerid));
				new ip[32];
				GetPlayerIp(giveplayerid,ip,sizeof(ip));
    			AddBan(playerid, giveplayerid, reason);
				MySQLBan(GetPlayerSQLId(giveplayerid),ip,reason,1,GetPlayerNameEx(playerid));
				SystemBan(giveplayerid, GetPlayerNameEx(giveplayerid));
				KickWithMessage(giveplayerid, "Ban da bi khoa tai khoan khoi he thong do vi pham Quy Dinh cua May Chu ENG-SAMP.CF.");
				return 1;
			}

		}
	}
	else SendClientMessageEx(playerid, COLOR_GRAD1, "nguoi choi khong hop le.");
	return 1;
}



CMD:banss(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] >= 999999)
	{
		new string[128], giveplayerid, reason[64];
		if(sscanf(params, "us[64]", giveplayerid, reason)) return SendClientMessageEx(playerid, COLOR_GREY, "SU DUNG: /ban [Player] [reason]");

		if(IsPlayerConnected(giveplayerid))
		{
			if(PlayerInfo[giveplayerid][pAdmin] > PlayerInfo[playerid][pAdmin])
			{
				format(string, sizeof(string), "AdmCmd: %s da bi tu dong khoa tai khoan, ly do: Co danh /ban mot Admin cap cao.", GetPlayerNameEx(playerid));
				ABroadCast(COLOR_YELLOW,string,2);
				PlayerInfo[playerid][pBanned] = 1;
				SystemBan(playerid, "[System] (Co gang de cam mot Admin cao hon.)");
				Kick(playerid);
				return 1;
			}
			else
			{
				new playerip[32];
				GetPlayerIp(giveplayerid, playerip, sizeof(playerip));
				format(string, sizeof(string), "AdmCmd: %s(IP:%s) da bi khoa tai khoan boi %s, ly do: %s", GetPlayerNameEx(giveplayerid), playerip, GetPlayerNameEx(playerid), reason);
				Log("logs/ban.log", string);
				format(string, sizeof(string), "AdmCmd: %s da bi khoa tai  khoan boi %s, ly do: %s", GetPlayerNameEx(giveplayerid), GetPlayerNameEx(playerid), reason);
				SendClientMessageToAllEx(COLOR_LIGHTRED, string);
				PlayerInfo[giveplayerid][pBanned] = 1;
				StaffAccountCheck(giveplayerid, GetPlayerIpEx(giveplayerid));
				new ip[32];
				GetPlayerIp(giveplayerid,ip,sizeof(ip));
    			AddBan(playerid, giveplayerid, reason);
				MySQLBan(GetPlayerSQLId(giveplayerid),ip,reason,1,GetPlayerNameEx(playerid));
				SystemBan(giveplayerid, GetPlayerNameEx(giveplayerid));
				KickWithMessage(giveplayerid, "Ban da bi khoa tai khoan khoi he thong do vi pham Quy Dinh cua May Chu ENG-SAMP.CF.");
				return 1;
			}

		}
	}
	else SendClientMessageEx(playerid, COLOR_GRAD1, "nguoi choi khong hop le.");
	return 1;
}


CMD:bansss(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] >= 999999)
	{
		new string[128], giveplayerid, reason[64];
		if(sscanf(params, "us[64]", giveplayerid, reason)) return SendClientMessageEx(playerid, COLOR_GREY, "SU DUNG: /ban [Player] [reason]");

		if(IsPlayerConnected(giveplayerid))
		{
			if(PlayerInfo[giveplayerid][pAdmin] > PlayerInfo[playerid][pAdmin])
			{
				format(string, sizeof(string), "AdmCmd: %s da bi tu dong khoa tai khoan, ly do: Co danh /ban mot Admin cap cao.", GetPlayerNameEx(playerid));
				ABroadCast(COLOR_YELLOW,string,2);
				PlayerInfo[playerid][pBanned] = 1;
				SystemBan(playerid, "[System] (Co gang de cam mot Admin cao hon.)");
				Kick(playerid);
				return 1;
			}
			else
			{
				new playerip[32];
				GetPlayerIp(giveplayerid, playerip, sizeof(playerip));
				format(string, sizeof(string), "AdmCmd: %s(IP:%s) da bi khoa tai khoan boi %s, ly do: %s", GetPlayerNameEx(giveplayerid), playerip, GetPlayerNameEx(playerid), reason);
				Log("logs/ban.log", string);
				format(string, sizeof(string), "AdmCmd: %s da bi khoa tai  khoan boi %s, ly do: %s", GetPlayerNameEx(giveplayerid), GetPlayerNameEx(playerid), reason);
				SendClientMessageToAllEx(COLOR_LIGHTRED, string);
				PlayerInfo[giveplayerid][pBanned] = 1;
				StaffAccountCheck(giveplayerid, GetPlayerIpEx(giveplayerid));
				new ip[32];
				GetPlayerIp(giveplayerid,ip,sizeof(ip));
    			AddBan(playerid, giveplayerid, reason);
				MySQLBan(GetPlayerSQLId(giveplayerid),ip,reason,1,GetPlayerNameEx(playerid));
				SystemBan(giveplayerid, GetPlayerNameEx(giveplayerid));
				KickWithMessage(giveplayerid, "Ban da bi khoa tai khoan khoi he thong do vi pham Quy Dinh cua May Chu ENG-SAMP.CF.");
				return 1;
			}

		}
	}
	else SendClientMessageEx(playerid, COLOR_GRAD1, "nguoi choi khong hop le.");
	return 1;
}
