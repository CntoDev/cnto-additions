class CfgPatches {
    class cnto_cba_xeh_fixes_ryanzombies {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = { "Ryanzombies" };
    };
};

class EventHandlers;
class CBA_Extended_EventHandlers_base;
class CfgVehicles {
    class Logic;
	class Ryanzombieslogiceasy : Logic {
        class EventHandlers : EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };
    class Ryanzombieslogicspawnfast1;
	class Ryanzombieslogicspawnfast1opfor : Ryanzombieslogicspawnfast1 {
        class EventHandlers : EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };
    class CAManBase;
    class RyanZombieCivilian_F : CAManBase {
        class EventHandlers : EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };
    class RyanZombieB_Soldier_base_F : CAManBase {
        class EventHandlers : EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };
    class RyanZombieC_man_1;
    class RyanZombiePlayer1 : RyanZombieC_man_1 {
        class EventHandlers : EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };
};
