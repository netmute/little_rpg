# Little RPG

This is my first try at building a little game. It consists of a few classes to create dungeons, creatures and initiate fights between them. The player can use magic and get level ups.

## Brief overview

### main.rb

This is the starting point. Here classes get loaded and the main RPG object is initialized.

### Dungeons

Used to layout the 'story' of the game. Can be used to describe places and stuff that happens. This is where fights get started.

### Creatures

Most attributes and abilities that the player, npcs and enemies can have are defined in **creature.rb**. The **player** and **enemy** classes inherit from this one.

### Fights

This is currently all you can do in the game :) The simple fight engine is defined in **fight.rb**. It loops over a choice menu until either the player or the enemy is dead.
