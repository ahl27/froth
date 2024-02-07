# froth: FORTH for R

<img src="./man/figures/froth.png" width="400" class="center"/>

`froth` is a Forth implementation for R. If you're new to `froth` or Forth, check out [the detailed overview](https://www.ahl27.com/froth/articles/froth.html) or my [in-depth tutorial](https://www.ahl27.com/froth/articles/FundamentalFroth.html).

`froth` is distributed by CRAN. You can download it for your R installation by running:
```
install.packages("froth")
```

This implementation comes with a number of differences from other FORTHs:

- uses R operators for arithmetic, so `3 2 /` returns `1.5`
- arbitrary R objects can be pushed onto the stack
- built-in R `print` methods; use `.R` to format according to the print method for the top of the parameter stack
- obfuscated memory (no direct or emulated hardware-level memory access)
- no distinction between compiled and interpreted words (loops are possible outside of definitions!)
- Use of R lists for internal arrays; arrays of bytes are not supported
- `'` will always look for the next token, not the next token from input stream. This makes it identical to `[']` in function definitions. I may change this later.

This will (likely) not be a 1:1 copy of Gforth, I think I'd rather have a forth implementation that is robust
and works in R than one that exacly imitates existing Gforth. But...tbd.

## TODOs
- any kind of I/O functionality (though you can read files into `froth` from R)
