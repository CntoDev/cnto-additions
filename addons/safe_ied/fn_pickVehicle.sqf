/*
 * don't run this everywhere - while setHitPointDamage is AL,
 * network desync might result in more than 1 vehicle being picked
 * as "nearest" and 2 or more explosions could happen from 1 mine
 *
 * therefore do this safely, pick a nearest vic on server only and
 * then remoteExec it everywhere (to safeguard against locality transfer
 * mid-remoteExec)
 */

if (!isServer) exitWith {};

params ["_mine", "", "", "_pos"];

// find a nearby vehicle
private _objs = nearestObjects [_pos, ["Car", "Tank", "Motorcycle"], 5, true];
if (_objs isEqualTo []) exitWith {};
private _veh = _objs select 0;
if (!(_veh isKindOf "Car")) exitWith {};

_veh remoteExec ["cnto_safe_ied_fnc_explode"];
