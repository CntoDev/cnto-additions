class CfgPatches {
    class cnto_telestation {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "cba_settings"
        };
    };
};

class CfgFunctions {
    class cnto_telestation {
        class all {
            file = "\cnto\additions\scope_remover";
            class init;
        };
    };
};
