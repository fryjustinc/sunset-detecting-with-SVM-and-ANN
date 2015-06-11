function [fv, label] = GenerateOneCluster(nPts, cls, xmu, ymu, xsigma, ysigma)

x = normrnd(xmu, xsigma,[nPts,1]);
y = normrnd(ymu, ysigma,[nPts,1]);
fv = [x, y];
label = ones(nPts, 1)*cls;






