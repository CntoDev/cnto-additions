/*
 * add a "safe IED" object that does very little actual engine damage
 * (barely enough to kill a soldier), but runs additional scripting
 *  to destroy the wheels of a nearest vehicle that presumably triggered
 *  the mine)
 *
 * the intended use case is to reliably paralyze a player convoy (or any
 * vehicle) without actually destroying the vehicle
 */
class CfgPatches {
    class cnto_safe_ied {
        units[] = {
            "cnto_safe_ied",
            "cnto_safe_ied_curator_module"
//            "cnto_safe_ied_invis",
//            "cnto_safe_ied_curator_module_invis"
        };
        weapons[] = {};
        magazines[] = {};
        requiredAddons[] = {
            "A3_Weapons_F_Explosives"
        };
    };
};

class CfgMineTriggers {
    class Default;
    class cnto_safe_ied_trigger : Default {
        mineTriggerType = "radius";
        mineTriggerRange = 1;
        mineTriggerMass = 200;
        mineDelay = 0;
        mineMagnetic = 1;
    };
};

class CfgMagazines {
    class ATMine_Range_Mag;
    class cnto_safe_ied_mag : ATMine_Range_Mag {
        displayName = "CNTO Safe IED";
        ammo = "cnto_safe_ied_ammo";
    };
/*
    class cnto_safe_ied_invis_mag : cnto_safe_ied_mag {
        displayName = "CNTO Safe IED (Invisible)";
        ammo = "cnto_safe_ied_invis_ammo";
        // have the mag visible, so players can see disarmed mines
        //model = "\A3\weapons_f\empty.p3d";
    };
*/
};

class CfgAmmo {
    class ATMine_Range_Ammo;
    class cnto_safe_ied_ammo : ATMine_Range_Ammo {
        defaultMagazine = "cnto_safe_ied_mag";
        hit = 1;
        indirectHit = 4;
        indirectHitRange = 8;
        //mineInconspicuousness = 40;
        mineTrigger = "cnto_safe_ied_trigger";
        explosionEffects = "DirectionalMineExplosionBig";
        craterEffects = "";
        craterShape = "\A3\weapons_f\empty.p3d";
        SoundSetExplosion[] = {
            "M6slamMine_Exp_SoundSet",
            "M6slamMine_Tail_SoundSet",
            "Explosion_Debris_SoundSet"
        };
        class Eventhandlers {
            class cnto_safe_ied_explode {
                AmmoHit = "_this call cnto_safe_ied_fnc_pickVehicle";
            };
        };
    };

/*
    class cnto_safe_ied_invis_ammo : cnto_safe_ied_ammo {
        model = "\A3\weapons_f\empty.p3d";
    };
*/
};

class CfgFunctions {
    class cnto_safe_ied {
        class all {
            file = "\cnto\additions\safe_ied";
            class pickVehicle;
            class explode;
        };
    };
};

class CfgVehicles {
    class ATMine;
    class cnto_safe_ied : ATMine {
        displayName = "CNTO Safe IED";
        ammo = "cnto_safe_ied_ammo";
        mapSize = 0;
        model = "\A3\Weapons_f\Explosives\mine_at";
    };
    class ModuleMine_ATMine_F;
    class cnto_safe_ied_curator_module : ModuleMine_ATMine_F {
        displayName = "CNTO Safe IED";
        explosive = "cnto_safe_ied_ammo";
        icon = "iconExplosiveAT";
    };

/*
    class cnto_safe_ied_invis : cnto_safe_ied {
        displayName = "CNTO Safe IED (Invisible)";
        ammo = "cnto_safe_ied_invis_ammo";
        model = "\A3\weapons_f\empty.p3d";
    };
    class cnto_safe_ied_curator_module_invis : cnto_safe_ied_curator_module {
        displayName = "CNTO Safe IED (Invisible)";
        explosive = "cnto_safe_ied_invis_ammo";
    };
*/
};
