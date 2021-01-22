["visionMode", {
    params ["_unit", "_new", "_old"];
    if (_new == 1) then {
        [true] call cnto_nv_color_mask_fnc_applyMask;
    } else {
        /* 0 (normal) or 2 (thermal) */
        [false] call cnto_nv_color_mask_fnc_applyMask;
    };
}] call CBA_fnc_addPlayerEventHandler;
