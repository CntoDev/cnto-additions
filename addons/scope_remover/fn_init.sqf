[
    "cnto_scope_remover_enable",
    "CHECKBOX",
    ["Enable", "Remove any scopes of more than 1x from AI (that are NOT Snipers or Marksman) units upon spawning."],
    ["CNTO Additions", "Scope remover"],
    false,  /* default */
    true,  /* isGlobal */
    nil,   /* script */
    true   /* needRestart */
] call CBA_settings_fnc_init;


["CBA_settingsInitialized", {
    if !(cnto_scope_remover_enable) exitWith {};
    ["CAManBase", "initPost", {
        params ["_unit"];
        if !(local _unit) exitWith {};
        if (primaryWeapon _unit == "" || _unit in playableUnits || isPlayer _unit || _unit in allPlayers) exitWith {};
        private _role = getText (configOf _unit >> "displayName");
        _role = toLower _role;
        if (["sniper", "marksman", "spotter"] findIf { _x in _role } != -1) exitWith {};
        private _optic = (primaryWeaponItems _unit)#2;
        if (_optic == "") exitWith {};
        private _opticCfg = configfile >> "CfgWeapons" >> _optic;
        private _opticVisionModes = configProperties [_opticCfg >> "ItemInfo" >> "OpticsModes", "true", true];
        private _opticMaxZoom = selectMin (_opticVisionModes apply { getNumber (_x >> "opticsZoomMin") });
        if (_opticMaxZoom < 0.25) then {
            _unit removePrimaryWeaponItem _optic;
        };
    }, true, [], true] call CBA_fnc_addClassEventHandler;
}] call CBA_fnc_addEventHandler;
