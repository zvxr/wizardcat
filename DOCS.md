# DOCS

## Globals

### b
Bonus table. Holds owned bonus flags `ea`, `ju`, `ma`, `me`, `mo`, `ne`, `pl`, `sa`, `su`, `ur`, and `ve`. Also holds selection state `lv`, `on`, and `sel`.

### h
Home table. Holds `a` for the game-over animation delay, `o` for main-menu option, `s` for screen state, and `x` for game-over `x` press count.

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

### s
Staff table. Holds `a` for staff animation timing, `o` for idle animation odds growth, and `t` for whether the 80%-full wizard message has already been shown this level.

### ver
Cart version string.

### w
Wizard table. Holds signed animation `a`, extra animation `ae`, message timer `am`, message id `m`, and idle odds `o` and `oe`.

## Functions

### draw_h()
Draws the home screen. Uses the map region anchored at `(16,0)`, draws the main-screen wizard with `draw_wm()`, and prints the `normal`, `easy`, and `continue` menu options starting at tile `(21,7)`.

### draw_hg()
Draws the game-over overlay used while `h.s==2`. After `15` frames of game-over time, also draws graphics `37,38,39,53,54,55` in a `3x2` block at tiles `(1,2)` through `(3,3)`. The box centers `game over`, then shows `continue on` and the capped continue level using `min(lv,12)` in dark grey text on separate lower lines.

### draw_b()
Draws owned bonus graphics on the HUD. Level-5 bonus graphics draw at tile `(10,14)`, level-8 bonuses draw as a 2x2 graphic with top-left at `(12,12)`, and level-11 bonuses draw at `(14,14)`. Also draws preview markers using graphic `10` at `(4,6)`, `(4,9)`, and `(4,12)`, remapping sprite color `8` to `3` by default and to `11` when bonuses `me`, `sa`, or `ne` are active for that slot. During bonus selection, draws the currently highlighted option in that level's HUD slot instead.

### draw_bb(g,x,y)
Draws a 2x2 bonus graphic block using top-left graphic `g` at pixel position `(x,y)`.

### draw_lv()
Draws the current level text as `level: {#}` at pixel `(4,8)`.

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
Draws the first live queue panel at tile coordinate `(2,3)`. Uses the normal panel draw path with level color `0`, so sprite color `5` is remapped to `0` and sprite color `6` is remapped to the panel color. When bonus `me` is active, also draws `q[1]` at tile `(4,5)`. When bonus `sa` is active, draws `q[2]` at tile `(4,8)`. When bonus `ne` is active, draws `q[3]` at tile `(4,11)`. Also draws the discard indicator at `(2,2)` using graphics `17`, `19`, or `20`, and when discards reach `3` draws a 2x2 game-over marker using graphics `35`, `36`, `51`, and `52`.

### draw_s()
Draws the full level-progress staff. Uses touched matrix count mapped proportionally from `0..81` into `0..28` visual fill steps. The base uses graphic `22` at `(2,14)`, and the upper shaft procedurally cycles graphics `56`, `40`, and `24` upward while recoloring filled colors to the current level color and unfilled colors to `0`. On graphic `24`, animation graphics `25..29` are only drawn when the third fill layer is active and `s.a` is running.

### draw_w()
Draws the wizard at tile coordinates `(9,12)` and `(9,13)`. Uses graphics `131/147` when `w.a==0`, `132/148` when `w.a<0`, and `133/149` when `w.a>0`. Also draws graphic `145` at `(7,13)` when `w.ae==0` and graphic `164` when `w.ae>0`. If `w.m>0`, prints the current wizard message at tile `(9,11)`.

### draw_wm()
Draws the main-screen wizard. Uses the same animation state as `draw_w()`, but at map-space positions `(21,12)`, `(21,13)`, and `(19,13)`, which render at screen pixels `(40,96)`, `(40,104)`, and `(24,104)`. If `w.m>0`, prints the current wizard message at tile `(21,11)`.

### discard_q()
Discards the first queue panel, refills the queue, and plays sound `6`. When bonus `mo` is active and `q.d` is `0`, or bonus `ur` is active and `q.d` is `2`, there is an `lk` percent chance the discard does not increase `q.d`, in which case sound `9` also plays. Otherwise the discard count increases normally. When `q.d` reaches `2`, also shows wizard message `102`.

### empty_m(p)
Returns true when matrix panel `p` is treated as empty. This includes blank panels with graphic `1`, cleared standard panels with graphics `112..127`, and cleared special panels `188..191`.

### get_lc()
Returns the current level color from `lv`, looping through colors `1` to `4`.

### get_lfp()
Returns a special first panel table with animation `40`. For levels `1` through `5`, returns `(0,142)`. From levels `6` through `9`, returns either `(0,141)` or `(0,142)` with equal chance. From level `10` onward, returns `(0,141)`, `(0,142)`, or `(0,143)` with equal chance.

### get_lp()
Returns a new level panel table. Uses `lk` as a `1` to `3` percent chance to return `get_lfp()` instead. Otherwise sets animation to `40`, chooses panel color from a level-scaled range starting at `8..11` and adding one color every third level until `8..15`, and chooses graphic from a level-scaled range starting at `64..67` and growing on the non-color levels until `64..79`.

### get_bg(i)
Returns the current level's bonus graphic for selection index `i`.

### get_bm(i)
Returns the current level's wizard message id for selection index `i`.

### get_bv()
Returns the current bonus selections as a bitmask integer for PICO-8 cart storage.

### get_wm(m)
Returns wizard message text for message id `m`. Current ids include `101` for `welcome`, `102` for `be careful...`, `103` for `almost there`, `104` for `select bonus`, `105` for `show next`, `106` for `more luck`, `107` for `rainbow`, `108` for `free disc`, `109` for `recover+`, `110` for `more luck`, `111` for `near future`, `112` for `remove`, `113` for `last free`, `114` for `far future`, `115` for `more luck`, `201` for `I <3 minnows`, `202` for `magic is cool`, and `203` for `meow`.

### init_game()
Initializes luck and level state from input level `l`.

### init_b()
Initializes the bonus table with no owned level-5 bonuses and selection state cleared.

### load_b(v)
Loads owned bonus flags from bitmask integer `v`.

### load_g()
Loads saved level and bonus state from PICO-8 cart storage, reinitializes gameplay systems, and starts play mode. If the loaded level is a bonus-selection level with no bonus chosen for that tier yet, it enters `start_b()`.

### init_h()
Initializes the home table with game-over animation delay `0`, option `1`, screen state `0`, and game-over press count `0`.

### next_lv()
Advances to the next level immediately. Increments `lv`, plays sound `8`, then resets the matrix, queue, staff, and target for the new level. Saves the new level and current bonuses to PICO-8 cart storage. At levels `5`, `8`, and `11`, enters bonus selection with `start_b()`.

### init_t()
Initializes the target table with starting coordinates.

### init_m()
Replaces the global matrix with a new 9x9 panel array. Looks up the current level color with `get_lc()`. Each panel starts as graphic `1`, color `lc`, animation `40`.

### init_q()
Initializes the queue table with discard count `0`, first index `1`, last index `0`, and target size `3`, or `4` when bonus `ne` is active.

### init_s()
Initializes the staff table with animation `0`, odds `0`, and threshold-message flag `0`.

### init_w()
Initializes the wizard table with animations `0`, idle odds `0`, and startup message `101` for `60` frames.

### add_q(p)
Appends panel `p` to the back of the queue.

### clear_q()
Clears queued panel references in place, then resets first index to `1` and last index to `0`. Keeps the existing queue size setting in `q.s`.

### fill_q()
Fills the queue up to `q.s` live items. If the queue is empty, adds `get_lfp()` first, unless bonus `ea` is active, in which case it adds graphic `140` instead. Then fills remaining slots with `get_lp()`, unless bonus `su` is active and a raw `lk` percent roll replaces that panel with graphic `139`. Uses the live count `q.l-q.f+1`, so refills continue to work after pops.

### pick_b()
Applies the currently selected bonus for the current bonus level, clears bonus-select mode, and clears the wizard message. Luck bonuses `ve`, `ju`, and `pl` immediately add `1..3` to `lk`. Bonus `ea` also immediately replaces the current first queue panel with graphic `140`. Bonus `ne` immediately raises queue size to `4` and refills it.

### pick_h()
Applies the selected home-menu option. `normal` starts gameplay at level `4` and clears saved progress, `easy` starts at level `1` and clears saved progress, and `continue` loads the saved level and bonus state from PICO-8 cart storage.

### pop_q()
Returns and removes the first panel in the queue. Returns nothing if the queue is empty.

### put_p()
Attempts to place the first queue panel on the matrix cell under the target. Placement normally succeeds only when the target matrix panel is treated as empty and `check_m()` passes for the queued panel against all in-bounds neighbors. Graphic `139` instead places onto any non-empty panel, immediately clears that panel by adding `48` to its graphic and setting animation to `40`, then refills the queue. Normal successful placement replaces the matrix panel with `pop_q()`, then checks the full target row and column. Any completed row or column is marked cleared by adding `48` to each panel graphic and resetting animation to `40`. Successful placement also recovers one discard from `q.d` until it reaches `0`, or two when bonus `ma` is active, plays sound `7` if a row or column was completed, plays sound `4`, then immediately advances with `next_lv()` if `check_mt()` passes. Otherwise it refills the queue with `fill_q()`. On failure, plays sound `5` and returns.

### put_w(m,am)
Replaces the current wizard message with id `m` and timer `am`.

### start_b()
Starts bonus selection. Sets `b.lv` from the current level, enables `b.on`, resets the selection index to `1`, and shows wizard message `104` as a persistent prompt.

### start_g(l)
Starts gameplay from level `l`. Reinitializes bonuses, game state, target, matrix, queue, staff, and wizard, resets the game-over animation state, saves that fresh state, then sets `h.s` to play.

### start_h()
Returns to the home screen. Resets home selection state, clears the game-over animation state, and reinitializes the wizard.

### has_bl()
Checks whether the current level's bonus slot has already been chosen. Returns true for non-bonus levels.

### reset_g(l)
Clears saved bonus state, stores level `l` into PICO-8 cart storage, and starts a fresh game from that level.

### save_g()
Stores the current bonus bitmask and the current level capped to `12` into PICO-8 cart storage.

### upd_input()
Handles directional target input with `btnp()`. Target movement is limited to the `1..9` matrix bounds. Plays sound `3` on a valid move and sound `1` when the target presses against an edge. Button `4` discards the first queue panel with `discard_q()`. Button `5` attempts to place the first queue panel with `put_p()`. When `q.d` reaches `3`, input stops until the cart is restarted.

### upd_b()
Handles bonus selection input while `b.on` is active. Left and right cycle through the current level's bonus options with wrapping and replace the wizard message using `get_bm()`. Level `5` has five options; levels `8` and `11` have three each. Button `5` confirms the current selection with `pick_b()`.

### upd_h()
Handles home-menu input. Up and down cycle through the three menu options with wrapping and play sound `3`. Button `5` confirms the current option with `pick_h()`.

### upd_hg()
Handles game-over input. Increments `h.a` up to `15` to drive the delayed lose animation. Each press of button `5` increments `h.x`; on the second press it returns to the home screen with `start_h()`.

### upd_m()
Reduces each matrix panel animation counter by `1` until it reaches `0`.

### upd_q()
Reduces the animation counter of each live queue panel by `1` until it reaches `0`.

### upd_s()
Reduces the staff animation counter by `1` until it reaches `0`. When `a` is `0`, uses chance `rnd(3000)<1+s.o` to start a new animation at `24` and reset `o` to `0`; otherwise increments `o` by `1`. When touched count reaches `64` or more for the first time in a level, shows wizard message `103` and marks the threshold flag.

### upd_w()
Moves the wizard animation values toward `0` by `1` each update. When `w.a` is `0`, uses chance `rnd(5000)<1+w.o` to set `w.a` to either `-55` or `55` with equal chance and reset `w.o` to `0`; otherwise increments `w.o` by `1`. When `w.ae` is `0`, uses chance `rnd(10000)<1+w.oe` to set `w.ae` to `24` and reset `w.oe` to `0`; otherwise increments `w.oe` by `1`. Timed messages count `w.am` down to `0`, then clear `w.m`. When no message is active, random ids `201` and `202` can appear with `1/10000` chance each and id `203` can appear with `1/4000` chance.
