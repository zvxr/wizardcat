function draw_l()
 print("level: "..l,4,8,7)
end

function get_lc()
 return l%4+1
end

function get_lb()
 if l==5 then
  return b.ea>0 or b.ma>0 or b.me>0 or b.mo>0 or b.ve>0
 end
 if l==8 then
  return b.ju>0 or b.sa>0 or b.su>0
 end
 if l==11 then
  return b.ne>0 or b.pl>0 or b.ur>0
 end
 return true
end

function init_l(n)
 local k
 if n and n>0 then
  init_b()
  dset(0,n)
  dset(1,0)
  dset(2,0)
  k=1+flr(rnd(3))
 else
  n=flr(dget(0))
  if n<1 then n=4 end
  init_b()
  load_b(flr(dget(1)))
  k=flr(dget(2))
  if k<1 then k=1+flr(rnd(3)) end
 end
 lk=k
 l=n
 init_t()
 init_m()
 init_q()
 init_s()
 init_g()
 init_w()
 h.s=1
 h.a=0
 h.x=0
 save_l()
 if not get_lb() then
  start_b()
 end
end

function put_l()
 l+=1
 sfx(8)
 init_m()
 init_q()
 init_s()
 init_t()
 init_g()
 save_l()
 if l==5 or l==8 or l==11 then
  start_b()
 end
end

function save_l()
 dset(0,min(l,12))
 dset(1,get_bv())
 dset(2,lk)
end
