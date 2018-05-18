function face_reconstruct = reconstruct_face(averageface, eigenfaces, weights)
    SUM = averageface;
    [ROWS COLUMNS] = size(weights);
    for i = 1:ROWS
        SUM = SUM + weights(i, 1)*eigenfaces(:,i);
    end
    face_reconstruct = SUM;
end