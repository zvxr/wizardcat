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

function init_q()
 q={
  f=1,
  l=0,
  s=3
 }
end

function pop_q()
 if q.f>q.l then return end
 local p=q[q.f]
 q[q.f]=nil
 q.f+=1
 return p
end
