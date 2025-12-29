# Black Ops 3 Zombies Test Map

I have created a very basic Black Ops 3 Zombies map with the power, one box location,
 most of the perk machines, and some zombie spawners.

## Info
I have added a damage trigger beside of the trigger that can give the player a ray gun.

If this perk bottle is shot at, it'll give the player a random perk

Dev mode functions can now all be toggled in `zm_test_map.gsh`.

The `map_source` folder contains the required `zm_test_map.map` file for this map.

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

The developer textures from here (I will possibly use this for blocking out textures and temporary stuff on my map.)
* https://www.devraw.net/approved-assets/verk0/developer-textures

# License
My additions and code files in the `scripts/zm` folder are licensed under the GPLv3 license.

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