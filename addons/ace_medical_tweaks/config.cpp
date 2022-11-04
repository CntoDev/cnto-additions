/*
 * miscellaneous ACE Medical system tweaks for CNTO
 */
class CfgPatches {
    class cnto_ace_medical_tweaks {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "ace_medical_status",
            "ace_medical_statemachine",
            "ace_medical_damage",
            "ace_medical_treatment"
        };
    };
};

// avoid the cardiac arrest state when receiving would-be-fatal damage,
// forcing unconsciousness instead
// note that this doesn't disable cardiac arrest completely - other logic
// can still enter that state, ie. very low blood / vitals checking code
class ACE_Medical_StateMachine {
    class Default {
        class FatalVitals {
            targetState = "Unconscious";
            events[] = {"ace_medical_FatalVitals"};  // split Bleedout
        };
        class FatalInjury {
            targetState = "Dead";
            //events[] = {QEGVAR(medical,FatalInjury)};
        };
        class Bleedout {
            targetState = "Dead";
            events[] = {"ace_medical_Bleedout"};
        };
    };
    class Injured {
        class FatalVitals {
            targetState = "Unconscious";
            events[] = {"ace_medical_FatalVitals"};  // split Bleedout
        };
        class FatalInjury {
            targetState = "Dead";
            //events[] = {QEGVAR(medical,FatalInjury)};
        };
        class Bleedout {
            targetState = "Dead";
            events[] = {"ace_medical_Bleedout"};
        };
    };
    class Unconscious {
        delete FatalTransitions;
        class FatalInjury {
            targetState = "Dead";
            //events[] = {QEGVAR(medical,FatalInjury)};
        };
        class Bleedout {
            targetState = "Dead";
            events[] = {"ace_medical_Bleedout"};
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
