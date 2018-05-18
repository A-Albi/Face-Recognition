% Experiment Question 2

RECONSTRUCTED_FACES = {};
FACE_WEIGHTS = {};
% For part 3, use VECTOR_ARRAY. For part 5, use VECTOR_ARRAY_TEST.
% For part 3, use NUMBERTEST = 218, COLNUM = 20.
% For part 4 and 5, use NUMBERTEST = 197 and COLNUM = 18;

NUMBER_TEST = 197;
COLNUM = 18;

for i = 1:NUMBER_TEST
    Projected_Face = project_face(AVERAGEFACE, EIGENFACES, VECTOR_ARRAY_TEST(:,i));
    FACE_WEIGHTS = [FACE_WEIGHTS; Projected_Face];
    RECONSTRUCTED_FACES = [RECONSTRUCTED_FACES;
        reconstruct_face(AVERAGEFACE, EIGENFACES, Projected_Face)];
end

% This part displays the faces in the SHOW_IMAGES and SHOW_RECONSTRUCTED
% arrays.
% COLNUM = floor(#ENTRIES/10) - 1;

% For part 3, use VECTOR_ARRAY. For part 5, use VECTOR_ARRAY_TEST

FACES_1D = reshape(VECTOR_ARRAY_TEST, [60 40 3 NUMBER_TEST]);
RECONSTRUCTED_7200 = cell2mat(RECONSTRUCTED_FACES);
RECONSTRUCTED_1D = reshape(RECONSTRUCTED_7200, [60 40 3 NUMBER_TEST]);
SHOW_IMAGES = zeros(60*22, 40*10, 3);
SHOW_RECONSTRUCTED = zeros(60*22, 40*10, 3);
for i = 0:COLNUM
    for j = 0:10
        X_BEGIN = (60 * i + 1);
        X_END = (60 * (i + 1));
        Y_BEGIN = (40 * j + 1);
        Y_END = (40 * (j + 1));
        CUR_INDEX = (i)*10 + j + 1;
        SHOW_IMAGES(X_BEGIN:X_END, Y_BEGIN:Y_END, :) = FACES_1D(:,:,:,CUR_INDEX);
        SHOW_RECONSTRUCTED(X_BEGIN:X_END, Y_BEGIN:Y_END, :) = RECONSTRUCTED_1D(:,:,:,CUR_INDEX);
    end
end

for j = 2:7
    CUR_INDEX = (COLNUM + 1)*10 + j;
    SHOW_IMAGES(60 * (COLNUM + 1) + 1: 60 * (COLNUM + 2), 40 * (j-2) + 1: 40 * (j-1), :) = FACES_1D(:,:,:,CUR_INDEX);
    SHOW_RECONSTRUCTED(60 * (COLNUM + 1) + 1: 60 * (COLNUM + 2), 40 * (j-2) + 1: 40 * (j-1), :) = RECONSTRUCTED_1D(:,:,:,CUR_INDEX);
end