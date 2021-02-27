[
	"cnto_littlebird_hud_enable",
	"CHECKBOX",
	["Enable", "Enable small forward-facing collimator style reticle for AH-6 and AH-9 aircraft. Requires re-entering vehicle for changes to take effect."],
	["CNTO Additions", "Littlebird HUD"],
	true,  /* default */
	false,  /* isGlobal */
	nil,   /* script */
	false   /* needRestart */
] call CBA_settings_fnc_init;

[
	"cnto_littlebird_hud_colour",
	"COLOR",
	["Colour", "Change the colour of the helicopter reticle"],
	["CNTO Additions", "Littlebird HUD"],
	[0.3, 1.0 , 0.3, 0.5],  /* default */
	false,  /* isGlobal */
	nil,   /* script */
	false   /* needRestart */
] call CBA_settings_fnc_init;

0 spawn {
	if (!hasInterface) exitWith {};
	waitUntil { !isNull player };
	["vehicle", {
		params ["_unit", "_newVehicle", "_oldVehicle"];
		if (_newVehicle isKindOf "RHS_MELB_AH6M" OR _newVehicle isKindOf "Heli_Light_01_armed_base_F") then {
			_newVehicle call cnto_littlebird_hud_fnc_hud;
		};
	}] call CBA_fnc_addPlayerEventHandler;
	
	// where player starts in vehicle
	private _playerVeh = vehicle player;
	if (_playerVeh isKindOf "RHS_MELB_AH6M" OR _playerVeh isKindOf "Heli_Light_01_armed_base_F") then {
		_playerVeh call cnto_littlebird_hud_fnc_hud;
	};
};
