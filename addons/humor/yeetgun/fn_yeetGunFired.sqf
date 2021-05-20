params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
private _barrelPos = eyePos _unit;
if (local _unit) then {
    // Shitty hack for 0 damage bullets, as AI refuse to shoot 0 damage ammo.
    deleteVehicle _projectile;
};
private _range = 85;
private _pressureBase = 13500; // Wind pressure of 335mph wind
private _barrelFOV = 45;
private _nearby = nearestObjects [_unit, ["Static", "CAManBase", "AllVehicles"], _range] - [_unit];
private _weaponDirVec = _unit weaponDirection currentWeapon _unit;
{
    private _target = _x;
    if !(local _target) then {continue};
    private _vectorDirTo = _barrelPos vectorFromTo getPosWorld _target;
    private _distanceToTarget = _target distance _unit;
    private _distanceCoef = 0 max (1 - _distanceToTarget/_range);
    private _weaponDirTo = (_vectorDirTo vectorDiff _weaponDirVec);
    private _weaponDirToMagnitude  = vectorMagnitude _weaponDirTo;
    private _effectiveAngle = deg pi*_weaponDirToMagnitude/2;
    private _angle = _barrelFOV min _effectiveAngle;
    private _angleCoef  = 1 - (_angle/_barrelFOV);
    if (_distanceCoef == 0 || _angleCoef == 0) then {continue};
    
    // Visiblity check
    private _bbr = 0 boundingBoxReal _target;
    private _p1 = _bbr select 0;
    private _p2 = _bbr select 1;
    private _canHit = false;
    // Checks the 8 bounding box points to see if any part of the object is visible. Horrible, right?
    for "_i" from 0 to 1 do {
        private _posX = [_p1#0, _p2#0]#_i;
        for "_j" from 0 to 1 do {
            private _posY = [_p1#1, _p2#1]#_j;
            for "_k" from 0 to 1 do {
                private _posZ = [_p1#2, _p2#2]#_k;
                private _pos = AGLtoASL (_target modelToWorld [_posX, _posY, _posZ]);
                if !(lineIntersects [_barrelPos, _pos, _unit, _target]) exitWith {_canHit = true}
            };
            if (_canHit) exitWith {}
        };
        if (_canHit) exitWith {};
    };
    if !(_canHit) then {continue};

    private _case = ["Static", "CAManBase", "AllVehicles"] findIf {_target isKindOf _x};
    switch (_case) do {
        case 0: {
            // Terrain objects are always local, this fixes that!
            if !(isServer) then {continue};
            _damageDealt = 1 * _angleCoef * _distanceCoef;
            _target setDamage (damage _target + _damageDealt);
        };
        case 1: {
            private _targetArea = 0.75;
            private _pressure = _pressureBase * _distanceCoef * _angleCoef;
            private _force = _pressure * _targetArea;
            private _forceVector = _vectorDirTo vectorMultiply _force;
            _target addForce [_forceVector, [0, 0, 0]];
            [_target, {
                params ["_target"];
                sleep 7;
                waitUntil {speed _target < 1};
                _target setUnconscious false;
            }] remoteExec ["spawn"];
        };
        case 2: {
            private _maxWidth = abs ((_p2 select 0) - (_p1 select 0));
            private _maxLength = abs ((_p2 select 1) - (_p1 select 1));
            private _maxHeight = abs ((_p2 select 2) - (_p1 select 2));
            private _targetArea = _maxWidth * _maxHeight + _maxLength * _maxHeight;
            private _pressure = _pressureBase * _distanceCoef * _angleCoef;
            private _force = _pressure * _targetArea;
            if (_force != 0) then {
                private _forceVector = _vectorDirTo vectorMultiply _force;
                _target addForce [_forceVector, [0, 0, 0]];
            };
        };
    };
} forEach _nearby;

// Smonk
private _direction = getDir _unit;
private _particleDirection = [[0, 25, 3], _direction, 2] call BIS_fnc_rotateVector3D;
private _particleDirectionRandom = [[4, 5, 1], _direction, 2] call BIS_fnc_rotateVector3D;
private _emitter = "#particleSource" createVehicleLocal ASLtoAGL _barrelPos;
_emitter setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,13,0],"","Billboard",1,15,[0,5,0],_particleDirection,0,0.15,0.03,0.075,[13,10],[[0.1,0.067,0.052,0.147318],[0.6,0.5,0.4,0.0966888],[0.6,0.5,0.4,0.0730617],[0.6,0.5,0.4,0.0460592],[0.6,0.5,0.4,0.0190566],[0.6,0.5,0.4,0]],[25,0,0,0],0,0,"","","",0,false,0,[[0,0,0,0]]];
_emitter setParticleRandom [5,[0,3,0],_particleDirectionRandom,20,0.3,[0,0,0,0],0,0,0,0];
_emitter setParticleCircle [5,[3,3,0]];
_emitter setParticleFire [0,0,0];
_emitter setDropInterval 0.01;
_emitter spawn {
    sleep ((random 0.2) + 0.1);
    deleteVehicle _this;
};
