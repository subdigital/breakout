# Breakout

A breakout clone, written in Ruby using Gosu.

## Running the game

It requires [gosu](https://www.libgosu.org) and [Hasu](https://github.com/michaelfairley/hasu) to run. To install them:

```
gem install gosu
gem install hasu
```

Once the gems are installed, just run it with ruby:

```
ruby game.rb
```

## Live Reload

Hasu supports live reload, so you can keep the game running and just make edits, all while not changing the entirety of game state, which can be useful for tweaking.


## Gameplay

Use the mouse to move the paddle. Click to start. Break all bricks to move to the next level. Collect power-ups to enhance your brick destroying ability! Lose all balls and the game is over.

- Press **M** to mute the music
- Press **P** to pause

There are some other debugging keys left in there, play around with them for some fun :)

## Why?

I've been interested in game development ever since I started programming. I've never shipped a real game. So I listed a bunch of simple games I could create quicly and just got started.
This is the third one.

I wrote [pong](https://github.com/subdigital/pong) and [tic-tac-toe](https://github.com/subdigital/tic-tac-toe) already, this seemed like a good next step.

## The Code Sucks! What gives?

The point is to finish something, ship it and move on. Pull requests accepted! Maybe I'll learn a few things ;)

## What was interesting about this one?

Tons! This one grew in complexity faster than the others. Notably new in this one:

- introduced a state system, separating game logic into classes based on the state. There's a bit too much mixed up with `game.rb` and `playing.rb`, but it seemed like an improvement over massive `case` statements
- movement, collision, gravity
- animations were added using multiple images for a single object. For repeat timing I sort of cheated and inserted dummy frames. Works, but kind of gross
- background music, mute & pausing
- debris! when you hit a brick, it breaks apart & falls down, rotating and fading out as it goes
- level loader based on text files. There are 4 levels my kids helped me create. Feel free to add more! Should be easy to follow, look at `level.rb` for details.
- lots more

## Acknowledgements

- Bricks, paddle & ball graphics from [Kenney Vleugels](www.kenney.nl)
- Powerup icon from 
- Sound effects generated by [Bfxr](http://www.bfxr.net)
- In-game music by [DST](http://dreade.com/nosoap/)

## What's Next?

I have some more plans for this one, but my next game will probably be Nibbles.

## LICENSE

Code released under the MIT License.