function draw_g(lc)
  for y=1,9 do
    for x=1,9 do
      draw_p(lc,g[y][x],x+5,y)
    end
  end
end

function init_g(lc)
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

function upd_g()
  for y=1,9 do
    for x=1,9 do
      if g[y][x].a>0 then
        g[y][x].a-=1
      end
    end
  end
end
