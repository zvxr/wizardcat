# DOCS

## Globals

### c
Cursor table. Holds `x` and `y` tile coordinates.

### cr
Cracks counter.

### g
9x9 grid of panel tables. Each panel uses `a` for animation ticks, `c` for panel color, and `g` for core graphic id.

### lv
Current level integer. `get_lc()` maps this to a level color with `lv%4+1`.

### q
Queue table. Holds `f` for first index, `l` for last index, and `s` for target size.

### sc
Score counter.

### ver
Cart version string.

## Functions

### draw_c()
Draws cursor graphic `2` as an overlay on top of the grid using cursor coordinates from `c`. The cursor is drawn at the matching grid tile position with no palette swap.

### draw_g(lc)
Draws the 9x9 panel grid at tile coordinates starting from `(6,1)`. Passes the level color through to `draw_p`.

### draw_p(lc,p,x,y)
Draws one panel at tile coordinate `(x,y)`. Blank graphic `1` uses `p.a` to animate through graphics `9`, `8`, `7`, then `1`, with no palette swap. Filled graphic `3` and standard play graphics `64` through `76` use `p.a` to choose an animated display graphic before drawing. Recolors sprite color `5` to the level color and sprite color `6` to the panel color.

### get_lc()
Returns the current level color from `lv`, looping through colors `1` to `4`.

### init_game()
Initializes level, cracks, and score state.

### init_c()
Initializes the cursor table with starting coordinates.

### init_g(lc)
Replaces the global grid with a new 9x9 panel array. Each panel starts as graphic `1`, color `lc`, animation `40`.

### init_q()
Initializes the queue table with first index `1`, last index `0`, and target size `3`.

### add_q(p)
Appends panel `p` to the back of the queue.

### clear_q()
Clears queued panel references in place, then resets first index to `1` and last index to `0`. Keeps the existing queue size setting in `q.s`.

### pop_q()
Returns and removes the first panel in the queue. Returns nothing if the queue is empty.

### upd_input()
Handles directional cursor input with `btnp()`. Cursor movement is limited to the `1..9` grid bounds. Plays sound `3` on a valid move and sound `1` when the cursor presses against an edge.

### upd_g()
Reduces each panel animation counter by `1` until it reaches `0`.
