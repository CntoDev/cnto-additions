if !(cnto_littlebird_hud_enable) exitWith {};

cnto_littlebird_hud_isCurrentPilot = false;

params ["_vehicle"];
// AH-6 is zeroed to eye level of player, not vehicle centre. AH-9 is zeroed to centre of aircraft model. Therefore offset Z level of reticle if vehicle is AH-6
private _zOffset = [0, 25] select (_vehicle isKindOf "RHS_MELB_AH6M");
private _size = 1 / (getResolution select 5);

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

            // Checking this every frame is bad but the alternatives are worse. 1 of 2. Explained at the end.
            if !(cnto_littlebird_hud_isCurrentPilot) then {
                cnto_littlebird_hud_isCurrentPilot = true;
                [_vehicle, false] call cnto_littlebird_hud_fnc_showGreaseDot;
            };

        } else {
            
            // Checking this every frame is bad but the alternatives are worse. 2 of 2. Explained at the end.
            if (cnto_littlebird_hud_isCurrentPilot) then {
                cnto_littlebird_hud_isCurrentPilot = false;
                [_vehicle, true] call cnto_littlebird_hud_fnc_showGreaseDot;
            };
        };

    } else {

        [_handle] call CBA_fnc_removePerFrameHandler;

        // Restore grease dot on vehicle exit if pilot
        if (cnto_littlebird_hud_isCurrentPilot) then {
            [_vehicle, true] call cnto_littlebird_hud_fnc_showGreaseDot;
        };

        cnto_littlebird_hud_isCurrentPilot = nil;
    };
}, 0, [_vehicle,_size,_zOffset]] call CBA_fnc_addPerFrameHandler;

/*
Explanation of retarded global variable checking every frame:
    In order to respect cnto_littlebird_hud_enable user preference and remove the grease dots if the hud is enabled, we must do all this stuff.

    Problems:
        animateSource is always global and has no local variant, so we might as well be using setObjectTextureGlobal as well.
        If we simply remove the grease dot upon entering the vehicle, this will overwrite the pilot when a passenger gets in if pilot has hud disabled and passenger has hud enabled
        If we check if the player is the pilot when they first get in, this will not account for swapping from passenger to pilot, should that happen.
        Calling animateSource or setObjectTextureGlobal to enforce user preference every frame will spam the network, and so must be avoided.

    Therefore, an ugly solution:
        Have a global variable isPilot that defaults to false. Check it every frame, and if the player is the pilot and the variable is false, then they are now the pilot when they previously were not
        Therefore remove the grease dot and set the variable to false, so the network is not spammed. This unfortunately means the variable must be checked every frame

        If the player is no longer the pilot for but the global isPilot variable is true, the player has switched seat or got out:
        Therefore, restore the grease dot to respect the settings of the next person to become the pilot.

        This has a race condition when the active pilot swaps in a small timeframe like a single frame, whoever reaches the server last has their settings applied.
        This does not matter for pilot-copilot switches, which are common as, only the main pilot has a grease dot anyway, so no harm done if race conditon occurs.
        This may cause real problems if a player is moved out of a pilot seat via script, and another player is moved in in a single frame. This is rare enough, and the fix is to just get in and out of the vehicle.
*/
