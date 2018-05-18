%{
We map every image and store it as a 7200x1 vector.
%}

[ROWS, COLUMNS] = size(ARRAY);
VECTOR_ARRAY = zeros(7200,COLUMNS);
imagesize = size(ARRAY{1, 1});
for i = 1:ROWS
    VECTOR_ARRAY(:,i) = reshape(ARRAY{i, 1}, [imagesize(1)*imagesize(2)*imagesize(3), 1]);
end