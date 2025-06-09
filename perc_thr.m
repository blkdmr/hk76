clc; clear; close all;

tic

probs = 0.55:0.01:0.65; % Valori di pcol
dims = [100; 300; 1000];  % Taglie del reticolo
iter = 50;           % Numero di esperimenti

P1 = zeros(length(dims), length(probs));
P2 = zeros(length(dims), length(probs));
P3 = zeros(length(dims), length(probs));
RACS = zeros(length(dims), length(probs));

meanTB = zeros(length(dims), length(probs));
meanLR = zeros(length(dims), length(probs));
errTB  = zeros(length(dims), length(probs));
errLR  = zeros(length(dims), length(probs));

for d = 1:length(dims)
    L = dims(d);

    for p = 1:length(probs)
                
        pcol = probs(p);
        
        partialP1 = zeros(iter,1);
        partialP2 = zeros(iter,1);
        partialP3 = zeros(iter,1);
        partialRACS = zeros(iter,1);

        partialTB = zeros(iter,1);
        partialLR = zeros(iter,1);

        for n = 1:iter

            fprintf("[Iteration %d] p: %.2f - d:%d\n", n, probs(p), dims(d))
            baseGrid = rand(L) <= pcol;

            [TB, LR, LofL, labels] = hk76(baseGrid);
            
            s_max = max(LofL); % max rank cluster 
            c_sites = sum(LofL(LofL > 0)); % total colored sites
            
            partialP1(n) = s_max / (L^2);
            partialP2(n) = s_max / (pcol*L^2);
            partialP3(n) = s_max / c_sites;
            partialRACS(n) = racs(LofL);
            
            partialTB(n) = TB;
            partialLR(n) = LR;
        end
        
        P1(d,p) = mean(partialP1);
        P2(d,p) = mean(partialP2);
        P3(d,p) = mean(partialP3);
        RACS(d,p) = mean(partialRACS);

        meanTB(d,p) = mean(partialTB);
        meanLR(d,p) = mean(partialLR);
        errTB(d,p)  = std(partialTB)/sqrt(iter); 
        errLR(d,p)  = std(partialLR)/sqrt(iter);
    end
end

figure('Visible', 'off'); hold on; grid on;

for d = 1:length(dims)
    %plot(probs, meanTB(d,:), '-o', 'DisplayName', ...
    %    sprintf('TB  L=%d', dims(d)), 'LineWidth', 1.5);
    
    errorbar(probs, meanTB(d,:), errTB(d,:), '-o', ...
        'DisplayName', sprintf('TB  L=%d', dims(d)), ...
        'LineWidth', 1.5);
end

xlabel('Probabilità di colorazione p_{col}');
ylabel('Probabilità di percolazione P_{perc}');
legend('Location','southeast');
saveas(gcf, 'out/perc_thr.png'); 
close(gcf);

save("env/stats_perc_thr","P1", "P2", "P3", "RACS", "meanTB","meanLR", "errTB","errLR");

toc