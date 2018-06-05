%%%%%%%%%%%%%%%% BACHELOR ENDPROJECT MEDICAL IMAGE ANALYSIS %%%%%%%%%%%%%%%

% Final method, June 2018
% (c) Y.H. Zhu and G. Grimbergen

%% Data preparation
%Import data, normalized, fourth column is SubjectDiabetesStatus
%Choose how to partition the dataset: 2 or 4 classes

clear, close all

load balanced
load balancedm2

dataset=balancedm2;

%choose diabetes classes 0, 1, 2 and 3, or 0+1=0 and 2+3=1
nrclasses=str2double(inputdlg('Choose classification: 2=two-class, 4=four-class'));

switch nrclasses
    case 2
        dataset=balancedm2;
    case 4
        dataset=balanced;
end


%%-->output: normalized dataset, Diabetes status [0:1] or [0:4]

%% Category selection
%For baseline: leave all features
%Choose catergory/categories: width, curvature, fractal dimension, other
%Choose with or without difference features
%Choose arteries+veins, only arteries, only veins

datasetLabeled=giveLabel(dataset);
dataset=filterCategories(datasetLabeled, dataset);

%-->output: indices with selected features

%% Feature selection
%for each category:
%Rank features by correlation coefficient
%Remove all features below chosen threshold

threshold=0.05; %choose minimum value for corr coefficient

[corr] = calcCorr(dataset);

toDelete=corr{1,:}<threshold;
featToDelete=corr(1,toDelete).Properties.VariableNames;
dataset=removevars(dataset, featToDelete);

%-->output: dataset with "best" features

%% Train classifier
%(choose classifier)

%train with 10-fold cross validation
mdl=fitcknn(dataset(:,2:end), 'SubjectDiabetesStatus', 'CrossVal', 'on');

%-->output: trained cross-validated model

%% Evalutate performace
%Predict labels within folds
%Calculate evaluation metrics: AUC, accuracy, precision, recall

posclass=1; %choose which class to evaluate as positive

[AUC, acc, prec, rec]=evalPerf(mdl, dataset, nrclasses, posclass);

%-->output: evaluation metrics
