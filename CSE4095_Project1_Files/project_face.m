function weights = project_face(averageface, eigenfaces, face)
    x = face - averageface;
    [ROWS COLUMNS] = size(eigenfaces);
    weights = zeros(COLUMNS, 1);
    for i = 1:COLUMNS
        weights(i, 1) = transpose(x)*eigenfaces(:,i);
    end
end