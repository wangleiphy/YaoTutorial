using YaoExtensions: get_diffblocks, _perturb
using StatsBase

function _expect(op::AbstractBlock, reg::ArrayReg; nshots=nothing)
    if nshots === nothing
        expect(op, reg)
    else
        mean(measure(op, copy(reg); nshots=nshots))
    end
end

@inline function my_faithful_grad(op::AbstractBlock, pair::Pair{<:ArrayReg, <:AbstractBlock}; nshots=nothing)
    map(get_diffblocks(pair.second)) do diffblock
        r1, r2 = _perturb(()->_expect(op, copy(pair.first) |> pair.second; nshots=nshots) |> real, diffblock, π/2)
        (r2 - r1)/2
    end
end
