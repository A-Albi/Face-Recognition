%{
We load a set of images directly from the directory.
%}

files = dir('P:\SOEHOME\private_home\MATLAB\CSE4095\Project1\Face_Images\*.jpg');
number_of_files = length(files);
files = struct2cell(files);
filenames = transpose(files(1, :));
[ROWS, COLUMNS] = size(filenames);
picturenames = {};

for i = 1:ROWS
    filename = filenames{i, 1};
    filename = filename(1:4);
    picturenames = [picturenames; filename];
end

VECTOR_ARRAY = zeros(7200, 217);
for i = 1:ROWS
    str_filename = filenames{i, 1};
    str_concat = strcat('P:\SOEHOME\private_home\MATLAB\CSE4095\Project1\Face_Images\', str_filename);
    VECTOR_ARRAY(:,i) = reshape(im2double((imread(str_concat, 'jpg'))), 7200, 1);
end

% We obtain weights for all the faces. We define K as 10, 20, or 30
% respectively.

RECONSTRUCTED_FACES = {};
FACE_WEIGHTS = {};
K = 10;
[AVERAGEFACE, EIGENFACES] = eigenface(VECTOR_ARRAY, K);

for i = 1:ROWS
    Projected_Face = project_face(AVERAGEFACE, EIGENFACES, VECTOR_ARRAY(:,i));
    FACE_WEIGHTS = [FACE_WEIGHTS; Projected_Face];
    RECONSTRUCTED_FACES = [RECONSTRUCTED_FACES;
        reconstruct_face(AVERAGEFACE, EIGENFACES, Projected_Face)];
end
FACE_WEIGHTS = [FACE_WEIGHTS{:}];

% We compute the probability of the detection rate. By definition, we count
% the number of successes that the program matches the correct person. To
% do this, we keep a list of what the program thinks each face matches.

% Observe that when running the comparisons, we erase the current picture
% by replacing it with an array of zeros. This will prevent the overfitting
% of matching the face with itself.

FACE_GUESS = {};
GUESS_WITH_PHOTO = {};
for i = 1:ROWS
    FACE_WEIGHTS_WITHOUT_I = FACE_WEIGHTS;
    FACE_WEIGHTS_WITHOUT_I(:,i) = zeros(10, 1);
    [ORDER, BEST_FACE] = recognize_face(AVERAGEFACE, EIGENFACES, FACE_WEIGHTS_WITHOUT_I, VECTOR_ARRAY(:,i));
    FACE_GUESS = [FACE_GUESS; ORDER(1)];
end

% We compute the probabilities here by determining if the persons match
% through their prefixes, such as "AA" == "AA".

SUCCESS = 0;
for i = 1:ROWS
    ACTUAL_PERSON = picturenames{i,1};
    GUESS_PERSON = picturenames{FACE_GUESS{i, 1}, 1};
    if ACTUAL_PERSON(1:2) == GUESS_PERSON(1:2)
        SUCCESS = SUCCESS + 1;
    end
end

EIGENFACES_NORMALIZED = EIGENFACES - min(EIGENFACES(:));
EIGENFACES_NORMALIZED = EIGENFACES_NORMALIZED ./ max(EIGENFACES_NORMALIZED(:));

SHOW_EIGENFACES = zeros(60, 40*(K+1), 3);
SHOW_EIGENFACES(:,1:40,:) = reshape(AVERAGEFACE, [60 40 3]);
for i = 1:K
    BEGIN = 40*i + 1;
    END = 40*(i + 1);
    SHOW_EIGENFACES(:,BEGIN:END, :) = reshape(EIGENFACES_NORMALIZED(:,i), [60 40 3]);
end

% The probability is the success divided by the number of rows.

DETECTION_RATE = SUCCESS/ROWS;