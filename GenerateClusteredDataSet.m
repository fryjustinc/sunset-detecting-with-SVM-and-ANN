function [X, Y] = GenerateClusteredDataSet(seed);

% Assume you have N total training points and each feature vector
% is of dimension D.
% X, the matrix of feature vectors, is an NxD matrix with one feature
% vector per row.
% Y, the label of each point, is a Nx1 matrix with one label per row. 
%seed = 137;
randn('state', seed);

% npts, cls, xmu, xsigma, ymu, ysigma
nPts = 20;
s = 1;
[x1,y1] = GenerateOneCluster(nPts, -1, 10,  6, s, s);
[x2,y2] = GenerateOneCluster(nPts, -1,  5, 12, s, s);
[x3,y3] = GenerateOneCluster(nPts, 1,  5, 5, s, s);
[x4,y4] = GenerateOneCluster(nPts, 1, 10, 12, s, s);
[x5,y5] = GenerateOneCluster(nPts, -1, 15, 10, s, s*4);
[x6,y6] = GenerateOneCluster(nPts, -1, 10, 10, s*5, s*5);
[x7,y7] = GenerateOneCluster(nPts/2, -1, 7, 9, s/2, s/2);

X = [x1; x2; x3; x4; x5; x6; x7];
Y = [y1; y2; y3; y4; y5; y6; y7];

pos = find(Y > 0);
xPos = X(pos,:);
yPos = Y(pos,:);

neg = find(Y <= 0);
xNeg = X(neg,:);
yNeg = Y(neg,:);

figure(seed);
hold on;

plot(xPos(:,1), xPos(:,2), 'ro', xNeg(:,1),xNeg(:,2), 'bx');
axis([0 20 0 20]);
axis xy;
hold off;
fprintf('Red are positive samples (label=+1)\n');
fprintf('Blue are negative samples (label=-1)\n');




