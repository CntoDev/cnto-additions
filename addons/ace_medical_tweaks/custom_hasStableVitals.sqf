#include "\z\ace\addons\medical_status\script_component.hpp"

params ["_unit"];

//if (GET_BLOOD_VOLUME(_unit) < BLOOD_VOLUME_CLASS_2_HEMORRHAGE) exitWith { false };
if IN_CRDC_ARRST(_unit) exitWith { false };

//private _cardiacOutput = [_unit] call FUNC(getCardiacOutput);
//private _bloodLoss = GET_BLOOD_LOSS(_unit);
//if (_bloodLoss > (BLOOD_LOSS_KNOCK_OUT_THRESHOLD * _cardiacOutput) / 2) exitWith { false };

private _bloodPressure = GET_BLOOD_PRESSURE(_unit);
_bloodPressure params ["_bloodPressureL", "_bloodPressureH"];
if (_bloodPressureL < 50 || {_bloodPressureH < 60}) exitWith { false };

private _heartRate = GET_HEART_RATE(_unit);
if (_heartRate < 40) exitWith { false };

true
