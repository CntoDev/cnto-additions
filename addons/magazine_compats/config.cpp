class CfgPatches {
    class cnto_magazine_compats {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "A3_Weapons_F_Exp_Rifles_CTARS"
            // "rhs_c_weapons",
            // "cba_jam"
        };
    };
};

class CfgWeapons 
{
    class Rifle_Base_F;
    // Make CAR-95 able to use 5.45mm ammo.
    class arifle_CTARS_base_F: Rifle_Base_F
    {
        magazineWell[] += {
            // RHS AK_545x39 Magazine well from "rhs_c_weapons"
            "AK_545x39", 
            // CBA Magazine wells from addon "cba_jam"
            "CBA_545x39_AK", "CBA_545x39_RPK"
        };
    };
    class arifle_CTAR_base_F: Rifle_Base_F
    {
        magazineWell[] += {
            // RHS AK_545x39 Magazine well from "rhs_c_weapons"
            "AK_545x39", 
            // CBA Magazine wells from addon "cba_jam"
            "CBA_545x39_AK", "CBA_545x39_RPK"
        };
    };
};
