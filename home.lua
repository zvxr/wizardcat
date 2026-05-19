function draw_h()
 map(16,0,0,0,16,16)
 draw_wm()
 print("normal",40,56,h.o==1 and 11 or 7)
 print("easy",40,64,h.o==2 and 11 or 7)
 print("continue",40,72,h.o==3 and 11 or 7)
end

function draw_hg()
 rectfill(28,54,100,74,0)
 rect(28,54,100,74,7)
 print("game over",38,62,7)
end

function init_h()
 h={o=1,s=0,x=0}
end

function pick_h()
 if h.o==1 then
  reset_g(4)
 elseif h.o==2 then
  reset_g(1)
 else
  load_g()
 end
end

function start_g(l)
 init_b()
 init_game(l)
 init_t()
 init_m()
 init_q()
 init_s()
 init_w()
 h.s=1
 h.x=0
 save_g()
end

function start_h()
 h.o=1
 h.s=0
 h.x=0
 init_w()
end

function upd_h()
 if btnp(2) then
  h.o-=1
  if h.o<1 then h.o=3 end
  sfx(3)
 elseif btnp(3) then
  h.o+=1
  if h.o>3 then h.o=1 end
  sfx(3)
 elseif btnp(5) then
  pick_h()
 end
end

function upd_hg()
 if btnp(5) then
  h.x+=1
  if h.x>1 then
   start_h()
  end
 end
end
