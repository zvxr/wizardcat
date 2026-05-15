function draw_m(lc)
  for y=1,9 do
    for x=1,9 do
      draw_p(lc,m[y][x],x+5,y)
    end
  end
end

function empty_m(p)
 return p.g==1 or p.g>=112 and p.g<=127 or p.g>=190 and p.g<=191
end

function check_m(p,x,y)
 local n=false
 if x>1 then
  if not empty_m(m[y][x-1]) then n=true end
  if not check_mc(p,x-1,y) then return end
 end
 if x<9 then
  if not empty_m(m[y][x+1]) then n=true end
  if not check_mc(p,x+1,y) then return end
 end
 if y>1 then
  if not empty_m(m[y-1][x]) then n=true end
  if not check_mc(p,x,y-1) then return end
 end
 if y<9 then
  if not empty_m(m[y+1][x]) then n=true end
  if not check_mc(p,x,y+1) then return end
 end
 if not n and p.c!=0 and p.c!=7 then return end
 return true
end

function check_mc(p,x,y)
 local n=m[y][x]
 if empty_m(n) or n.g==p.g then return true end
 if n.c==p.c then return true end
 if p.c==0 and n.c>=8 and n.c<=11 then return true end
 if n.c==0 and p.c>=8 and p.c<=11 then return true end
 if p.c==7 and n.c>=12 and n.c<=15 then return true end
 if n.c==7 and p.c>=12 and p.c<=15 then return true end
end

function init_m(lc)
  m={}            -- matrix
  for y=1,9 do
    m[y]={}
    for x=1,9 do
      m[y][x]={
        a=40,     -- animation
        c=lc,     -- color
        g=1       -- graphic
      }
    end
  end
end

function put_p()
 local qp=q[q.f]
 if not empty_m(m[t.y][t.x]) or not check_m(qp,t.x,t.y) then
  sfx(5)
  return
 end
 m[t.y][t.x]=pop_q()
 local fy=true
 local fx=true
 for x=1,9 do
  if empty_m(m[t.y][x]) then
   fy=false
   break
  end
 end
 for y=1,9 do
  if empty_m(m[y][t.x]) then
   fx=false
   break
  end
 end
 if fy then
  for x=1,9 do
   m[t.y][x].g+=48
   m[t.y][x].a=40
  end
 end
 if fx then
  for y=1,9 do
   if not fy or y!=t.y then
    m[y][t.x].g+=48
    m[y][t.x].a=40
   end
  end
 end
 if q.d>0 then
  q.d-=1
 end
 fill_q()
 if fy or fx then
  sfx(7)
 end
 sfx(4)
end

function upd_m()
  for y=1,9 do
    for x=1,9 do
      if m[y][x].a>0 then
        m[y][x].a-=1
      end
    end
  end
end
