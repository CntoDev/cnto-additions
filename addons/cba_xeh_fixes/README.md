CBA has an Extended Event Handler (XEH) framework, see
[the official docs](https://github.com/CBATeam/CBA_A3/wiki/Extended-Event-Handlers-(new)).

This extends the vanilla `class EventHandler { ... }` defined in `CfgVehicles`
sub-classes to both smoothly support Event Handlers in misc modded content,
as well as allow EH additions mid-mission via `CBA_fnc_addClassEventHandler`.

The problem is that, for this to work, every `CfgVehicles` sub-class needs to
include `class CBA_Extended_EventHandlers` in its `class EventHandlers`, so that
the engine executes CBA code for the unit. This is normally achieved just by
the mod maker not touching `class EventHandlers`, so it gets inherited from
a more generic parent class, or by including
```
class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
```
explicitly. See
[the official docs](https://github.com/CBATeam/CBA_A3/wiki/Extended-Event-Handlers-(new)#compatibility-without-dependance)
again for details.

Some mod authors however "hardcode" their own `class EventHandlers` and do not
include this CBA call - this happens ie. on
```
	class TH_SNOWING1 : THIRSK_WeatherPreSet {
		scope = public;
		displayName = "Snowing Strenght 1";
		icon = "\RHNET\Thirsk5\icons\snowing2";
		
		class EventHandlers {
			init = "[_this select 0,2] exec ""\RHNET\Thirsk5\scripts\THIRSK_Snow.sqs""";
		};
	};
```

The addons in this directory then further modify the modded content to either
properly inherit the CBA sub-class or re-define it from scratch.
