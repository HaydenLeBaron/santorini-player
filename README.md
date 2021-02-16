# README

## Brainstorm

https://www.cs.utah.edu/~mflatt/cs6963/santorini.html





- game played on 5x5 grid of *spaces*
  - a *space* is an ordered pair (row, col)
- A *tower* on each space has a *level* from 0 to 4, marking the number of *elements* the tower has.
  - level 4 is *capped*
  - player's goal is to move a token onto a tower with 3 elements (level 3). 
- each player has 2 *tokens*
  - A token cannot be on a level 4 space (full tower)
  - no two tokens are on the same space

- Note also that the board for a winning move should not include an unnecessary build step. A player program will not be sent a board if there are no valid moves or if the other player has already won 


- TODO: look up racket JSON serializer/de-serializer



## Glossary
- space
- token
- tower
- level
- elements
- capped

## Implementation strategy



