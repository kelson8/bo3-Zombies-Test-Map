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

#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;

#using scripts\shared\ai\zombie_utility;

//Perks
#using scripts\zm\_zm_pack_a_punch;
#using scripts\zm\_zm_pack_a_punch_util;
#using scripts\zm\_zm_perk_additionalprimaryweapon;
#using scripts\zm\_zm_perk_doubletap2;
#using scripts\zm\_zm_perk_deadshot;
#using scripts\zm\_zm_perk_juggernaut;
#using scripts\zm\_zm_perk_quick_revive;
#using scripts\zm\_zm_perk_sleight_of_hand;
#using scripts\zm\_zm_perk_staminup;

//Powerups
#using scripts\zm\_zm_powerup_double_points;
#using scripts\zm\_zm_powerup_carpenter;
#using scripts\zm\_zm_powerup_fire_sale;
#using scripts\zm\_zm_powerup_free_perk;
#using scripts\zm\_zm_powerup_full_ammo;
#using scripts\zm\_zm_powerup_insta_kill;
#using scripts\zm\_zm_powerup_nuke;
//#using scripts\zm\_zm_powerup_weapon_minigun;

//Traps
#using scripts\zm\_zm_trap_electric;

#using scripts\zm\zm_usermap;

// New
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_audio;

// From my other zm_test map
// My code
#using scripts\zm\zm_functions;

// Mod menu
// 
#using scripts\zm\kcnet_test\menu_util;

#insert scripts\zm\zm_test_map.gsh;
// #define DEVMODE 1
//


//*****************************************************************************
// MAIN
//*****************************************************************************

// Test
// function __init__()
// {
// 	callback::on_spawned( &on_player_spawned );
// }

function main()
{
	// Dev features, these shouldn't be enabled if I publish a map.
	// Enable high starting points (Start with 500,000 points.)
	high_start_points = true;
	
	zm_usermap::main();

	// From my zm_test, setup max ammo watcher and player spawn watcher
	// https://t7wiki.com/guides/black-ops-4-max-ammo
	// Well possibly adding this is what crashed this map...
	callback::on_spawned(&watchMaxAmmo);
	callback::on_spawned(&onPlayerSpawned);
	//
	
	level._zombie_custom_add_weapons =&custom_add_weapons;
	
	//Setup the levels Zombie Zone Volumes
	level.zones = [];
	level.zone_manager_init_func =&usermap_test_zone_init;
	init_zones[0] = "start_zone";
	level thread zm_zonemgr::manage_zones( init_zones );

	// New
	if(high_start_points)
	{
		level.player_starting_points = 10000;
	} 
	else 
	{
		level.player_starting_points = 2000;
	}
	

	level.pathdist_type = PATHDIST_ORIGINAL;

	thread introText();

	// New, from my zm_test map
	level.perk_purchase_limit = 20;


}

//-----------
// Copied from zm_test map

// When the player is spawned
function onPlayerSpawned()
{
	// Copied from my Mod menu test.
	// Zombie counter test
	// zombie_counter::init_zombie_counter();

	// Mod menu test, should only work if DEVMODE is defined.
	// TODO Figure out if preprocessors work like this in gsc, I don't think they do.
	
	// If dev mode is enabled, this mod menu should run.
	// * Disabled for now
	// #ifdef DEVMODE
	// Test
	if(DEVMODE == 1){

	
	if(!isDefined(self.menu["active"]))
	{
		// self thread init_menuSystem();
		self thread menu_util::init_menuSystem();
		self.menu["active"] = true;
		self iprintln("Welcome to "+self.menu["name"]+" ^7for Black Ops 3");
		// self iprintln("By ^2CabCon");
		self iprintln("Menu created by ^2kelson8, menu base created By ^2CabCon");
		// Menu options
		self menu_util::initMenuOpts(); 
		
		// Menu init
		self thread menu_util::initMenu();
		// self initMenuOpts(); 
		// self thread initMenu();
	}

	}
	// #endif
	
}

//

// https://t7wiki.com/guides/black-ops-4-max-ammo
// Refill ammo in clip and stock with max ammo, like in Cold War and BO4
function watchMaxAmmo()
{
	self endon("bled_out");
	self endon("spawned_player");
	self endon("disconnect");
	for(;;)
	{
		self waittill("zmb_max_ammo");
		foreach(weapon in self GetWeaponsList(1))
		{
			if(isdefined(weapon.clipsize) && weapon.clipsize > 0)
			{
				self SetWeaponAmmoClip(weapon, weapon.clipsize);
			}
		}
	}
}

//----------

// Test
function on_player_spawned()
{
	self give_points(10000);
}

function give_points(amount)
{
	self zm_score::add_to_player_score(amount);
}



function usermap_test_zone_init()
{
	level flag::init( "always_on" );
	level flag::set( "always_on" );
}	

function custom_add_weapons()
{
	zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_levelcommon_weapons.csv", 1);
}

function introText()
{
	level flag::wait_till( "initial_blackscreen_passed" );
	IPrintLn("Welcome to the the test map!");
}