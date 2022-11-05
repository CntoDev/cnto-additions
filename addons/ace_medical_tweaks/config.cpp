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

class ACE_Medical_Injuries {
    class wounds {
        // make burns bleed a little bit, so they can be bandaged/stitched
        // - unlike bruises, they don't produce other wounds that would bleed,
        //   and are rare enough to where bleeding probably doesn't matter
        class ThermalBurn {
            bleeding = 0.01;
        };
    };
    class damageTypes {
        // generally less wounds per bullet
        class bullet {
            //thresholds[] = {{20, 10}, {4.5, 2}, {3, 1}, {0, 1}};
            thresholds[] = {{20, 6}, {5, 1}, {0, 1}};
            delete Contusion;
        };
        // notably less wounds per small explosive effect, but at least 1
        class grenade {
            //thresholds[] = {{20, 10}, {10, 5}, {4, 3}, {1.5, 2}, {0.8, 2}, {0.3, 1}, {0, 0}};
            thresholds[] = {{20, 8}, {10, 3}, {4, 2}, {0.3, 1}, {0, 0}};
            class Contusion { weighting[] = {{0.5, 0}, {0.35, 0.2}}; };
        };
        // a lot of wounds for big damage, but very few for small damage
        class explosive {
            //thresholds[] = {{20, 15}, {8, 7}, {2, 3}, {1.2, 2}, {0.4, 1}, {0,0}};
            thresholds[] = {{20, 15}, {8, 4}, {0.4, 1}, {0, 0}};
            class Contusion { weighting[] = {{0.5, 0}, {0.35, 0.2}}; };
        };
        // shrapnel - same idea as explosive, but less wounds overall
        class shell {
            //thresholds[] = {{20, 10}, {10, 5}, {4.5, 2}, {2, 2}, {0.8, 1}, {0.2, 1}, {0, 0}};
            thresholds[] = {{20, 10}, {10, 3}, {4, 2}, {0.2, 1}, {0, 0}};
            class Cut { weighting[] = {{0.7, 0}, {0.35, 1}}; };
            class Contusion { weighting[] = {{0.5, 0}, {0.35, 0.2}}; };
        };
        class vehiclecrash {
            delete Contusion;  // due to discrete weight ranges
        };
        class collision {
            class Contusion { weighting[] = {{0.4, 0}, {0.2, 0.2}}; };
        };
        // fall damage - reduce overall bruise amount
        class falling {
            //thresholds[] = {{8, 4}, {1, 1}, {0.2, 1}, {0.1, 0.7}, {0, 0.5}};
            thresholds[] = {{8, 3}, {1, 1}, {0.2, 1}, {0.1, 0.7}, {0, 0.5}};
            class Contusion { weighting[] = {{0.4, 0}, {0.2, 0.2}}; };
        };
        // backblast - same idea as fall damage
        class backblast {
            //thresholds[] = {{1, 6}, {1, 5}, {0.55, 5}, {0.55, 2}, {0, 2}};
            thresholds[] = {{1, 3}, {0.55, 2}, {0, 1}};
            class Contusion { weighting[] = {{0.35, 0}, {0.35, 0.2}}; };
        };
        class punch {
            class Contusion { weighting[] = {{0.35, 0}, {0.35, 0.2}}; };
        };
    };
};

class ace_medical_treatment {
    class Medication {
        class Morphine {
            // lower the effect on heart rate, to avoid the need of many
            // epinephrines to counter it + actually allow people to wake
            // up without epinephrine use
            hrIncreaseLow[] = {-1, -5};
            hrIncreaseNormal[] = {-3, -8};
            hrIncreaseHigh[] = {-6, -12};
            timeTillMaxEffect = 10;
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
