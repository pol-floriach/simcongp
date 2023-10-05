using DataFrames, DelimitedFiles, GLMakie

df = DataFrame(readdlm("pi_k.dat"), :auto)

pis = df.x1;
its = eachindex(df.x1);

f = Figure()

ax = Axis(f[1,1], xlabel = "Number of iterations", ylabel = "π approximation")

f
