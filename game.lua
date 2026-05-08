function draw_cursor()
 spr(2,(c.x+5)*8,c.y*8)
end

function get_lc()
  return lv%4+1
end

function init_game()
  lv=1    -- level
  cr=0    -- cracks
  sc=0    -- score
  c={     -- cursor
    x=5,  -- x coord
    y=5   -- y coord
  }
  q={     -- queue
    f=1,  -- first
    l=0,  -- last
    s=3,  -- size
  }
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
 end
end
