# ybus
function ybus(bus,branch,Mbase)
#ybus(mpc["bus"],mpc["branch"],mpc["baseMVA"])
	n=length(bus[:,1]);
	nl=length(branch[:,1]);
	Y=zeros(Complex,(n,n));

	for i=1:n
		shunt=(bus[i,5]+bus[i,6]*im)./Mbase;
		Y[i,i]=Y[i,i]+shunt;
	end

	for i=1:nl
		f=UInt32(branch[i,1]);
		t=UInt32(branch[i,2]);
		z=branch[i,3]+branch[i,4]*im;

		k=branch[i,9];
		if k==0
			k=1;
		end

		b=branch[i,5]*im/2;

		Y[f,t]=Y[f,t]-1/(z*k);
		Y[t,f]=Y[f,t];

		Y[t,t]=Y[t,t]+1/(z*k^2)+b;
		Y[f,f]=Y[f,f]+1/z+b;
	end
	return Y;

end
