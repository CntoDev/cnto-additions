#include "\z\ace\addons\medical_status\script_component.hpp"

params ["_unit"];

// if lost "a large amount of blood"
// && doesn't have epinephrine in the system || does and is unlucky,
// then do not wake up
//
// note that this assumes 100% wakeup chance *while epi is in the system*
// eg. maximum spontaneousWakeUpEpinephrineBoost, and this 100% is reduced
// further by the 'random' command
//if (
//    GET_BLOOD_VOLUME(_unit) < BLOOD_VOLUME_CLASS_3_HEMORRHAGE
//    ) exitWith { false };
//&& {[_unit, "Epinephrine"] call ace_medical_status_fnc_getMedicationCount == 0 || false}

if IN_CRDC_ARRST(_unit) exitWith { false };

//private _cardiacOutput = [_unit] call FUNC(getCardiacOutput);
//private _bloodLoss = GET_BLOOD_LOSS(_unit);
//if (_bloodLoss > (BLOOD_LOSS_KNOCK_OUT_THRESHOLD * _cardiacOutput) / 2) exitWith { false };

private _bloodPressure = GET_BLOOD_PRESSURE(_unit);
_bloodPressure params ["_bloodPressureL", "_bloodPressureH"];
if (_bloodPressureL < 40 || {_bloodPressureH < 60}) exitWith { false };

private _heartRate = GET_HEART_RATE(_unit);
if (_heartRate < 40) exitWith { false };

true;
