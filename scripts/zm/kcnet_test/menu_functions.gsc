#using scripts\codescripts\struct;

#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;

#using scripts\shared\music_shared;

#using scripts\zm\_zm_score;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_powerups;

#using scripts\zm\_zm_score;
#using scripts\zm\_zm_audio;
#using scripts\shared\ai\zombie_utility;

// Test
#using scripts\zm\kcnet_test\zombie_counter;
//

// New
// Powerups
// #using scripts\zm\_zm_powerup_bonus_points_player;
// #using scripts\zm\_zm_powerup_bonus_points_team;
#using scripts\zm\_zm_powerup_fire_sale;
#using scripts\zm\_zm_powerup_carpenter;
#using scripts\zm\_zm_powerup_double_points;
#using scripts\zm\_zm_powerup_free_perk;
#using scripts\zm\_zm_powerup_full_ammo;
#using scripts\zm\_zm_powerup_insta_kill;
#using scripts\zm\_zm_powerup_nuke;
#using scripts\zm\_zm_powerup_weapon_minigun;

#insert scripts\shared\shared.gsh;

//
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;

//----------------------//
// Functions
//----------------------//

function test()
{
    self iPrintln("^9Does nothing.");
}


// New
// Some obtained from here: https://github.com/mcabcon/EnCoReV20/blob/main/main.gsc

// This seems to work once the round ends
function func_roundsystem(value)
{
	// https://forum.modme.co/wiki/threads/1354.html
	level thread zm_utility::zombie_goto_round(value);

	// Test, this didn't work
	// zm::set_round_number(value);

}

//-----------
// Copied from ugxm_util.gsc in chaos mod.
function func_turnOnPower()
{
	power_boxes = GetEntArray("use_elec_switch", "targetname");
	for (i = 0; i < power_boxes.size; i++)
	{
		power_boxes[i] notify("trigger", level, true);
		wait 0.001;
	}
}

// This doesn't work
function func_turnOffPower()
{
	power_boxes = GetEntArray("use_elec_switch", "targetname");
	for (i = 0; i < power_boxes.size; i++)
	{
		// What exactly is a trigger on here?
		power_boxes[i] notify("trigger", level, false);
		wait 0.001;
	}
}

function func_openAllDoors()
{
	trigs = GetEntArray("trigger_use", "classname");
	for (i = 0; i < trigs.size; i++)
	{
		if(!isDefined(trigs[i])) continue;
		if(!isDefined(trigs[i].script_flag)) continue;
		trigs[i] notify("trigger", level, true);
		wait 0.001;
	}
}

//----------

// Not sure of the names for these
function func_doGivePerk(perk)
{
	if(!self hasperk(perk) || self zm_perks::has_perk_paused(perk))
	{
		self zm_perks::vending_trigger_post_think(self, perk);
	}
	else
	{
		self notify(perk + "_stop");
		self IPrintLn("Perk [" + perk + "] ^1Removed.");
	}
}

function func_giveAllPerks()
{
	all_perks = GetArrayKeys( level._custom_perks );
	for ( i = 0; i < all_perks.size; i++ )
	{
		if( isdefined( self.perk_purchased) && self.perk_purchased == all_perks[i])
		{
			continue;
		}

		if( !self HasPerk( all_perks[i] ) && !self zm_perks::has_perk_paused(all_perks[i] ) )
		{
			self zm_perks::give_perk(all_perks[i]);
		}
	}
}

// Idea came from _zm_perks.gsc
// This works, plays the teddy bear sound if the player has all perks
function func_addRandomPerk()
{
	self zm_perks::give_random_perk();
}

// TODO Check if player has any perks
function func_removeRandomPerk()
{
	// TODO Test this later, this should check if the player has a perk.
	// if ( isdefined(self.perk_purchased) ) 
	// {
	// 	self zm_perks::lose_random_perk();
	// }
	self zm_perks::lose_random_perk();
}

// This didn't work
function func_removeAllPerks()
{
	self ClearPerks();
}

// This works
function func_givePowerups(powerup)
{
	switch(powerup)
	{
		case "double_points":
			zm_powerup_double_points::grab_double_points(self);
		break;

		// case "bonus_points_self":
		// 	zm_powerup_bonus_points_player::grab_bonus_points_player();
		// break;

		// case "bonus_points_team":
		// 	zm_powerup_bonus_points_team::grab_bonus_points_team();
		// break;

		case "free_perk":
			zm_powerup_free_perk::grab_free_perk();
		break;

		case "max_ammo":
			zm_powerup_full_ammo::grab_full_ammo(self);
		break;

		case "minigun":
			zm_powerup_weapon_minigun::grab_minigun(self);
		break;

		case "insta_kill":
			zm_powerup_insta_kill::grab_insta_kill(self);
		break;

		case "carpenter":
			zm_powerup_carpenter::grab_carpenter(self);
		break;

		case "nuke":
			zm_powerup_nuke::grab_nuke();
		break;

		case "firesale":
			zm_powerup_fire_sale::grab_fire_sale();
		break;


	}
}

// TODO Set this up to toggle on/off the zombie counter

// This doesn't work for turning it back on
function func_turnOnZombieCounter()
{
	if(!level.zombie_counter_enabled)
	{
		level.zombie_counter_enabled = true;
		zombie_counter::init_zombie_counter();
	}
}

// Well this wants to turn it off but it doesn't turn back on lol.
function func_turnOffZombieCounter()
{
	if(level.zombie_counter_enabled)
	{
		level.zombie_counter_enabled = false;
	}
	
}

// Incomplete
function func_killAllZombies()
{

}


function func_changeRound(round)
{

}
//

function func_getAmountOfZombies()
{
	self IPrintLn(zombie_utility::get_current_zombie_count());
}

// Incomplete
// TODO Check if "||" (Or) Exists in this language, "&&" (And) does so I'm sure it would work.
// function func_takeAllPerks()
// {
// 	all_perks = GetArrayKeys( level._custom_perks );
// 	for ( i = 0; i < all_perks.size; i++ )
// 	{
// 		if( isdefined( self.perk_purchased) && self.perk_purchased == all_perks[i])
// 		{
// 			self 
// 			continue;
// 		}
// 	}
// }





function func_giveWeapon(weapon)
{
	// Possibly change to this:
	// self GiveWeapon(weapon);
	self zm_weapons::weapon_give(weapon);
}

function func_giveRayGun()
{
	/*
	* In ugxm_chaosmode.gsc they are using flags like this. 
	* These could be useful for checking if something in my mod is happening. 
	if(!flag::exists("weapon_give_in_progress"))
		self flag::init("weapon_give_in_progress");

	if(self flag::get("weapon_give_in_progress"))	
		self flag::wait_till_clear( "weapon_give_in_progress" ); //if they get two weapons simultaneously for whatever reason, this will keep them from exceeding their inventory size and triggering the engine gun stealing
	
	self flag::set("weapon_give_in_progress");
	*/
	// Which one is it?? None of these worked so far
	self GiveWeapon("ray_gun");
	// self zm_weapons::weapon_give("ray_gun");
	// self func_giveWeapon("ray_gun");
}

// Point functions

function func_givePoints(amount)
{
	self zm_score::add_to_player_score(amount);
}

function func_takePoints(amount)
{
	self zm_score::minus_to_player_score(amount);
}

// Test, well this didn't work
// function func_toggleNoClip()
// {
// 	if (GetDvarInt("noclip", 0) == 0)
// 	{
// 		SetDvar("noclip", 1);
// 	}
// 	else
// 	{
// 		SetDvar("noclip", 0);
// 	}
// }

// Toggle notarget on the player, makes it to where the zombies ignore them if enabled.
// https://github.com/mcabcon/EnCoReV20/blob/main/main.gsc#L2265-L2277
function func_toggleNoTarget()
{
    if(!self.ignoreme)
    {
        self IPrintLn("No Target ^2ON");
        self.ignoreme = true;
    }
    else
    {
        self IPrintLn("No Target ^1OFF");
        self.ignoreme = false;
    }
}

// I don't know how to use this one.
function func_setMusicState()
{
	// self globallogic_audio::set_next_music_state(nextstate, wait_time)
	// self music::setmusicstate("");
}

// Sound effects

// function func_playSfx()
// {
// 	case "double_points":
// 	break;

// 	case "carpenter":
// 	break;

// 	case "insta_kill":
// 	break;

// 	case "nuke":
// 	break;

// 	case "max_ammo":
// 	break;

// 	case "firesale":
// 	break;

// 	case "minigun":
// 	break;

// 	case "boxmove":
// 	break;

// 	case "dogstart":
// 	break;
// }

function func_sfxDoublePoints()
{
	self zm_audio::sndannouncerplayvox("double_points");
}

function func_sfxCarpenter()
{
	self zm_audio::sndannouncerplayvox("carpenter");
}

function func_sfxInstaKill()
{
	self zm_audio::sndannouncerplayvox("insta_kill");
}

function func_sfxNuke()
{
	self zm_audio::sndannouncerplayvox("nuke");
}

function func_sfxMaxAmmo()
{
	self zm_audio::sndannouncerplayvox("full_ammo");
}

function func_sfxFireSale()
{
	self zm_audio::sndannouncerplayvox("fire_sale");
}

function func_sfxMinigun()
{
	self zm_audio::sndannouncerplayvox("minigun");
}

function func_sfxBoxMove()
{
	self zm_audio::sndannouncerplayvox("boxmove");
}

function func_sfxDogStart()
{
	self zm_audio::sndannouncerplayvox("dogstart");
}

// function func_hudTest1()
// {
// 	self.health_bar = NewClientHudElem(self);
// }


// function func_soloCheck()
// {
// 	// This should only run if the game is solo, from turn_revive_on under _zm_perk_quick_revive.gsc
// 	if( level flag::exists("solo_game") )
// 	{

// 	}
// 	else
// 	{

// 	}

// }




// Original
function func_godmode()
{
	if(!isDefined(self.gamevars["godmode"]))
	{
		self.gamevars["godmode"] = true;
		self enableInvulnerability(); 
		self iprintln("God Mode ^2ON");
	}
	else
	{
		self.gamevars["godmode"] = undefined;
		self disableInvulnerability(); 
		self iprintln("God Mode ^1OFF");
	}
}

function func_ufomode()
{
	if(!isDefined(self.gamevars["ufomode"]))
	{
		self thread func_activeUfo();
		self.gamevars["ufomode"] = true;
		self iPrintln("UFO Mode ^2ON");
		self iPrintln("Press [{+frag}] To Fly");
	}
	else
	{
		self notify("func_ufomode_stop");
		self.gamevars["ufomode"] = undefined;
		self iPrintln("UFO Mode ^1OFF");
	}
}
function func_activeUfo()
{
	self endon("func_ufomode_stop");
	self.Fly = 0;
	UFO = spawn("script_model",self.origin);
	for(;;)
	{
		if(self FragButtonPressed())
		{
			self playerLinkTo(UFO);
			self.Fly = 1;
		}
		else
		{
			self unlink();
			self.Fly = 0;
		}
		if(self.Fly == 1)
		{
			Fly = self.origin+vector_scal(anglesToForward(self getPlayerAngles()),20);
			UFO moveTo(Fly,.01);
		}
		wait .001;
	}
}

function func_unlimitedAmmo()
{
	if(!isDefined(self.gamevars["ammo_weap"]))
	{
		self notify("stop_ammo");
		self thread func_ammo();
		self iPrintln("Unlimited Ammo ^2ON");
		self.gamevars["ammo_weap"] = true;
	}
	else
	{
		self notify("stop_ammo");
		self.gamevars["ammo_weap"] = undefined;
		self iPrintln("Unlimited Ammo ^1OFF");
	}
}

function func_ammo()
{
	self endon("stop_ammo");
	for(;;)
	{
			if(self.gamevars["ammo_weap"]==true)
			{	
				if ( self getcurrentweapon() != "none" )
				{
					self setweaponammostock( self getcurrentweapon(), 1337 );
					self setweaponammoclip( self getcurrentweapon(), 1337 );
				}
			}
		wait .1;
	}
}

//----------------------//
//
//----------------------//

//----------------------//
// Extras
//----------------------//

function vector_scal(vec, scale)
{
	vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
	return vec;
}

//----------------------//
//
//----------------------//