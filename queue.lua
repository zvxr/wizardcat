function add_q(p)
 q.l+=1
 q[q.l]=p
end

function discard_q()
 pop_q()
 fill_q()
 if rnd(100)<lk*((b.mo>0 and 1 or 0)+(b.ur>0 and 1 or 0)) then
  sfx(9)
 else
  q.d+=1
  if q.d==2 then
   put_w(102,60)
  end
 end
 step_g()
 sfx(6)
end

function draw_q()
 if q.f>q.l then return end
 draw_p(0,q[q.f],2,3)
 if b.me>0 and q.f<q.l then
  draw_p(0,q[q.f+1],4,5)
 end
 if b.sa>0 and q.f+2<=q.l then
  draw_p(0,q[q.f+2],4,8)
 end
 if b.ne>0 and q.f+3<=q.l then
  draw_p(0,q[q.f+3],4,11)
 end
 if q.d==0 then
  spr(17,16,16)
 elseif q.d==1 then
  spr(19,16,16)
 elseif q.d==2 then
  spr(20,16,16)
 else
  spr(35,16,16)
  spr(36,24,16)
  spr(51,16,24)
  spr(52,24,24)
 end
end

function init_q()
 q={
  d=0,
  f=1,
  l=0,
  s=b.ne>0 and 4 or 3
 }
 if l==1 then
  add_q({a=40,c=0,g=142})
  add_q({a=40,c=8,g=67})
  add_q({a=40,c=8,g=68})
  add_q({a=40,c=14,g=73})
  return
 end
 fill_q()
end

function fill_q()
  if q.f>q.l then
    if b.ea>0 then
      add_q({a=40,c=0,g=140})
    else
      add_q(get_lfp())
    end
  end
  while q.l-q.f+1<q.s do
    if b.su>0 and rnd(100)<lk then
      add_q({a=40,c=0,g=139})
    else
      add_q(get_lp())
    end
  end
end

function pop_q()
 if q.f>q.l then return end
 local p=q[q.f]
 q[q.f]=nil
 q.f+=1
 return p
end

function upd_q()
  for i=q.f,q.l do
    if q[i].a>0 then
      q[i].a-=1
    end
  end
end
