#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\compass;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#insert scripts\zm\_zm_utility.gsh;

#using scripts\zm\_zm_powerups;

//Powerups
#using scripts\zm\_zm_powerup_double_points;
#using scripts\zm\_zm_powerup_carpenter;
#using scripts\zm\_zm_powerup_fire_sale;
#using scripts\zm\_zm_powerup_free_perk;
#using scripts\zm\_zm_powerup_full_ammo;
#using scripts\zm\_zm_powerup_insta_kill;
#using scripts\zm\_zm_powerup_nuke;
//#using scripts\zm\_zm_powerup_weapon_minigun;

// New
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_weapons;

// Triggers

// Dev teleport features, these will only be enabled if 'DEV_TELEPORT_TRIGGERS' is enabled in zm_test_map.gsh.
// TODO Consolidate the triggers in this function, use switch statements or something if possible.
// TODO Make this work more then once, the text stays on screen but it won't teleport the player more then once.
// Well this almost works, it works once then the trigger doesn't work anymore.
function devTriggersUse()
{
	// teleport_player_devloc1
	// Teleport player outside
	trig1 = GetEnt("teleport_player_devloc1", "targetname");

	hintTextTrig1 = "Press &&1 to teleport to the dev test area";

	trig1 SetHintString(hintTextTrig1);

	trig1 waittill("trigger", player);

    // Outside coords
	player SetOrigin((-1428, 785, 0.5));

	// Teleport player back inside
	trig2 = GetEnt("teleport_player_devloc2", "targetname");

	hintTextTrig2 = "Press &&1 to teleport back inside";

	trig2 SetHintString(hintTextTrig2);

	trig2 waittill("trigger", player);

	// Inside coords
	player SetOrigin((-276, 11, 0.5));
}