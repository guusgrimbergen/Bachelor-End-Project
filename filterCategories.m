function [output] = filterCategories(data, dataT)
%This function enables the user to filter out certain categories out of the
%dataset
%input: dataset Labeled, dataset in Table form
%output: dataset filtered

list = {'Gender','Age','Curvature', 'Width', 'Fractal Dimension', ...
    'Bifurcation', 'Asymmetry','Area Ratio', 'Optimality' };
[indx,tf] = listdlg('ListString',list);

list = {'Difference feature', 'rest'};
[indx2,tf2] = listdlg('ListString',list);

list = {'non AV related', 'Veins','Arteries', 'both AV'};
[indx3,tf3] = listdlg('ListString',list);

iCat=[];
iDiff=[];
iAV=[];

if tf
    iCat=indx;
end
if tf2
   iDiff=indx2;
end
if tf3
    iAV=indx3;
end
 
indx2=indx2+9;
indx3=indx3+11;
allcat=dataT.Properties.VariableNames(:,:);
cat2remove={};

for i=5:length(data)
    if ismember(data{1,i}{1,1}(1,1),indx)==0 || ...
            ismember(data{1,i}{1,1}(1,2),indx2)==0 || ...
            ismember(data{1,i}{1,1}(1,3),indx3)==0
        cat2remove(end+1)={allcat{1,i}};
    end
end
if ~ismember(indx,1)
    cat2remove(end+1)={"SubjectGender"};
end
if ~ismember(indx,2)
    cat2remove(end+1)={"SubjectAge"};
end

output=removevars(dataT,cat2remove);
end

