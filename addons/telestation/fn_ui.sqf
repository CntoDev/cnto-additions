/* ----------------------------------------------------------------------------
Function: cnto_telestation_fnc_telestation;
Description:
    Adds a telestation UI to an object. The telestation allows a player to teleport to any other player on their team
    But will not teleport the player near or in the line of sight of enemies or friendlies.
Parameters:
    0: The item to attach the telestation to addaction to.
Returns:
    None
Examples:
    (begin example)
        this call cnto_telestation_fnc_telestation;
    (end)
Author:
    Seb
---------------------------------------------------------------------------- */
params ["_telestation"];

private _fnc_UI = {
    params ["_caller"];

    [
        "Telestation",
        [
            ["EDIT:MULTI", "The telestation is only to be used in cases of technical problems.", ["", {}, 0], true],
            ["EDIT:MULTI", "Confirm your use is because of technical difficulties.", ["", {}, 0], true], 
            ["CHECKBOX", "Confirm", false, true]
        ],
        {
            /*---------------------------------------------------------*/
            params ["_dialog_data","_caller"];
            _dialog_data params ["_text1", "_text2", "_ticked"];
            if (_ticked) then {
                private _validTargets = [
                    playableUnits,                                  // Initial list
                    [],                                             // Params
                    {groupID group _x},                             // Sort by group name
                    "ASCEND",                                       // Ascending
                    {side _x == side _caller && _x != _caller}      // Filter to remove things from list
                    ] call BIS_fnc_sortBy;
                
                private _fnc_getUnitInsigniaTexture = {
                    params ["_unit"];
                    private _insigniaClass = _unit getVariable ["BIS_fnc_setUnitInsignia_class", ""];
                    private _cfg = missionConfigFile >> "CfgUnitInsignia" >> _insigniaClass;
                    if (!isClass _cfg) then {
                        _cfg = campaignConfigFile >> "CfgUnitInsignia" >> _insigniaClass;
                        if (!isClass _cfg) then {
                            _cfg = configFile >> "CfgUnitInsignia" >> _insigniaClass;
                        };
                    };
                    
                    private _texture = getText (_cfg >> "texture");
                    _texture
                };

                private _validTargetDisplay = _validTargets apply {
                    [
                        name _x,                        // Name of unit
                        groupID group _x,               // Group name (Alpha, Bravo etc)
                        _x call _fnc_getUnitInsigniaTexture    // Unit insignia
                    ]
                };

                [
                    "Telestation: destination selector",
                    [
                        ["LIST", "Select a player to move near to", [_validTargets, _validTargetDisplay, 0]]
                    ],
                    {
                        params ["_dialog_data","_caller"];
                        _dialog_data params ["_target"];
                        private _success = [_target, _caller] call cnto_telestation_fnc_teleportUnit;
                        if (_success) then {
                            systemchat format ["Moved to near %1", name _target];
                        } else {
                            systemchat "Could not find teleport position. Try again or try another player.";
                        };
                    },
                    {},
                    _caller
                ] call zen_dialog_fnc_create;
            } else {
                systemchat "The telestation is only to be used in cases of technical difficulties"
            };
            /*---------------------------------------------------------*/
        },
        {},
        _caller
    ] call zen_dialog_fnc_create;
};

_telestation addAction
[
    "Use telestation",    // title
    {
        params ["_target", "_caller", "_actionId", "_fnc_UI"]; // script
        _caller call _fnc_UI;
    },
    _fnc_UI,    // arguments
    1.5,        // priority
    true,       // showWindow
    true,       // hideOnUse
    "",         // shortcut
    "true",     // condition
    3,         // radius
    false,      // unconscious
    "",         // selection
    ""          // memoryPoint
];
