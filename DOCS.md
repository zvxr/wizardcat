# DOCS

## Globals

### t
Target table. Holds `x` and `y` tile coordinates.

### m
9x9 matrix of panel tables. Each panel uses `a` for animation ticks, `c` for panel color, and `g` for core graphic id.

### lk
Luck integer. Set randomly to `1`, `2`, or `3` during game init. Used as the percent chance for `get_lp()` to return a special first panel instead of a normal level panel.

### lv
Current level integer. `get_lc()` maps this to a level color with `lv%4+1`.

### q
Queue table. Holds `d` for discard count, `f` for first index, `l` for last index, and `s` for target size.

### sc
Score counter.

### s
Staff table. Holds `a` for staff animation timing, `o` for idle animation odds growth, and `t` for whether the 80%-full wizard message has already been shown this level.

### ver
Cart version string.

### w
Wizard table. Holds signed animation `a`, extra animation `ae`, message timer `am`, message id `m`, and idle odds `o` and `oe`.

## Functions

### draw_lv()
Draws the current level text as `level: {#}`.

### draw_t()
Draws target graphic `2` as an overlay on top of the matrix using target coordinates from `t`. The target is drawn at the matching matrix tile position with no palette swap.

### draw_m(lc)
Draws the 9x9 panel matrix at tile coordinates starting from `(6,1)`. Passes the level color through to `draw_p`.

### draw_p(lc,p,x,y)
Draws one panel at tile coordinate `(x,y)`. Blank graphic `1` uses `p.a` to animate through graphics `9`, `8`, `7`, then `1`, with no palette swap. Cleared standard panels with graphics `112..127` and cleared special panels `188..191` use reverse animation graphics and draw as blank graphic `1` when `a` reaches `0`, while still using level-border recoloring. Filled graphic `3` and standard play graphics `64` through `76` use `p.a` to choose an animated display graphic before drawing. Recolors sprite color `5` to the level color and sprite color `6` to the panel color.

### check_m(p,x,y)
Checks whether panel `p` can be placed at matrix coordinate `(x,y)` based on the four cardinal neighbors. Only in-bounds neighbors are checked. Returns true only if every checked neighbor passes `check_mc()`. Panels whose color is not `0` must also touch at least one non-empty neighbor.

### check_mt()
Checks whether the matrix is ready to advance the level. Returns true only when every matrix panel has been touched at least once, meaning no panel still has graphic `1`.

### check_mc(p,x,y)
Checks whether panel `p` is compatible with the existing matrix panel at `(x,y)`. Empty panels and cleared panels always pass. Graphic `140` matches all panels. Panels with color `0` use their graphic to decide color-group matching: `141` matches the `10..13` group, `142` matches the `8..11` group, and `143` matches the `12..15` group. Other non-empty panels pass if the graphic matches or the color matches exactly.

### count_mt()
Counts touched matrix panels. Returns the number of cells whose graphic is not `1`.

### draw_q()
Draws the first live queue panel at tile coordinate `(2,3)`. Uses the normal panel draw path with level color `0`, so sprite color `5` is remapped to `0` and sprite color `6` is remapped to the panel color. Also draws the discard indicator at `(2,2)` using graphics `17`, `19`, or `20`, and when discards reach `3` draws a 2x2 game-over marker using graphics `35`, `36`, `51`, and `52`.

### draw_s()
Draws the full level-progress staff. Uses touched matrix count mapped proportionally from `0..81` into `0..28` visual fill steps. The base uses graphic `22` at `(2,14)`, and the upper shaft procedurally cycles graphics `56`, `40`, and `24` upward while recoloring filled colors to the current level color and unfilled colors to `0`. On graphic `24`, animation graphics `25..29` are only drawn when the third fill layer is active and `s.a` is running.

### draw_w()
Draws the wizard at tile coordinates `(9,12)` and `(9,13)`. Uses graphics `131/147` when `w.a==0`, `132/148` when `w.a<0`, and `133/149` when `w.a>0`. Also draws graphic `145` at `(7,13)` when `w.ae==0` and graphic `164` when `w.ae>0`. If `w.m>0`, prints the current wizard message at tile `(9,11)`.

### discard_q()
Discards the first queue panel, refills the queue, increments `q.d`, and plays sound `6`. When `q.d` reaches `2`, also shows wizard message `102`.

### empty_m(p)
Returns true when matrix panel `p` is treated as empty. This includes blank panels with graphic `1`, cleared standard panels with graphics `112..127`, and cleared special panels `188..191`.

### get_lc()
Returns the current level color from `lv`, looping through colors `1` to `4`.

### get_lfp()
Returns a special first panel table with animation `40`. For levels `1` through `5`, returns `(0,142)`. From levels `6` through `9`, returns either `(0,141)` or `(0,142)` with equal chance. From level `10` onward, returns `(0,141)`, `(0,142)`, or `(0,143)` with equal chance.

### get_lp()
Returns a new level panel table. Uses `lk` as a `1` to `3` percent chance to return `get_lfp()` instead. Otherwise sets animation to `40`, chooses panel color from a level-scaled range starting at `8..11` and adding one color every third level until `8..15`, and chooses graphic from a level-scaled range starting at `64..67` and growing on the non-color levels until `64..79`.

### get_wm(m)
Returns wizard message text for message id `m`. Current ids include `101` for `welcome`, `102` for `be careful...`, `103` for `almost there`, `201` for `i like minnows.`, `202` for `magic is cool.`, and `203` for `meow`.

### init_game()
Initializes luck, level, and score state.

### next_lv()
Advances to the next level immediately. Increments `lv`, plays sound `8`, then resets the matrix, queue, staff, and target for the new level.

### init_t()
Initializes the target table with starting coordinates.

### init_m()
Replaces the global matrix with a new 9x9 panel array. Looks up the current level color with `get_lc()`. Each panel starts as graphic `1`, color `lc`, animation `40`.

### init_q()
Initializes the queue table with discard count `0`, first index `1`, last index `0`, and target size `3`.

### init_s()
Initializes the staff table with animation `0`, odds `0`, and threshold-message flag `0`.

### init_w()
Initializes the wizard table with animations `0`, idle odds `0`, and startup message `101` for `60` frames.

### add_q(p)
Appends panel `p` to the back of the queue.

### clear_q()
Clears queued panel references in place, then resets first index to `1` and last index to `0`. Keeps the existing queue size setting in `q.s`.

### fill_q()
Fills the queue up to `q.s` live items. If the queue is empty, adds `get_lfp()` first, then fills remaining slots with `get_lp()`. Uses the live count `q.l-q.f+1`, so refills continue to work after pops.

### pop_q()
Returns and removes the first panel in the queue. Returns nothing if the queue is empty.

### put_p()
Attempts to place the first queue panel on the matrix cell under the target. Placement currently succeeds only when the target matrix panel is treated as empty and `check_m()` passes for the queued panel against all in-bounds neighbors. On success, replaces the matrix panel with `pop_q()`, then checks the full target row and column. Any completed row or column is marked cleared by adding `48` to each panel graphic and resetting animation to `40`. Successful placement also recovers one discard from `q.d` until it reaches `0`, plays sound `7` if a row or column was completed, plays sound `4`, then immediately advances with `next_lv()` if `check_mt()` passes. Otherwise it refills the queue with `fill_q()`. On failure, plays sound `5` and returns.

### put_w(m,am)
Replaces the current wizard message with id `m` and timer `am`.

### upd_input()
Handles directional target input with `btnp()`. Target movement is limited to the `1..9` matrix bounds. Plays sound `3` on a valid move and sound `1` when the target presses against an edge. Button `4` discards the first queue panel with `discard_q()`. Button `5` attempts to place the first queue panel with `put_p()`. When `q.d` reaches `3`, input stops until the cart is restarted.

### upd_m()
Reduces each matrix panel animation counter by `1` until it reaches `0`.

### upd_q()
Reduces the animation counter of each live queue panel by `1` until it reaches `0`.

### upd_s()
Reduces the staff animation counter by `1` until it reaches `0`. When `a` is `0`, uses chance `rnd(3000)<1+s.o` to start a new animation at `24` and reset `o` to `0`; otherwise increments `o` by `1`. When touched count reaches `64` or more for the first time in a level, shows wizard message `103` and marks the threshold flag.

### upd_w()
Moves the wizard animation values toward `0` by `1` each update. When `w.a` is `0`, uses chance `rnd(5000)<1+w.o` to set `w.a` to either `-55` or `55` with equal chance and reset `w.o` to `0`; otherwise increments `w.o` by `1`. When `w.ae` is `0`, uses chance `rnd(10000)<1+w.oe` to set `w.ae` to `24` and reset `w.oe` to `0`; otherwise increments `w.oe` by `1`. Timed messages count `w.am` down to `0`, then clear `w.m`. When no message is active, random ids `201` and `202` can appear with `1/10000` chance each and id `203` can appear with `1/4000` chance.
