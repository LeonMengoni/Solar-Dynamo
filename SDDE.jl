using Random
using StochasticDelayDiffEq
using DifferentialEquations
using SpecialFunctions
using DelimitedFiles
using Plots

function solar_dynamo_f(dB, B, h, p, t) # drift function
    q, N, sigma, Bmax, tau = p
    hist1 = h(p, t - q)[1]
    
    dB[1] = B[2]
    dB[2] = - (N * f(hist1, p) + 2 * tau * B[2] + B[1]) / tau^2
end

function solar_dynamo_g(dB, B, h, p, t) # diffusion function
    q, N, sigma, Bmax, tau = p

    dB[1] = 0
    dB[2] = sigma * Bmax / tau^1.5
end

function f(B, p) # non-linear function in model 
    
    return(0.5 * (1 - erf(B^2 - Bmax^2)) * B)
end

function simulated_data(p) # Data simulator with SDDE
    q, N, sigma, Bmax, tau = p
    # (tau, N, sigma, Bmax, q) = p

    B_data = readdlm("bfield_from_sunspots.dat", ',')

    Random.seed!(1234)

    h(p, t) = [Bmax, 0.] # History # ones(2)    
    lags = [q] # Delay

    T = length(B_data)
    tspan = (0.0, T) # 100.0)
    u0 = [Bmax, 0.] # [10.0, 0.5]
    dt = 1 # 0.01

    prob = SDDEProblem(solar_dynamo_f, solar_dynamo_g, u0, h, tspan, p; constant_lags = lags)
    sol = solve(prob, EM(), dt=dt, saveat=dt) # solver: RKMil()

    times = sol.t
    simulated_B_data = sol[1,:] # sol.t

    plot(times, [simulated_B_data, B_data], xlabel="t", ylabel="B(t)")
    # # plot(sol.t, sol[1, :], xlim=(0,3250), xlabel="t", ylabel="B(t)")

    filepath = "/Users/leonm/LaboratoryOfComputationalPhysics_Y5/Mod B - Baiesi/Project/Data/" # path of data
    
    filename = "SunspotSimulatedData" * 
               "_tau" * string(tau) * 
               "_N" * string(N) * 
               "_sigma" * string(sigma) * 
               "_Bmax" * string(Bmax) * 
               "_q" * string(q) * 
               ".csv"

    # Save simulated data to file
    writedlm(filepath * filename, simulated_B_data, ",")
end