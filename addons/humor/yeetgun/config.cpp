class CfgPatches 
{
    class cnto_humor_yeetgun
    {
        units[] = {};
        weapons[] = {"cnto_hgun_Pistol_Yeetgun"};
        requiredAddons[] = {
            "A3_Weapons_F_Pistols_Pistol_Heavy_02",
            "A3_Weapons_F",
            "A3_Sounds_F",
            "A3_Sounds_F_Enoch"
        };
    };
};

class CfgFunctions
{
    class cnto_humor_yeetgun
    {
        class all
        {
            file = "cnto\additions\humor\yeetgun";
            class yeetGunFired;
        }
    };
};

class Mode_SemiAuto;
class CfgWeapons
{
    class hgun_Pistol_heavy_02_F;
    class cnto_hgun_Pistol_Yeetgun: hgun_Pistol_heavy_02_F 
    {
        author = "Seb";
        baseWeapon = "cnto_hgun_Pistol_Yeetgun";
        picture = "\A3\Weapons_F_EPA\Pistols\Pistol_Heavy_02\data\UI\gear_Pistol_heavy_02_X_CA.paa";
        magazines[] = {"cnto_Yeetgun_Cannister"};
        magazineWell[] = {""};
        displayname = "The Yeet Gun™";
        descriptionShort = "Handgun..?<br />Caliber: Air";
        hiddenSelectionsTextures[] = {"\cnto\additions\humor\yeetgun\cnto_hgun_Pistol_Yeetgun","\A3\Weapons_F_EPA\Pistols\Pistol_Heavy_02\data\Pistol_Heavy_02_mag_co"};
        class Library
        {
            libTextDesc = "Nobody is really sure how this works. The inventor was killed when this weapon was fired for the first time as his house collapsed in on him. RIP big G.";
        };
        class EventHandlers
        {
            fired = "_this call cnto_yeetgun_fnc_yeetGunFired";
        };
        class Single: Mode_SemiAuto
        {
            class BaseSoundModeType;
            class StandardSound: BaseSoundModeType
            {
                soundSetShot[] = {"cnto_Yeetgun_Shot_SoundSet","Zubr_Tail_SoundSet","Zubr_InteriorTail_SoundSet"};
            };
            class SilencedSound: BaseSoundModeType
            {
            };
        };
    };
};

class CfgMagazines
{
    class 6Rnd_45ACP_Cylinder;
    class cnto_Yeetgun_Cannister: 6Rnd_45ACP_Cylinder 
    {
        author = "Seb";
        displayName = "CNTO Certified Yeetgun Cannister";
        descriptionShort = "Caliber: Air<br />Rounds: 6<br />Used in: The Yeet Gun™";
        ammo = "cnto_Yeetgun_Round";
    };
};


class CfgAmmo
{
    class B_45ACP_Ball;
    class cnto_Yeetgun_Round: B_45ACP_Ball
    {
    };
};

class CfgSoundSets
{
    class Pistol_Shot_Base_SoundSet;
    class cnto_Yeetgun_Shot_SoundSet: Pistol_Shot_Base_SoundSet
    {
        soundShaders[] = {"Zubr_Closure_SoundShader","cnto_Yeetgun_closeShot_SoundShader","cnto_Yeetgun_midShot_SoundShader","cnto_Yeetgun_distShot_SoundShader"};
    };
};

class CfgSoundShaders
{
    class cnto_Yeetgun_closeShot_SoundShader
    {
        samples[] = {{"\cnto\additions\humor\yeetgun\cnto_hgun_Pistol_Yeetgun_shot",1}};
        volume = 0.8;
        range = 50;
        rangeCurve = "closeShotCurve";
    };
    class cnto_Yeetgun_midShot_SoundShader
    {
        samples[] = {{"\cnto\additions\humor\yeetgun\cnto_hgun_Pistol_Yeetgun_shot",1}};
        volume = 0.707946;
        range = 1200;
        rangeCurve[] = {{0,0.2},{50,1},{150,0},{1200,0}};
    };
    class cnto_Yeetgun_distShot_SoundShader
    {
        samples[] = {{"\cnto\additions\humor\yeetgun\cnto_hgun_Pistol_Yeetgun_shot",1}};
        volume = 1;
        range = 1200;
        rangeCurve[] = {{0,0},{50,0},{150,1},{1200,1}};
    };
};
