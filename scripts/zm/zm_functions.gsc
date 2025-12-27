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

// TODO Move functions into here

// TODO Check if power is on, if so print "You have turned on the power! Prepare for crawlers and random hellhounds"

// I got this working
function powerupSpawn()
{
	// Static powerups
	// https://t7wiki.com/guides/how-to-add-static-powerup
	powerup_spawn_loc = struct::get("powerup_spawn_location");
	drops = array("fire_sale", "insta_kill", "double_points");

	while(!level.passed_introscreen)
		WAIT_SERVER_FRAME;
	
	level thread zm_powerups::specific_powerup_drop(array::random(drops), powerup_spawn_loc.origin, undefined, undefined, undefined, undefined, true);
	//
}

// Test

// zm_cosmodrome.gsc lines 636-660
function checkIfPowerIsOn()
{
	power_switch = struct::get("power_switch", "targetname");
	level flag::wait_till("power_on");
	// Hmm, this could be useful once I figure out how to play the vox announcer sounds.
	// I have a bunch of assets for it.
	// level thread zm_cosmodrome_amb::play_cosmo_announcer_vox("vox_ann_power_switch");
	// What is this doing? I think it's setting a flag for the power
	IPrintLnBold("You have turned on the power! Prepare for crawlers and random hellhounds");
	// level clientfield::set("zombie_power_on", 1);
}

function powerTest()
{
	// TODO Possibly check if power is turned on using this below
	power_boxes = GetEntArray("use_elec_switch", "targetname");

	// Idea from zm_temple_power.gsc
	if(flag::get("power_on"))
	{
		self IPrintLn("You have turned on the power! Prepare for crawlers and random hellhounds");
		// return true;

	}
	// else
	// {
	// 	return false;
	// }
}

// function tellPlayerPowerOn()
// {
// 	level waittill ("player_spawned", player);
// 	if(powerTest())
// 	{
// 		player IPrintLn("You have turned on the power! Prepare for crawlers and random hellhounds");
// 	}
// }

function giveDoublePoints()
{
	self zm_powerup_double_points::grab_double_points();
}

function giveMoney()
{
	self zm_score::add_to_player_score(50000);
}

function on_player_spawned()
{
	self give_points(10000);
}

// Give the player a set amount of points.
function give_points(amount)
{
	self zm_score::add_to_player_score(amount);
}

// Trigger functions

// https://www.youtube.com/watch?v=rhlWM0mJ5vM&list=PL1rMfOFuHfbMzBHibfla9wyCwdfMao0ou&index=3
// Give the player a perk when the perk bottle is shot on the map.

function givePlayerPerkTriggerUse()
{
	trig = GetEnt("give_player_perk", "targetname");

	// Get the bottle entity
	// Get the bottles target name from the trigger
	bottle = GetEnt(trig.target, "targetname");

	trig waittill("trigger", player);

	// Remove the perk bottle
	bottle Delete();

	// Give the player a random perk
	player zm_perks::give_random_perk();

	// Remove the trigger
	trig Delete();
}

// Basic test to display some text with the trigger
// This works, I had to change "self waittill" to "trig waittill"
function triggerTest()
{
	trig = GetEnt("give_player_weapon", "targetname");
	hintText = "Press &&1 to display some text";

	trig SetHintString(hintText);

	trig waittill("trigger", player);

	player IPrintLn("You have pressed the trigger");
	trig Delete();
}

// https://www.youtube.com/watch?v=midIUORXf10&list=PL1rMfOFuHfbMzBHibfla9wyCwdfMao0ou&index=2
// Give the player a weapon from a use trigger
// Well this shows the hint string, but doesn't give the player a weapon.
// TODO Setup a function that gives the player a random weapon
function giveWeaponTriggerUse(weapon)
{
	trig = GetEnt("give_player_weapon", "targetname");
	trig UseTriggerRequireLookAt();
	// &&1 Should replace the key with the action button, although I'm not sure how this works.
	// TODO Set this hint string to get the text of the weapon name, instead of "ray_gun", display "Ray Gun"
	hintText = "Press &&1 to take " + weapon;
	// hintText = "Press &&1 to take weapon";
	trig SetHintString(hintText);

	trig waittill("trigger", player);

	// self zm_weapons::weapon_give(weapon);
	weapon_to_give = GetWeapon(weapon);
	player zm_weapons::weapon_give(weapon_to_give);
	// TODO Is this needed if I use weapon_give?
	// player SwitchToWeapon(weapon_to_give);

	// Remove the trigger so it doesn't show up anymore.
	trig Delete();
}

// Door test triggers
// Well this didn't work for moving the doors.
// TODO Figure out how to move the X and Y position of these in the scripts, for now this will do.
// Most of this is already set in the script, I'm just going to override part of it.
/* 
Door #1 position

X: 968 - 997

Y: 208 - 177
*/
function doorTriggers()
{
	// trig = GetEnt("test_door1", "targetname");
	// trig = GetEnt("test_door1", "target");
	trig = GetEnt("zombie_door", "target_name");

	// TODO Use switch statements if this below works
	/**
	switch(trig.target)
	{
		case "test_door1":
			// Door features here
			break;
	}
	*/

	trig waittill("trigger");

	// TODO Test this
	// test_door1 is the first door on my map.
	// This should move the X, and Y positions of the door into the proper place
	if(trig.target == "test_door1")
	{
		// door = GetEnt(trig.target, "targetname");
		door = GetEnt("test_door1", "targetname");

		// Move the X position of the door
		door moveX(-29, 1);

		// Move the Y position of the door when opened
		door MoveY(-31, 1);
	}
}

//

// Weapons
function giveRandomWeapon(player) 
{
	// TODO Figure out arrays for this
	// weapon_list = StrTok(string, delim)
}

// Powerups
// This should remove specific powerups from the drop list
// https://steamcommunity.com/app/455130/discussions/0/1291817208498696239/
function removePowerups()
{
	// zm_powerups::powerup_remove_from_regular_drops( "minigun" );
	// Disable the nukes and carpenter
	zm_powerups::powerup_remove_from_regular_drops( "nuke" );
	zm_powerups::powerup_remove_from_regular_drops( "carpenter" );
}