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

#using scripts\zm\_zm_zonemgr;

#using scripts\shared\ai\zombie_utility;

// This file was created by kelson8, I took some inspiration from other elevator scripts.
// For now this is just a very basic script that will open and close the elevator doors 
// and move the elevator platform up and down.

// TODO Fix the elevator to open the bottom doors and enable the elevator when power is activated.
// TODO Fix the call button hint strings to only display if the elevator is not on the current floor.
// Currently they dissappear if the elevator if the call buttons are used.

// Goals:
// Make elevator platform move when trigger is pressed with the platform. - Complete
// Setup elevator call button. - Complete
// Only allow elevator to be called if the bottom or top doors are open and the player is on the opposite floor. - Mostly complete
// Require elevator to have power before it'll work. - Incomplete/Not started

//-------
// Trigger targetnames below
//-------

// Elevator doors targetname:
// Bottom: elevator_bottom_floor_doors
// Top: elevator_top_floor_doors

// Elevator platform targetname:
// elevator_moving_platform

// Elevator call buttons targetname:
// Top floor: elevator_top_call_btn
// Bottom floor: elevator_bottom_call_btn

// Elevator triggers targetname
// Top floor: elevator_top_platform_trigger
// Bottom floor: elevator_bottom_platform_trigger

//-----
// Elevator variables
//-----

// Elevator doors

// Set the X position for the elevator doors being open here.
// Set the doors to open towards the left.
#define ELEVATOR_DOORS_OPEN_OFFSET 326

// Set the doors close offset, should normally be negative of the open offset.
#define ELEVATOR_DOORS_CLOSE_OFFSET -326

// Elevator doors move time in seconds
#define ELEVATOR_DOORS_MOVE_TIME 2

// Elevator platform
// Move up offset
#define ELEVATOR_PLATFORM_MOVE_UP_OFFSET 403

// Move down offset
#define ELEVATOR_PLATFORM_MOVE_DOWN_OFFSET -403

// Time to move
#define ELEVATOR_PLATFORM_MOVE_TIME 2

// Init function for the elevator variables, place in the main script somewhere under 'zm_usermap::main()'
function initElevatorVariables()
{
    // Should the doors auto open when the game starts?
    // TODO Fix this to where the elevator is only active with the power on.
    level.autoOpenDoors = true;

    // level.topDoorsOpen = undefined;
    // Closed by default, I did have these set to undefined but I don't want to deal with that right now.
    level.topDoorsOpen = false;
    level.bottomDoorsOpen = false;
    level.platformMovedUp = false;

    // Elevator floor doors
    level.elevatorTopFloorDoors = GetEnt("elevator_top_floor_doors", "targetname");
    level.elevatorBottomFloorDoors = GetEnt("elevator_bottom_floor_doors", "targetname");
    
    // Elevator platform
    level.elevatorPlatform = GetEnt("elevator_moving_platform", "targetname");
    // Trigger
    level.elevatorBottomPlatformTrigger = GetEnt("elevator_bottom_platform_trigger", "targetname");
    level.elevatorTopPlatformTrigger = GetEnt("elevator_top_platform_trigger", "targetname");

    // Elevator call buttons
    level.elevatorTopFloorCallButton = GetEnt("elevator_top_call_btn", "targetname");
    level.elevatorBottomFloorCallButton = GetEnt("elevator_bottom_call_btn", "targetname");

    // TODO Remove, this is for testing purposes only.
    // TODO Make this auto open when the power is turned on for play tests.
    if(level.autoOpenDoors)
    {
        openBottomElevatorDoors();
        // openTopElevatorDoors();
    }

    // thread activateElevatorWithPower();

    // New, threads for the triggers
    level thread bottomFloorElevatorCallButton();
    level thread topFloorElevatorCallButton();

    level thread elevatorBottomPlatformTrigger();
    level thread elevatorTopPlatformTrigger();
    //

    // Auto activate zone for debugging, this is now activated by the spawn room door #2.
    // I added outside_door3 to go out to the elevator for now, Re-enable if the zone doesn't work right.
    // zm_zonemgr::enable_zone("outside_zone2");
    
}

//-----
// Elevator functions
//-----

//-----
// Power
//-----

// TODO Make the elevator bottom doors automatically open with power.
// TODO Make the elevator only work when the power is on.
function openBottomDoorsWithPower()
{
    openBottomElevatorDoors();
}

function activateElevatorWithPower()
{
    level flag::wait_till("power_on");
    thread openBottomDoorsWithPower();
}

//-----
// Elevator doors
//-----

function openTopElevatorDoors()
{
    if(isdefined(level.topDoorsOpen) && !level.topDoorsOpen)
    {
        level.elevatorTopFloorDoors MoveX(ELEVATOR_DOORS_OPEN_OFFSET, ELEVATOR_DOORS_MOVE_TIME);
        level.topDoorsOpen = true;
    }
}

function openBottomElevatorDoors()
{
    if(isdefined(level.bottomDoorsOpen) && !level.bottomDoorsOpen)
    {
        level.elevatorBottomFloorDoors MoveX(ELEVATOR_DOORS_OPEN_OFFSET, ELEVATOR_DOORS_MOVE_TIME);
        level.bottomDoorsOpen = true;
    }
}

function closeTopElevatorDoors()
{
    if(isdefined(level.topDoorsOpen) && level.topDoorsOpen)
    {
        level.elevatorTopFloorDoors MoveX(ELEVATOR_DOORS_CLOSE_OFFSET, ELEVATOR_DOORS_MOVE_TIME);
        level.topDoorsOpen = false;
    }
}

function closeBottomElevatorDoors()
{
    if(isdefined(level.bottomDoorsOpen) && level.bottomDoorsOpen)
    {
        level.elevatorBottomFloorDoors MoveX(ELEVATOR_DOORS_CLOSE_OFFSET, ELEVATOR_DOORS_MOVE_TIME);
        level.bottomDoorsOpen = false;
    }
}
//

//-----
// Elevator platform
//-----

function moveElevatorPlatformUp()
{
    if(isdefined(level.platformMovedUp) && !level.platformMovedUp)
    {
        level.elevatorPlatform MoveZ(ELEVATOR_PLATFORM_MOVE_UP_OFFSET, ELEVATOR_PLATFORM_MOVE_TIME);
        level.platformMovedUp = true;
    }
}

function moveElevatorPlatformDown()
{
    if(isdefined(level.platformMovedUp) && level.platformMovedUp)
    {
        level.elevatorPlatform MoveZ(ELEVATOR_PLATFORM_MOVE_DOWN_OFFSET, ELEVATOR_PLATFORM_MOVE_TIME);
        level.platformMovedUp = false;
    }

}

//-----
// Moving the entire elevator
//-----

// Move the elevator down
function moveElevatorDown()
{
    closeTopElevatorDoors();
    moveElevatorPlatformDown();
    openBottomElevatorDoors();
}

// Move the elevator up
function moveElevatorUp()
{
    closeBottomElevatorDoors();
    moveElevatorPlatformUp();
    openTopElevatorDoors();
}

//-----
// Call buttons
//-----

// This mostly works, but if both elevator doors are closed and the platform is in a different spot it won't work.
// Although in the code that should never happen unless I use the mod menu for it.
// TODO Fix the hint strings to display again, once the call button is used they go away forever
// Other then that, this elevator mostly works
function bottomFloorElevatorCallButton()
{
    level.elevatorBottomFloorCallButton SetHintString("Press &&1 to call elevator.");

    while (true)
    {
        level.elevatorBottomFloorCallButton waittill("trigger");

        if(level.topDoorsOpen && level.platformMovedUp)
        {
            moveElevatorDown();

            level.elevatorBottomFloorCallButton SetHintString("");
        }
    }
}

function topFloorElevatorCallButton()
{
    // Well this hint string never comes back lol
    level.elevatorTopFloorCallButton SetHintString("Press &&1 to call elevator.");

    while (true)
    {
        level.elevatorTopFloorCallButton waittill("trigger");

        if(level.bottomDoorsOpen && !level.platformMovedUp)
        {
            moveElevatorUp();

            level.elevatorTopFloorCallButton SetHintString("");
        }
    }
}


//-----
// Elevator move triggers
//-----

// Move the elevator trigger with the elevator
// Well I made these into separate functions, I think putting them together was breaking it.

// This almost works, I need to set it to where the trigger can only be pressed once and not spammed, otherwise it breaks the elevator.

// Bottom floor trigger, move elevator up.
function elevatorBottomPlatformTrigger()
{
    level.elevatorBottomPlatformTrigger SetHintString("Press &&1 to use elevator");
    while (true)
    {
        level.elevatorBottomPlatformTrigger waittill("trigger");

        if(level.bottomDoorsOpen && !level.platformMovedUp)
        {
            moveElevatorUp();
            wait 5;
        }
    }
}

// Top floor trigger, move elevator down.
function elevatorTopPlatformTrigger()
{
    level.elevatorTopPlatformTrigger SetHintString("Press &&1 to use elevator");
    while (true)
    {
        level.elevatorTopPlatformTrigger waittill("trigger");

        if(level.topDoorsOpen && level.platformMovedUp)
        {
            moveElevatorDown();
            wait 5;
        }
    }
}