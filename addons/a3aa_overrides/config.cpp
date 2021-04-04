/*
 * configure/override various custom features of freghar/arma-additions
 */
class CfgPatches {
    class cnto_a3aa_overrides {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "a3aa_ai_dynamic_skill"
        };
    };
};

class CfgFunctions {
    class cnto_a3aa_overrides {
        class all {
            file = "\cnto\additions\a3aa_overrides";
            class customAISkills { preInit = 1; };
        };
    };
};
