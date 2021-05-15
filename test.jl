function eval_exp(N)
    a = range(0, stop=2*pi, length=N)
    A = zeros(Complex{Float64},N,N)

    Threads.@threads for i in 1:N
    for j in 1:N
        A[i,j] = exp(100*im*(a[i]^2 + a[j]^2))
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

