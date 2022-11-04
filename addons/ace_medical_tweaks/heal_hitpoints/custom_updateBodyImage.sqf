#define PREFIX ace
#include "\x\cba\addons\main\script_macros_common.hpp"
#include "\z\ace\addons\medical_engine\script_macros_medical.hpp"

params ["_ctrl", "_target"];

// collect damage/trauma from all wounds (used only for blue GUI coloring)
//
// this is basically the same as ACE natively calculating it for
// ace_medical_bodyPartDamage, except we can display it independently
// of the real ace_medical_bodyPartDamage set for the _target unit

private _trauma = [0,0,0,0,0,0];

// count only fully auto-treated bruises,
// see fn_onStitch.sqf for the params
{
    _x params ["_classID", "_bodypartIndex", "_amountOf", "_bloodloss", "_damage"];
    if (_amountOf == 0) then { continue };
    private _wound_name = ace_medical_damage_woundClassNamesComplex select _classID;
    if (_wound_name find "Contusion" == 0) then {
        private _orig = _trauma select _bodypartIndex;
        _trauma set [_bodypartIndex, _orig + _amountOf*_damage];
    };
} forEach GET_OPEN_WOUNDS(_target);

{
    _x params ["_classID", "_bodypartIndex", "_amountOf", "_bloodloss", "_damage"];
    private _orig = _trauma select _bodypartIndex;
    _trauma set [_bodypartIndex, _orig + _amountOf*_damage];
} forEach (GET_BANDAGED_WOUNDS(_target) + GET_STITCHED_WOUNDS(_target));

// the default is to use the darkest blue even for medium-ish
// wounds - tone it down, so darker blue is reserved only for
// heavier ones
_trauma = _trauma apply { _x * 0.3 };

// fool the original ACE updateBodyImage function
// by faking bodyPartDamage for the duration of the function run
// - this works reliably because we run unscheduled
private _backup = _target getVariable ["ace_medical_bodyPartDamage", [0,0,0,0,0,0]];
_target setVariable ["ace_medical_bodyPartDamage", _trauma];
_this call cnto_ace_medical_tweaks_heal_hitpoints_fnc_orig_updateBodyImage;
_target setVariable ["ace_medical_bodyPartDamage", _backup];
