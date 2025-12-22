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

function give_points(amount)
{
	self zm_score::add_to_player_score(amount);
}