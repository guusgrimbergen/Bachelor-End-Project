function [patientTable] = sortdata(patient, play)
%A function that selects data from a single patient from the play dataset,
%and sorts the biomarkers per image type.


%load('play.mat')


%Initialize empty table. The rows are the image types: optical disc centered Left/Right,
%fovea centered Left/Right, and the difference between left and right eyes
%for OD centered and fovea centered. The first column is the image name
%from where the data for each image type was extracted from. If this value is 0,
%the image type did not exist with the chosen subject ID. 

patientTable=array2table(zeros(6, 382));
patientTable.Properties.RowNames={'ODL', 'ODR', 'FL', 'FR', 'DOD', 'DF'};
patientTable.Properties.VariableNames=[{'ImageName'} play.Properties.VariableNames(15:end-1)];

for i=1:height(play) %loop over every image in the dataset
    
    if play{i,'SubjectID'} == patient %if an image belongs to the chosen subject ID
       
        %The following if statements check to which image type the found
        %row with features belongs to, and puts them into the proper row of
        %the new table.
        
        if strcmp(char(play{i, 'ODorFoveaCentered'}), 'OD') && strcmp(char(play{i, 'Eye'}), 'Left')
            patientTable('ODL','ImageName')=play(i,1);
            patientTable('ODL',2:end)=play(i, 15:end-1);
        
        elseif strcmp(char(play{i, 'ODorFoveaCentered'}), 'OD') && strcmp(char(play{i, 'Eye'}), 'Right')
            patientTable('ODR','ImageName')=play(i,1);
            patientTable('ODR',2:end)=play(i, 15:end-1);
            
        elseif strcmp(char(play{i, 'ODorFoveaCentered'}), 'Fovea') && strcmp(char(play{i, 'Eye'}), 'Left')
            patientTable('FL','ImageName')=play(i,1);
            patientTable('FL',2:end)=play(i, 15:end-1);
            
        elseif strcmp(char(play{i, 'ODorFoveaCentered'}), 'Fovea') && strcmp(char(play{i, 'Eye'}), 'Right')
            patientTable('FR','ImageName')=play(i,1);
            patientTable('FR',2:end)=play(i, 15:end-1);
        
        end
        
    end
    %Because the data set is sorted on subject ID, if duplicates of the 
    %same image type exist, the last one found will be in the final table.
 
end

%Finally, the last two rows of the table are filled with differences in
%features between the left and right eye, for OD centered and fovea
%centered. This is only calculated if the subject had data for both the 
%left and right eye with the same center.

if patientTable{'ODL', 'ImageName'} ~=0 && patientTable{'ODR', 'ImageName'} ~=0
    patientTable('DOD',2:end)=array2table(abs(patientTable{'ODL', 2:end}-patientTable{'ODR', 2:end}));
end 

if patientTable{'FL', 'ImageName'} ~=0 && patientTable{'FR', 'ImageName'} ~=0
    patientTable('DF',2:end)=array2table(abs(patientTable{'FL', 2:end}-patientTable{'FR', 2:end}));
end

end
        
        


