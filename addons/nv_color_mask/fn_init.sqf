[
    "cnto_nv_color_mask_rgb",
    "COLOR",
    ["RGB ratio", "This specifies the Red/Green/Blue proportions of the mask, which replaces the default\nACE NVG green color. The absolute slider values don't matter - only  the proportion\nof Red vs Green vs Blue, IOW all sliders on 0.2/0.2/0.2 are equivalent to 0.6/0.6/0.6.\n\nTo leave default ACE (and save an imperceivable bit of performance), set all to 0."],
    ["CNTO Additions", "Nightvision Color Mask"],
    [0,0,0],
    nil,   /* isGlobal */
    {
        if (!hasInterface) exitWith {};
        if (_this isEqualTo [0,0,0] && isNil "cnto_nv_color_mask_rgba_ratio") exitWith {};
        /* add PFH-based EH only if mask is in use, limit overhead */
        if (isNil "cnto_nv_color_mask_rgba_ratio") then {
            call cnto_nv_color_mask_fnc_setupEH;
        };
        /* recalculate RGB ratio */
        params ["_red", "_green", "_blue"];
        private _sum = _red + _green + _blue;
        if (_sum != 0) then {
            /* maintain the same brightness */
            cnto_nv_color_mask_rgba_ratio = [_red,_green,_blue] apply { 3*(_x/_sum) };
            /* add saturation */
            cnto_nv_color_mask_rgba_ratio pushBack 0;
        } else {
            /* transparent by default */
            cnto_nv_color_mask_rgba_ratio = [0,0,0,1];
        };
    }
] call CBA_settings_fnc_init;
