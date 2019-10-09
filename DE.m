function U = DE(p, lu, i, F, CR, popsize, n)

    % Choose the indices for mutation
    indexSet = 1 : popsize;
    indexSet(i) = [];

    % Choose the first Index
    temp = floor(rand * (popsize - 1)) + 1;
    index(1) = indexSet(temp);
    indexSet(temp) = [];

    % Choose the second index
    temp = floor(rand * (popsize - 2)) + 1;
    index(2) = indexSet(temp);
    indexSet(temp) = [];

    % Choose the third index
    temp = floor(rand * (popsize - 3)) + 1;
    index(3) = indexSet(temp);

    % Mutation
    V = p(index(1), :) + F .* (p(index(2), :) - p(index(3), :));
    
    % Handle the elements of the vector which violate the boundary
    vioLow = find(V < lu(1, : ));
    V(1, vioLow) = lu(1, vioLow);
        
    vioUpper = find(V > lu(2, : ));
    V(1, vioUpper) =  lu(2, vioUpper);
    
    % Implement the binomial crossover
    jRand = floor(rand * n) + 1;
    t = rand(1, n) < CR;
    t(1, jRand) = 1;
    t_ = 1 - t;
    U = t .* V + t_ .* p(i,  : );
end





