/*
 * performance monitoring functions
 */
class CfgPatches {
    class cnto_functions {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "zen_dialog"
        };
    };
};

class CfgFunctions {
    class cnto {
        class loadout {
            file = "\cnto\additions\functions\loadout";
            class boxGuard;
        };
        class performance {
            file = "\cnto\additions\functions\performance";
            class runTest;
        };
        class scopebox {
            file = "\cnto\additions\functions\scopebox";
            class scopebox;
        };
    };
};
