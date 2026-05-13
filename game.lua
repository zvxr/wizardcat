function get_lc()
  return lv%4+1
end

function init_game()
  lv=1    -- level
  cr=0    -- cracks
  sc=0    -- score
end

function upd_input()
 if btnp(0) then
  if c.x>1 then
   c.x-=1
   sfx(3)
  else
   sfx(1)
  end
 elseif btnp(1) then
  if c.x<9 then
   c.x+=1
   sfx(3)
  else
   sfx(1)
  end
 elseif btnp(2) then
  if c.y>1 then
   c.y-=1
   sfx(3)
  else
   sfx(1)
  end
 elseif btnp(3) then
  if c.y<9 then
   c.y+=1
   sfx(3)
  else
   sfx(1)
  end
 elseif btnp(5) then
  put_p()
 end
end
