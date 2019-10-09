clc;
clear;
tic;

%% The initial parameters
amount_baoxiao = 62;%要报金额
invoice = [8,10,11,10,10,17,10,10,16,11,15];%每张发票金额
dim = length(invoice(:));
lu=repmat([0;1],[1,dim]);

F = 0.9;
CR = 0.9;
popsize = 30;

p = repmat(lu(1, :), popsize, 1) + rand(popsize, dim) .* (repmat(lu(2, :) - lu(1, :), popsize, 1));
FES = popsize;

% Evaluate the objective function values
    fit = benchmark_func(p, amount_baoxiao, invoice,popsize);
while FES < dim * 1000
    
    pTemp = p;
    fitTemp = fit;
    
    for i = 1 : popsize
        pTemp(i, :) = DE(p, lu, i, F, CR, popsize, dim);
        
    end
    FES = FES + popsize;
    fitTemp = benchmark_func(pTemp, amount_baoxiao, invoice,popsize);
    select = find(fitTemp < fit);
    if ~isempty(select)
        fit(select, :) = fitTemp(select, :);
        p(select, :) = pTemp(select, :);
    end
    [bset_fit,best_id] = min(fit);
    best_ind = p(best_id,:);
    if(~rem(FES, 100))
        fprintf('minfit %d\n', bset_fit);
    end
end;
best_ind = logical(round(best_ind));
res = invoice(best_ind);

fprintf('报销金额 %d\n', amount_baoxiao);
fprintf('小仙女手里的发票 %s\n',mat2str(invoice));
fprintf('小仙女要报的发票 %s\n',mat2str(res));
