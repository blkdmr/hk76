function LofL = hkclass(nodeLabel, LofL, badLabel)
    %----------------------------------------------------------------------
    % Hoshen-Kopelman “class” step
    %----------------------------------------------------------------------
    
    % Make sure LofL can hold nodeLabel
    if numel(LofL) < nodeLabel
        LofL(nodeLabel) = 0;
    end
    %======================================================================
    % 1.  NO MERGE (only one neighbouring label)
    %======================================================================
    if badLabel == 0
        % --- find the true root of nodeLabel ---
        root = nodeLabel;
        while LofL(root) < 0
            root = -LofL(root);
        end
        % --- count this site at the root ---
        LofL(root) = LofL(root) + 1;
    
    %======================================================================
    % 2.  MERGE NEEDED (nodeLabel conflicts with badLabel)
    %======================================================================
    else
        % --- find true roots of BOTH labels ---
        nodeRoot = find_root(nodeLabel, LofL);
        badRoot =find_root(badLabel, LofL);         
        %--------------------------------------------------------------
        % Are they already in the same cluster?
        %--------------------------------------------------------------
        if nodeRoot == badRoot
            % just add this site once
            LofL(nodeRoot) = LofL(nodeRoot) + 1;
        
        %--------------------------------------------------------------
        % Different clusters → merge badRoot under nodeRoot
        % (you can swap the two lines if you prefer the other way round)
        %--------------------------------------------------------------
        else
            % add full size of bad cluster, plus this new site
            LofL(nodeRoot) = LofL(nodeRoot) + LofL(badRoot) + 1;

            % make badRoot and badLabel both point to nodeRoot
            LofL(badRoot)  = -nodeRoot;
            LofL(badLabel) = -nodeRoot;
        end
    end
end
