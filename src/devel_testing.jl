include("/home/arch/GitHub/BoundaryValueDiffEq.jl/src/BoundaryValueDiffEq.jl")
import BoundaryValueDiffEq:BVPSystem, eval_fun!, Φ!, MIRK_scheme
using GR
# Testing function for development, please ignore.
function func!(x, y, out)
    out[1] = y[2]
    out[2] = -y[1]
end

function boundary!(residual, ua, ub)
    residual[1, 1] = ua[1]-5
    residual[1, end] = ub[1]
end

n=50
y = vcat(collect(linspace(5,0,n))', zeros(n)')
S = BVPSystem(func!, boundary!, collect(linspace(0,5,n)),
              y, 4)

eval_fun!(S)
Φ!(S)
display(S.residual)
MIRK_scheme(S)
display(S.y)
plot(S.x, S.y[1, :])
