include("pste.jl")

#pste.t_pste()
psc=pste.CaseIEEE9()
Ybus=pste.ybus(psc["bus"],psc["branch"],psc["baseMVA"])
