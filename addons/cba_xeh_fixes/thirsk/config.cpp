class CfgPatches {
    class cnto_cba_xeh_fixes_thirsk {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = { "THIRSK_Clouds" };
    };
};

class EventHandlers;
class CBA_Extended_EventHandlers_base;
class CfgVehicles {
    class THIRSK_WeatherPreSet;
    class TH_SNOWING1 : THIRSK_WeatherPreSet {
        class EventHandlers : EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };
    class TH_SNOWING2 : THIRSK_WeatherPreSet {
        class EventHandlers : EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };
    class TH_SNOWING3 : THIRSK_WeatherPreSet {
        class EventHandlers : EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };
    class TH_SNOWING4 : THIRSK_WeatherPreSet {
        class EventHandlers : EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };
    class TH_FOG1 : THIRSK_WeatherPreSet {
        class EventHandlers : EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };
    class TH_FOG2 : THIRSK_WeatherPreSet {
        class EventHandlers : EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };
    class TH_FOG3 : THIRSK_WeatherPreSet {
        class EventHandlers : EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };
    class TH_SNOWSTORM1 : THIRSK_WeatherPreSet {
        class EventHandlers : EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };
};
