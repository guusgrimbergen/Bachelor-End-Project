%This script rearranges the initial dataset into a table where each row is
%a patient, and the columns are features. Per feature there are six
%columns: optical disc centered left/right/difference and fovea centered
%left/right/difference.
%WARNING: it may take quite some time (up to 1 hour) to compute the entire
%data set.

%% Initialisation

%load('play.mat')
close, clearvars -except play

%Create a list with only the unique patient ID and corresponding age,
%gender and diabetes status
patientdata=play{:,5:8};
dif=[diff(patientdata(:,1)); 1];
uniquedata=patientdata(dif~=0, :);

%Initialise empty table
allpatients=array2table(zeros(2748, 2290));
featNames=[play.Properties.VariableNames(5:8) cell(1, 2286)];
var=5;

%Loop through all feature names and concatenate to each one the six strings
%for eye type.
for i=play.Properties.VariableNames(15:end-1)
    featNames(1,var)=join([i, 'ODLeft'], '_');
    featNames(1,var+1)=join([i, 'ODRight'], '_');
    featNames(1,var+2)=join([i, 'ODDiff'], '_');
    featNames(1,var+3)=join([i, 'FLeft'], '_');
    featNames(1,var+4)=join([i, 'FRight'], '_');
    featNames(1,var+5)=join([i, 'FDiff'], '_');
    var=var+6;
end

%Assign the feature names as variable names in the table, and add the
%previously extracted patient data.
allpatients.Properties.VariableNames=featNames;
allpatients(:, 1:4)=array2table(uniquedata);

%% Rearranging features

%For every unique patient, the function sortdata gets used to seperate
%their features from OD/Fovea left/right eye and respective differences 
%into a 6-by-n table. Then, this table gets rearranged into a 1-n row for
%in the final table.

for i=1:length(allpatients{:, 'SubjectID'})
    
   newfeatnum=5;
   id=allpatients{i, 'SubjectID'};
   data=sortdata(id, play);
   
   for j=2:382
       
       allpatients(i, newfeatnum)=data('ODL', j);
       allpatients(i, newfeatnum+1)=data('ODR', j);
       allpatients(i, newfeatnum+2)=data('DOD', j);
       allpatients(i, newfeatnum+3)=data('FL', j);
       allpatients(i, newfeatnum+4)=data('FR', j);
       allpatients(i, newfeatnum+5)=data('DF', j);
       newfeatnum=newfeatnum+6;
   end 
   
   
    
end

%writetable(allpatients, 'allpatients.csv')




