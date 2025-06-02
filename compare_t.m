clc;clear;close all;

p = 0.5;
dims = 1000:1000:10000;
disp(dims);
hkTime = zeros(2,length(dims));

for n = 1:length(dims)

    baseGrid = rand(dims(n)) <= p;

    tic;
    [LofL, labels] = hk76(baseGrid);

    for i = 1:dims(n)
        for j = 1:dims(n)
            if labels(i,j) ~= 0
                labels(i, j) = find_root(labels(i, j), LofL);
            end
        end
    end

    [TB, LR] = check_percolation(labels);

    hkTime(1, n) = toc;

end

for n = 1:length(dims)
    tic;
    res = naive(dims(n), p);
    hkTime(2, n) = toc;
end 


figure('Visible', 'off');
bar(dims,hkTime);
legend('hk76','naive');
saveas(gcf, 'out/compare_t.png'); 
close(gcf);