load("stats_perc_thr.mat");
probs = 0.55:0.01:0.65;
dims = [100; 300; 1000];

for d = 1:length(dims)

    perc = meanTB(d,:);
    
    [perc_unique, ia] = unique(perc);
    prob_unique = probs(ia);  

    p_c = interp1(perc_unique, prob_unique, 0.5, 'linear');
    fprintf("Soglia stimata di percolazione per L=%d: p_c = %.4f\n", dims(d), p_c);

end