class CfgPatches {
    class cnto_magazine_compats {
        units[] = {};
        weapons[] = {"Rifle_Base_F", "arifle_CTARS_base_F", "arifle_CTAR_base_F"};
        requiredAddons[] = {
            "A3_Weapons_F_Exp_Rifles_CTARS",
            "rhs_c_weapons",
            "cba_jam"
        };
    };
};

class CfgWeapons {
    class Rifle_Base_F;
    // Make CAR-95 able to use 5.45mm ammo.
    class arifle_CTARS_base_F: Rifle_Base_F
    {
        magazineWell[] = {"CTAR_580x42","CTAR_580x42_Large","CBA_580x42_TYPE95","CBA_580x42_TYPE95_XL", "AK_545x39","CBA_545x39_AK","CBA_545x39_RPK"};
    };
    class arifle_CTAR_base_F: Rifle_Base_F
    {
        magazineWell[] = {"CTAR_580x42","CTAR_580x42_Large","CBA_580x42_TYPE95","CBA_580x42_TYPE95_XL", "AK_545x39","CBA_545x39_AK","CBA_545x39_RPK"};
    };
};
