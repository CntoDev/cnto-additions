params ["_target", "_caller"];

private _teleportSuccess = false;   // set to true later if valid position found
private _failPos = [-500, -500, 0]; // Position to be returned by cnto_telestation_fnc_customFindSafePos if no valid position is found
                                    // so set this is somthing that will never logically occur if a safe position WAS found.

private _blacklistUnits = allUnits select {_target distance2D _x < 150}; // all units within 150m are to be checked for visibility and distance
private _blacklistEnemy =    (_blacklistUnits select {(side _caller != side _x) && (side _x != civilian)}) apply {[getPos _x, 75]}; // Do not TP to within 50m of any enemy
private _blacklistFriendly = (_blacklistUnits select {(side _caller == side _x) || (side _x == civilian)}) apply {[getPos _x, 5]}; // Do not TP to within 10m of any friendly or civilian
private _blacklist = _blacklistEnemy + _blacklistFriendly;

// if target is in vehicle and said vehicle has space
if (vehicle _target != _target && vehicle _target emptyPositions "cargo" > 0) then {
    private _veh = vehicle _target;
    _caller moveInCargo _veh;
    _teleportSuccess = true;

} else {
    private _pos = _failPos;
    
    if (vehicle _target != _target && {vehicle _target isKindOf "Air" || speed vehicle _target > 15}) exitWith {}; // Don't teleport player near a full helicopter or fast-moving vehicle

    for "_maxDist" from 10 to 100 step 10 do {
        _pos = [
            getPos _target,         // centre
            10,                     // min dist
            _maxDist,               // max dist
            1,                      // min dist from any object
            0,                      // water mode
            0.1,                    // max ground gradient
            0,                      // shore mode
            _blacklist,             // blacklist positions array
            _blacklistUnits,        // blacklisted unit visibility checks
            side _caller,           // friendly side
            [_failPos, _failPos]    // default positions if no pos found
        ] call cnto_telestation_fnc_customFindSafePos;
        
        if !(_pos isEqualTo _failPos) exitWith {};
    };

    if !(_pos isEqualTo _failPos) then {
        _caller setPos _pos;
        _teleportSuccess = true;
    };

};
// snitch on player to Zeus
[_caller, _teleportSuccess] remoteExec ["cnto_telestation_fnc_bugDaZeus"];

_teleportSuccess
