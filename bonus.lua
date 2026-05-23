function draw_b()
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
 if b.ga>0 then
  spr(206,80,96)
 elseif b.co>0 then
  spr(222,80,96)
 elseif b.sp>0 then
  spr(238,80,96)
 end
 if b.ur>0 then
  spr(150,112,112)
 elseif b.ne>0 then
  spr(151,112,112)
 elseif b.pl>0 then
  spr(152,112,112)
 end
 if b.on>0 then
  local bg=get_bg(b.sel)
  if b.l==5 then
   spr(bg,80,112)
  elseif b.l==8 then
   draw_bb(bg,96,96)
  elseif b.l==14 then
   spr(bg,80,96)
  else
   spr(bg,112,112)
  end
 end
end

function draw_bb(bg,x,y)
 spr(bg,x,y)
 spr(bg+1,x+8,y)
 spr(bg+16,x,y+8)
 spr(bg+17,x+8,y+8)
end

function get_bg(i)
 if b.l==5 then return 133+i end
 if b.l==8 then return 163+i*2 end
 if b.l==14 then return 190+i*16 end
 return 149+i
end

function get_bm(i)
 if b.l==5 then return i end
 if b.l==8 then return 5+i end
 if b.l==14 then return 11+i end
 return 8+i
end

function get_bs(v)
 local s=0
 if v%2>0 then s+=1 end
 if flr(v/4)%2>0 then s+=4 end
 if flr(v/8)%2>0 then s+=8 end
 if flr(v/16)%2>0 then s+=16 end
 if flr(v/1024)%2>0 then s+=1024 end
 return s
end

function get_bv()
 local v=0
 if b.co>0 then v+=2048 end
 if b.ea>0 then v+=1 end
 if b.ga>0 then v+=4096 end
 if b.ju>0 then v+=2 end
 if b.ma>0 then v+=4 end
 if b.me>0 then v+=8 end
 if b.mo>0 then v+=16 end
 if b.ne>0 then v+=32 end
 if b.pl>0 then v+=64 end
 if b.sa>0 then v+=128 end
 if b.su>0 then v+=256 end
 if b.ur>0 then v+=512 end
 if b.ve>0 then v+=1024 end
 if b.sp>0 then v+=8192 end
 return v
end

function init_b()
 b={
  co=0,
  ea=0,
  ga=0,
  ju=0,
  l=0,
  ma=0,
  me=0,
  mo=0,
  ne=0,
  on=0,
  pl=0,
  sa=0,
  sel=1,
  sp=0,
  su=0,
  ur=0,
  ve=0
 }
end

function load_b(v)
 b.co=flr(v/2048)%2
 b.ea=v%2
 b.ga=flr(v/4096)%2
 b.ju=flr(v/2)%2
 b.ma=flr(v/4)%2
 b.me=flr(v/8)%2
 b.mo=flr(v/16)%2
 b.ne=flr(v/32)%2
 b.pl=flr(v/64)%2
 b.sa=flr(v/128)%2
 b.sp=flr(v/8192)%2
 b.su=flr(v/256)%2
 b.ur=flr(v/512)%2
 b.ve=flr(v/1024)%2
end

function pick_b()
 if b.l==5 then
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
 elseif b.l==8 then
  if b.sel==1 then
   b.ju=1
   lk+=1+flr(rnd(3))
  elseif b.sel==2 then
   b.sa=1
  else
   b.su=1
  end
 elseif b.l==11 then
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
 else
  if b.sel==1 then
   b.ga=1
   q.g=1
   if q.f+2<=q.l then
    q[q.f+2]={a=0,c=0,g=207}
    q.g=0
   end
   fill_q()
  elseif b.sel==2 then
   b.co=1
   q.t=-1
  else
   b.sp=1
  end
 end
 b.on=0
 put_w(0,0)
 save_l()
end

function start_b()
 b.l=l
 b.on=1
 b.sel=1
 put_w(104,30)
end

function upd_b()
 local n=b.l==5 and 5 or 3
 if w.m==0 then
  put_w(get_bm(b.sel),-1)
 end
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
