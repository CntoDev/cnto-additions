class CfgPatches {
    class cnto_ace_medical_tweaks_heal_hitpoints {
        units[] = {};
        weapons[] = {};
        magazines[] = {};
        requiredAddons[] = {
            "cba_events",
            "cba_xeh",
            "ace_medical",
            "ace_medical_engine",
            "ace_medical_gui",
            "ace_medical_damage"
        };
    };
};

class CfgFunctions {
    class cnto_ace_medical_tweaks_heal_hitpoints {
        class all {
            file = "\cnto\additions\ace_medical_tweaks\heal_hitpoints";
            class init;
            class onStitch;
        };
        class overriden {
            class orig_updateBodyImage {
                file = "z\ace\addons\medical_gui\functions\fnc_updateBodyImage.sqf";
            };
        };
    };
    class ace_medical_gui {
        class all {
            class updateBodyImage {
                file = "\cnto\additions\ace_medical_tweaks\heal_hitpoints\custom_updateBodyImage.sqf";
            };
        };
    };
};

class Extended_PreInit_EventHandlers {
    class cnto_ace_medical_tweaks_heal_hitpoints {
        init = "[] call cnto_ace_medical_tweaks_heal_hitpoints_fnc_init";
    };
};
