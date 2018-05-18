function [averageface, eigenfaces] = eigenface(training_set, k)
    
    %{
    We find the mean face from the training set.
    %}
    [ROWS, COLUMNS] = size(training_set);
    SUM = zeros(ROWS, 1);
    for i = 1:COLUMNS
        SUM(:,1) = SUM(:,1) + training_set(:,i);
    end
    averageface = SUM/COLUMNS;
    
    %{
    We compute the transposed term x_i - average(x) for all columns i.
    %}
    transposed_term = training_set;
    for i = 1:COLUMNS
        transposed_term(:,i) = transposed_term(:,i) - averageface;
    end
    
    %{
    We compute the covariance and find the eigenvectors. Then, we sort
    them.
    %}
    COVARIANCE = (transposed_term * transpose(transposed_term)) / COLUMNS;
    [eigenfaces, eigenvalues] = eig(COVARIANCE);
    indices = [];
    for j = 1:ROWS
        val = eigenvalues(j, j);
        indices = cat(2, indices, [val]);
    end
    [eigenvalues, indices] = sort(indices);
    indices = flip(indices);
    eigenfaces = eigenfaces(:, indices);
    eigenfaces = eigenfaces(:, 1:k);
    
end