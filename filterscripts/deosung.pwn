
#include <a_samp>



public OnFilterScriptInit()
{
    print("\n--------------------------------------");
    print(" FS Deo Sung Share by BLOG Code SA-MP");
    print("--------------------------------------\n");
    return 1;
}
enum //attach slot
{
    SLOT_HAT,//0
    SLOT_MASK,//1
    SLOT_TOY1,//2
    SLOT_TOY2,//3
    SLOT_TOY3,//4
    SLOT_TOY4,//5
    //
    SLOT_WEAPON2,//6
    SLOT_WEAPON6,//7
    SLOT_BLEED,//8
    SLOT_BAG//9
}
public OnPlayerUpdate(playerid)
{
    if(IsPlayerNPC(playerid)) return 1;
    new weaponid2,weaponid6,weaponid3,weaponid4,weaponid5,ammo,weaponid10;
    GetPlayerWeaponData(playerid,2,weaponid2,ammo);
    GetPlayerWeaponData(playerid,3,weaponid3,ammo);
    GetPlayerWeaponData(playerid,4,weaponid4,ammo);
    GetPlayerWeaponData(playerid,5,weaponid5,ammo);
    GetPlayerWeaponData(playerid,6,weaponid6,ammo);
    GetPlayerWeaponData(playerid,10,weaponid10,ammo);
    if(weaponid5 > 0)
    {
        if(GetPlayerWeapon(playerid) == weaponid5)
        {
        RemovePlayerAttachedObject(playerid,SLOT_TOY4);
        }
        else
        {
        SetPlayerAttachedObject(playerid,SLOT_TOY4, GetWeaponModel(weaponid5), 1, 0.000000, -0.036000, 0.081000, 92.900009, 1.000000, 7.200002, 1.000000, 1.000000, 1.000000, 0, 0);
        }
    }
    else if(weaponid5 == 0)
    {
    RemovePlayerAttachedObject(playerid,SLOT_TOY4);
    }
    if(weaponid3 > 0)
    {
        if(GetPlayerWeapon(playerid) == weaponid3)
        {
        RemovePlayerAttachedObject(playerid,SLOT_TOY2);
        }
        else
        {
        SetPlayerAttachedObject(playerid,SLOT_TOY2, GetWeaponModel(weaponid3), 1, -0.176000, -0.057999, -0.153000, 95.900001, 13.100000, 11.399998, 1.000000, 1.000000, 1.000000, 0, 0);
        }
    }
    else if(weaponid3 == 0)
    {
    RemovePlayerAttachedObject(playerid,SLOT_TOY2);
    }
    if(weaponid4 > 0)
    {
        if(GetPlayerWeapon(playerid) == weaponid4)
        {
        RemovePlayerAttachedObject(playerid,SLOT_TOY3);
        }
        else
        {
        SetPlayerAttachedObject(playerid,SLOT_TOY3, GetWeaponModel(weaponid4), 7, 0.000000, -0.145999, -0.055999, -74.899986, 0.000000, 9.199999, 1.000000, 1.000000, 1.000000, 0, 0);
        }
    }
    else if(weaponid4 == 0)
    {
    RemovePlayerAttachedObject(playerid,SLOT_TOY3);
    }
    if(weaponid10 == 15)
    {
       if(GetPlayerWeapon(playerid) != 15)
       {
       SetPlayerAttachedObject(playerid,SLOT_MASK, 2590, 1, -0.414000, -0.110999, 0.082000, 0.000000, -88.799995, -66.099998, 0.658000, 0.388999, 0.500000, 0, 0);
       }
       else
       {
        RemovePlayerAttachedObject(playerid,SLOT_MASK);
       }
    }
    if(weaponid2 > 0)
    {
        if(GetPlayerWeapon(playerid) == weaponid2)
        {
        RemovePlayerAttachedObject(playerid,SLOT_WEAPON2);
        }
        else
        {
        SetPlayerAttachedObject(playerid,SLOT_WEAPON2, GetWeaponModel(weaponid2), 8, 0.000000, -0.047000, 0.104999, -99.399978, 0.000000, -5.099998, 0.852000, 1.000000, 0.940000, 0, 0);
        }
    }
    else if(weaponid2 == 0)
    {
    RemovePlayerAttachedObject(playerid,SLOT_WEAPON2);
    }
    if(weaponid6 > 0)
    {
        if(GetPlayerWeapon(playerid) == weaponid6)
        {
        RemovePlayerAttachedObject(playerid,SLOT_WEAPON6);
        }
        else
        {
        SetPlayerAttachedObject(playerid, SLOT_WEAPON6, GetWeaponModel(weaponid6), 1, 0.039000, 0.036000, -0.176999, 86.100013, 0.000000, 7.000000, 1.000000, 1.000000, 1.000000, 0, 0);
        }

    }
    else if(weaponid6 == 0)
        {
        RemovePlayerAttachedObject(playerid,SLOT_WEAPON6);
        }
    return 1;
}
stock GetWeaponModel(weaponid)
{
    switch(weaponid)
    {
        case 1: return 331;
        case 2: return 333;
        case 3: return 334;
        case 4: return 335;
        case 5: return 336;
        case 6: return 337;
        case 7: return 338;
        case 8: return 339;
        case 9: return 341;
        case 10: return 321;
        case 11: return 322;
        case 12: return 323;
        case 13: return 324;
        case 14: return 325;
        case 15: return 326;
        case 16: return 342;
        case 17: return 343;
        case 18: return 344;
        case 22: return 346;
        case 23: return 347;
        case 24: return 348;
        case 25: return 349;
        case 26: return 350;
        case 27: return 351;
        case 28: return 352;
        case 29: return 353;
        case 30: return 355;
        case 31: return 356;
        case 32: return 372;
        case 33: return 357;
        case 34: return 358;
        case 35: return 359;
        case 36: return 360;
        case 37: return 361;
        case 38: return 362;
        case 39: return 363;
        case 40: return 364;
        case 41: return 365;
        case 42: return 366;
        case 43: return 367;
        case 44: return 368;
        case 45: return 369;
        case 46: return 371;
        default: return -1;
    }
    return -1;
}
public OnFilterScriptExit()
{
    return 1;
}

public OnPlayerConnect(playerid)
{
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    return 1;
}

public OnPlayerSpawn(playerid)
{
    return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    return 1;
}

public OnVehicleSpawn(vehicleid)
{
    return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
    return 1;
}

public OnPlayerText(playerid, text[])
{
    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    if (strcmp("/mycommand", cmdtext, true, 10) == 0)
    {
        // Do something here
        return 1;
    }
    return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
    return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
    return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
    return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
    return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
    return 1;
}

public OnRconCommand(cmd[])
{
    return 1;
}

public OnPlayerRequestSpawn(playerid)
{
    return 1;
}

public OnObjectMoved(objectid)
{
    return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
    return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
    return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
    return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
    return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
    return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
    return 1;
}

public OnPlayerExitedMenu(playerid)
{
    return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
    return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
    return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
    return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
    return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
    return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
    return 1;
}
