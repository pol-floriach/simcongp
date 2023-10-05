using DataFrames, DelimitedFiles, Plots
cd("/home/pol/dev/simcon")
# Llegir dades de l'euler
begin
    df = DataFrame(readdlm("harmonic_euler_001.dat"), :auto)
    t = df.x1;
    x = df.x2;
    v = df.x3;
    kin = df.x4;
    pot = df.x5;
    df = DataFrame(readdlm("harmonic_euler_01.dat"), :auto)
    t2 = df.x1;
    x2 = df.x2;
    v2 = df.x3;
    kin2 = df.x4;
    pot2 = df.x5;
    df = DataFrame(readdlm("harmonic_euler_02.dat"), :auto)
    t3 = df.x1;
    x3 = df.x2;
    v3 = df.x3;
    kin3 = df.x4;
    pot3 = df.x5;
    df = DataFrame(readdlm("predcorr.dat"), :auto)
    tpp = df.x1;
    xpp = df.x2;
    vpp = df.x3;
    kinpp = df.x4;
    potpp = df.x5;
    df = DataFrame(readdlm("verlet.dat",','), :auto)
    tv = df.x1[1:Int(round(end/5))]
    xv = df.x2[1:Int(round(end/5))]
    vv = df.x3[1:Int(round(end/5))]
end
# Funcions i paràmetres
begin
    x0 = 5e-2
    k = 2.0; m = 0.2; w = sqrt(k/m)
    # posicio i velocitat analítiques
    x_teoric(t) = @. x0*cos(w*t)
    v_teoric(t) = @. - x0 * w * sin(w*t)
    # Energies
    kin_teoric(t) = @. 0.5*m*(-x0*w*sin(w*t))^2
    pot_teoric(t) = @. 0.5*k*(x0*cos(w*t))^2
    e_tot(t) = @. kin_teoric(t) + pot_teoric(t)
    # Error
    error(tz,kinz,potz) = @. abs(e_tot(tz) - (kinz+potz))
end


# Euler plot posicions
begin
    f1 = plot(t,x, 
        label = "Δt = 0.001 s",
        ls = :dash,
        xlabel = "t (s)",
        ylabel = "x(t)",
        dpi = 600,
        )
    plot!(t2,x2, label = "Δt = 0.01 s", ls = :dashdot)
    plot!(t3,x3, label = "Δt = 0.02 s", ls = :dash)
    plot!(t,x_teoric(t), label = "Analític")
    savefig(f1, "euler_timeseries.png")
    # Euler plot energies
    colors = palette(:default)
    f2 = plot(t2,kin2,
        label = "K (euler)",
        ls = :dash, 
        xlabel = "t (s)", 
        ylabel = "Energy (J)", 
        dpi = 600,
        color = colors[1])
    plot!(t2,pot2, label = "V (euler)",ls = :dash, color = colors[2])
    plot!(t,kin_teoric(t), label = "K", color = colors[13])
    plot!(t,pot_teoric(t), label = "V", color = colors[14])
    plot!(t2,kin2.+pot2, label = "E (euler)")
    plot!(t, e_tot(t), label = "E")
    savefig(f2, "energies_euler.png")
end

# Predictor - corrector
begin
    # posicio
    f3 = plot(t,x_teoric(t), label = "Analític", xlabel = "t (s)", ylabel = "x(t)", dpi = 600)
    plot!(tpp,xpp, label = "Verlet, Δt = 0.02", ls = :dash)
    savefig(f3, "euler_pc_timeseries.png")

    # energia 
    f4 = plot(tpp,kinpp,
        label = "K (euler)",
        ls = :dash, 
        xlabel = "t (s)", 
        ylabel = "Energy (J)", 
        dpi = 600,
        color = colors[1])
    plot!(tpp,potpp, label = "V (euler)",ls = :dash, color = colors[2])
    plot!(tpp,potpp.+kinpp, label = "K + V (euler)",ls = :solid, color = colors[2])

    savefig(f4, "pc_energia.png")

    plot(tpp,error(tpp,kinpp,potpp))
end


# Error entre enrgia total

# kinv = @. 0.5*m*v_verlet[1:end-1]^2
# potv = @. 0.5*k*x_verlet[2:end]^2

kinv = @. 0.5*m*vv^2
potv = @. 0.5*k*xv^2

fig5 = plot(t,error(t,kin,pot), label = "Euler, Δt = 0.001", xlabel = "t", ylabel = "Error absolut Energia total", yscale = :log10)
plot!(t2,error(t2,kin2,pot2), label = "Euler, Δt = 0.01", ls = :dash)
plot!(t3,error(t3,kin3,pot3), label = "Euler, Δt = 0.02", ls = :dashdot)
plot!(tpp, error(tpp,kinpp,potpp), label = "Euler - pc, Δt = 0.02", ls = :dot )
# plot!(tv[2:end],error(tv[2:end],kinv,potv), label = "Verlet, Δt = 0.02", xlabel = "t", ylabel = "Error absolut Energia total")
plot!(tv[2:end],error(tv,kinv,potv)[2:end], label = "Verlet, Δt = 0.02", xlabel = "t", ylabel = "Error absolut Energia total", legend = :bottomright, ls = :dashdot)

savefig(fig5, "energies_tot.png")