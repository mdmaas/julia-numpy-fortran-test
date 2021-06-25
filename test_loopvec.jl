using LoopVectorization: @tvectorize

function eval_exp_tvectorize(N)
    a = range(0, stop=2*pi, length=N)
    A = Matrix{ComplexF64}(undef, N, N)

    _A = reinterpret(reshape, Float64, A)
    @tvectorize for j in 1:N, i in 1:N
        x = sqrt(a[i]^2 + a[j]^2)
        prefac = exp(-x)
        s, c = sincos(100*x)

        _A[1,i,j] = prefac * c
        _A[2,i,j] = prefac * s
    end
    return A
end

eval_exp_tvectorize(5)
print(string("running loop on ", Threads.nthreads(), " threads \n"))
for N in 1000:1000:10000
    @time begin
    A = eval_exp_tvectorize(N)
    end
end

