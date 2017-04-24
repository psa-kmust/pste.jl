function PsteOption()
  opt=Dict{AbstractString,Any}()
  #pf
  opt["pf.alg"]=1  #1--nl,2--pq

  #sc
  opt["sc.bus"]=3
  opt["sc.type"]=1  #1--ABC，2--AG，3--BC, 4--BCG
  opt["sc.zf"]=0
  #tsa

  return opt
end
