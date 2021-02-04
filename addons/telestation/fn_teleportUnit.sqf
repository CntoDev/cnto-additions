params ["_target", "_caller"];

private _teleportSuccess = false;
private _failPos = [-500, -500, 0];

private _blacklistEnemy = 		(allUnits select {side _caller != side _x && side _x != "civilian"}) apply {[getPos _x, 50]};
private _blacklistFriendly = 	(allUnits select {side _caller == side _x || side _x == "civilian"}) apply {[getPos _x, 10]};
private _blacklist = _blacklistEnemy + _blacklistFriendly;

// if target is in vehicle and said vehicle has space
if (vehicle _target != _target && vehicle _target emptyPositions "cargo" > 0) then {
	private _veh = vehicle _target;
	_caller moveInCargo _veh;
	_teleportSuccess = true;

} else {
	private _pos = _failPos;
	for "_maxDist" from 10 to 100 step 10 do {
		_pos = [
			getPos _target,		// centre
			10, 				// min dist
			_maxDist, 			// max dist
			1, 					// min dist from any object
			0, 					// water mode
			0.1, 				// max ground gradient
			0, 					// shore mode
			_blacklist, 		// blacklist array
			_failPos			// defualt position if no pos found
		] call BIS_fnc_findSafePos;
		
		if !(_pos isEqualTo _failPos) exitWith {};
	};

	if !(_pos isEqualTo _failPos) then {
		_caller setPos _pos;
		_teleportSuccess = true;
	};
};
// snitch on player to Zeus
private _gamemasters = allCurators apply {getAssignedCuratorUnit _x};
(format ["%1 %2 attempted to use the telestation", name _caller, ["unsuccessfully", "successfully"] select _teleportSuccess]) remoteExec ["systemChat", _gamemasters];

_teleportSuccess
