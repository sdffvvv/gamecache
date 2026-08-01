if(!IsSoundPrecached("chimcham/fnaf2jumpscare.wav"))
{
	PrecacheSound("chimcham/fnaf2jumpscare.wav")
}

SpawnEntityFromTable("env_screenoverlay", { targetname = "ChCh_WitheredFoxy", OverlayName1 = "chimcham/fnaf2foxy", OverlayTime1 = -1})
SpawnEntityFromTable("info_target", { targetname = "ChCh_WitheredFoxy_Sound1"})
SpawnEntityFromTable("info_target", { targetname = "ChCh_WitheredFoxy_Sound2"})

Convars.SetValue("mp_weapon_p228_price", 0)

ChCh_FoxyScare <-
{
    function OnGameEvent_player_say( params )
    {
        if("userid" in params && "text" in params)
        {
    		local player = GetPlayerFromUserID(params.userid)
    		local whatsay = params.text.tolower()
    
            if(whatsay == "!foxy" && player == GetListenServerHost())
			{
				ClientPrint(null, 3, " ")
				ClientPrint(null, 3, " ")
				ClientPrint(null, 3, " ")
				ClientPrint(null, 3, " ")
				ClientPrint(null, 3, " ")
				ClientPrint(null, 3, " ")
				ClientPrint(null, 3, " ")
				ClientPrint(null, 3, " ")
				Jumpscare()
			}
        }
    }

    function OnGameEvent_round_start(params) 
    {
        g_MapScript.ScriptedMode_AddUpdate(FoxyTimes)
    }

	function FoxyTimes()
	{
		if(RandomInt(1,1000) == 1)
		{
			DirectorScript.ChCh_FoxyScare.Jumpscare()
		}
	}

	function Jumpscare()
	{
		if(!Director.IsPlayingIntro())
	    EntFire("ChCh_WitheredFoxy", "StartOverlays", "", 0.0, null)
		for(local index = 0 ; index < 18 ; index += 1)
		{
			EntFire("worldspawn", "RunScriptCode", "Convars.SetValue(\"mp_weapon_p228_price\", " + index.tostring() + ")", index * 0.06, null)
		}
	    EntFire("ChCh_WitheredFoxy", "StopOverlays", "", 1.05, null)
	    EmitAmbientSoundOn("chimcham/fnaf2jumpscare.wav", 1.0, 0, 100, Entities.FindByName(null, "ChCh_WitheredFoxy_Sound1"))
	    EmitAmbientSoundOn("chimcham/fnaf2jumpscare.wav", 1.0, 0, 100, Entities.FindByName(null, "ChCh_WitheredFoxy_Sound2"))
	}
}

__CollectEventCallbacks(ChCh_FoxyScare, "OnGameEvent_", "GameEventCallbacks", RegisterScriptGameEventListener);

//script DirectorScript.ChCh_FoxyScare.Jumpscare()