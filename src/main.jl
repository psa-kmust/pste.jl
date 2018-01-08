include("pste.jl")


#psc=pste.CaseIEEE9()
psc=pste.CaseMorden5()

PQ, PV, REF, NONE, BUS_I, BUS_TYPE, PD, QD, GS, BS, BUS_AREA, VM, VA, BASE_KV, ZONE,
VMAX, VMIN, LAM_P, LAM_Q, MU_VMAX, MU_VMIN=pste.idx_bus();
GEN_BUS, PG, QG, QMAX, QMIN, VG, MBASE, GEN_STATUS, PMAX, PMIN, MU_PMAX, MU_PMIN, MU_QMAX, MU_QMIN,PC1, PC2, QC1MIN, QC1MAX,QC2MIN, QC2MAX, RAMP_AGC, RAMP_10, RAMP_30, RAMP_Q, APF=pste.idx_gen();
F_BUS, T_BUS, BR_R, BR_X, BR_B, RATE_A, RATE_B,RATE_C, TAP, SHIFT, BR_STATUS, PF, QF, PT, QT, MU_SF, MU_ST, ANGMIN, ANGMAX, MU_ANGMIN, MU_ANGMAX=pste.idx_brch();

bus,branch,gen,baseMVA=pste.Dict2Array(psc)

#print(bus[:,BUS_TYPE])

opt=pste.PsteOption()
Ybus=pste.ybus(bus,branch,baseMVA)
print(Ybus)
#Zbus=pste.myinv(Ybus)
#print(Zbus)
