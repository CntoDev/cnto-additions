/*
 * See https://github.com/freghar/arma-additions/blob/master/addons/editor_extensions/validate_mission/README.md
 */

private _check_game_type = {
    private _type = "Multiplayer" get3DENMissionAttribute "GameType";
    if (_type in ["Coop","DM"]) then {
        ["Game type", true];
    } else {
        ["Game type", false, [], [
            format ["Unexpected game type %1.", _type],
            "This may be okay for a custom mission, but none of the default modules",
            "use this type. If you're making a normal mission, check that a module",
            "composition was placed."
        ]];
    };
};

private _check_respawn_type = {
    private _gametype = "Multiplayer" get3DENMissionAttribute "GameType";
    private _respawn = "Multiplayer" get3DENMissionAttribute "Respawn";
    if (!(_gametype in ["Coop","DM"])) exitWith {
        ["Respawn type", true]  /* unknown, pass */
    };
    /* 3 = custom position, 1 = spectator */
    if (
        (_gametype == "Coop" && _respawn in [3,1]) ||
        (_gametype == "DM" && _respawn == 1)
        ) then {
        ["Respawn type", true];
    } else {
        ["Respawn type", false, [], [
            "Invalid respawn settings for Coop/PvP.",
            "Make sure the correct module composition was placed and respawn settings",
            "were not edited."
        ]];
    };
};

private _check_respawn_marker_invis = {
    private _failed = (all3DENEntities select 5) select {
        private _alpha = _x get3DENAttribute "alpha" select 0;
        _x select [0,7] == "respawn" && _alpha > 0;
    };
    if (_failed isEqualTo []) then {
        ["Respawn markers invisible", true];
    } else {
        ["Respawn markers invisible", false, _failed, [
            "Some respawn markers are visible.",
            "Double click them in the left panel (or on the map screen) and set their",
            "'Alpha' value all the way to 0%."
        ]];
    };
};

private _check_respawn_marker_proximity = {
    private _maxdist = 100;
    private _playable = playableUnits + [player] - [objNull];
    private _respawns = (all3DENEntities select 5) select {
        _x select [0,7] == "respawn";
    };
    private _failed = _respawns select {
        private _marker_pos = _x get3DENAttribute "position" select 0 select [0,2];
        private _found = _playable findIf {
            private _pos2d = position _x select [0,2];
            _pos2d distance _marker_pos < _maxdist;
        };
        _found == -1;
    };
    if (_failed isEqualTo []) then {
        ["Respawn markers proximity", true];
    } else {
        private _msg = [
            format ["One or more respawn markers is >%1m away from nearest playable unit.", _maxdist],
            "Perhaps you accidentally moved playable units without moving their",
            "respawn marker?"
        ];
        private _modules = all3DENEntities select 3;
        private _found = _modules findIf { _x isKindOf "a3aa_ee_teleport_on_jip" };
        if (_found != -1) then {
            private _tel_on_jip = _modules select _found;
            private _pos2d = position _tel_on_jip select [0,2];
            private _closest_respawn = selectMin (
                _respawns apply {
                    private _marker_pos = _x get3DENAttribute "position" select 0 select [0,2];
                    _pos2d distance _marker_pos;
                }
            );
            if (_closest_respawn > _maxdist) then {
                _msg append [
                    format ["The 'Teleport on JIP' module is also >%1m away from nearest respawn", _maxdist],
                    "which is probably not intentional (JIPs joining on a place different",
                    "from where players respawn). Move it closer to a respawn marker."
                ];
                ["Respawn markers proximity", false, _failed, _msg];
            } else {
                ["Respawn markers proximity", true];
            };
        } else {
            _msg append [
                "If the starting position is vastly different from the respawn location,",
                "consider using the 'Teleport on JIP' module."
            ];
            ["Respawn markers proximity", false, _failed, _msg];
        };
    };
};

private _check_respawn_marker_count = {
    private _gametype = "Multiplayer" get3DENMissionAttribute "GameType";
    if (_gametype != "Coop") exitWith {
        ["Respawn marker count", true];
    };
    private _count = {
        _x select [0,7] == "respawn";
    } count (all3DENEntities select 5);
    if (_count <= 1) then {
        ["Respawn marker count", true];
    } else {
        ["Respawn marker count", false, [], [
            format ["Found >1 (%1) respawn markers.", _count],
            "Using multiple respawn markers for Coop results in players respawning",
            "on randomly chosen respawn markers. This is a very rare use case.",
            "It's more likely that you deleted a player faction composition in 3D",
            "and re-placed it, leaving old map markers behind.",
            "Either delete those markers from the left panel (or map view) or simply",
            "delete the entire placed composition in map view + re-place it."
        ]];
    };
};

private _check_mission_info = {
    private _title = "Scenario" get3DENMissionAttribute "IntelBriefingName";
    private _picture = "Scenario" get3DENMissionAttribute "OverviewPicture";
    private _text = "Scenario" get3DENMissionAttribute "OverviewText";
    private _msg = [];
    if (_title == "") then { _msg pushBack "Mission Title is empty." };
    if (_picture == "") then { _msg pushBack "Mission Overview Picture is empty." };
    if (_text == "") then { _msg pushBack "Mission Overview Text is empty." };
    if (_title != "") then {
        ["Mission info", true, [], _msg];
    } else {
        ["Mission info", false, [], _msg + [
            "Fill in at least the mission Title in Attributes -> General."
        ]];
    };
};

private _check_cba_settings = {
    private _changed = (allVariables CBA_settings_mission) select {
        ([_x] call CBA_settings_fnc_priority) isEqualTo "mission";
    };
    private _strings = _changed apply {
        format ["%1 = %2;", _x, [_x, "mission"] call CBA_settings_fnc_get];
    };
    ["Changed CBA settings", true, [], _strings];
};

private _check_playable_units = {
    private _msg = [];
    private _pass = true;
    if (count playableUnits < 35) then {
        (_msg pushBack "Not enough playable units: 35 required")};
        _pass = false;
    if ((group player get3DENAttribute "a3aa_ee_persistent_callsign" select 0) isEqualTo "") then {
        _msg pushback "Possible AI unit marked as player.";
        _msg pushback "Did you place some AI before any playable units?";
        _pass = false;
    };

    ["Playable unit checks", _pass, [], _msg]
};

private _check_default_modules = { 
    private _msg = []; 
    private _pass = true; 
    if ((all3DENEntities#7) apply {(_x get3DENAttribute "name")#0} find "CNTO" isEqualTo -1) then { 
        _msg pushBack "Default CNTO modules not detected.";
        _msg pushBack "Place down the default CNTO Co-op or PvP modules.";
        _pass = false; 

    } else { 

        private _briefingModules = all3DENEntities#3 select {typeOf _x isEqualTo "a3aa_ee_briefing"}; 
        if (count _briefingModules > 0) then { 

            { 
                private _module = _x;
                private _moduleIndex = _forEachIndex + 1;
                { 
                    private _fieldText = (_module get3DENAttribute _x)#0; 
                    if (count _fieldText < 5) then { 
                        _msg pushBack format ["Field '%1' of the OPORD briefing module %2 is incomplete", _x select [17], _moduleIndex]; 
                        _pass = false; 
                    } 
                } forEach ["a3aa_ee_briefing_situation", "a3aa_ee_briefing_mission", "a3aa_ee_briefing_execution", "a3aa_ee_briefing_admin_logistics"]; 
            } forEach _briefingModules; 

        } else { 
            _msg pushBack "No OPORD briefing modules found";
            _msg pushBack "The default CNTO modules seem to have been placed, yet no briefing module has been found.";
            _msg pushBack "Delete the whole CNTO Module set and re-place it.";
            _pass = false; 
        } 

    }; 

    ["CNTO module check", _pass, [], _msg]; 
};


[
    [] call _check_game_type,
    [] call _check_respawn_type,
    [] call _check_respawn_marker_invis,
    [] call _check_respawn_marker_proximity,
    [] call _check_respawn_marker_count,
    [] call _check_mission_info,
    [] call _check_cba_settings,
    [] call _check_playable_units,
    [] call _check_default_modules
];
