# Black Ops 3 Zombies Test Map

I have created a very basic Black Ops 3 Zombies map with the power, one box location,
 most of the perk machines, and some zombie spawners.

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