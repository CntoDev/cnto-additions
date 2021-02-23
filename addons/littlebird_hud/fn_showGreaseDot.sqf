params ["_vehicle", "_enable"];

if (_vehicle isKindOf "RHS_MELB_AH6M") then {
        private _status = [0, 1] select _enable;
        _vehicle animateSource ["Addcrosshair", _status, true];
    } else {
        private _status = ["", "a3\air_f\heli_light_01\data\heli_light_01_dot_ca.paa"] select _enable;
        _vehicle setObjectTextureGlobal [1, _status];
};
