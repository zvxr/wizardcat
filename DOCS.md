# DOCS

## Globals

### t
Target table. Holds `x` and `y` tile coordinates.

### cr
Cracks counter.

### m
9x9 matrix of panel tables. Each panel uses `a` for animation ticks, `c` for panel color, and `g` for core graphic id.

### lv
Current level integer. `get_lc()` maps this to a level color with `lv%4+1`.

### q
Queue table. Holds `f` for first index, `l` for last index, and `s` for target size.

### sc
Score counter.

### ver
Cart version string.

## Functions

### draw_t()
Draws target graphic `2` as an overlay on top of the matrix using target coordinates from `t`. The target is drawn at the matching matrix tile position with no palette swap.

### draw_m(lc)
Draws the 9x9 panel matrix at tile coordinates starting from `(6,1)`. Passes the level color through to `draw_p`.

### draw_p(lc,p,x,y)
Draws one panel at tile coordinate `(x,y)`. Blank graphic `1` uses `p.a` to animate through graphics `9`, `8`, `7`, then `1`, with no palette swap. Filled graphic `3` and standard play graphics `64` through `76` use `p.a` to choose an animated display graphic before drawing. Recolors sprite color `5` to the level color and sprite color `6` to the panel color.

### check_m(p,x,y)
Checks whether panel `p` can be placed at matrix coordinate `(x,y)` based on the four cardinal neighbors. Only in-bounds neighbors are checked. Returns true only if every checked neighbor passes `check_mc()`.

### check_mc(p,x,y)
Checks whether panel `p` is compatible with the existing matrix panel at `(x,y)`. Empty panels with graphic `1` always pass. Non-empty panels pass if the graphic matches, the color matches exactly, color `0` matches colors `8..11`, or color `7` matches colors `12..15`.

### draw_q()
Draws the first live queue panel at tile coordinate `(2,3)`. Uses the normal panel draw path with level color `0`, so sprite color `5` is remapped to `0` and sprite color `6` is remapped to the panel color.

### get_lc()
Returns the current level color from `lv`, looping through colors `1` to `4`.

### get_lfp()
Returns a special first panel table with animation `40`. For levels `1` through `9`, always returns color `0`, graphic `142`. From level `10` onward, returns either `(0,142)` or `(7,143)` with a 50/50 chance.

### get_lp()
Returns a new level panel table. Sets animation to `40`, chooses panel color from a level-scaled range starting at `8..11` and adding one color every third level until `8..15`, and chooses graphic from a level-scaled range starting at `64..67` and growing on the non-color levels until `64..79`.

### init_game()
Initializes level, cracks, and score state.

### init_t()
Initializes the target table with starting coordinates.

### init_m(lc)
Replaces the global matrix with a new 9x9 panel array. Each panel starts as graphic `1`, color `lc`, animation `40`.

### init_q()
Initializes the queue table with first index `1`, last index `0`, and target size `3`.

### add_q(p)
Appends panel `p` to the back of the queue.

### clear_q()
Clears queued panel references in place, then resets first index to `1` and last index to `0`. Keeps the existing queue size setting in `q.s`.

### fill_q()
Fills the queue up to `q.s` live items. If the queue is empty, adds `get_lfp()` first, then fills remaining slots with `get_lp()`. Uses the live count `q.l-q.f+1`, so refills continue to work after pops.

### pop_q()
Returns and removes the first panel in the queue. Returns nothing if the queue is empty.

### put_p()
Attempts to place the first queue panel on the matrix cell under the target. Placement currently succeeds only when the target panel graphic is `1` and `check_m()` passes for the queued panel against all in-bounds neighbors. On success, replaces the empty matrix panel with `pop_q()`, refills the queue with `fill_q()`, and plays sound `4`. On failure, plays sound `5` and returns.

### upd_input()
Handles directional target input with `btnp()`. Target movement is limited to the `1..9` matrix bounds. Plays sound `3` on a valid move and sound `1` when the target presses against an edge. Button `5` attempts to place the first queue panel with `put_p()`.

### upd_m()
Reduces each matrix panel animation counter by `1` until it reaches `0`.

### upd_q()
Reduces the animation counter of each live queue panel by `1` until it reaches `0`.
