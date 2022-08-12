/*
 * delete ACE Headless checkboxes in 3DEN, to prevent confusion
 * (they don't work, CNTO doesn't use ACE Headless)
 */

class CfgPatches {
    class cnto_ace_no_headless {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "ace_headless"
        };
    };
};

class Cfg3DEN {
    class Object {
        class AttributeCategories {
            class ace_attributes {
                class Attributes {
                    delete acex_headless_blacklist;
                };
            };
        };
    };
    class Group {
        class AttributeCategories {
            class ace_attributes {
                class Attributes {
                    delete acex_headless_blacklist;
                };
            };
        };
    };
};
