include("pste.jl")

#pste.t_pste()
psc=pste.CaseIEEE9()
opt=pste.PsteOption()
Ybus=pste.ybus(psc["bus"],psc["branch"],psc["baseMVA"])
Zbus=pste.myinv(Ybus)
