if (isNil "cnto_nv_color_mask_rgba_ratio") exitWith {};

params ["_enable"];
if (isNil "_enable") then {
    _enable = !isNull player && currentVisionMode player == 1;
};

if (_enable) then {
    if (!isNil "cnto_nv_color_mask_effect") then {
        ppEffectDestroy cnto_nv_color_mask_effect;
    };
    /* https://community.bistudio.com/wiki/Post_process_effects */
    private _effect = ppEffectCreate ["ColorCorrections", 2050];
    _effect ppEffectAdjust [
        1, 1, 0,
        [0,0,0,0],
        cnto_nv_color_mask_rgba_ratio,
        [0.299, 0.587, 0.114, 0]
    ];
    _effect ppEffectForceInNVG true;
    _effect ppEffectCommit 0;
    _effect ppEffectEnable true;
    cnto_nv_color_mask_effect = _effect;
} else {
    if (!isNil "cnto_nv_color_mask_effect") then {
        ppEffectDestroy cnto_nv_color_mask_effect;
        cnto_nv_color_mask_effect = nil;
    };
};
