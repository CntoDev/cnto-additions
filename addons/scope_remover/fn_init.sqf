[
    "cnto_scope_remover_enable",
    "CHECKBOX",
    ["Enable", "Remove any scopes of more than 1x from AI (that are NOT Snipers or Marksman) units upon spawning."],
    ["CNTO Additions", "Scope remover"],
    true,  /* default */
    true,  /* isGlobal */
    nil,   /* script */
    true   /* needRestart */
] call CBA_settings_fnc_init;

if !(isServer) exitWith {};

["CBA_settingsInitialized", {
    if !(cnto_scope_remover_enable) exitWith {};
    ["CAManBase", "initPost", {
        params ["_unit"];
        if (primaryWeapon _unit == "" || _unit in playableUnits || isPlayer _unit || _unit in allPlayers) exitWith {};
        private _role = [configOf _unit, "displayName"] call BIS_fnc_returnConfigEntry;
        _role = toLower _role;
        if (["sniper", "marksman", "spotter"] findIf {_x in _role} != -1) exitWith {};
        private _optic = (primaryWeaponItems _unit)#2;
        if (_optic == "") exitWith {};
        private _opticCfg = (configfile >> "CfgWeapons" >> _optic >> "ItemInfo" >> "OpticsModes"); 
        private _opticVisionModes = [_opticCfg,2] call BIS_fnc_returnChildren; 
        private _opticExtremes = [_opticVisionModes,["opticsZoomMin"]] call BIS_fnc_configExtremes; 
        private _opticMaxZoom = (_opticExtremes#0)#0;
        if !(_opticMaxZoom >= 0.25) then {
            [_unit, _optic] remoteExec ["removePrimaryWeaponItem"];
        };
    }, true, [], true] call CBA_fnc_addClassEventHandler;
}] call CBA_fnc_addEventHandler;
