using Yao
using KrylovKit: eigsolve

hij(n, i) = sum([repeat(n, σ, (i, i+1)) for σ in (X, Y, Z)])
build_h(n) = sum([hij(n, i) for i in 1:n-1])

h = build_h(4)
Matrix(h)
w, v = eigsolve(mat(h), 1, :SR, ishermitian=true)

te = time_evolve(cache(h), 1.0)

s = product_state(bit"0101")
s |> te

s |> te'

Matrix(te)
Matrix(te*te')

parameters(te)
dispatch!(te, 2.0)
