# froth: FORTH for R

<img src="./man/figures/froth.png" width="400" class="center"/>

froth is a FORTH implementation for R.

This implementation comes with a number of differences from other FORTHs:
- uses R operators for arithmetic, so `3 2 /` returns `1.5`
- arbitrary R objects can be pushed onto the stack
- built-in R `print` methods; use `.R` to format according to the print method for the top of the parameter stack
- obfuscated memory (no direct or emulated hardware-level memory access)
- no distinction between compiled and interpreted words (loops are possible outside of definitions!)
- Use of R lists for internal arrays; arrays of bytes are not supported

This will (likely) not be a 1:1 copy of Gforth, I think I'd rather have a forth implementation that is robust
and works in R than one that exacly imitates existing Gforth. But...tbd.

## TODOs
- `FORGET` word (definitions currently overwrite previous ones)
- `'` word
- any kind of I/O functionality (though you can read files into `froth` from R)
