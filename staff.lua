function draw_s()
 local f=flr(count_mt()*28/81)
 local n

 pal(1,f>0 and get_lc() or 0)
 spr(22,16,112)
 pal()

 f-=1
 for i=0,8 do
  n=mid(0,f,3)
  if i%3==0 then
   pal(1,n>0 and get_lc() or 0)
   pal(2,n>1 and get_lc() or 0)
   pal(3,n>2 and get_lc() or 0)
   spr(56,16,104-i*8)
  elseif i%3==1 then
   pal(4,n>0 and get_lc() or 0)
   pal(1,n>1 and get_lc() or 0)
   pal(2,n>2 and get_lc() or 0)
   spr(40,16,104-i*8)
  else
    if n>2 and s.a>0 then
    pal(3,n>0 and get_lc() or 0)
    pal(4,n>1 and get_lc() or 0)
    pal(6,get_lc())
    spr(24+mid(1,flr((s.a-1)/4)+1,5),16,104-i*8)
   else
    pal(3,n>0 and get_lc() or 0)
    pal(4,n>1 and get_lc() or 0)
    pal(6,n>2 and get_lc() or 0)
    spr(24,16,104-i*8)
   end
  end
  pal()
  f-=3
 end
end

function init_s()
 s={a=0,o=0,t=0}
end

function upd_s()
 if s.a>0 then
  s.a-=1
 elseif rnd(3000)<1+s.o then
  s.a=24
  s.o=0
  return
  end
 s.o+=1

 if s.t==0 and count_mt()>=64 then
  put_w(103,60)
  s.t=1
 end
end
