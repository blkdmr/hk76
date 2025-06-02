function root = find_root(label, LofL)
    root = label;
    while LofL(root) < 0
        root = -LofL(root);
    end
end