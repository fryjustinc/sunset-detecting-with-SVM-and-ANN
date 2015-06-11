function [X, Y] = GenerateGaussianDataSet(seed);

randn('state', seed);

% Create positive examples (label = +1)
nPos = 100;
xmu = 14; xsigma = 2;
xPos = normrnd(xmu, xsigma,[nPos,1]);
ymu = 10; ysigma = 2;
yPos = normrnd(ymu, ysigma,[nPos,1]);
Ppos = [xPos, yPos];
Tpos = ones(nPos, 1);

% Create negative examples (label = +1)
nNeg = 100;
% xmu = 5 is separable, 10 is not.
xmu = 11.5; xsigma = 0.5;
xNeg = normrnd(xmu, xsigma,[nNeg,1]);
ymu = 10; ysigma = 3;
yNeg = normrnd(ymu, ysigma,[nNeg,1]);

figure(seed);
hold on;
plot(xPos,yPos, 'ro', xNeg,yNeg, 'bx');
axis([0 20 0 20]);
axis xy;
hold off;
fprintf('Red are positive samples (label=+1)\n');
fprintf('Blue are negative samples (label=-1)\n');

Pneg = [xNeg,yNeg];
Tneg = ones(nNeg,1)*-1;

% Assume you have N total training points and each feature vector
% is of dimension D.
% X, the matrix of feature vectors, is an NxD matrix with one feature
% vector per row.
% Y, the label of each point, is a Nx1 matrix with one label per row. 
X = [Ppos; Pneg]; 
Y = [Tpos; Tneg];



