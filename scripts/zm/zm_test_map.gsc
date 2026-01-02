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
// New for Widows Wine
#using scripts\zm\_zm_perk_widows_wine;

// Gobblegums
#using scripts\zm\_zm_bgb_machine;

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

// Five style Teleporter
// #using scripts\orng\teleporter;

// ZombieKid164's Buyable Elevator
// #using scripts\_ZK\zk_buyable_elevator;

// Dobby's Cold War styled Wonderfizz
#using scripts\zm\_t9_wonderfizz;

// New
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_audio;

// From my other zm_test map
// My code
#using scripts\zm\zm_functions;
#using scripts\zm\zm_dev_functions;
#using scripts\zm\zm_elevator_functions;

// Mod menu
// 
#using scripts\zm\kcnet_test\menu_util;
#using scripts\zm\zm_functions;
#using scripts\zm\kcnet_test\zombie_counter;

#insert scripts\zm\zm_test_map.gsh;
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
	// Remove powerups toggle, remove the nuke and carpenter.
	remove_powerups = true;

	// Higher jumping, and other features I may add, there is nothing here yet.
	fun_features = false;

	// Misc tests for triggers
	// I moved these into zm_test_map.gsh.

	// Change the zombies walking speed on all rounds.
	// This didn't work
	super_speed_zombies = false;

	// Disable dog rounds if flag is set to 0 in zm_test_map.gsh.
	// This has to be above the zm_usermap::main
	// https://wiki.ugx-mods.com/Modding/Black-Ops-3-Modtools/Mapping/Adding-Dog-Spawners-or-Disabling-Dog-Rounds
	if(DOGS_ENABLED == 0)
	{
		level.dog_rounds_allowed = false;
	}

	zm_usermap::main();

	
	// TODO: This might also need to be in the CSC to display the message for it, or some other format for the CSC.
	// This allows the player to get their first gobblegum for free for each round.
	// Normally, this is what the base game maps do.
	setdvar( "scr_firstGumFree", "1" );

	// Five style teleporter init
	// thread init_power_orng();

	// ZombieKid164's Buyable Elevator
	// level thread zk_buyable_elevator::init();

	// Setup the voice lines
	// Not in use
	// level thread zm_castle_vox();

	// Well I got the Kino voice lines working
	level thread zm_theater_vox();

	// From my zm_test, setup max ammo watcher and player spawn watcher
	// https://t7wiki.com/guides/black-ops-4-max-ammo
	// TODO Move watchMaxAmmo into onPlayerSpawned, possibly run as a thread.
	callback::on_spawned(&watchMaxAmmo);
	callback::on_spawned(&onPlayerSpawned);
	//
	
	level._zombie_custom_add_weapons =&custom_add_weapons;
	
	//Setup the levels Zombie Zone Volumes
	level.zones = [];
	level.zone_manager_init_func =&usermap_test_zone_init;
	init_zones[0] = "start_zone";
	level thread zm_zonemgr::manage_zones( init_zones );


	// New for my elevator test functions
	zm_elevator_functions::initElevatorVariables();
	//

	// Zombie counter that displays on screen
	if(ZOMBIE_COUNTER == 1)
	{
		level.zombie_counter_enabled = true;
		zombie_counter::init_zombie_counter();
	}

	// Remove specific powerups, I think this works
	if(remove_powerups)
	{
		zm_functions::removePowerups();
	}

	// Toggle higher jumping and other stuff here
	if(fun_features)
	{
		// Well I'm not sure which gsc file this is in.
		// self SetJumpHeight(100.0);
	}

	// New for trigger testing

	// TODO Set this up
	// Move the opened doors Y position or whatever to make it look like it opens properly.
	if(DOOR_TRIGGER_TEST == 1)
	{
		// Well this didn't work or do anything, maybe I can use 'script_vector' on the door object in Radiant.
		// level thread zm_functions::door1Trigger();
		level thread zm_functions::doorTriggers();
	}

	// Use trigger test
	// TODO Try to make one of these play a sound
	if(DEV_TELEPORT_TRIGGERS == 1)
	{
		// level thread zm_dev_functions::devTriggersUse();
		// I separated these out, and used the same logic I use for the elevators and the loop.
		// This should work for teleporting between areas, well as long as the zone is active..
		// TODO Make these check if the zone is active, if not don't teleport!!
		level thread zm_dev_functions::teleportDevTrigger1Use();
		level thread zm_dev_functions::teleportDevTrigger2Use();
	}
	
	if(GIVE_WEAPON_TRIGGER == 1)
	{
		// Give a player a weapon if the action button is pressed on the control panel.
		// give_player_weapon
		// level thread zm_functions::giveWeaponTriggerUse("ray_gun");

		// Give the player a random weapon.
		level thread zm_functions::giveRandomWeaponTriggerUse();

		// level thread zm_functions::triggerTest();
	}

	// Damage trigger test
	// Give player a random perk when the perk bottle is shot at.	
	if(GIVE_PERK_TRIGGER == 1)
	{
		level thread zm_functions::givePlayerPerkTriggerUse();
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

		// Make the zombies super fast
		// Well this didn't do anything
		if(super_speed_zombies)
		{
			level.zombie_move_speed = 10;
		}

	}

	// New
	if(HIGH_START_POINTS == 1)
	{
		level.player_starting_points = HIGH_START_POINTS_AMOUNT;
	} 
	else 
	{
		level.player_starting_points = DEFAULT_START_POINTS;
	}
	

	level.pathdist_type = PATHDIST_ORIGINAL;

	// Display the intro text for the map
	thread introText();

	// New, from my zm_test map
	// Set the perk purchase limit in zm_test_map.gsh
	level.perk_purchase_limit = PERK_LIMIT;
}

// Five style teleporter init
// Well oops, where I didn't have the other zones active it just killed me when I went to them lol.
// TODO Fix this to work with zones.
// function init_power_orng() 
// { 
// 	level flag::wait_till("power_on");
// 	teleporter::teleporter_init(); 
// }

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
	if(DEVMODE == 1)
	{	
		if(!isDefined(self.menu["active"]))
		{
			// self thread init_menuSystem();
			self thread menu_util::init_menuSystem();
			self.menu["active"] = true;
			self iprintln("Welcome to " + self.menu["name"] + " ^7for Black Ops 3");
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

	// New for zones
	// Add more of these when adding zones.
	// Make sure to link zones together if there are multiple that go to one spot.
	// Such as outside_zone1 to start_zone if I set that up.
	
	//-----
	// Start zone
	//-----

	// Start zone to room1 zone
	zm_zonemgr::add_adjacent_zone( "start_zone", "room1_zone", "activate_room1_zone" );
	
	// Start zone to room2 zone, probably not needed
	// zm_zonemgr::add_adjacent_zone( "start_zone", "room2_zone", "activate_room2_zone" );

	// Start zone to pack a punch room zone, probably not needed
	// zm_zonemgr::add_adjacent_zone( "start_zone", "pack_a_punch_room_zone", "activate_pack_a_punch_room_zone" );

	// Test zone
	zm_zonemgr::add_adjacent_zone( "start_zone", "outside_zone2", "activate_zone2_outside" );

	//-----
	// Room 1 zone
	
	//-----
	// Room 1 zone to pack a punch room
	zm_zonemgr::add_adjacent_zone( "room1_zone", "pack_a_punch_room_zone", "activate_pack_a_punch_room_zone" );
	
	// Room 1 zone to room 2 zone
	zm_zonemgr::add_adjacent_zone( "room1_zone", "room2_zone", "activate_room2_zone" );

	//-----
	// Room 2 zone
	//-----

	// Room 2 zone to outside zone1
	zm_zonemgr::add_adjacent_zone( "room2_zone", "outside_zone1", "activate_zone1_outside" );

	//-----
	// Outside, test zones
	//-----
	// For now, I set this up to auto activate in zm_elevator_functions.gsc under the init variables function.
	// zm_zonemgr::add_adjacent_zone( "test_zone1", "start_zone", "activate_test_zone1" );
	zm_zonemgr::add_adjacent_zone( "outside_zone2", "start_zone", "activate_zone2_outside" );
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

// Kino Der Toten voice lines
// https://www.devraw.net/approved-assets/zecstasy/kino-der-toten-character-vox
function zm_theater_vox()
{
	zm_audio::loadPlayerVoiceCategories("gamedata/audio/zm/zm_theater_vox.csv");
}
