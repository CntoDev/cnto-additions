["CBA_settingsInitialized", {
    // just to make sure it's not enabled
    ace_medical_treatment_clearTrauma = 0;
}] call CBA_fnc_addEventHandler;

["ace_treatmentSucceded", {
    params ["_medic", "_patient", "_bodyPart", "_classname"];
    if (_classname != "SurgicalKit") exitWith {};
    if (!local _patient) exitWith {
        ["ace_treatmentSucceded", _this, _patient] call CBA_fnc_targetEvent;
    };
    _patient call cnto_ace_medical_tweaks_heal_hitpoints_fnc_onStitch;
}] call CBA_fnc_addEventHandler;
