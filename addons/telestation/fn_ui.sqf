params ["_telestation"];

private _fnc_UI = {
	params ["_caller"];

	[
		"Telestation",
		["CHECKBOX", "The telestation is ONLY to be used in case of deaths due to glitches or disconnects", false],
		{
			/*---------------------------------------------------------*/
			params ["_ticked", "_caller"];
			if (_ticked) then {
				private _validTargets = allUnits select {side _x == side _caller};
				private _validTargetNames = _validTargets apply {name _x};

				[
					"Telestation destination selector",
					["LISTBOX", "Select a player to move near to", [_validTargets, _validTargetNames, 0]],
					{
						params ["_target","_caller"];
						[_target, _caller] call cnto_telestation_teleportUnit;
					},
					{},
					_caller
				] call zen_dialog_fnc_create;
			};
			/*---------------------------------------------------------*/
		},
		{},
		_caller
	] call zen_dialog_fnc_create;
};

_telestation addAction
[
	"Use telestation",	// title
	{
		params ["_target", "_caller", "_actionId", "_fnc_UI"]; // script
		_caller call _fnc_UI;
	},
	_fnc_UI,		// arguments
	1.5,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"true", 	// condition
	50,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];
