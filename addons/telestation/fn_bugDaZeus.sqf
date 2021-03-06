#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"
params ["_caller","_success"];

if (!isNull getAssignedCuratorLogic player) then { // is reciever a Curator?
    private _str = format ["%1 %2 attempted to use the Telestation", name _caller, ["unsuccessfully", "successfully"] select _success];
    
    if (!isNull findDisplay IDD_RSCDISPLAYCURATOR) then { // are they in the Zeus interface?
        ["Telestation notification", _str, 30] call BIS_fnc_curatorHint;
    } else {
        hint _str;
    };
};