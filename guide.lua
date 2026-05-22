function can_g()
 local p=q[q.f]
 for y=1,9 do
  for x=1,9 do
   if m[y][x].g==1 and check_m(p,x,y) then
    return true
   end
  end
 end
end

function draw_g()
 if g.s<1 then
  if b.sp>0 then
   local p=q[q.f]
   for y=1,9 do
    for x=1,9 do
     local e=empty_m(m[y][x])
     if ((p.g==139 and not e) or (p.g!=139 and e)) and check_m(p,x,y) then
      spr(11,(x+5)*8,y*8)
     end
    end
   end
  end
  return
 end
 local bl=g.a\15%2==0
 local gs=g.s
 if gs==1 then
  print("place panels",72,88,7)
  print(" with x key",72,94,7)
  if bl then
   spr(12,13*8,14*8)
  end
 elseif gs==2 then
  print("navigate with",72,88,7)
  print("arrow keys",72,94,7)
  if bl then
   spr(4,10*8,1*8)
   spr(5,10*8,9*8)
   spr(3,6*8,5*8)
   spr(6,14*8,5*8)
  end
 elseif gs==3 then
  print("next panel",72,88,7)
  print("is here",72,94,7)
  if bl then
   spr(3,4*8,3*8)
  end
 elseif gs==4 then
  print("wild matches",72,88,7)
  print("color",72,94,7)
  if bl then
   spr(11,10*8,4*8)
   spr(11,11*8,5*8)
   spr(11,9*8,5*8)
   spr(11,10*8,6*8)
  end
 elseif gs==5 then
  print("wild matches",72,88,7)
  print("color",72,94,7)
 elseif gs==6 or gs==7 or gs==8 then
  print("match color",72,88,7)
  print("or shape",72,94,7)
 elseif gs==61 then
  print("trash panel",72,88,7)
  print("with z key",72,94,7)
  if bl then
   spr(13,13*8,14*8)
  end
 elseif gs==71 then
  print("place panels",72,88,7)
  print("to recover",72,94,7)
 elseif gs==81 then
  print("finish row",72,88,7)
  print("to make space",72,94,7)
 elseif gs==9 then
  print("change all",72,88,7)
  print("panels to win",72,94,7)
 end
 if bl and gs==81 then
  local x,y=where_g()
  if x then
   spr(11,(x+5)*8,y*8)
  end
 elseif bl and (gs==5 or gs==6 or gs==61 or gs==7 or gs==71 or gs==8) then
  local p=q[q.f]
  for y=1,9 do
   for x=1,9 do
    if m[y][x].g==1 and check_m(p,x,y) then
     spr(11,(x+5)*8,y*8)
    end
   end
  end
 end
end

function fin_g()
 local x=where_g()
 return x!=nil
end

function where_g()
 local p=q[q.f]
 for y=1,9 do
  for x=1,9 do
   if m[y][x].g==1 and check_m(p,x,y) and would_m(p,x,y) then
    return x,y
   end
  end
 end
end

function init_g()
 g={a=0,k=0,s=l==1 and 1 or 0,t=0}
 if w then
  w.m=0
  w.am=0
 end
end

function put_g(r)
 if g.s<1 then return end
 if g.s==1 then
  g.s=2
  g.k=0
 elseif g.s==5 then
  g.s=6
 elseif g.s==71 then
  g.s=8
 elseif g.s==81 and r then
  g.s=9
 elseif g.s==9 then
  g.s=0
 end
end

function upd_g()
 if g.s<1 then return end
 g.a+=1
 if g.s==2 then
  if g.k>=3 then
   g.s=3
   g.t=90
   q[q.f]={a=40,c=8,g=67}
  end
 elseif g.s==3 then
  if g.t>0 then
   g.t-=1
  else
   g.s=4
  end
 elseif g.s==4 then
  if q[q.f] and q[q.f].g!=142 then
   g.s=5
  end
 elseif g.s>5 and g.s<81 and fin_g() then
  g.s=81
 elseif g.s==6 and not can_g() then
  g.s=61
 elseif g.s==7 and q.t>0 and can_g() then
  g.s=71
 end
end

function use_g()
 if g.s<1 then return false end
 if g.s==1 then
  return not btnp(5)
 elseif g.s==2 then
  if btnp(0) or btnp(1) or btnp(2) or btnp(3) then
   g.k=min(3,g.k+1)
   return false
  end
  return true
 elseif g.s==3 then
  return true
 elseif g.s==81 then
  local x,y=where_g()
  if btnp(0) then
   move_t(-1,0)
  elseif btnp(1) then
   move_t(1,0)
  elseif btnp(2) then
   move_t(0,-1)
  elseif btnp(3) then
   move_t(0,1)
  elseif btnp(5) then
   if x and t.x==x and t.y==y then
    put_p()
   end
  end
  return true
 end
 return false
end

function step_g()
 if g.s==61 then
  g.s=7
 elseif g.s==9 then
  g.s=0
 end
end
