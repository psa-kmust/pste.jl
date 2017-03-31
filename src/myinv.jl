function myinv(A)
    n=length(A[:,1])
    E=eye(n)
    return A\E   

end
