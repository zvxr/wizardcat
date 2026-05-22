function draw_w()
 if l>=16 then
  local fg=198+(w.ab\18)%4*2
  spr(fg,88,104)
  spr(fg+1,96,104)
  spr(fg+16,88,112)
  spr(fg+17,96,112)
  spr(fg+32,88,120)
  spr(fg+33,96,120)
 end
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
 w={a=0,ab=0,ae=0,am=60,m=101,o=0,oe=0}
end

function get_wm(id)
 if id==1 then return "show next" end
 if id==2 then return "luck+" end
 if id==3 then return "rainbow" end
 if id==4 then return "trash luck" end
 if id==5 then return "recover+" end
 if id==6 then return "luck+" end
 if id==7 then return "near future" end
 if id==8 then return "remove" end
 if id==9 then return "trash luck" end
 if id==10 then return "far future" end
 if id==11 then return "luck+" end
 if id==101 then return "welcome" end
 if id==102 then return "be careful..." end
 if id==103 then return "almost there" end
 if id==104 then return "select bonus" end
 if id==201 then return "I <3 minnows" end
 if id==202 then return "magic is cool" end
 if id==203 then return "meow" end
 if id==204 then return "Luck: "..lk end
end

function put_w(id,am)
 w.m=id
 w.am=am
end

function upd_w()
 if l>=16 then
  w.ab=(w.ab+1)%72
 else
  w.ab=0
 end
 if g and g.s>0 then
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
 elseif w.m==0 and (not g or g.s<1) then
  if rnd(10000)<1 then
   put_w(201,60)
  elseif rnd(10000)<1 then
   put_w(202,60)
  elseif rnd(4000)<1 then
   put_w(203,60)
  elseif rnd(4000)<1 then
   put_w(204,60)
  end
 end
end
