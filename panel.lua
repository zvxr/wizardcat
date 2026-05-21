function draw_p(lc,p,x,y)
 local pg=p.g
 local ga=0

 if p.a>=10 then
  ga=mid(0,flr(p.a/10)-1,3)
 end

 if pg==1 then
  if ga>0 then
   pg=7+ga
  end
  spr(pg,x*8,y*8)
  return
 end

 if pg>=112 and pg<=127 or pg>=188 and pg<=191 then
  if p.a>0 then
   pg-=ga*16
  else
   pg=1
  end
  pal(5,lc)
  pal(6,p.c)
  spr(pg,x*8,y*8)
  pal()
  return
 end

 if pg>=64 then
  pg+=ga*16
 end

 pal(5,lc)
 pal(6,p.c)
 spr(pg,x*8,y*8)
 pal()
end

function get_lfp()
 if l<6 then
  return {a=40,c=0,g=142}
 end
 return {a=40,c=0,g=141+flr(rnd(l<10 and 2 or 3))}
end

function get_lp()
 if rnd(100)<lk then
  return get_lfp()
 end
 local cn=min(8,4+flr(l/3))
 local gn=min(16,3+l-flr(l/3))
 return {
  a=40,
  c=8+flr(rnd(cn)),
  g=64+flr(rnd(gn))
 }
end
