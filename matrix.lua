function draw_m(lc)
  for y=1,9 do
    for x=1,9 do
      draw_p(lc,m[y][x],x+5,y)
    end
  end
end

function empty_m(p)
 return p.g==1 or p.g>=112 and p.g<=127 or p.g>=188 and p.g<=191
end

function check_m(p,x,y)
 if p.g==139 then
  return not empty_m(m[y][x])
 end
 if p.g==207 then
  return true
 end
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
 if not n and (p.c!=0 or count_mt()>0) then return end
 return true
end

function check_mt()
 for y=1,9 do
  for x=1,9 do
   if m[y][x].g==1 then return end
  end
 end
 return true
end

function check_mc(p,x,y)
 local n=m[y][x]
 if empty_m(n) then return true end
 if p.g==140 or n.g==140 or p.g==207 or n.g==207 then return true end
 if n.g==p.g then return true end
 if p.c==0 then
  if p.g==141 then
   if n.c>=10 and n.c<=13 or n.c==0 then return true end
  elseif p.g==142 or p.g==190 then
   if n.c>=8 and n.c<=11 or n.c==0 then return true end
  elseif p.g==143 or p.g==191 then
   if n.c>=12 and n.c<=15 or n.c==0 then return true end
  end
  return
 end
 if n.c==0 then
  if n.g==141 then
   if p.c>=10 and p.c<=13 then return true end
  elseif n.g==142 or n.g==190 then
   if p.c>=8 and p.c<=11 then return true end
  elseif n.g==143 or n.g==191 then
   if p.c>=12 and p.c<=15 then return true end
  end
  return
 end
 if n.c==p.c then return true end
end

function init_m()
  local lc=get_lc()
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

function count_mt()
 local n=0
 for y=1,9 do
  for x=1,9 do
   if m[y][x].g!=1 then
    n+=1
   end
  end
 end
 return n
end

function would_m(p,x,y)
 local fy=true
 local fx=true
 for i=1,9 do
  if i!=x and empty_m(m[y][i]) then
   fy=false
   break
  end
 end
 for i=1,9 do
  if i!=y and empty_m(m[i][x]) then
   fx=false
   break
  end
 end
 return fy or fx
end

function put_p()
 local qp=q[q.f]
 if qp.g==139 then
  if not check_m(qp,t.x,t.y) then
   sfx(5)
   return
  end
  if m[t.y][t.x].g==207 then
   m[t.y][t.x]={a=40,c=get_lc(),g=1}
  else
   m[t.y][t.x].g+=48
   m[t.y][t.x].a=40
  end
  pop_q()
  if q.t>-1 then
   q.t=max(0,q.t-(b.ma>0 and 2 or 1))
  end
  sfx(4)
  if check_mt() then
   put_l()
   return
  end
 put_g()
  fill_q()
  return
 end
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
   if m[t.y][x].g!=207 then
    m[t.y][x].g+=48
    m[t.y][x].a=40
   end
  end
 end
 if fx then
  for y=1,9 do
   if (not fy or y!=t.y) and m[y][t.x].g!=207 then
    m[y][t.x].g+=48
    m[y][t.x].a=40
   end
  end
 end
 if q.t>-1 then
  q.t=max(0,q.t-(b.ma>0 and 2 or 1))
 end
 if fy or fx then
  sfx(7)
 end
 sfx(4)
 if check_mt() then
   put_l()
  return
 end
 put_g(fy or fx)
 fill_q()
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
