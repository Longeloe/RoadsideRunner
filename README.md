# Roadside Runner
## Video Demo:  https://youtu.be/BYkeJASpz04
## Description
Roadside Runner is an infite-runner type of game based on a child's day-dream of having a character running alongside the car while looking outside the window from the backseat. This game was created as my Final Project for CS50's Introduction to Computer Science course.

The game uses the Love2D framework, which uses the Lua programming language. I mainly used things I learned from the first couple of classes of CS50's Intro to GameDev, specifically the FlappyBird and Breakout clones. I used the files from those lessons as a starting point but all the code was written and modified by myself.
Most of the sounds, including the Menu and Gameplay music, were created by me using Bfxr (for effects) and Beepbox (for music).

All of the game art was downloaded from [OpenGameArt](https://opengameart.org/) and here are all the artist's names:
- Background/Hydrant - CraftPix.net 2D Game Assets - https://opengameart.org/users/craftpixnet-2d-game-assets
- Wasp - Tiamalt - https://opengameart.org/users/tiamalt
- Trashcan - dant-e - https://opengameart.org/users/dant-e
- Runner/Icon - bevouliin - https://opengameart.org/users/bevouliincom

The font used was downloaded from https://www.1001freefonts.com/raider-crusader.font and was crated by Iconian Fonts.

***Hope you enjoy the game. I had a great time creating it!***
## File Structure
The files are divided into multiple smaller ones for better readability. Inside the first folder you'll find **main.lua**. The other files are all located inside the **src** folder.

The fonts, graphics and sounds folders contain what each of their names suggests and the lib folder contains the external libraries used.

### main.lua
This is the file that takes care of the core game loop. Inside it, the game's StateMachine is initialized as well as the logic that takes care of checking for the player's input.
Here you'll also find the a function that creates a Highscore's file or simply load it to the game if already present.

For this kind of game, the background and obstacles are the ones actually moving from left to right and the Runner (player) only moves vertically. That gives the impression of the movement to the player.

### Constants.lua
Some game constants that are used throughout the game.

### Dependencies.lua
Here are most of the *require* statements so that they don't overtake the main.lua file. This is also where the fonts and sounds are initialized.

### Obstacle.lua
This is where the Obstacle Class is defined. When created, an Obstacle receives an index, which is used to define all of that Obstacle-instance's attributes.
Each Obstacle has different values for each attribute (id, y, width, height, frameFreq) which are all imported from a Table defined inside the *obstacleStats.lua* file.

On each update loop, the obstacles x value is updated based on the objects speed (which is equal to the ground speed value). It's current animation frame is also changed based on its own frameFreq value.
The image to be rendered is retrieved from the obstacleIMG table (also defined in the obstacleStats.lua file) using the obstacles id (name) and the current frameCounter.

### obstacleStats.lua
Two different tables are created inside this file.

The first is the obstacleStats table. It has numbers (1 to 3 for now) as keys and another table as values, one for each different obstacle. This value table contains all the different stats for each obstacle: id, y, width, height and frameFreq.

The second table is the obstacleIMG table. It has each obstacle's id as keys and a table containing all of the animation frames for each obstacle as values.

### playerAnimations.lua
Defines a table similar to the obstacleIMG table. It has the type of animation as keys ('run' or 'roll' in this case) and a table containing all of the pertinent images as values.

### Runner.lua
Here is where the Runner Class is defined. At the top, the 2 constants (Gravity and jumpPower) used for our player's physics are defined.
When initialized, the values for x, y, current animation (anim), width and height are created as well as the player's vertical speed (dy).

The __collides__ function is the one responsible for detecting collisions between the player and all obstacles. It works by using the AABB collision method, which first checks if the player/obstacle x-axis overlap with eachother and then checks for the y-axis. If both overlap, that means they collided.
When the player is rolling (anim == 'roll'), I game the collision system bigger offsets so that it would be possible to roll under the flying objects.

In the __update__ function we check for player-input, reposition the player vertically when jumping/landing and also change frames for the animations.
The player is rendered using current animation frame. Added some offset to the roll animation frames so that it looked better.

### StateMachine.lua
Definition of the game's StateMachine, including the __change__ function, that takes care of transitioning in between states and checking if the next state exists.

## Game States
Each Game State represents a different moment of the game (MainMenu, Actual Gameplay, Highscore, for example). This way, it's easier to define transitions and the actual flow of the user experience.
### BaseState
Basic game state containing all of the different functions needed. All other states inherit from this one.
### StartState
Represents the game starting screen (Main Menu). When entering it, the Menu music should start playing.

Here, the player can choose one of 3 options: **Start** the game, look at **Highscores** and look at game **Info**. The current selected option is highlighted using a different colour and can be changed using the arrow keys. When any option is selected (using Enter), the game will transition to the selected GameState.
### InfoState
Here the player can find info about Controls and Objective of the game.
Returns to the StartState by pressing ESC.
### HighScoreState
Here the player can find the top10 best scores of the game.
Returns to the StartState by pressing ESC.
### CountdownState
Transitional state in which a countdown from 3 to 0 appears in the middle of the screen. When it ends, the game automatically transitions to the PlayState.
### PlayState
Here is where the actual gameplay takes place.

An instance of the runner is created when entering this state as are an empty table for the obstacles and the timer/score variables.

The timer variable is used to spawn obstacles when a defined number is reached (in this case, 6). This new Obstacle-instance type is chosen randomly using the random function with a value ranging from 1 to the size of the obstacleStats table and is then added to the obstacles table. The frequency with which they are spawned is random and gets higher as the player score increases (more frequent = higher difficulty).
The score variable increases every few moments by a small amount and by a bigger amount when the player successfully dodges an obstacle.

Inside two different loops, each obstacle is first removed, if already past the player's x-position and then checked for collision (described inside the Runner.lua file). If the collision happens, the game transitions to the GameOverState.
### GameOverState
Entered after the Runner collides with any obstacle. Shows the player's final score in the center of the screen.

If the score is higher then any score from the top10 (inside the highscore's file), the game transitions to the EnterHighScoreState. If not, the game goes back to the Main Menu (StartState).
### EnterHighScoreState
Here is where the player can enter his 3-char initials for his score. The current character is highlighted using a different colour and can be changed using the arrow-keys.

When confirmed (using Enter), the chosen initials and score are saved to the highscores file and the game transitions to the HighScoreState to show the player where he ranks.
