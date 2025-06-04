load("stats_perc_thr.mat");
probs = 0.55:0.01:0.65;
dims = [100; 300; 1000];

figure; hold on; grid on;
colors = lines(length(dims));  % palette colori distinta per ogni L

for d = 1:length(dims)

    perc = meanTB(d,:);  % curva di percolazione TB per dimensione d
    
    % Rimuovi duplicati
    [perc_unique, ia] = unique(perc);
    prob_unique = probs(ia);

    % Interpolazione spline
    if length(perc_unique) >= 2
        p_c = interp1(perc_unique, prob_unique, 0.5, 'linear');
        fprintf("Soglia stimata di percolazione (spline) per L=%d: p_c = %.4f\n", dims(d), p_c);

        % Plot curva
        plot(probs, perc, '-o', 'DisplayName', sprintf('L=%d', dims(d)), ...
            'Color', colors(d,:), 'LineWidth', 1.5);

        % Punto rosso sulla soglia stimata
        plot(p_c, 0.5, 'ro',  'DisplayName', sprintf('p_{c} = %.3f', p_c) , ...
            'MarkerSize', 8, 'MarkerFaceColor',  colors(d,:));

    else
        fprintf("Dati insufficienti per stimare p_c per L=%d\n", dims(d));
    end

end

xlabel('Probabilità di colorazione p_{col}');
ylabel('Probabilità di percolazione P_{perc}');
title('Stima della soglia di percolazione');
legend('Location','southeast');
xlim([min(probs), max(probs)]);
ylim([0 1]);

saveas(gcf, 'out/percolation_threshold.png');