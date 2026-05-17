function draw_lv()
 print("level: "..lv,8,8,7)
end

function get_lc()
  return lv%4+1
end

function init_game()
  lk=1+flr(rnd(3))
  lv=4    -- level
  sc=0    -- score
end

function next_lv()
 lv+=1
 sfx(8)
 init_m()
 init_q()
 init_s()
 init_t()
end

function upd_input()
 if q.d>=3 then return end
 if btnp(0) then
  if t.x>1 then
   t.x-=1
   sfx(3)
  else
   sfx(1)
  end
 elseif btnp(1) then
  if t.x<9 then
   t.x+=1
   sfx(3)
  else
   sfx(1)
  end
 elseif btnp(2) then
  if t.y>1 then
   t.y-=1
   sfx(3)
  else
   sfx(1)
  end
 elseif btnp(3) then
  if t.y<9 then
   t.y+=1
   sfx(3)
  else
   sfx(1)
  end
 elseif btnp(4) then
  discard_q()
 elseif btnp(5) then
  put_p()
 end
end
