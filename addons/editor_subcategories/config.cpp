/*
 * adds CNTO composition category and subcategories to keep things organized
 */

class CfgPatches {
    class cnto_editor_subcategories {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {};
    };
};

class CfgEditorSubcategories {
    /*
     * keep these names as-is even if they don't have cnto_ prefix,
     * for compatibility with already existing compositions
     */
    class CNTODefaults {
        displayName = "CNTO Defaults";
    };
    class CNTOStandardFaction {
        displayName = "CNTO Standard Faction";
    };    
    class CNTOStandardFactionAdaptation {
        displayName = "CNTO Standard Faction Adaptation";
    };    
    class CNTOCustomFaction {
        displayName = "CNTO Custom Faction";
    };        
};
