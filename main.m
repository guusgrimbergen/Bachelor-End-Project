%%%%%%%%%%%%%%%% BACHELOR ENDPROJECT MEDICAL IMAGE ANALYSIS %%%%%%%%%%%%%%%

% Final method, June 2018
% Y.H. Zhu and G. Grimbergen - TU Eindhoven

%% Data preparation
%Import data, normalized, fourth column is SubjectDiabetesStatus
%Choose how to partition the dataset: 2 or 4 classes

clear, close all

load balanced
load balancedm2

%choose diabetes classes 0, 1, 2 and 3, or 0+1=0 and 2+3=1
nrclasses=str2double(inputdlg('Choose classification: 2=two-class, 4=four-class'));

switch nrclasses
    case 2
        data=balancedm2;
    case 4
        data=balanced;
end


%%-->output: normalized dataset, Diabetes status [0:1] or [0:3]

%% Category selection
%For baseline: leave all features
%Choose catergory/categories: width, curvature, fractal dimension, other
%Choose with or without difference features
%Choose arteries+veins, only arteries, only veins

datasetLabeled=giveLabel(data);
data=filterCategories(datasetLabeled, data);

%-->output: indices with selected features

%% Feature selection
%For each category:
%Rank features by correlation coefficient
%Remove all features below chosen threshold

threshold=0.05; %choose minimum value for corr coefficient

[corr] = calcCorr(data);

toDelete=corr{1,:}<threshold;
featToDelete=corr(1,toDelete).Properties.VariableNames;
data=removevars(data, featToDelete);

%-->output: dataset with "best" features

%% Train classifier

%train with 10-fold cross validation
mdl=fitcknn(data(:,2:end), 'SubjectDiabetesStatus', 'CrossVal', 'on');

%-->output: trained cross-validated model

%% Evalutate performace
%Predict labels within folds
%Calculate evaluation metrics: AUC, accuracy, precision, recall

posclass=nrclass-1; %Positive class is unhealthy/diabetes

[AUC, acc, prec, rec]=evalPerf(mdl, data, nrclasses, posclass);

%-->output: evaluation metrics
