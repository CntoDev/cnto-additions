/*
 * miscellaneous ACE Medical system tweaks for CNTO
 */
class CfgPatches {
    class cnto_ace_medical_tweaks {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "ace_medical_status"
        };
    };
};

/*
 * unconsciousness condition tweaks
 *
 * override ACE's hasStableVitals function:
 * hasn't changed in a few years (and if it does, should throw up enough errors
 * on game startup for people to notice)
 * https://github.com/acemod/ACE3/blob/master/addons/medical_status/functions/fnc_hasStableVitals.sqf
 */
class CfgFunctions {
    class ace_medical_status {
        class misc {
            /*
             * surprisingly, this works as BIS_fnc_initFunctions is faster than
             * CBA's PREP() macro, at least with debugging disabled, and manages
             * to finalize our code, so ACE cannot override it
             */
            class hasStableVitals {
                file = "\cnto\additions\ace_medical_tweaks\custom_hasStableVitals.sqf";
            };
        };
    };
};
