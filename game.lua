function draw_lv()
 print("level: "..lv,8,8,7)
end

function get_lc()
  return lv%4+1
end

function has_bl()
 if lv==5 then
  return b.ea>0 or b.ma>0 or b.me>0 or b.mo>0 or b.ve>0
 end
 if lv==8 then
  return b.ju>0 or b.sa>0 or b.su>0
 end
 if lv==11 then
  return b.ne>0 or b.pl>0 or b.ur>0
 end
 return true
end

function init_game(l)
  lk=1+flr(rnd(3))
  lv=l
end

function load_g()
 local l=flr(dget(0))
 if l<1 then l=4 end
 init_b()
 load_b(flr(dget(1)))
 init_game(l)
 init_t()
 init_m()
 init_q()
 init_s()
 init_w()
 h.s=1
 h.x=0
 if not has_bl() then
  start_b()
 end
end

function next_lv()
 lv+=1
 sfx(8)
 init_m()
 init_q()
 init_s()
 init_t()
 save_g()
 if lv==5 or lv==8 or lv==11 then
  start_b()
 end
end

function reset_g(l)
 dset(0,l)
 dset(1,0)
 start_g(l)
end

function save_g()
 dset(0,lv)
 dset(1,get_bv())
end

function upd_input()
 if q.d>=3 then return end
 if btnp(0) then
  if t.x>1 then
   t.x-=1
   sfx(3)
  else
   sfx(1)
  end
 elseif btnp(1) then
  if t.x<9 then
   t.x+=1
   sfx(3)
  else
   sfx(1)
  end
 elseif btnp(2) then
  if t.y>1 then
   t.y-=1
   sfx(3)
  else
   sfx(1)
  end
 elseif btnp(3) then
  if t.y<9 then
   t.y+=1
   sfx(3)
  else
   sfx(1)
  end
 elseif btnp(4) then
  discard_q()
 elseif btnp(5) then
  put_p()
 end
end
