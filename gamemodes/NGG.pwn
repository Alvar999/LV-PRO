#define SERVER_GM_TEXT "Las Venturas"

#include <a_samp>
#include <a_mysql>
#include <a_actor>
#include <streamer>
#include <yom_buttons>		
#include <ZCMD>
#include <dini>
#include <easydialog>
#include <sscanf2>
#include <foreach>
#include <YSI\y_timers>
#include <YSI\y_utils>

#if defined SOCKET_ENABLED
#include <socket>
#endif
#include "./includes/ngg.pwn"
#include "./includes/NCS.pwn"
#include "./includes/Trucker.pwn"
#include "./includes/BXH.pwn"
#include "./includes/TX.pwn"

main() {}

public OnGameModeInit()
{
	print("Dang chuan bi tai gamemode, xin vui long cho doi...");
	g_mysql_Init();
	return 1;
}

public OnGameModeExit()
{
    g_mysql_Exit();
	return 1;
}
