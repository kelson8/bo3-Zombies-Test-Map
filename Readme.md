# Black Ops 3 Zombies Test Map

I have created a very basic Black Ops 3 Zombies map with the power, one box location,
 most of the perk machines, and some zombie spawners.

## Info
I have added a damage trigger beside of the trigger that can give the player a ray gun.

If this perk bottle is shot at, it'll give the player a random perk

Dev mode functions can now all be toggled in `zm_test_map.gsh`.

The `map_source` folder contains the required `zm_test_map.map` file for this map.

I now have a basic elevator script along with a prefab for it, 
so far it mostly works but the hint strings on the call buttons dissappear once they are used.
It uses the developer block textures for now until I find textures that I like for it.

The elevator prefab is located here: `prefabs/elevator_test1.map`, and the elevator script is located here: `scripts/zm/zm_elevator_functions.gsc`.

I have a textured version of the elevator prefab, the one with the dev textures has been renamed to `elevator_test1_old.map` in the prefabs folder.

Now, the map has a Cold War style wunderfizz machine in the first room, which requires power before it'll work.

## Changing the skybox
To change the skybox, find the `sun_volume` in the map.

By default, it is set to `default_day` but can be changed to `zm_factory` to make it look like the lighting on the Giant map.

You can also download custom skybox assets from Devraw
* https://www.devraw.net/assets

## Mod Menu
I have a basic mod menu that can be toggled in the `scripts/zm_test_map.gsh` file.
If `DEVMAP` is set to 1 in that file, it enables the mod menu and developer functions to this map.

The menu gets loaded in with this function under `scripts/zm_test_map.gsc`:
* onPlayerSpawned()

The menu files are located here, along with a test for a zombie counter on screen:
`scripts/zm/kcnet_test`

## Prefabs
I now have a stairs prefab for the stairs that I will be using in the map, it has a basic set of stairs with collision.

Prefab locations in repo:
* stairs1.map - `prefabs/stairs1.map`


I plan on adding more prefabs to this map in the future when I create more of them.
 
# Building
To build this map, you will need to own a copy of Black Ops 3 on Steam to be able to use the Mod Tools.

You can download the Black Ops 3 Mod Tools on Steam, add this map to your Black Ops 3 folder here:
* C:\Program Files (x86)\Steam\steamapps\common\Call of Duty Black Ops III\usermaps

There is also a `zm_test_map.map` file that goes here but I'll have to figure out where that gets updated later
* C:\Program Files (x86)\Steam\steamapps\common\Call of Duty Black Ops III\map_source\zm

# Requirements
This map now requires the 90GB extra assets in the Black Ops 3 mod tools.

Also, you now need this Kino Der Toten vox pack installed:
* https://www.devraw.net/approved-assets/zecstasy/kino-der-toten-character-vox

I added the BO2 perk jingles from here:
* https://drive.google.com/file/d/18QvCrsv7Bpnm-kum9Y7tHCChsBFdH53t/view

The sound fixes from MikeyRay on the modme forums, this fixes the perk jingles, PPSH weapon firing sounds and other sounds
* https://forum.modme.co/wiki/threads/3283.html

The developer textures from here (I will be using this for blocking out textures and temporary stuff on my map.)
* https://www.devraw.net/approved-assets/verk0/developer-textures

Cold war Wunderfizz
* https://mega.nz/file/YJ4yiBjY#lronc5rcYgxE3JnCNuOcyJVBu0q_eRP8oyl3mNCnJDs

L3akMod for Lua:
* https://wiki.modme.co/wiki/black_ops_3/lua_(lui)/Installation.html

**Not in use below**

The Five Style Teleporters For BO3 (This doesn't seem to work for multiple zones, so I disabled it. It'll kill the player if they go to an inactive zone.):
* https://www.ugx-mods.com/forum/scripting/91/drag-and-drop-five-style-teleporters-for-bo3/23420/

# License
My additions and code files in the `scripts/zm` folder are licensed under the GPLv3 license.

Files not under GPLv3 license due to me not creating them:
* `scripts/zm/_t9_wonderfizz.gsc`
* `scripts/zm/zombie_counter.gsc`

* Currently, all items in the `ui` folder, I may make some additions once I learn LUA scripting with LUI.

# Credits
I did not create a lot of assets that are in use for this map, if you like what I am creating with these check out the below for credits to the users that created these maps/perks/assets.

BO2 Perk Jingles:
* https://drive.google.com/file/d/18QvCrsv7Bpnm-kum9Y7tHCChsBFdH53t/view

Kino Der Toten vox pack:
* https://www.devraw.net/approved-assets/zecstasy/kino-der-toten-character-vox

The sound fixes from MikeyRay on the modme forums
* https://forum.modme.co/wiki/threads/3283.html

The developer textures from here
* https://www.devraw.net/approved-assets/verk0/developer-textures

Five Style Teleporters For BO3 by djluvorng on ugx-mods.com:
* https://www.ugx-mods.com/forum/scripting/91/drag-and-drop-five-style-teleporters-for-bo3/23420/

Cold war Wunderfizz (I don't have the original source to this, it came from the google spreadsheet below):
* https://docs.google.com/spreadsheets/d/10aQLnuZUgvduFS4zgPNOTBlFbD-pBfpy--Gm9ilIqRg/edit?gid=1848896341#gid=1848896341
* https://mega.nz/file/YJ4yiBjY#lronc5rcYgxE3JnCNuOcyJVBu0q_eRP8oyl3mNCnJDs
