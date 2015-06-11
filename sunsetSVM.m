% toyProblem.m
% Written by Matthew Boutell, 2006.
% Feel free to distribute at will.

clear all;
clc;

load('features.mat');
X = normalizeFeatures01(X);

trainersX = [];
trainersY = [];
testersX = [];
testersY = [];
for i = 1:size(X, 1)
    if C(i) == 0
        trainersX = cat(1,trainersX,X(i,:));
        trainersY = cat(1,trainersY,Y(i,:));
    else
        testersX = cat(1,testersX,X(i,:));
        testersY = cat(1,testersY,Y(i,:));
    end
end

net = svm(size(trainersX,2), 'rbf', 1.6, 100);
R=repmat([0,1],294,1);
S=[800 1];
%net2 = newff(R,S,{'tansig','purelin'});
%net = svm(size(trainersX,2), 'linear', [1], 100);
%net = svm(size(trainersX,2), 'poly', [1], 100);
net = svmtrain(net, trainersX, trainersY);
%net2 = train(net2,trainersX,trainersY);
[y, y1] = svmfwd(net, testersX);
trueposarray=[];
falseposarray=[];
for threshold = -10:.5:10
    threshedY = y1+threshold;
    threshedY = threshedY./abs(threshedY);
    truepos=0;
    trueneg=0;
    falsepos=0;
    falseneg=0;
    for i = 1:size(testersY,1)
        if (testersY(i)==1 && threshedY(i)==1)
            truepos=truepos+1;
        elseif (testersY(i)==-1 && threshedY(i)==-1)
            trueneg=trueneg+1;
        elseif (testersY(i)==-1 && threshedY(i)==1)
            falsepos=falsepos+1;
        elseif (testersY(i)==1 && threshedY(i)==-1)
            falseneg=falseneg+1;

        end
    end
    trueposrate = truepos / (truepos + falseneg);
    falseposrate = falsepos / (truepos + falseneg);
    trueposarray=cat(1,trueposarray,trueposrate);
    falseposarray=cat(1,falseposarray,falseposrate);
end
nettarget=[];
for k =1:1:499
    if trainersY(k) == -1
        nettarget =cat(1,nettarget,[0,1]);
    else
        nettarget =cat(1,nettarget,[1,0]);
    end
end
nettest=[];
for k =1:1:606
    if testersY(k) == -1
        nettest =cat(1,nettest,[0,1]);
    else
        nettest =cat(1,nettest,[1,0]);
    end
end
% Create a new figure. You can also number it: figure(1)
figure;
% Hold on means all subsequent plot data will be overlaid on a single plot
hold on;
% Plots using a blue line (see 'help plot' for shape and color codes 
plot(falseposarray, trueposarray, 'b-', 'LineWidth', 2);
% Overlaid with circles at the data points
plot(falseposarray, trueposarray, 'bo', 'MarkerSize', 6, 'LineWidth', 2);

% You could repeat here with a different color/style if you made 
% an enhancement and wanted to show that it outperformed the baseline.

% Title, labels, range for axes
title('Performance of Detector X', 'fontSize', 18);
xlabel('False Positive Rate', 'fontWeight', 'bold');
ylabel('True Positive Rate', 'fontWeight', 'bold');
% TPR and FPR range from 0 to 1. You can change these if you want to zoom in on part of the graph.
axis([0 1 0 1]);
inputs = trainersX';
targets = nettarget';

% Create a Pattern Recognition Network
hiddenLayerSize = 20;
net = patternnet(hiddenLayerSize);


% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;


% Train the Network
[net,tr] = train(net,inputs,targets);

% Test the Network
outputs = net(testersX');
errors = gsubtract(nettest',outputs);
performance = perform(net,nettest',outputs)

% View the Network
view(net)
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, plotconfusion(targets,outputs)
figure, plotroc(nettest',outputs)

%[net cverr paramseq] = svmcv(net, trainersX, trainersY, [1 100], 1.25, 50);
%[net cverr paramseq] = svmcv(net, trainersX, trainersY, [0.5 3], 1.25, 50);
%[net cverr paramseq] = svmcv(net, trainersX, trainersY, [.625 1 1.56]);
% [detectedClasses, distances] = svmfwd(net, xTest);
% truePositives = 0;
% trueNegatives = 0;
% falsePositives = 0;
% falseNegatives = 0;
% for i = 1:length(yTrain)
%     fprintf('Point %d, True class: %d, detected class: %d, distance: %0.2f\n', i, yTrain(i), detectedClasses(i), distances(i))
% 
%     if yTest(i) == detectedClasses(i)
%         if yTrain(i) == 1
%             truePositives = truePositives + 1;
%         else
%             trueNegatives = trueNegatives + 1;
%         end
%     else
%         if yTest(i) == 1
%             falseNegatives = falseNegatives + 1;
%         else
%             falsePositives = falsePositives + 1;
%         end
%     end
% end
% 
% fprintf('True positives: %d.\n', truePositives);
% fprintf('True negatives: %d.\n', trueNegatives);
% fprintf('False positives: %d.\n', falsePositives);
% fprintf('False negatives: %d.\n', falseNegatives);
% 
% tpr = truePositives / (truePositives + falsePositives);
% fpr = falsePositives / (falsePositives + truePositives);
% 
% fprintf('True positive rate: %d.\n', tpr);
% fprintf('False positive rate: %d.\n', fpr);
% 
% % Run this on a trained network to see the resulting boundary 
% % (as in the demo)
% plotboundary(net, [0,20], [0,20]);
% 
% 
