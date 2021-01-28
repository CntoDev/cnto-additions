/*
 * wrap BIS_fnc_endMission so that it calls CNTR (Carpe Noctem Tactical Replay)
 * function to finish and save a recording of the mission
 */
class CfgPatches {
    class cnto_endmission_cntr {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = { "A3_Functions_F" };
    };
};

class CfgFunctions {
    class HSim {
        class Misc {
            class endMission {
                file = "\cnto\additions\endmission_cntr\wrapper.sqf";
            };
            class endMission_orig {
                file = "A3\functions_f\Misc\fn_endMission.sqf";
            };
        };
    };
};
