function draw_t()
 spr(2,(t.x+5)*8,t.y*8)
end

function init_t()
 t={x=5,y=5}
end

function move_t(x,y)
 if x<0 then
  if t.x>1 then
   t.x-=1
   sfx(3)
  else
   sfx(1)
  end
 elseif x>0 then
  if t.x<9 then
   t.x+=1
   sfx(3)
  else
   sfx(1)
  end
 elseif y<0 then
  if t.y>1 then
   t.y-=1
   sfx(3)
  else
   sfx(1)
  end
 elseif y>0 then
  if t.y<9 then
   t.y+=1
   sfx(3)
  else
   sfx(1)
  end
 end
end

function point_t(mx,my)
 local x=flr(mx/8)-5
 local y=flr(my/8)
 if x<1 or x>9 or y<1 or y>9 then return end
 t.x=x
 t.y=y
 return true
end
