/* ----------------------------------------------------------------------------
Function: cnto_fnc_scopebox;
Description:
	Adds a scopebox which will open a Zeus Enhanced dialog allowing a player to select any 1x optic that is compatible with their gun.
Parameters:
	_scopebox = the object that scopebox addAction will be attached to.
Returns:
	None
Examples:
	(begin example)
		this call cnto_fnc_scopebox;
	(end)
Author:
	Seb
---------------------------------------------------------------------------- */
params ["_scopebox"];

private _scopeBoxUI = {
	params ["_caller"];
	private _allWeaponOptics = [primaryWeapon _caller, "optic"] call CBA_fnc_compatibleItems;
	private _allWeaponEligibleOptics = _allWeaponOptics select {
		private _optic = _x;
		private _opticCfg = (configfile >> "CfgWeapons" >> _optic >> "ItemInfo" >> "OpticsModes");
		private _opticVisionModes = [_opticCfg,2] call BIS_fnc_returnChildren;
		private _opticVisionModeUseModelOptics = _opticVisionModes apply {getNumber (_x >> "useModelOptics")};
		private _opticUseModelOpticsFindNonZero = _opticVisionModeUseModelOptics findIf {_x != 0};
		private _cfgScope = getNumber (configfile >> "CfgWeapons" >> _optic >> "scope");
		private _opticExtremes = [_opticVisionModes,["opticsZoomMin"]] call BIS_fnc_configExtremes;
		private _opticMaxZoom = (_opticExtremes select 0) select 0;
		_opticMaxZoom >=0.25 && _cfgScope == 2 && _opticUseModelOpticsFindNonZero == -1;
	};

	private _optics = [_allWeaponEligibleOptics, [], {
		getText (configfile >> "CfgWeapons" >> _x >> "displayName");
	}] call BIS_fnc_sortBy;
	private _opticsDisplay = _optics apply {
		_optic = _x;
		[
			getText (configfile >> "CfgWeapons" >> _optic >> "displayName"),
			getText (configfile >> "CfgWeapons" >> _optic >> "displayName"),
			getText (configfile >> "CfgWeapons" >> _optic >> "picture")
		]
	};
	if (count _optics > 0) then {
		[
			"Scopebox 3.0",
			[
				["LIST", "Select a scope", [_optics, _opticsDisplay, 0, 15]]
			],
			{
				params ["_dialog_data","_caller"];
				_dialog_data params ["_scope"];
				_caller addPrimaryWeaponItem _scope;
			},
			{},
			_caller
		] call zen_dialog_fnc_create;
	} else {
		hint "Your primary weapon has no scopes available"
	};
};

_scopebox addAction
	[
		"<t color='#87ceeb'>Scopebox</t>",
		{
		params ["_target", "_caller", "_actionId", "_arguments"];
		_arguments params ["_scopeBoxUI"];
		_caller call _scopeBoxUI;
	},
	_scopeBoxUI, 15, false, true, "", "(_target distance _this) < 3"
];
