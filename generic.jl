struct OuterProduct{T} <: AbstractMatrix{T}
     u::Vector{T}
     v::Vector{T}
end

Base.size(c::OuterProduct) = length(c.u), length(c.v)
Base.getindex(c::OuterProduct,i,j) =  c.u[i]*c.v[j]

N = 1000
u = randn(N)
v = randn(N)
A = OuterProduct(u, v)

Matrix(A)

@which  A*B

Base.:*(A::OuterProduct, B::AbstractMatrix) = A.u * (A.v' * B)

@which  A*B

Base.:*(A::AbstractMatrix, B::OuterProduct) = (A*B.u) * B.v'

@which B*A

Base.:*(A::OuterProduct, B::OuterProduct) = OuterProduct(A.u * (A.v'*B.u), B.v)
