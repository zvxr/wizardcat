function draw_grid(lc)
  for y=1,9 do
    for x=1,9 do
      draw_panel(lc,g[y][x],x+5,y)
    end
  end
end

function draw_panel(lc,p,x,y)
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

 if pg==3 then
  pg+=ga
 elseif pg>=64 and pg<=76 then
  pg+=ga*16
 end

 pal(5,lc)
 pal(6,p.c)
 spr(pg,x*8,y*8)
 pal()
end

function init_grid(lc)
  g={}            -- grid
  for y=1,9 do
    g[y]={}
    for x=1,9 do
      g[y][x]={
        a=40,     -- animation
        c=lc,     -- color
        g=1       -- graphic
      }
    end
  end
end

function upd_grid()
  for y=1,9 do
    for x=1,9 do
      if g[y][x].a>0 then
        g[y][x].a-=1
      end
    end
  end
end
