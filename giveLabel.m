function [CwPwL] = giveLabel(dataset)
%This function labels the dataset. The categories are given below.
%input dataset: dataset in table form
%output CwPwL: cell array with [labels, tableproperties, dataset]

%labels:
%1: Gender
%2: Age
%3: curvature
%4: width
%5: Fractal Dimension
%6: Bifurcation
%7: Asymmetry
%8: Area Ratio
%9: Optimality

%10: Difference feature
%11: rest

%12: non AV related
%13: veins
%14: arteries
%15: both AV

C=table2cell(dataset);
CwP=[dataset.Properties.VariableNames;C];
[~,col]=size(CwP);
labels={};

for i=1:col
    name=CwP{1,i};
    if contains(name,'Gender')
        cat=1;
    elseif contains(name, 'Age')
        cat=2;
    elseif contains(name, 'Curvature')
        cat=3;
    elseif contains(name, 'CRAE')
        cat=5;  
    elseif contains(name, 'AVR')
        cat=5;  
    elseif contains(name, 'Angle')
        cat=6;
    elseif contains(name, 'Width')
        cat=4;
    elseif contains(name, 'Asymmetry')
        cat=7; 
    elseif contains(name, 'AreaRatio')
        cat=8;
    elseif contains(name, 'Index')
        cat=6;
     elseif contains(name, 'Diameter')
        cat=4;
    elseif contains(name, 'Optimality')
        cat=9; 
    elseif contains(name, 'BoxD')
        cat=5;
    elseif contains(name, 'InformatioD')
        cat=5;
    elseif contains(name, 'CorreationD')
        cat=5;    
    elseif contains(name, 'Lacunarity')
        cat=5;       
    elseif contains(name, 'MF_')
        cat=5; 
    else
        cat=0;
    end
    if contains(name,'Diff')
        diff=10;
    else
        diff=11;
    end
    if contains(name,'Veins')
        kind=13;
    elseif contains(name,'Arteries')
        kind=14;
    elseif contains(name,'BothAV')
        kind=15;
    else
        kind=12;
    end
     labels{1,i}={[cat diff kind]}; 
end

CwPwL=[labels;CwP];
end

