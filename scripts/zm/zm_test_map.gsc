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
#using scripts\zm\kcnet_test\zombie_counter;

#insert scripts\zm\zm_test_map.gsh;
// #define DEVMODE 1
//


// Useful links for doors

// Setting up doors/debris doors, and garage doors that open.
// https://www.youtube.com/watch?v=FZaaw01xvmA

// Setting up specific rotations for doors:
// https://www.youtube.com/watch?v=p0aUgx9OZMU

// TODO Fix the doors on this map.
// Well I did have the door rotation working, now it clears the door when bought but doesn't move or rotate.
// One of the two doors somewhat rotate, although it doesn't properly rotate.
// The other door, the player can walk through once bought but it stays in the same place.

//*****************************************************************************
// MAIN
//*****************************************************************************

// Test
// TODO Is an init needed in here?
// function __init__()
// {
// 	
// }

function main()
{
	// Dev features, these shouldn't be enabled if I publish a map.
	// Enable high starting points (Start with a set amount of points.)
	high_start_points = true;

	// Max starting points for starting the map with high start points enabled.
	max_starting_points = 30000;

	// Zombie counter toggle
	zombie_counter = true;

	// Remove powerups toggle
	remove_powerups = true;

	// Higher jumping, and other features I may add, there is nothing here yet.
	fun_features = false;

	zm_usermap::main();

	// TODO Fix these
	// Setup the voice lines
	// level thread zm_castle_vox();

	// level thread zm_theater_vox();

	// From my zm_test, setup max ammo watcher and player spawn watcher
	// https://t7wiki.com/guides/black-ops-4-max-ammo
	// Well possibly adding this is what crashed this map...
	callback::on_spawned(&watchMaxAmmo);
	callback::on_spawned(&onPlayerSpawned);
	//
	
	level._zombie_custom_add_weapons =&custom_add_weapons;
	
	//Setup the levels Zombie Zone Volumes
	// TODO Look into these zones later
	level.zones = [];
	level.zone_manager_init_func =&usermap_test_zone_init;
	init_zones[0] = "start_zone";
	level thread zm_zonemgr::manage_zones( init_zones );

	// Zombie counter that displays on screen
	if(zombie_counter)
	{
		level.zombie_counter_enabled = true;
		zombie_counter::init_zombie_counter();
	}

	// Remove specific powerups, I think this works
	if(remove_powerups)
	{
		removePowerups();
	}

	// Toggle higher jumping and other stuff here
	if(fun_features)
	{
		// Well I'm not sure which gsc file this is in.
		// self SetJumpHeight(100.0);
	}

	// Toggle dev mode features such as no target
	if(DEVMODE == 1) 
	{
		// TODO Setup no target here and other items if needed
		
		// No target
		// self.ignoreme = true;

		// I may add more to this in the future
		// Infinite ammo

		// Other items

	}



	// New
	if(high_start_points)
	{
		level.player_starting_points = max_starting_points;
	} 
	else 
	{
		level.player_starting_points = 2000;
	}
	

	level.pathdist_type = PATHDIST_ORIGINAL;

	// Display the intro text for the map
	thread introText();

	// New, from my zm_test map
	// Set the perk purchase limit here
	level.perk_purchase_limit = 20;
}

// New

// This should remove specific powerups from the drop list
// https://steamcommunity.com/app/455130/discussions/0/1291817208498696239/
function removePowerups()
{
	// zm_powerups::powerup_remove_from_regular_drops( "minigun" );
	// Disable the nukes and carpenter
	zm_powerups::powerup_remove_from_regular_drops( "nuke" );
	zm_powerups::powerup_remove_from_regular_drops( "carpenter" );
}

//

//-----------
// Copied from zm_test map

// When the player is spawned
function onPlayerSpawned()
{
	// Give the player a set amount of points when they join in, this is already being set in the main function.
	// self zm_functions::give_points(10000);

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

// Init the test zone for the zones
function usermap_test_zone_init()
{
	level flag::init( "always_on" );
	level flag::set( "always_on" );
}	

function custom_add_weapons()
{
	zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_levelcommon_weapons.csv", 1);
}

// Intro text to display on game startup
function introText()
{
	welcomeMessage = "Welcome to the KCNet Test map";
	level flag::wait_till( "initial_blackscreen_passed" );
	IPrintLn(welcomeMessage);
}

// https://wiki.modme.co/wiki/black_ops_3/basics/Setting-Up-Player-Voices-(Der-Eisendrache).html
// https://wiki.zeroy.com/index.php?title=Call_of_Duty_bo3:_ZM_Voxes
// function zm_castle_vox()
function add_zm_vox()
{
	// zm_audio::loadPlayerVoiceCategories("gamedata/audio/zm/zm_vox.csv");
	// TODO Figure this out
	// zm_audio::loadPlayerVoiceCategories("gamedata/audio/zm/zm_castle_vox.csv");
}

// Kino Der Toten vox
// Well this didn't work
// https://www.devraw.net/approved-assets/zecstasy/kino-der-toten-character-vox
function zm_theater_vox()
{
	// zm_audio::loadPlayerVoiceCategories("gamedata/audio/zm/zm_theater_vox.csv");
}
