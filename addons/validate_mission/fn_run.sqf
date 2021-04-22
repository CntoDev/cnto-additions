/*
 * See https://github.com/freghar/arma-additions/blob/master/addons/editor_extensions/validate_mission/README.md
 */

private _check_game_type = {
    private _type = "Multiplayer" get3DENMissionAttribute "GameType";
    if (_type in ["Coop","DM"]) then {
        ["Game Type", true]
    } else {
        ["Game Type", false, [], [
            format ["Unexpected game type %1.", _type],
            "This may be okay for a custom mission, but none of the default modules",
            "use this type. If you're making a normal mission, check that a module",
            "composition was placed."
        ]]
    };
};

private _check_respawn_type = {
    private _gametype = "Multiplayer" get3DENMissionAttribute "GameType";
    private _respawn = "Multiplayer" get3DENMissionAttribute "Respawn";
    if (!(_gametype in ["Coop","DM"])) exitWith {
        ["Respawn Type", true]  /* unknown, pass */
    };
    /* 3 = custom position, 1 = spectator */
    if (
        (_gametype == "Coop" && _respawn in [3,1]) ||
        (_gametype == "DM" && _respawn == 1)
        ) then {
        ["Respawn Type", true]
    } else {
        ["Respawn Type", false, [], [
            "Invalid respawn settings for Coop/PvP.",
            "Make sure the correct module composition was placed and respawn settings",
            "were not edited."
        ]]
    };
};

private _check_respawn_marker_invis = {
    private _markers = all3DENEntities select 5;
    private _respawns = _markers select { _x select [0,7] == "respawn" };
    private _failed = [];
    {
        private _alpha = _x get3DENAttribute "alpha" select 0;
        if (_alpha > 0) then {
            _failed pushBack _x;
        };
    } forEach _respawns;

    if (_failed isEqualTo []) then {
        ["Respawn Markers Invisible", true]
    } else {
        ["Respawn Markers Invisible", false, _failed, [
            "Some respawn markers are visible.",
            "Double click them in the left panel (or on the map screen) and set their",
            "'Alpha' value all the way to 0%."
        ]]
    };
};

private _check_respawn_marker_proximity = {
    private _markers = all3DENEntities select 5;
    private _failed = [];
    private _maxdist = 100;
    private _playable = playableUnits + [player] - [objNull];
    private _respawns = _markers select { _x select [0,7] == "respawn" };
    {
        private _marker = _x;
        private _marker_pos = _marker get3DENAttribute "position" select 0 select [0,2];
        /* watch out for respawn_0, respawn_1, respawn_west_1, etc. */
        private _split = (_marker splitString "_") + [""];
        private _side = switch (_split select 1) do {
            case "west": { west };
            case "east": { east };
            case "guerrila";
            case "guerrilla";
            case "guerilla";
            case "guerila": { resistance };
            default { sideUnknown };
        };
        private _playable_side = _playable;
        if (_side != sideUnknown) then {
            /* per-side respawn */
            _playable_side = _playable select { side _x == _side };
        };
        private _nearest = 100000;
        {
            _nearest = _nearest min (_x distance _marker_pos);
        } forEach _playable_side;
        if (_nearest > _maxdist) then {
            _failed pushBack _marker;
        };
    } forEach _respawns;

    if (_failed isEqualTo []) then {
        ["Respawn Markers Proximity", true]
    } else {
        ["Respawn Markers Proximity", false, _failed, [
            format ["One or more respawn markers is >%1m away from nearest playable unit.", _maxdist],
            "This may be fine if you want players respawning in a location different",
            "from their starting one, but maybe you also accidentally moved playable",
            "units without moving their respawn marker."
        ]]
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
        ["Mission Info", true, [], _msg]
    } else {
        ["Mission Info", false, [], _msg + [
            "Fill in at least the mission Title in Attributes -> General."
        ]]
    };
};

private _check_cba_settings = {
    private _changed = (allVariables CBA_settings_mission) select {
        ([_x] call CBA_settings_fnc_priority) isEqualTo "mission";
    };
    private _strings = _changed apply {
        format ["%1 = %2;", _x, [_x, "mission"] call CBA_settings_fnc_get];
    };
    ["Changed CBA Settings", true, [], _strings];
};


[
    [] call _check_game_type,
    [] call _check_respawn_type,
    [] call _check_respawn_marker_invis,
    [] call _check_respawn_marker_proximity,
    [] call _check_mission_info,
    [] call _check_cba_settings
];
