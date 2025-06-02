function [tbPercolates, lrPercolates] = check_percolation(labels)

    [N, ~] = size(labels);

    % Unique labels on top row
    topLabels    = unique(labels(1, :));
    topLabels(topLabels == 0) = [];  % remove 0 if any

    % Unique labels on bottom row
    bottomLabels = unique(labels(N, :));
    bottomLabels(bottomLabels == 0) = [];

    % Unique labels on left column
    leftLabels   = unique(labels(:, 1));
    leftLabels(leftLabels == 0) = [];

    % Unique labels on right column
    rightLabels  = unique(labels(:, end));
    rightLabels(rightLabels == 0) = [];

    % Check if any label is in both top and bottom
    if isempty(intersect(topLabels, bottomLabels))
        tbPercolates = false;
    else
        tbPercolates = true;
    end

    % Check if any label is in both left and right
    if isempty(intersect(leftLabels, rightLabels))
        lrPercolates = false;
    else
        lrPercolates = true;
    end
end