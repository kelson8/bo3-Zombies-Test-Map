// For the toggle options below:
// 0 is disabled, 1 is enabled.

//---------
// Misc Options
//---------

// Set the perk limit for the map here
#define PERK_LIMIT 10

// Setup the high start points and the amount here.
#define HIGH_START_POINTS 0
#define HIGH_START_POINTS_AMOUNT 50000

// Setup the default starting points for the map here, normally it is 500.
#define DEFAULT_START_POINTS 500

// TODO Set these up, automatically turn power on, and automatically open all doors.
// #define POWER_AUTO_ON 0
// #define DOORS_AUTO_OPEN 0

// Toggle the dogs here
// For now due to glitches with the dogs on my map I have turned them off
// TODO Fix dogs on the map.
#define DOGS_ENABLED 0

//---------
// Zombie Counter
//---------

// If this is enabled, the zombie counter is active in game.
#define ZOMBIE_COUNTER 1

//---------
// Developer options
//---------

// Enable/disable the mod menu for my map.
// I may add more to this later.
#define DEVMODE 0

// #if DEVMODE
// These are extras for the test triggers that I have setup
// Give the player a weapon if the action button is pressed on the control panel for the trigger.
#define GIVE_WEAPON_TRIGGER 1

// Give the player a random perk when the perk bottle on the map is damaged.
#define GIVE_PERK_TRIGGER 1

// Setup the door trigger tests
// This doesn't seem to work right so I disabled it.
#define DOOR_TRIGGER_TEST 0

// Enable the developer teleport triggers, this is mostly going to be for me debugging if I don't have a door in certain areas.
// Well this doesn't properly work just yet.
// It teleports the player once, but after that the hint will show up and it just won't do anything.
// TODO Fix this, I currently have it disabled.
#define DEV_TELEPORT_TRIGGERS 0

// #endif