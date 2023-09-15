using Plots, DelimitedFiles
pi_vec = vec(readdlm("pi_k.txt", '\t', Float64));
it_vec = collect(1:length(pi_vec));

plot(it_vec[5000:end], pi_vec[5000:end])
