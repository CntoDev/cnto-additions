/*
 * add additional checks to A3AA's validate mission system
 */
class CfgPatches {
    class cnto_validate_mission {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "cba_xeh",
            "a3aa_ee_validate_mission"
        };
    };
};

class CfgFunctions {
    class cnto_validate_mission {
        class all {
            file = "\cnto\additions\validate_mission";
            class run;
        };
    };
};

class Extended_PreInit_EventHandlers {
    class cnto_validate_mission {
        init = "cnto_validate_mission_fnc_run call a3aa_ee_validate_mission_fnc_register";
    };
};
