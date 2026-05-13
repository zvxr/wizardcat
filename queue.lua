function add_q(p)
 q.l+=1
 q[q.l]=p
end

function clear_q()
 local l=q.l
 for i=q.f,l do
  q[i]=nil
 end
 q.f=1
 q.l=0
end

function draw_q()
 if q.f>q.l then return end
 draw_p(0,q[q.f],2,3)
end

function init_q()
 q={
  f=1,
  l=0,
  s=3
 }
 fill_q()
end

function fill_q()
  if q.f>q.l then
    add_q(get_lfp())
  end
  for i=q.l-q.f+2,q.s do
    add_q(get_lp())
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

