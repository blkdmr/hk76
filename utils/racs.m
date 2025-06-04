function RACS = racs(LofL) 
    % Estrai solo le taglie positive (cioè veri cluster, non alias)
    cluster_sizes = LofL(LofL > 0);
    
    % Escludi il cluster più grande (percolante)
    s_max = max(cluster_sizes);
    filtered_sizes = cluster_sizes(cluster_sizes < s_max);
    
    % Calcola n_s (numero di cluster per ogni taglia)
    [unique_sizes, ~, ic] = unique(filtered_sizes);
    n_s = accumarray(ic, 1);  % frequenza di ciascuna taglia
    
    % Numeratore e denominatore della RACS
    numerator   = sum((unique_sizes.^2) .* n_s);
    denominator = sum(unique_sizes .* n_s);
    RACS = numerator / denominator;
end