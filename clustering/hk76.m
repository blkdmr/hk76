function [TB, LR, LofL, labels] = hk76(mat)

    LofL = 0;

    N = size(mat,2);
    labels = zeros(N,N);
   
    lastLabel = 0;
    if mat(1,1) ~=0
        lastLabel = 1;
        labels(1,1) = lastLabel;
        LofL = hkclass(lastLabel, LofL, 0);
    end

    for i = 1:N % row
        for j = 1:N % cols
            
            if mat(i,j) ~= 0 % if site is colored
                badLabel = 0;

                % default case
                if i ~= 1 && j ~= 1 
                    left = labels(i,j-1);
                    up = labels(i-1, j);
                    

                    if left == 0 && up == 0 % no nearby clusters
                        lastLabel = lastLabel + 1;
                        nodeLabel = lastLabel;
                       
                    elseif left ~= 0 && up == 0 % left case
                        nodeLabel = left;

                    elseif left == 0 && up ~= 0 % up case
                        nodeLabel = up;
                        
                    elseif left ~= 0 && up ~= 0 && up == left % up and left case. NOT A BAD LABEL!
                         nodeLabel = left;

                    else % up and left case. BAD LABEL!
                        nodeLabel = min(up, left); 
                        badLabel = max(up, left);
                    end
                    LofL = hkclass(nodeLabel, LofL, badLabel);
                    labels(i,j) = nodeLabel;

                end
    
                if i == 1 && j ~= 1 % first row (only left case)
                    left = labels(i,j-1);
                    
                    if left == 0 
                        lastLabel = lastLabel + 1;
                        nodeLabel = lastLabel;
                    else
                        nodeLabel = left;
                    end

                    LofL = hkclass(nodeLabel, LofL, badLabel);
                    labels(i,j) = nodeLabel;
                end
                
                if i ~= 1 && j == 1 % first col (only up case)
    
                    up = labels(i-1, j);
    
                    if up == 0
                        lastLabel = lastLabel + 1;
                        nodeLabel = lastLabel;
                    else
                        nodeLabel = up;
                    end

                    LofL = hkclass(nodeLabel, LofL, badLabel);
                    labels(i,j) = nodeLabel;
                end
            end
        end
    end

    % Relabel first and last rows
    for i = 1:N
        if labels(1,i) ~= 0
            labels(1,i) = find_root(labels(1,i), LofL);
        end
        if labels(N,i) ~= 0
            labels(N,i) = find_root(labels(N,i), LofL);
        end
    end


    % Relabel first and last columns (excluding corners to avoid duplication)
    for i = 2:N-1
        if labels(i,1) ~= 0
            labels(i,1) = find_root(labels(i,1), LofL);
        end
        if labels(i,N) ~= 0
            labels(i,N) = find_root(labels(i,N), LofL);
        end
    end

    [TB, LR] = check_percolation(labels);

end