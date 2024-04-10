# Memory Matching Game App
This Flutter application implements a memory matching game, where players have to find matching pairs of images by flipping tiles. Below is an overview of the app's features and the logic behind its implementation:

## Features
- Tile Grid: The game displays a grid of tiles, each containing an image face down.
- Image Pairs: The images are arranged in pairs within the grid. The player's objective is to match all pairs.
- Gameplay Logic: Players can tap on a tile to flip it over and reveal the image beneath. If two flipped tiles match, they remain face up; otherwise, they flip back over.
- Scoring: Points are awarded for every successful match. The game ends when all pairs are matched or when the player chooses to replay.

## Implementation Logic
- Initialization: When the game starts or is restarted, the reStart() function is called. This function shuffles the pairs of images and initializes the game grid with face down tiles.
- Tile Flipping: The Tile widget represents each tile in the grid. It responds to user taps by flipping over the tile and revealing the image beneath. If two consecutive taps reveal matching images, the tiles remain face up; otherwise, they flip back over after a brief delay.
- State Management: The game state, including the status of each tile (selected or not), is managed using stateful widgets. State changes trigger UI updates to reflect the current game state.
- Game Over: When all pairs are matched, the game ends, and a "Replay" button is displayed. Tapping the button restarts the game.