(getAllHitpointsDamage _this) params ["_hpnames", "_selections", "_damages"];

// damage its wheels + glasses
{
    switch true do {
        // always kill front wheels
        case (_x regexMatch "hit[lr]fwheel"): {
            _this setHitPointDamage [_x, 1];
        };
        // 50/50 on other wheels
        case (_x find "wheel" != -1): {
            private _dmg = _damages select _forEachIndex;
            _this setHitPointDamage [_x, (random 1 + 0.5 + _dmg) min 1];
        };
        // damage and maybe fully destroy some windows
        case (_x find "glass" != -1): {
            private _dmg = _damages select _forEachIndex;
            _this setHitPointDamage [_x, (random 1 + 0.5 + _dmg) min 1];
        };
        // add a bit of damage to the engine - don't add more than 0.5
        // as hitengine has a wider range of perceivable damage
        case (_x == "hitengine"): {
            private _dmg = _damages select _forEachIndex;
            _this setHitPointDamage [_x, (random 0.5 + _dmg) min 1];
        };
    };
} forEach _hpnames;
