function draw_g(lc)
  for y=1,9 do
    for x=1,9 do
      draw_p(lc,g[y][x],x+5,y)
    end
  end
end

function check_g(p,x,y)
 if x>1 and not check_gc(p,x-1,y) then return end
 if x<9 and not check_gc(p,x+1,y) then return end
 if y>1 and not check_gc(p,x,y-1) then return end
 if y<9 and not check_gc(p,x,y+1) then return end
 return true
end

function check_gc(p,x,y)
 local n=g[y][x]
 if n.g==1 or n.g==p.g then return true end
 if n.c==p.c then return true end
 if p.c==0 and n.c>=8 and n.c<=11 then return true end
 if n.c==0 and p.c>=8 and p.c<=11 then return true end
 if p.c==7 and n.c>=12 and n.c<=15 then return true end
 if n.c==7 and p.c>=12 and p.c<=15 then return true end
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

function put_p()
 local qp=q[q.f]
 local p=g[c.y][c.x]
 if p.g!=1 or not check_g(qp,c.x,c.y) then
  sfx(5)
  return
 end
 g[c.y][c.x]=pop_q()
 fill_q()
 sfx(4)
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
