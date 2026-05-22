function draw_l()
 print("level: "..l,4,8,7)
end

function init_lg()
 lg={
  b=flr(dget(1)),
  k=flr(dget(2)),
  l=flr(dget(0))
 }
 lg.b%=2048
 if lg.l<1 then lg.l=4 end
 if lg.k<1 then lg.k=1+flr(rnd(3)) end
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
 if l==13 then
  return b.co>0 or b.ga>0 or b.sp>0
 end
 return true
end

function init_l(n)
 if n and n>0 then
  init_b()
  lk=1+flr(rnd(3))
  l=n
 else
  init_b()
  load_b(lg.b)
  b.co=0
  b.ga=0
  b.sp=0
  lk=lg.k
  l=lg.l
 end
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
 if l==5 or l==8 or l==11 or l==13 then
  start_b()
 end
end

function save_l()
 local cl=min(l,12)
 lg.b=get_bv()%2048
 lg.k=lk
 lg.l=cl
 if cl>=flr(dget(0)) then
  dset(0,cl)
  dset(1,lg.b)
  dset(2,lg.k)
 end
end
