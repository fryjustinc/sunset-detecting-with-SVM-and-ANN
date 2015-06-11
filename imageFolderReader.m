clear all
clc

% Example of reading all the files in a given folder, e.g., TrainSunset. 
% For the sunset detector, you should keep the images in 4 separate folders: train and test 
% are separate, and the folder names tell you what the labels are (sunset = +1, non = -1) 
dirs = cell(6,1);
label = cell(6,1);
class = cell(6,1); % 0 = train; 1 = test
difficulty = cell(6,1); % 0 = normal; 1 = difficult
dirs{1} = 'images/TestDifficultSunsets';
label{1} = 1;
class{1} = 1;
difficulty{1} = 1;
dirs{2} = 'images/TestNonsunsets';
label{2} = -1;
class{2} = 1;
difficulty{2} = 0;
dirs{3} = 'images/TestSunset';
label{3} = 1;
class{3} = 1;
difficulty{3} = 0;
dirs{4} = 'images/TestDifficultNonsunsets';
label{4} = -1;
class{4} = 1;
difficulty{4} = 1;
dirs{5} = 'images/TrainNonsunsets';
label{5} = -1;
class{5} = 0;
difficulty{5} = 0;
dirs{6} = 'images/TrainSunset';
label{6} = 1;
class{6} = 0;
difficulty{6} = 0;
    
fileList = cell(6,1);
for i = 1:size(dirs,1)
    fileList{i} = dir(dirs{i});
end

% files 1 and 2 are . (current dir) and .. (parent dir), respectively, 
% so we start with 3.
X = [];
Y = [];
C = [];
D = [];
for i = 1:size(fileList, 1)
    for j = 3:size(fileList{i})
        img = imread([dirs{i}  '/'  fileList{i}(j).name]);
        fv = extractFeatureVector(img);
        X = [X; fv];
        Y = [Y; label{i}];
        C = [C; class{i}];
        D = [D; difficulty{i}];
    end
end

save('features.mat', 'X', 'Y', 'C');