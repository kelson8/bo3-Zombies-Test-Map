# Black Ops 3 Zombies Test Map

I have created a very basic Black Ops 3 Zombies map with the power, one box location,
 most of the perk machines, and some zombie spawners.

## Requirements
This map now requires the 90GB extra assets in the Black Ops 3 mod tools.

Also, you now need this Kino Der Toten vox pack installed (This isn't in use just yet, I cannot figure it out):
* https://www.devraw.net/approved-assets/zecstasy/kino-der-toten-character-vox

I added the BO2 perk jingles from here:
* https://drive.google.com/file/d/18QvCrsv7Bpnm-kum9Y7tHCChsBFdH53t/view

The sound fixes from here, this fixes the perk jingles, PPSH weapon firing sounds and other sounds
* https://forum.modme.co/wiki/threads/3283.html

## Changing the skybox
To change the skybox, find the `sun_volume` in the map.

By default, it is set to `default_day` but can be changed to `zm_factory` to make it look like the lighting on the Giant map.

You can also download custom skybox assets from Devraw
* https://www.devraw.net/assets

## TODO
Move the sounds and extra assets into a separate file in the releases section, I will just add a download link to these instead of including them in my repo.

## Mod Menu
I have a basic mod menu that can be toggled in the `scripts/zm_test_map.gsc` file.
If `DEVMAP` is set to 1 in that file, it enables the mod menu and developer functions to this map.

The menu gets loaded in with this function under `scripts/zm_test_map.gsc`:
* onPlayerSpawned()

The menu files are located here, along with a test for a zombie counter on screen:
`scripts/zm/kcnet_test`
 
# Building
To build this map, you will need to own a copy of Black Ops 3 on Steam to be able to use the Mod Tools.

You can download the Black Ops 3 Mod Tools on Steam, add this map to your Black Ops 3 folder here:
* C:\Program Files (x86)\Steam\steamapps\common\Call of Duty Black Ops III\usermaps

There is also a `zm_test_map.map` file that goes here but I'll have to figure out where that gets updated later
* C:\Program Files (x86)\Steam\steamapps\common\Call of Duty Black Ops III\map_source\zm

# License
My additions and code files in the `scripts/zm` folder are licensed under the GPLv3 license.

# Credits
I did not create a lot of assets that are in use for this map, if you like what I am creating with these check out the below for credits to the users that created these maps/perks/assets.

BO2 Perk Jingles:
* https://drive.google.com/file/d/18QvCrsv7Bpnm-kum9Y7tHCChsBFdH53t/view

Kino Der Toten vox pack (This isn't in use just yet, I cannot figure it out):
* https://www.devraw.net/approved-assets/zecstasy/kino-der-toten-character-vox