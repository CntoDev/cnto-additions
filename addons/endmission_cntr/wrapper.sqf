if (isDedicated && !isNil "cntr_exportPath" && !isNil "cntr_fnc_export") then {
    diag_log "endMission: Stopping CNTR recording.";
    ["stop", cntr_exportPath] call cntr_fnc_export;
};
_this call BIS_fnc_endMission_orig;
