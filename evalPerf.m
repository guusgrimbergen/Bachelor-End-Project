function [AUC, acc, prec, rec] = evalPerf(mdl, dataset, nrclasses, posclass)
%A function that evaluates the performance of a cross-validated model by
%predicting in-fold and calculating various performace metrics
%
%Input:
%   - mdl: a cross-validated model
%   - dataset:  normalized dataset with n features, first column patient ID 
%     and fourth column diabetes status
%   - nrclasses: number of classes for diabetes status, 2 or 4
%   - posclass: the class assigned to be positive: the other class(es) with
%     be regarded as negative
% 
%Output:
%   - AUC: the area under the ROC curve
%   - acc: accuracy=(TP+TN)/(TP+FP+FN+TN)
%   - prec: precision=TP/(TP+FP)
%   - rec: recall=TP/(TP+FN)
% 

%assign the negative classes
classes=0:nrclasses-1;
negclass=classes(classes~=posclass);

%predict labels and posterior probability in each fold
[labels, scores]=kfoldPredict(mdl);

%calculate AUC 
[~, ~, ~, AUC]=perfcurve(dataset.SubjectDiabetesStatus, scores(:,nrclasses), 1);

%calculate other performance metrics
CP=classperf(dataset.SubjectDiabetesStatus, labels, 'Positive', posclass, 'Negative', negclass);


confmat=CP.CountingMatrix;
confmat(end,:)=[];

acc=(trace(confmat))/(sum(sum(confmat)));
prec=CP.PositivePredictiveValue;
rec=CP.Sensitivity;




end

