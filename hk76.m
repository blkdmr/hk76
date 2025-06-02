function [LofL, labels] = hk76(mat)

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
    
end