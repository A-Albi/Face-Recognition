ARRAY = {};

%{
Load all images in order.
%}

DIRECTORY = 'P:\SOEHOME\private_home\MATLAB\CSE4095\Project1\Face_Images\';
PREFIXES = {'AA', 'BJ', 'CZ', 'GN', 'GP', 'GS', 'HH', 'HS', 'JM', 'JP', 'KY', 'MC', 'MG', 'MK', 'OH', 'PR', 'RS', 'SA', 'TJ', 'TS', 'ZQ'};
NUMBERS = {'01', '02', '03', '04', '05', '06', '07', '08', '09', '10'};

for i = 1:length(PREFIXES)
    for j = 1:10
        stringarray = strcat(DIRECTORY, PREFIXES(i), NUMBERS(j), '.jpg');
        ARRAY = [ARRAY; im2double((imread(stringarray{1}, 'jpg')))];
    end
end

NUMBERS2 = {'11', '12', '13', '14', '15', '16', '17'};
for j = 1:length(NUMBERS2)
    stringarray = strcat(DIRECTORY, 'PR', NUMBERS2{j}, '.jpg');
    ARRAY = [ARRAY; im2double((imread(stringarray, 'jpg')))];
end