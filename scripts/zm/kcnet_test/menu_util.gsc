/*
┏━━━┓╋╋┏┓╋┏━━━┓╋╋╋╋╋┏━┓┏━┓╋╋╋╋┏┓╋┏┓
┃┏━┓┃╋╋┃┃╋┃┏━┓┃╋╋╋╋╋┃┃┗┛┃┃╋╋╋╋┃┃╋┃┃
┃┃╋┗╋━━┫┗━┫┃╋┗╋━━┳━┓┃┏┓┏┓┣━━┳━┛┣━┛┣┳━┓┏━━┓
┃┃╋┏┫┏┓┃┏┓┃┃╋┏┫┏┓┃┏┓┫┃┃┃┃┃┏┓┃┏┓┃┏┓┣┫┏┓┫┏┓┃
┃┗━┛┃┏┓┃┗┛┃┗━┛┃┗┛┃┃┃┃┃┃┃┃┃┗┛┃┗┛┃┗┛┃┃┃┃┃┗┛┃
┗━━━┻┛┗┻━━┻━━━┻━━┻┛┗┻┛┗┛┗┻━━┻━━┻━━┻┻┛┗┻━┓┃
╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋┏━┛┃
╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋┗━━┛

Check out: https://cabconmodding.com/
For more Black Ops 3 Source and scripts or mods: https://cabconmodding.com/forums/call-of-duty-black-ops-3-mods-and-scripts.8/

Check out the source below for the menu base, I did not create it.
Original source: https://cabconmodding.com/threads/black-ops-3-gsc-mod-menu-base-by-cabcon-simple-source-and-download.1332/

*/

#using scripts\codescripts\struct;

#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#insert scripts\shared\shared.gsh;

// kcnet_test
#using scripts\zm\kcnet_test\menu_functions;
#using scripts\zm\kcnet_test\zombie_counter;


// TODO Figure out how to add parameters to the methods in the menu.

function init_menuSystem()
{
	self.menu = [];
	self.gamevars = [];
	// self.menu["name"] = "BO3 Mod Menu";
	self.menu["name"] = "KCNet BO3 ZM Menu";
	
}

function initMenuOpts()
{
    // To add a menu to this:
    /*

    * First define the menu
    self addMenu("example_menu", "Example Menu", "main");
	* Next define the button for the menu
    *           mainMenu, Menu Name,  subMenu for the submenus.
    self addOpt("main", "Example Menu", &subMenu);
    * Lastly, start adding options to the menu. 
    * This function needs to be defined in functions.gsc or it won't work.
    self addOpt("example_menu", "Print Zombie counter", &menu_functions::zombieCounter);


	self addOpt("weapon_mods", "Give Raygun", &menu_functions::func_giveRayGun, "weapon_mods");
    */

	self addMenu("main", self.menu["name"], undefined);
	self addOpt("main", "Main Menu", &subMenu, "main_mods");
	// self addOpt("main", "Weapons", &subMenu, "main_mods");  
	// self addOpt("main", "Game Settings", &subMenu, "main_mods");  
	// self addOpt("main", "Models", &subMenu, "main_mods");  
	// self addOpt("main", "Bullets", &subMenu, "main_mods"); 
	// self addOpt("main", "Messages", &subMenu, "main_mods");  
	// self addOpt("main", "Perks", &subMenu, "main_mods");  
	// self addOpt("main", "Admin Menu", &subMenu, "main_mods");  
	// self addOpt("main", "Host Menu", &subMenu, "main_mods");  
	// self addOpt("main", "Aimbot", &subMenu, "main_mods");  
	// self addOpt("main", "Clients", &subMenu, "main_mods");  
	// self addOpt("main", "All Clients", &subMenu, "main_mods");  

	// New
	// Test menu
	self addMenu("test_mods", "Test Mods", "main");
	self addOpt("main", "Test Mods", &subMenu, "test_mods");
	// self addOpt("main", "Test", &subMenu, "test_mods");
	// self addOpt("test_mods", "Give jug perk", &func_doGivePerk())
	// This works
	self addOpt("test_mods", "Give all perks", &menu_functions::func_giveAllPerks);
	self addOpt("test_mods", "Add random perk", &menu_functions::func_addRandomPerk);

	self addOpt("test_mods", "Remove random perk", &menu_functions::func_removeRandomPerk);
    self addOpt("test_mods", "Remove all perks", &menu_functions::func_removeAllPerks);

    // This works
    self addOpt("test_mods", "Turn on power", &menu_functions::func_turnOnPower);
    // Doesn't work
    // self addOpt("test_mods", "Turn off power", &menu_functions::func_turnOffPower);

    self addOpt("test_mods", "Open all doors", &menu_functions::func_openAllDoors);

    self addOpt("test_mods", "Toggle no target", &menu_functions::func_toggleNoTarget);

    self addOpt("test_mods", "Print zombie count", &menu_functions::func_getAmountOfZombies);

    self addOpt("test_mods", "Turn on zombie counter", &menu_functions::func_turnOnZombieCounter);
    self addOpt("test_mods", "Turn off zombie counter", &menu_functions::func_turnOffZombieCounter);

    
    // This doens't work
    // self addOpt("test_mods", "Toggle no clip", &menu_functions::func_toggleNoClip, "test_mods");

    
    // self addOpt("test_mods", "Play SFX Test 2", &menu_functions::func_sfxTest1);

	// self addOpt("test_mods", "Give weapon", &menu_functions::func_giveWeapon);

	// Weapons menu
	self addMenu("weapon_mods", "Weapon Mods", "main");
	self addOpt("main", "Weapon mods", &subMenu, "weapon_mods");

	// TODO Figure out how to use the give weapon function
	self addOpt("weapon_mods", "Give Raygun", &menu_functions::func_giveRayGun);

    // Points menu
    self addMenu("points_menu", "Points Menu", "main");
	self addOpt("main", "Points menu", &subMenu, "points_menu");

    self addOpt("points_menu", "Give 1000 points", &menu_functions::func_givePoints, 1000);
    self addOpt("points_menu", "Give 10000 points", &menu_functions::func_givePoints, 10000);
    self addOpt("points_menu", "Give 100,000 points", &menu_functions::func_givePoints, 100000);

    self addOpt("points_menu", "Take 1000 points", &menu_functions::func_takePoints, 1000);
    self addOpt("points_menu", "Take 10000 points", &menu_functions::func_takePoints, 10000);
    self addOpt("points_menu", "Take 100,000 points", &menu_functions::func_takePoints, 100000);

    // Sound effects menu
    self addMenu("soundfx_menu", "Sound Effects", "main");
	self addOpt("main", "Sound Effects", &subMenu, "soundfx_menu");
    self addOpt("soundfx_menu", "Play Double points sound", &menu_functions::func_sfxDoublePoints);
    self addOpt("soundfx_menu", "Play Carpenter sound", &menu_functions::func_sfxCarpenter);
    self addOpt("soundfx_menu", "Play Insta Kill sound", &menu_functions::func_sfxInstaKill);
    self addOpt("soundfx_menu", "Play Nuke sound", &menu_functions::func_sfxNuke);
    self addOpt("soundfx_menu", "Play Max Ammo sound", &menu_functions::func_sfxMaxAmmo);
    self addOpt("soundfx_menu", "Play Fire Sale sound", &menu_functions::func_sfxFireSale);
    self addOpt("soundfx_menu", "Play Minigun sound", &menu_functions::func_sfxMinigun);
    self addOpt("soundfx_menu", "Play Box move sound", &menu_functions::func_sfxBoxMove);
    self addOpt("soundfx_menu", "Play Dog start sound", &menu_functions::func_sfxDogStart);

    // Power ups menu
    self addMenu("powerups_menu", "Powerups", "main");
	self addOpt("main", "Powerups", &subMenu, "powerups_menu");
    // self addOpt("powerups_menu", "Nuke", &menu_functions::func_sfxDoublePoints);

    // self addOpt("powerups_menu", "Fire sale", &menu_functions::func_giveFireSale, "test_mods");
    self addOpt("powerups_menu", "Double points", &menu_functions::func_givePowerups, "double_points");
    // self addOpt("powerups_menu", "Bonus points (Self)", &menu_functions::func_givePowerups, "bonus_points_self");
    // self addOpt("powerups_menu", "Bonus points (Team)", &menu_functions::func_givePowerups, "bonus_points_team");
    self addOpt("powerups_menu", "Free perk", &menu_functions::func_givePowerups, "free_perk");
    self addOpt("powerups_menu", "Max Ammo", &menu_functions::func_givePowerups, "max_ammo");
    self addOpt("powerups_menu", "Minigun", &menu_functions::func_givePowerups, "minigun");
    self addOpt("powerups_menu", "Insta Kill", &menu_functions::func_givePowerups, "insta_kill");
    self addOpt("powerups_menu", "Carpenter", &menu_functions::func_givePowerups, "carpenter");
    self addOpt("powerups_menu", "Nuke", &menu_functions::func_givePowerups, "nuke");
    self addOpt("powerups_menu", "Fire sale", &menu_functions::func_givePowerups, "firesale");

    // New
    // Round menu
    self addMenu("round_menu", "Rounds", "main");
    self addOpt("main", "Rounds", &subMenu, "round_menu");

    self addOpt("round_menu", "Set round to 5", &menu_functions::func_roundsystem, 5);


    // Perk menu

    // 

	
	// func_giveAllPerks

	// Test
	// TODO Figure out how to use this from cabcon mod
	// This might be useful for options that need parameters
	// self addMenuPar_withDef("main", "Give weapon", &giveWeapon, "weapon_name" )

	// Main menu
	
	self addMenu("main_mods", "Main Mods", "main");
	self addOpt("main_mods", "God Mode", &menu_functions::func_godmode);
	self addOpt("main_mods", "Unlimited Ammo", &menu_functions::func_unlimitedAmmo);
	self addOpt("main_mods", "Ufo Mode", &menu_functions::func_ufomode);
	self addOpt("main_mods", "Field of View", &menu_functions::test);
	self addOpt("main_mods", "Print something!", &menu_functions::test);
}

//----------------------//
// Menu functions
//----------------------//

function initMenu()
{
	self.openBox = self createRectangle("CENTER", "CENTER", 480, 0, 200, 0, (0, 0, 0), "white", 1, 0);
	
	self.currentMenu = "main";
    self.menuCurs = 0;
    for(;;)
    {
        if(self adsButtonPressed() && self MeleeButtonPressed())
        {
            if(!isDefined(self.inMenu))
            {
                self.inMenu = true;
                
				self.openText = self createText("default", 2, "TOP", "TOP", self.openBox.x - 40, 20, 2, 1, (0, 0, 0), self.menu["name"]); 
				self.openBox.alpha = .7;
    
                menuOpts = self.menuAction[self.currentMenu].opt.size;
                self.openBox scaleOverTime(.4, 200, ((455)+45));
                wait .4;
                self.openText setText(self.menuAction[self.currentMenu].title);
                string = "";
                for(m = 0; m < menuOpts; m++)
                    string+= self.menuAction[self.currentMenu].opt[m]+"\n";

				self.menuText = self createText("default", 1.5, "TOP", "TOP", self.openBox.x - 80, 100, 3, 1, undefined, string);
				self.scrollBar = self createRectangle("CENTER", "CENTER", self.openBox.x, ((self.menuCurs*17.98)+((self.menuText.y+2.5)-(17.98/15))), 200, 15, (0, 1, 0), "white", 2, .7);

            }
        }
        if(isDefined(self.inMenu))
        {

            // Scroll up
            if(self attackButtonPressed())
            {
                self.menuCurs++;
                if(self.menuCurs > self.menuAction[self.currentMenu].opt.size-1)
                    self.menuCurs = 0;
                self.scrollBar moveOverTime(.15);
                self.scrollBar.y = ((self.menuCurs*17.98)+((self.menuText.y+2.5)-(17.98/17)));
                wait .15;
            }

            // Scroll down
            if(self adsButtonPressed())
            {
                self.menuCurs--;
                if(self.menuCurs < 0)
                    self.menuCurs = self.menuAction[self.currentMenu].opt.size-1;
                self.scrollBar moveOverTime(.15);
                self.scrollBar.y = ((self.menuCurs*17.98)+((self.menuText.y+2.5)-(17.98/17)));
                wait .15;
            }

            // Open menu item
            if(self useButtonPressed())
            {
                self thread [[self.menuAction[self.currentMenu].func[self.menuCurs]]](self.menuAction[self.currentMenu].inp[self.menuCurs]);
                wait .2;
            }

            // Close menu
            if(self meleeButtonPressed())
            {
                if(!isDefined(self.menuAction[self.currentMenu].parent))
                {
					self thread func_menuexiut();
				}
                else
                    self subMenu(self.menuAction[self.currentMenu].parent);
            }
        }
        wait .05;
    }
}

function func_menuexiut()
{
	self.inMenu = undefined;
    self.openText destroy();                    
	self.openBox scaleOverTime(.4, 200, 30);
	self.menuText destroy();
	self.scrollBar destroy();
	self.openBox.alpha = 0;
	wait .4;
	self freezecontrols(false);
}

function subMenu(menu)
{
    self.menuCurs = 0;
    self.currentMenu = menu;
    self.scrollBar moveOverTime(.2);
    self.scrollBar.y = ((self.menuCurs*17.98)+((self.menuText.y+2.5)-(17.98/15)));
    self.menuText destroy();
    self.openText setText(self.menuAction[self.currentMenu].title);

    menuOpts = self.menuAction[self.currentMenu].opt.size;
	
    wait .2;
    string = "";
    for(m = 0; m < menuOpts; m++)
        string+= self.menuAction[self.currentMenu].opt[m]+"\n";
    self.menuText = self createText("default", 1.5, "TOP", "TOP", self.openBox.x - 80, 100, 3, 1, undefined, string);
	wait .2;
}
 
function addMenu(menu, title, parent)
{
    if(!isDefined(self.menuAction))
        self.menuAction = [];
    self.menuAction[menu] = spawnStruct();
    self.menuAction[menu].title = title;
    self.menuAction[menu].parent = parent;
    self.menuAction[menu].opt = [];
    self.menuAction[menu].func = [];
    self.menuAction[menu].inp = [];
}

// Copied from main.gsc in encore_v20
// function addMenuPar_withDef(menu, name, func, input1, input2, input3, input4)
// {
//     count = self.menu["items"][menu].name.size;
//     self.menu["items"][menu].name[count] = name;
//     self.menu["items"][menu].func[count] = func;
//     if( isDefined(input1) )
//         self.menu["items"][menu].input1[count] = input1;
//     if( isDefined(input2) )
//         self.menu["items"][menu].input2[count] = input2;
//     if( isDefined(input3) )
//         self.menu["items"][menu].input3[count] = input3;
//     if( isDefined(input4) )
//         self.menu["items"][menu].input4[count] = input4;
// }

// What's the point in this?
// function headline()
// {

// }

// function addHeadline(menu,name)
// {
//     count = self.menu["items"][menu].name.size;
//     self.menu["items"][menu].name[count] = "--- "+name+" ---";
//     self.menu["items"][menu].func[count] = &headline;
// }

//----------------------//
//
//----------------------//
 
function addOpt(menu, opt, func, inp)
{
    m = self.menuAction[menu].opt.size;
    self.menuAction[menu].opt[m] = opt;
    self.menuAction[menu].func[m] = func;
    self.menuAction[menu].inp[m] = inp;
}
  
function createText(font, fontScale, align, relative, x, y, sort, alpha, glow, text)
{
    textElem = newClientHudElem(self);
    textElem.sort = sort;
    textElem.alpha = alpha;
	textElem.x = x;
    textElem.y = y;
	textElem.glowColor = glow;
    textElem.glowAlpha = 1;
    textElem.fontScale = fontScale;
    textElem setText(text);
    return textElem;
}
 
function createRectangle(align, relative, x, y, width, height, color, shader, sort, alpha)
{
    boxElem = newClientHudElem(self);
    boxElem.elemType = "bar";
    if(!level.splitScreen)
    {
        boxElem.x = -2;
        boxElem.y = -2;
    }
    boxElem.width = width;
    boxElem.height = height;
    boxElem.align = align;
    boxElem.relative = relative;
    boxElem.xOffset = 0;
    boxElem.yOffset = 0;
    boxElem.children = [];
    boxElem.sort = sort;
    boxElem.color = color;
    boxElem.alpha = alpha;
    boxElem setShader(shader, width, height);
    boxElem.hidden = false;
    boxElem.x = x;
    boxElem.y = y;
    boxElem.alignX = align;
    boxElem.alignY = relative;
    return boxElem;
}