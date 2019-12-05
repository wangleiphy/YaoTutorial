using Yao, Yao.AD, YaoExtensions

n = 4
d = 10
circuit = dispatch!(variational_circuit(n, d),:random)

gatecount(circuit)

h = heisenberg(n)

for i in 1:100
      _, grad = expect'(h, zero_state(n) => circuit)
      dispatch!(-, circuit, 1e-2 * grad)
      println("Step $i, energy = $(real.(expect(h, zero_state(n)=>circuit)))")
end

using LinearAlgebra
w, _ = eigen(Matrix(mat(h)))
