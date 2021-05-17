function eval_exp(N)
    a = range(0, stop=2*pi, length=N)
    A = Matrix{ComplexF64}(undef, N, N)

    @inbounds Threads.@threads for j in 1:N
    for i in 1:N
        A[i,j] = exp((100+im)*im*sqrt(a[i]^2 + a[j]^2))
    end
    end
    
    return A

end

eval_exp(5)
print(string("running loop on ", Threads.nthreads(), " threads \n"))
for N in 1000:1000:10000
    @time begin
    A = eval_exp(N)
    end
end

