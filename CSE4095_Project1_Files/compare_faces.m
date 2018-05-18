function mse = compare_faces(averageface, eigenfaces, face1, face2)
    weights1 = project_face(averageface, eigenfaces, face1);
    weights2 = project_face(averageface, eigenfaces, face2);
    weights_difference = weights1 - weights2;
    weights_difference_squared_sum = 0;
    for i = 1:length(weights1)
        val = weights_difference(i);
        val = val*val;
        weights_difference_squared_sum = weights_difference_squared_sum + val;
    end
    mse = weights_difference_squared_sum/length(weights1);
end