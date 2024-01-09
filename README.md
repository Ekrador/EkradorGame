# Ekrador's Game
#### Video Demo:  https://youtu.be/VFWq6UDF190
#### Description:
This is an isometric role-playing game built in the Love 2D engine using Lua.   
Here the player can improve the characteristics and skills of his character,  
obtain items and gain experience by defeating monsters.  
On the map we have a merchant who trade undefined items and potions, and the player can also sell what he does not need.  
The main goal is to reach the final boss and defeat him.
#### Structure of project:
- fonts - fonts for game
- graphics - sprites for game (all drawn by me using aseprite)
- lib - an third party libraries for project:
  - knife - a collection of useful micro-modules for Lua
  - class - lightweight object orientation
  - push - simple resolution-handling library that allows you to focus on making your game with a fixed resolution
- sounds - sounds for the game obtained from a free source
- src - game source code:
  - entity - folder with entities classes:  
    entity_defs - defining parameters for each possible entity  
    entity_spells - defining of parameters of each entities spells  
    Entity - base class for each entity  
    Player - class for player based on "Entity"  
    Spells - base class for each spell  
    Vendor - class for merchant  
  - states - folder with possible states of entities/game:
    entity - states of entities:
    EntityAbilityState - state when an entity casts a spell
    EntityAttackState - state when an entity attacks in melee
    EntityBaseState - base class for the state of entities. includes a function that defines the behavior of an entity  
    EntityDeathState - state when an entity reach 0 hp (used for playing animation)
    EntityIdleState - state when an entity does not chase the player, but simply walks around
    EntityRangedAttackState - state when an entity attacks from a distance (bows, fireballs)
    EntityStunnedState - state when an entity stunned by the player
    EntityWalkState - state when an entity get command to move
    PlayerAbilityState - state when the player casts a spell
    PlayerAttackState - state when the player attacks
    PlayerIdleState - state when the player does not perform any actions
    PlayerWalkState - state when the player is moving
    game - states of game:
    
    
