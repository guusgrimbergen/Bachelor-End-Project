function [corr] = calcCorr(dataset)
%Calculate the absolute Pearson correlation coefficient for all features 
%against the diabetes status, then sort in order of absolute magnitude.
%
%Input:
%   - dataset: normalized dataset with n features, first column patient ID 
%   and fourth column diabetes status
%Output:
%   - corr: 1xn table, sorted by correlation coefficient in descending
%   order, and feature names as variable names
%

%Initialisation; coefficients have to be put into a cell so they can be
%sorted
numfeat=length(dataset{1,2:end});
corr=cell(2, numfeat);
corr(2,:)=dataset.Properties.VariableNames(2:end);

%Calculate the correlation coefficient for every feature
for i=2:numfeat+1
    r=abs(corrcoef(dataset.SubjectDiabetesStatus, dataset{:,i}));
    corr{1,i-1}=r(1,2); %coefficients are on the off-diagonal
end

%Sort coefficients and convert into table
[~,idx]=sort(cell2mat(corr(1,:)),2,'descend');
corr=corr(:,idx);
corr=cell2table(corr(1,:), 'VariableNames', corr(2,:));

end

