function can_i()
 local p=q[q.f]
 if not p then return end
 for y=1,9 do
  for x=1,9 do
   if p.g==139 then
    if not empty_m(m[y][x]) and check_m(p,x,y) then return true end
   elseif empty_m(m[y][x]) and check_m(p,x,y) then
    return true
   end
  end
 end
end

function draw_i()
 local b=flr(i.a/15)%2==0
 if i.s==1 then
  print("place panels",72,88,7)
  print("with x key",72,94,7)
 elseif i.s==2 then
  print("navigate with",72,88,7)
  print("arrow keys",72,94,7)
  if b then
   spr(4,80,8)
   spr(5,80,72)
   spr(3,48,40)
   spr(6,112,40)
  end
 elseif i.s==3 then
  print("next panel",72,88,7)
  print("is here",72,94,7)
  if b then
   spr(3,32,24)
  end
 elseif i.s==4 then
  print("wild matches",72,88,7)
  print("color",72,94,7)
  if b then
   spr(11,80,32)
   spr(11,88,40)
   spr(11,72,40)
   spr(11,80,48)
  end
 elseif i.s==5 then
  print("others match",72,88,7)
  print("color or shape",72,94,7)
 elseif i.s==61 then
  print("discard",72,88,7)
  print("with z key",72,94,7)
 elseif i.s==71 then
  print("recover by",72,88,7)
  print("placing panels",72,94,7)
 elseif i.s==81 then
  print("finish row",72,88,7)
  print("to make space",72,94,7)
 elseif i.s==9 then
  print("change all",72,88,7)
  print("panels to win",72,94,7)
 end
 if i.s==5 or i.s==6 or i.s==61 or i.s==7 or i.s==71 or i.s==8 or i.s==81 then
  if b then
   for y=1,9 do
    for x=1,9 do
     if empty_m(m[y][x]) and check_m(q[q.f],x,y) then
      spr(11,(x+5)*8,y*8)
     end
    end
   end
  end
 end
end

function fin_i()
 local p=q[q.f]
 if not p then return end
 for y=1,9 do
  for x=1,9 do
   if empty_m(m[y][x]) and check_m(p,x,y) then
    local n=0
    for j=1,9 do
     if empty_m(m[y][j]) then n+=1 end
    end
    if n==1 then return true end
   end
  end
 end
end

function init_i()
 i={a=0,k=0,s=lv==1 and 1 or 0,t=0}
 if i.s>0 then
  put_w(0,0)
 end
end

function put_i(r)
 if i.s==1 then
  i.k=0
  i.s=2
 elseif i.s==4 then
  i.s=5
 elseif i.s==5 then
  i.s=6
 elseif i.s==71 then
  i.s=8
 elseif i.s==81 and r then
  i.s=9
 elseif i.s==9 then
  i.s=0
 end
end

function upd_i()
 if i.s<1 then return end
 i.a=(i.a+1)%30
 if i.s==2 and i.k>2 then
  i.s=3
  i.t=90
  q[q.f]={a=40,c=8,g=67}
 elseif i.s==3 then
  i.t-=1
  if i.t<1 then
   i.s=4
  end
 elseif i.s>5 and i.s<81 and fin_i() then
  i.s=81
 elseif i.s==6 and not can_i() then
  i.s=61
 elseif i.s==7 and q.d>0 and can_i() then
  i.s=71
 end
end

function use_i()
 if i.s<1 then return end
 if i.s==1 then
  if btnp(5) then put_p() end
  return true
 elseif i.s==2 then
  if btnp(0) then
   move_t(-1,0)
   i.k+=1
  elseif btnp(1) then
   move_t(1,0)
   i.k+=1
  elseif btnp(2) then
   move_t(0,-1)
   i.k+=1
  elseif btnp(3) then
   move_t(0,1)
   i.k+=1
  end
  return true
 elseif i.s==3 then
  if btnp(0) then
   move_t(-1,0)
  elseif btnp(1) then
   move_t(1,0)
  elseif btnp(2) then
   move_t(0,-1)
  elseif btnp(3) then
   move_t(0,1)
  end
  return true
 end
end

function z_i()
 if i.s==61 then
  i.s=7
 elseif i.s==9 then
  i.s=0
 end
end
