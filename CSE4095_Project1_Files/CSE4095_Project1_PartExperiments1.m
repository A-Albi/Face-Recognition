% Experiment Question 1

%{
We choose the number of eigenvectors we are looking for, K.
%}

K = 10;
[ROWS, COLUMNS] = size(ARRAY);

%{
We feed this into the eigenfaces function.
%}

[AVERAGEFACE, EIGENFACES] = eigenface(VECTOR_ARRAY, K);

EIGENFACES_NORMALIZED = EIGENFACES - min(EIGENFACES(:));
EIGENFACES_NORMALIZED = EIGENFACES_NORMALIZED ./ max(EIGENFACES_NORMALIZED(:));

SHOW_EIGENFACES = zeros(60, 40*(K+1), 3);
SHOW_EIGENFACES(:,1:40,:) = reshape(AVERAGEFACE, [60 40 3]);
for i = 1:K
    BEGIN = 40*i + 1;
    END = 40*(i + 1);
    SHOW_EIGENFACES(:,BEGIN:END, :) = reshape(EIGENFACES_NORMALIZED(:,i), [60 40 3]);
end