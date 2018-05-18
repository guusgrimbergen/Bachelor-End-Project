pvalues=array2table(zeros(1, 2286));
pvalues.Properties.VariableNames=finalmatrix.Properties.VariableNames(5:end);
for i=5:2290
    [~, p]=corrcoef(finalmatrix{:,4}, finalmatrix{:,i});
    pvalues(1,i-4)=array2table(p(1,2));
end