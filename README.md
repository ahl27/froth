# froth: FORTH for R

froth is a FORTH implementation for R (or at least, it will be).

I've just started development, but this README will be updated as I get further in this project.

## Current Status
- stack correctly initializes
- `push` and `pop` methods work correctly

## TODOs
Planning to update bespoke stack implementation to instead use a Pairlist.
Pairlists will simplify code greatly and can theoretically be implemented
using only a single PROTECT stack call. This should also solve issues with
background garbage collection causing problems when frequently malloc'ing
and freeing memory. Pairlists are intended for usage in function calls, 
but the structure will work nicely here.
