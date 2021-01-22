/*
 * make NVGs full-screen and ACE-like in visual appearance
 */
class CfgPatches {
    class cnto_nv_color_mask {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "cba_events",
            "cba_xeh",
            /*
             * this is not strictly needed, but since all masks will be
             * user-configured relative to ACE's green NVGs, it makes
             * sense to require ACE Nightvision
             */
            "ace_nightvision"
        };
    };
};

class CfgFunctions {
    class cnto_nv_color_mask {
        class all {
            file = "\cnto\additions\nv_color_mask";
            class init;
            class setupEH;
            class applyMask;
        };
    };
};

class Extended_PreInit_EventHandlers {
    class cnto_nv_color_mask {
        init = "[] call cnto_nv_color_mask_fnc_init";
    };
};

#define DISPLAY_DISABLE(rscname) \
    class rscname { \
        cnto_nv_color_mask = "[false] call cnto_nv_color_mask_fnc_applyMask"; \
    }
#define DISPLAY_RESTORE(rscname) \
    class rscname { \
        cnto_nv_color_mask = "[] call cnto_nv_color_mask_fnc_applyMask"; \
    }

class Extended_DisplayLoad_EventHandlers {
    DISPLAY_DISABLE(RscDisplayCurator);
    DISPLAY_DISABLE(RscDisplayArsenal);
    DISPLAY_DISABLE(ace_arsenal_display);
};
class Extended_DisplayUnload_EventHandlers {
    DISPLAY_RESTORE(RscDisplayCurator);
    DISPLAY_RESTORE(RscDisplayArsenal);
    DISPLAY_RESTORE(ace_arsenal_display);
};
