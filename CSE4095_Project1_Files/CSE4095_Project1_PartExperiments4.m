%{
We load a set of images directly from the directory.

For part 4, VECTOR_ARRAY is used. However, this code can also be modified
to test for K and the i-th picture.

For part 5, VECTOR_ARRAY_T is fed into the eigenface function, and
VECTOR_ARRAY_TEST is used to project faces and recognize faces.
%}

K = 30;
STRTAG = '10';

files = dir('P:\SOEHOME\private_home\MATLAB\CSE4095\Project1\Face_Images\*.jpg');
number_of_files = length(files);
files = struct2cell(files);
filenames = transpose(files(1, :));
[ROWS, COLUMNS] = size(filenames);
picturenames = {};


%{
The original vector array contained all the images.
%}

VECTOR_ARRAY = zeros(7200, 217);
for i = 1:ROWS
    str_filename = filenames{i, 1};
    str_concat = strcat('P:\SOEHOME\private_home\MATLAB\CSE4095\Project1\Face_Images\', str_filename);
    VECTOR_ARRAY(:,i) = reshape(im2double((imread(str_concat, 'jpg'))), 7200, 1);
end

PREFIXES = ['AA', 'BJ', 'CZ', 'GN', 'GP', 'GS', 'HH', 'HS', 'JM', 'JP', 'KY', 'MC', 'MG', 'MK', 'OH', 'PR', 'RS', 'SA', 'TJ', 'TS', 'ZQ'];
VECTOR_ARRAY_T = zeros(7200, 21);
VECTOR_ARRAY_TEST = zeros(7200, ROWS - 21);
COUNT = 1;
for i = 1:ROWS
    str_filename = filenames{i, 1};
    
    % Modify this part to find the first, second, or k-th image of a
    % student.
    
    if str_filename(3:4) == STRTAG
        k = find(PREFIXES == repelem(str_filename(1:2), 21));
        str_concat = strcat('P:\SOEHOME\private_home\MATLAB\CSE4095\Project1\Face_Images\', str_filename);
        VECTOR_ARRAY_T(:,k(1)) = reshape(im2double((imread(str_concat, 'jpg'))), 7200, 1);
    else
        str_concat = strcat('P:\SOEHOME\private_home\MATLAB\CSE4095\Project1\Face_Images\', str_filename);
        VECTOR_ARRAY_TEST(:,COUNT) = reshape(im2double((imread(str_concat, 'jpg'))), 7200, 1);
        filename = filenames{i, 1};
        filename = filename(1:4);
        picturenames = [picturenames; filename];
        COUNT = COUNT + 1;
    end
end

% We obtain weights for all the faces. We define K as 10, 20, or 30
% respectively.

RECONSTRUCTED_FACES = {};
FACE_WEIGHTS = {};
[AVERAGEFACE, EIGENFACES] = eigenface(VECTOR_ARRAY_T, K);

for i = 1:(ROWS - 21)
    Projected_Face = project_face(AVERAGEFACE, EIGENFACES, VECTOR_ARRAY_TEST(:,i));
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
for i = 1:(ROWS - 21)
    FACE_WEIGHTS_WITHOUT_I = FACE_WEIGHTS;
    FACE_WEIGHTS_WITHOUT_I(:,i) = zeros(K, 1);
    [ORDER, BEST_FACE] = recognize_face(AVERAGEFACE, EIGENFACES, FACE_WEIGHTS_WITHOUT_I, VECTOR_ARRAY_TEST(:,i));
    FACE_GUESS = [FACE_GUESS; ORDER(1)];
end

% We compute the probabilities here by determining if the persons match
% through their prefixes, such as "AA" == "AA".

SUCCESS = 0;
for i = 1:(ROWS - 21)
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

DETECTION_RATE = SUCCESS/(ROWS - 21);