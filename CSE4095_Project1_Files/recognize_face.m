function [order, best_matched_face] = recognize_face(averageface, eigenfaces, weights, face)
    [K NUM_USERS] = size(weights);
    
    RECONSTRUCTED_FACES = zeros(7200, NUM_USERS);
    MSES = zeros(NUM_USERS, 1);
    for i = 1:NUM_USERS
        RECONSTRUCTED_FACES(:,i) = reconstruct_face(averageface, eigenfaces, weights(:, i));
        val = compare_faces(averageface, eigenfaces, face, RECONSTRUCTED_FACES(:,i));
        MSES(i,1) = val;
    end
    [SORTED_MSES, INDICES] = sort(MSES);
    order = INDICES;
    best_matched_face = RECONSTRUCTED_FACES(:, INDICES(1));
end