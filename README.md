# Ekrador's Game
#### Video Demo:  https://youtu.be/VFWq6UDF190
#### Description:
This is an isometric role-playing game built in the Love 2D engine using Lua.   
Here the player can improve the characteristics and skills of his character,  
obtain items and gain experience by defeating monsters.  
On the map we have a merchant who trade undefined items and potions, and the player can also sell what he does not need.  
The main goal is to reach the final boss and defeat him.
Controls:  
- Q, W, E, R for skills and 1, 2, 3, 4 for potions on belt slots  
- C to open inventory, V to open talent tree  
- RMB - move, Shift - attack  
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
    DialogueState - state representing dialogue with the player (now using only for introduce to controls)  
    FadeInState and FadeOutState - states for transition between scenes  
    GameOverState - state when the player reach 0 hp  
    PlayState - main state when level is loaded (all major changes in the game occur here)  
    StartState - the first state with the starting picture, which then pushes us to the welcome dialogue  
    VictoryState - finishing state when defeat the Lich  
    BaseState - just base class for states  
    StateStack - base class for creating a state stack  
  - world - folder with classes which describes other material things:  
    items_defs - defining parameters for each possible item in player's equipment  
    Items - class which describes how item should be created and rendered  
    Level - class for tracking changes in the game level and drawing everything that happens  
    levels_defs - defining the level parameters includes the code for the position of the tiles on the map  
    Loot - class containing the logic for generating loot boxes contents  
    Looting - class containing the logic for looting for player and render it contents  
    potions_defs - defining parameters for each possible potion  
    Potions - class containing the logic for using potions  
    Projectile - class containing the logic for calculating the projectile trajectory and render it  
    tile_ids - defining parameters for each tile  
    Tile - class for creating tiles  
    TileMap - class for placing tiles on the map grid  
  - Animation - class describing the order in which animations are drawn  
  - const - set of constants (different sizes, types of potions, directions of tiles in isometry, sounds, generation of quality of items)  
  - Dependencies - standard file for dependencies for game  
  - StateMachine - class for switching states  
  - Util - generate quads of sprites from spritesheet  
- ui - some classes for ui:  
  - Interface - render main panel, health and energy bars  
  - Inventory - push state which render player's inventory and where player can interact with his items and stats  
  - Panel - UI element for creating panels (used for dialogues)  
  - ProgressBar - UI element for creating panels like HP bar, XP panel  
  - TalentTree - push state where player can spent talent points for learning spells  
  - Textbox - UI element for display text  
  - Trade - push state where player can trade with merchant  
- main - main file for Love 2d    
     
    
