struct OuterProduct{T, V<:AbstractVector{T}} <: AbstractMatrix{T}
     u::V
     v::V
end

Base.size(c::OuterProduct) = length(c.u), length(c.v)
Base.getindex(c::OuterProduct,i,j) =  c.u[i]*c.v[j]

N = 1000
u = randn(N)
v = randn(N)
A = OuterProduct(u, v)

Matrix(A)
B = randn(N, N)

using BenchmarkTools
@btime A*B;

@which  A*B

Base.:*(A::OuterProduct, B::AbstractMatrix) = A.u * (A.v' * B)

@which A*B

Base.:*(A::AbstractMatrix, B::OuterProduct) = (A*B.u) * B.v'

@which B*A

Base.:*(A::OuterProduct, B::OuterProduct) = OuterProduct(A.u * (A.v'*B.u), B.v)

using CuArrays
A_cuda = OuterProduct(CuArray(u), CuArray(v))
B_cuda = CuArray(B)

@btime A_cuda * B_cuda
