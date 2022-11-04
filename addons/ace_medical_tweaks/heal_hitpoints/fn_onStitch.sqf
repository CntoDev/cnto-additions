#define PREFIX ace
#include "\x\cba\addons\main\script_macros_common.hpp"
#include "\z\ace\addons\medical_engine\script_macros_medical.hpp"

private _restore_hit_idx = [true,true,true,true,true,true];

// open wound entries persist even after bandaging/stitching
{
    _x params ["_classID", "_bodypartIndex", "_amountOf", "_bloodloss", "_damage"];

    // bandaged/stitched, nothing open remains;
    // used for partially bandaged wounds
    if (_amountOf == 0) then { continue };

    // don't ask me why
    private _wound_name = ace_medical_damage_woundClassNamesComplex select _classID;
    // treat bruises as always bandaged/stitched
    if (_wound_name find "Contusion" == 0) then { continue };

    // finally, an untreated open wound;
    _restore_hit_idx set [_bodypartIndex, false];
} forEach GET_OPEN_WOUNDS(_this);

// bandaged wounds are easier - they disappear after stitching
{
    _x params ["_classID", "_bodypartIndex", "_amountOf", "_bloodloss", "_damage"];
    _restore_hit_idx set [_bodypartIndex, false];
} forEach GET_BANDAGED_WOUNDS(_this);


// if a body part made it this far, it doesn't contain any
// unstitched wounds - restore lost trauma

// restore vanilla game hitpoints

private _current = _this getHitPointDamage "hitHead";
if (_current > 0 && _restore_hit_idx select HITPOINT_INDEX_HEAD) then {
    _this setHitPointDamage ["hitHead", 0];
};

_current = _this getHitPointDamage "hitBody";
if (_current > 0 && _restore_hit_idx select HITPOINT_INDEX_BODY) then {
    _this setHitPointDamage ["hitBody", 0];
};

_current = _this getHitPointDamage "hitHands";
if (_current > 0 && _restore_hit_idx select HITPOINT_INDEX_LARM && _restore_hit_idx select HITPOINT_INDEX_RARM) then {
    _this setHitPointDamage ["hitHands", 0];
};

_current = _this getHitPointDamage "hitLegs";
if (_current > 0 && _restore_hit_idx select HITPOINT_INDEX_LLEG && _restore_hit_idx select HITPOINT_INDEX_RLEG) then {
    _this setHitPointDamage ["hitLegs", 0];
};

// update ACE trauma

private _ace_damage_old = _this getVariable ["ace_medical_bodyPartDamage", [0,0,0,0,0,0]];
private _ace_damage_new = +_ace_damage_old;

{
    if (_x) then {
        _ace_damage_new set [_forEachIndex, 0];
    };
} forEach _restore_hit_idx;

// avoid unnecessary network traffic
if (_ace_damage_new isNotEqualTo _ace_damage_old) then {
    _this setVariable ["ace_medical_bodyPartDamage", _ace_damage_new, true];
};
