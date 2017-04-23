#run_series.jl  functions
include("ybus.jl")
function run_sc(psc,opt)
  Ybus=ybus(psc["bus"],psc["branch"],psc["baseMVA"])
  Zbus=inv(Ybus)

  if opt["sc.type"]==1
    k=opt["sc.bus"]
    I=1/(Zbus[k,k]+opt["sc.zf"])
  end


  return I
  
end
