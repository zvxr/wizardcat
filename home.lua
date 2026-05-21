function draw_h()
 map(16,0,0,0,16,16)
 draw_hp()
 draw_wm()
 print("normal",40,56,h.o==1 and 11 or 7)
 print("easy",40,64,h.o==2 and 11 or 7)
 print("continue",40,72,h.o==3 and 11 or 7)
 print(ver,96,112,7)
end

function draw_hg()
 if h.a>=15 then
  spr(37,8,16)
  spr(38,16,16)
  spr(39,24,16)
  spr(53,8,24)
  spr(54,16,24)
  spr(55,24,24)
 end
 rectfill(28,54,100,80,0)
 rect(28,54,100,80,7)
 print("game over",46,56,7)
 print("continue on",38,68,5)
 print("level "..min(l,12),38,74,5)
end

function draw_hp()
 local a=h.p.a
 local pg=h.p.g
 local p={c=h.p.c,g=pg}
 if a<1 then return end
 if a<41 then
  p.a=a
 elseif a<71 then
  p.a=40
 else
  p.a=111-a
 end
 draw_p(0,p,8,13)
end

function get_hp()
 local p=get_lp()
 p.a=1
 p.g+=48
 return p
end

function get_ho()
 local sl=flr(dget(0))
 if sl==1 then return 2 end
 if sl>1 and sl!=4 then return 3 end
 return 1
end

function init_h()
 h={a=0,o=get_ho(),p={a=0,c=0,g=1},po=0,s=0,x=0}
end

function pick_h()
 if h.o==1 then
  init_l(4)
 elseif h.o==2 then
  init_l(1)
 else
  init_l(0)
 end
end

function start_h()
 h.a=0
 h.o=get_ho()
 h.p={a=0,c=0,g=1}
 h.po=0
 h.s=0
 h.x=0
 init_w()
end

function upd_h()
 if h.p.a>0 then
  h.p.a+=1
  if h.p.a>110 then
   h.p.a=0
  end
 elseif rnd(1000)<1+h.po then
  h.p=get_hp()
  h.po=0
 else
  h.po+=1
 end
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
 if h.a<15 then
  h.a+=1
 end
 if btnp(5) then
  h.x+=1
  if h.x>1 then
   start_h()
  end
 end
end
