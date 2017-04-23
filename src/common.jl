#common.jl
#some common functions

###########
function myinv(ybus)
  n=length(ybus[:,1])
  E=eye(n)
  return ybus\E
end
########
