class CfgPatches {
    class cnto_scope_remover {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "cba_settings"
        };
    };
};

class CfgFunctions {
    class cnto_scope_remover {
        class all {
            file = "\cnto\additions\scope_remover";
            class init;
        };
    };
};

class Extended_PreInit_EventHandlers {
    class cnto_scope_remover {
        init = "[] call cnto_scope_remover_fnc_init";
    };
};
