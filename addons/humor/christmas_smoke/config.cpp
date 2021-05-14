class CfgPatches {
    class cnto_humor_christmas_smoke {
        units[] = {};
        weapons[] = {};
        magazines[] = { "cnto_humor_SmokeShellChristmas_mag" };
        requiredAddons[] = {
            "A3_Data_F_ParticleEffects",
            "A3_Weapons_F"
        };
    };
};

class CfgCloudlets {
    class SmokeShellWhite;
    class cnto_humor_SmokeShellChristmasWhite : SmokeShellWhite {
        sizeCoef = 0.15;
        lifeTime = 60;
        sizeVar = 0.05;
        /* stop the animation early, like SmokeShellWhite2 */
        particleFSNtieth = 16;
        particleFSIndex = 12;
        particleFSFrameCount = 4;
        particleFSLoop = 0;
        /* white more frequent than red/green */
        interval = 0.05;
        color[] = {
            {1,1,1,1}
        };
        /* defaults, but overwritten by mods, so re-set them here */
        moveVelocity[] = {0.2,0.1,0.1};
        MoveVelocityVar[] = {0.25,0.25,0.25};
    };
    class cnto_humor_SmokeShellChristmasRed : cnto_humor_SmokeShellChristmasWhite {
        interval = 0.2;
        color[] = {
            {1,0.1,0.1,1}
        };
    };
    class cnto_humor_SmokeShellChristmasGreen : cnto_humor_SmokeShellChristmasWhite {
        interval = 0.2;
        color[] = {
            {0.1,1,0.1,1}
        };
    };
};

class cnto_humor_SmokeShellChristmasEffect {
    class White {
        simulation = "particles";
        type = "cnto_humor_SmokeShellChristmasWhite";
        position[] = {0,0,0};
        intensity = 1;
        interval = 1;
    };
    class Red {
        simulation = "particles";
        type = "cnto_humor_SmokeShellChristmasRed";
        position[] = {0,0,0};
        intensity = 1;
        interval = 1;
    };
    class Green {
        simulation = "particles";
        type = "cnto_humor_SmokeShellChristmasGreen";
        position[] = {0,0,0};
        intensity = 1;
        interval = 1;
    };
};

class CfgAmmo {
    class SmokeShell;
    class cnto_humor_SmokeShellChristmas_ammo : SmokeShell {
        effectsSmoke = "cnto_humor_SmokeShellChristmasEffect";
        timeToLive = 120;
        // filename, volume, pitch, distance ??
        SmokeShellSoundLoop1[] = {"\cnto\additions\humor\christmas_smoke\jingle",1.5,1,30};
        SmokeShellSoundLoop2[] = {};
    };
};

class CfgMagazines {
    class SmokeShell;
    class cnto_humor_SmokeShellChristmas_mag : SmokeShell {
        ammo = "cnto_humor_SmokeShellChristmas_ammo";
        descriptionShort = "Type: Smoke Grenade - Christmas<br />Rounds: 1<br />Used in: Hand or Rectum";
        displayName = "Smoke Grenade (Christmas)";
        displayNameShort = "Christmas Smoke";
    };
};

class CfgWeapons {
    class GrenadeLauncher;
    class Throw : GrenadeLauncher {
        muzzles[] += { "SmokeShellChristmasMuzzle" };
        class SmokeShellMuzzle;
        class SmokeShellChristmasMuzzle : SmokeShellMuzzle {
            displayName = "Christmas Smoke";
            magazines[] = { "cnto_humor_SmokeShellChristmas_mag" };
        };
    };
};
