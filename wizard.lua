function draw_w()
 if w.a<0 then
  spr(132,72,96)
  spr(148,72,104)
 elseif w.a>0 then
  spr(133,72,96)
  spr(149,72,104)
 else
  spr(131,72,96)
  spr(147,72,104)
 end
 if w.ae>0 then
  spr(164,56,104)
 else
  spr(145,56,104)
 end
 if w.m>0 then
  print(get_wm(w.m),72,88,7)
 end
end

function draw_wm()
 if w.a<0 then
  spr(132,40,96)
  spr(148,40,104)
 elseif w.a>0 then
  spr(133,40,96)
  spr(149,40,104)
 else
  spr(131,40,96)
  spr(147,40,104)
 end
 if w.ae>0 then
  spr(164,24,104)
 else
  spr(145,24,104)
 end
 if w.m>0 then
  print(get_wm(w.m),40,88,7)
 end
end

function init_w()
 w={a=0,ae=0,am=60,m=101,o=0,oe=0}
end

function get_wm(m)
 if m==101 then return "welcome" end
 if m==102 then return "be careful..." end
 if m==103 then return "almost there" end
 if m==104 then return "select bonus" end
 if m==105 then return "show next" end
 if m==106 then return "luck+" end
 if m==107 then return "rainbow" end
 if m==108 then return "discard+" end
 if m==109 then return "recover+" end
 if m==110 then return "luck+" end
 if m==111 then return "near future" end
 if m==112 then return "remove" end
 if m==113 then return "discard+" end
 if m==114 then return "far future" end
 if m==115 then return "luck+" end
 if m==201 then return "I <3 minnows" end
 if m==202 then return "magic is cool" end
 if m==203 then return "meow" end
end

function put_w(m,am)
 w.m=m
 w.am=am
end

function upd_w()
 if i and i.s>0 then
  w.m=0
  w.am=0
 end
 if w.a<0 then
  w.a+=1
 elseif w.a>0 then
  w.a-=1
 elseif rnd(5000)<1+w.o then
  w.a=rnd(2)<1 and -55 or 55
  w.o=0
  return
 end
 w.o+=1

 if w.ae>0 then
  w.ae-=1
 elseif rnd(10000)<1+w.oe then
  w.ae=24
  w.oe=0
  return
 end
 w.oe+=1

 if w.am>0 then
  w.am-=1
  if w.am==0 then
   w.m=0
  end
 elseif w.m==0 and (not i or i.s<1) then
  if rnd(10000)<1 then
   put_w(201,60)
  elseif rnd(10000)<1 then
   put_w(202,60)
  elseif rnd(4000)<1 then
   put_w(203,60)
  end
 end
end
