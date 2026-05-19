function draw_b()
 local g
 pal(8,b.me>0 and 11 or 3)
 spr(10,32,48)
 pal()
 pal(8,b.sa>0 and 11 or 3)
 spr(10,32,72)
 pal()
 pal(8,b.ne>0 and 11 or 3)
 spr(10,32,96)
 pal()
 if b.me>0 then
  spr(134,80,112)
 elseif b.ve>0 then
  spr(135,80,112)
 elseif b.ea>0 then
  spr(136,80,112)
 elseif b.mo>0 then
  spr(137,80,112)
 elseif b.ma>0 then
  spr(138,80,112)
 end
 if b.ju>0 then
  draw_bb(165,96,96)
 elseif b.sa>0 then
  draw_bb(167,96,96)
 elseif b.su>0 then
  draw_bb(169,96,96)
 end
 if b.ur>0 then
  spr(150,112,112)
 elseif b.ne>0 then
  spr(151,112,112)
 elseif b.pl>0 then
  spr(152,112,112)
 end
 if b.on>0 then
  g=get_bg(b.sel)
  if b.lv==5 then
   spr(g,80,112)
  elseif b.lv==8 then
   draw_bb(g,96,96)
  else
   spr(g,112,112)
  end
 end
end

function draw_bb(g,x,y)
 spr(g,x,y)
 spr(g+1,x+8,y)
 spr(g+16,x,y+8)
 spr(g+17,x+8,y+8)
end

function get_bg(i)
 if b.lv==5 then return 133+i end
 if b.lv==8 then return 163+i*2 end
 return 149+i
end

function get_bm(i)
 if b.lv==5 then return 104+i end
 if b.lv==8 then return 109+i end
 return 112+i
end

function init_b()
 b={
  ea=0,
  ju=0,
  lv=0,
  ma=0,
  me=0,
  mo=0,
  ne=0,
  on=0,
  pl=0,
  sa=0,
  sel=1,
  su=0,
  ur=0,
  ve=0
 }
end

function pick_b()
 if b.lv==5 then
  if b.sel==1 then
   b.me=1
  elseif b.sel==2 then
   b.ve=1
   lk+=1+flr(rnd(3))
  elseif b.sel==3 then
   b.ea=1
   q[q.f]={a=40,c=0,g=140}
  elseif b.sel==4 then
   b.mo=1
  else
   b.ma=1
  end
 elseif b.lv==8 then
  if b.sel==1 then
   b.ju=1
   lk+=1+flr(rnd(3))
  elseif b.sel==2 then
   b.sa=1
  else
   b.su=1
  end
 else
  if b.sel==1 then
   b.ur=1
  elseif b.sel==2 then
   b.ne=1
   q.s=4
   fill_q()
  else
   b.pl=1
   lk+=1+flr(rnd(3))
  end
 end
 b.on=0
 put_w(0,0)
end

function start_b()
 b.lv=lv
 b.on=1
 b.sel=1
 put_w(104,-1)
end

function upd_b()
 local n=b.lv==5 and 5 or 3
 if btnp(0) then
  b.sel-=1
  if b.sel<1 then b.sel=n end
  put_w(get_bm(b.sel),-1)
 elseif btnp(1) then
  b.sel+=1
  if b.sel>n then b.sel=1 end
  put_w(get_bm(b.sel),-1)
 elseif btnp(5) then
  pick_b()
 end
end
