/*
 * show empty inventory on _box if it is closer than _range meters to its
 * initial placement location (as seen on mission start)
 */

params ["_box", "_range"];

if (isServer) then {
    _box setVariable ["cnto_boxguard_data", [
        position _box, _range
    ], true];
};
if (hasInterface) then {
    _box addEventHandler ["ContainerOpened", {
        params ["_box", "_player"];

        private _disabled = _box getVariable ["cnto_boxguard_disabled", false];
        if (_disabled) exitWith {
            _box removeEventHandler ["ContainerOpened", _thisEventHandler];
        };

        private _data = _box getVariable "cnto_boxguard_data";
        if (isNil "_data") exitWith {};
        _data params ["_initpos", "_range"];
        if (position _box distance2D _initpos > _range) exitWith {
            _box setVariable ["cnto_boxguard_disabled", true, true];
        };

        0 = [] spawn {
            waitUntil { !isNull findDisplay 602 };
            (findDisplay 602) closeDisplay 0;
            player action ["Gear", objNull];
        };
    }];
};

private _action = [
    "cnto_boxguard_action_disable",
    "Unlock supply box",
    "",
    { _target setVariable ["cnto_boxguard_disabled", true, true] },
    { rankId _player >= 3 && !(_target getVariable ["cnto_boxguard_disabled", false]) }
] call ace_interact_menu_fnc_createAction;

[
    _box,
    0,
    ["ACE_MainActions"],
    _action
] call ace_interact_menu_fnc_addActionToObject;
