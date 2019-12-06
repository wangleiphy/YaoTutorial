using Yao, Yao.AD, YaoExtensions

include("faithful_grad.jl")
n = 4
d = 5
circuit = dispatch!(variational_circuit(n, d),:random)

gatecount(circuit)

h = heisenberg(n)

for i in 1:1000
      #reverse-mode
      # _, grad = expect'(h, zero_state(n) => circuit)
      #forward mode
      grad = my_faithful_grad(h, zero_state(n) => circuit; nshots=100)

      dispatch!(-, circuit, 1e-2 * grad)
      println("Step $i, energy = $(real.(expect(h, zero_state(n)=>circuit)))")
end

using LinearAlgebra
w, _ = eigen(Matrix(mat(h)))
