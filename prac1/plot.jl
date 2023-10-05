using DataFrames, DelimitedFiles, CairoMakie
cd("/home/pol/dev/simcon")
df = DataFrame(readdlm("harmonic_euler_01.dat"), :auto)
t = df.x1;
x = df.x2;
v = df.x3;
kin = df.x4;
pot = df.x5;

begin
    x0 = 5e-2
    k = 2.0; m = 0.2; w = k/m
    x_teoric(t) = @. x0*cos(w*t)
    v_teoric(t) = @. - x0 * w * sin(w*t)
    kin_teoric(t) = @. 0.5*m*(-x0*w*sin(w*t))^2
    pot_teoric(t) = @. 0.5*k*(x0*cos(w*t))^2
end
# begin
f = Figure(resolution = (800,500));

ax = Axis(f[1,1], 
    xlabel = L" t(s$^{-1}$)",
    ylabel = "x(t)",
    #xscale = log10,
    # xticks = (0:50:500),
    # yticks = (0:0.01:0.05),
)
hidespines!(ax,:t, :r)

lines!(t,x, linestyle = :dash);
#lines!(t,x_teoric(t))
f

# save("simpson.png", f, px_per_unit = 2)

 



