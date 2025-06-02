clc; clear; close all;

probs = 0.3:0.01:0.8; % Valori di pcol
dims = 100:100:1000;  % Taglie del reticolo
iter = 100;           % Numero di esperimenti

meanTB = zeros(length(dims), length(probs));
meanLR = zeros(length(dims), length(probs));
errTB  = zeros(length(dims), length(probs));
errLR  = zeros(length(dims), length(probs));

for d = 1:length(dims)
    L = dims(d);
    for p = 1:length(probs)
        pcol = probs(p);

        resultsTB = zeros(iter,1);
        resultsLR = zeros(iter,1);

        for n = 1:iter
            baseGrid = rand(L) <= pcol;

            [LofL, labels] = hk76(baseGrid);

            for i = 1:L
                for j = 1:L
                    if labels(i,j) ~= 0
                        labels(i,j) = find_root(labels(i,j), LofL);
                    end
                end
            end

            [TB, LR] = check_percolation(labels);
            resultsTB(n) = TB;
            resultsLR(n) = LR;
        end

        meanTB(d,p) = mean(resultsTB);
        meanLR(d,p) = mean(resultsLR);
        errTB(d,p)  = std(resultsTB)/sqrt(iter); 
        errLR(d,p)  = std(resultsLR)/sqrt(iter);
    end
end

figure; hold on; grid on;

for d = 1:length(dims)
    plot(probs, meanTB(d,:), '-o', 'DisplayName', sprintf('TB  L=%d', dims(d)), 'LineWidth', 1.5);
    %plot(probs, meanLR(d,:), '--s', 'DisplayName', sprintf('LR  L=%d', dims(d)), 'LineWidth', 1.5);
end

xlabel('Probabilità di colorazione p_{col}');
ylabel('Probabilità di percolazione P_{perc}');
title("P_{perc} vs p_{col} — TB e LR (senza barre d'errore)");
legend('Location','southeast');