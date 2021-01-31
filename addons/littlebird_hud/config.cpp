class CfgPatches {
    class cnto_littlebird_hud {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "cba_settings",
            "cba_events",
            "cba_xeh"
        };
    };
};

class CfgFunctions {
    class cnto_littlebird_hud {
        class all {
            file = "cnto\additions\littlebird_hud";
            class init;
            class hud;
        };
    };
};

class Extended_PreInit_EventHandlers {
    class cnto_littlebird_hud {
        init = "[] call cnto_littlebird_hud_fnc_init";
    };
};