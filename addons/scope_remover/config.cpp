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
