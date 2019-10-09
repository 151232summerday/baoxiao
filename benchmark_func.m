function[fit] = benchmark_func(p, amount_baoxiao, invoice,popsize)
   invoice_pop = repmat(invoice,popsize,1);
   baoxiao_pop = repmat(amount_baoxiao,popsize,1);
   p_mask = round(p);
   invoice_pop = invoice_pop .* p_mask;
   amount_pop=sum(invoice_pop,2);
   penalty = amount_pop < baoxiao_pop;
   penalty = penalty * 10000;
   fit = amount_pop + penalty;
end