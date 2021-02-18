if !(cnto_littlebird_hud_enable) exitWith {};
params ["_vehicle"];
private _isLittlebird = _vehicle isKindOf "RHS_MELB_AH6M";
// AH-6 is zeroed to eye level of player, not vehicle centre. AH-9 is zeroed to centre of aircraft model. Therefore offset Z level of reticle if vehicle is AH-6
private _zOffset = [0, 25] select _isLittlebird;
private _size = 1 / (getResolution select 5);

// Remove grease dot on vehicle entry
if (_isLittlebird) then {
    _vehicle animateSource ["Addcrosshair", 0, true];
} else {
    _vehicle setObjectTextureGlobal [1, "\A3\Weapons_F\Data\clear_empty.paa"];
};

[{
    _this#0 params ["_vehicle", "_size", "_zOffset"];
    private _currentUnit = call CBA_fnc_currentUnit;
    if (vehicle _currentUnit == _vehicle) then {
        if (currentPilot _vehicle == _currentUnit && isEngineOn _vehicle) then {
            private _zoomSize = _size * (0.9/(getObjectFOV _currentUnit));
            drawIcon3D [
                "cnto\additions\littlebird_hud\reticle.paa", 
                cnto_littlebird_hud_colour, 
                (_vehicle modelToWorldVisual [0, 1000, _zOffset]), 
                _zoomSize, 
                _zoomSize, 
                0
            ];
        };
    } else {
        [_handle] call CBA_fnc_removePerFrameHandler;

        // Restore grease dot on vehicle exit
        if (_vehicle isKindOf "RHS_MELB_AH6M") then {
            _vehicle animateSource ["Addcrosshair", 1, true];
        } else {
            _vehicle setObjectTexture [1, "a3\air_f\heli_light_01\data\heli_light_01_dot_ca.paa"];
        };
    };
}, 0, [_vehicle,_size,_zOffset]] call CBA_fnc_addPerFrameHandler;
