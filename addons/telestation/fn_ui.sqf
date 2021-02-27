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
                private _validTargets = playableUnits select {side _x == side _caller && _x != _caller};
                private _validTargetNames = _validTargets apply {name _x};

                [
                    "Telestation: destination selector",
                    [
                        ["LIST", "Select a player to move near to", [_validTargets, _validTargetNames, 0]]
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
