%% pre_data: create netcdf file from input features and labels
function data_pre(file_input,file_target,nc_train,nc_val,nc_test)
inputlist=dir([file_input filesep '*.input']);
targetlist=dir([file_target filesep '*.target']);
len_input_files=length(inputlist);
len_target_files=length(targetlist);
assert(len_input_files == len_target_files, 'the number of input_files is not equal to the number of target_files.');

numSeqs_train = len_input_files - 150;
numTimesteps_train = 0;%訓練集有多少針
inputPattSize_train = 0;%％輸入的維度
targetPattSize_train = 0;
maxSeqTagLength_train = 0;%％文件名

numSeqs_val = 100;
numTimesteps_val = 0;%訓練集有多少針
inputPattSize_val = 0;%％輸入的維度
targetPattSize_val = 0;
maxSeqTagLength_val = 0;%％文件名

numSeqs_test = 50;
numTimesteps_test = 0;%訓練集有多少針
inputPattSize_test = 0;%％輸入的維度
targetPattSize_test = 0;
maxSeqTagLength_test = 0;%％文件名

input_msum = [];
output_msum = [];

%for n=1:50
for n=1
basename=regexp(inputlist(n).name,'\.input','split');
basename=char(basename(1));
str=sprintf('Reading file: %s',basename);
disp(str)
%data_input=importdata([basename '.input']);
%data_input=importdata(inputlist(n).name);
data_input=load([file_input filesep basename '.input']);
%data_input
max_abs_in=max(abs(data_input));
if(max_abs_in>9999)
str=sprintf('input data wrong in %s', find(max_abs_in));
disp(str)
end
data_target=importdata([file_target filesep basename '.target']);
%data_target=getdata([file_target filesep basename '.target']);
%data_target=getdata(targetlist(n).name);
max_abs_tar=max(abs(data_target));
if(max_abs_tar>9999)
str=sprintf('target data wrong in %s', find(max_abs_tar));
disp(str)
end

maxSeqTagLength_test = max(maxSeqTagLength_test,length(inputlist(n).name));
numTimesteps_test = numTimesteps_test + size(data_input,1);
inputPattSize_test = size(data_input,2);
targetPattSize_test = size(data_target,2);
end

%    for n=51:len_input_files
for n=51
basename=regexp(inputlist(n).name,'\.input','split');
basename=char(basename(1));
str=sprintf('Reading file: %s',basename);
disp(str)
%data_input=importdata([basename '.input']);
data_input=importdata([file_input filesep basename '.input']);
max_abs_in=max(abs(data_input));
if(max_abs_in>9999)
str=sprintf('input data wrong in %s', find(max_abs_in));
disp(str)
end
data_target=importdata([file_target filesep basename '.target']);
%data_target=getdata([file_target filesep basename '.target']);
%data_target=getdata(targetlist(n).name);
max_abs_tar=max(abs(data_target));
if(max_abs_tar>9999)
str=sprintf('target data wrong in %s', find(max_abs_tar));
disp(str)
end

input_msum = [input_msum;data_input];
output_msum = [output_msum;data_target];

if (n<151)
maxSeqTagLength_val = max(maxSeqTagLength_val,length(inputlist(n).name));
numTimesteps_val = numTimesteps_val + size(data_input,1);
inputPattSize_val = size(data_input,2);
targetPattSize_val = size(data_target,2);
else

maxSeqTagLength_train = max(maxSeqTagLength_train,length(inputlist(n).name));
numTimesteps_train = numTimesteps_train + size(data_input,1);
inputPattSize_train = size(data_input,2);
targetPattSize_train = size(data_target,2);
end
end


input_mean = mean(input_msum,1);
input_std = std(input_msum,0,1);
input_std(input_std==0)=0.01;
output_mean = mean(output_msum,1);
output_std = std(output_msum,0,1);
output_std(output_std==0)=0.01;
save('input_mean','input_mean');
save('input_std','input_std');
save('output_mean','output_mean');
save('output_std','output_std');

% train
fileIndex=0;
frameIndex=0;
ncid_train = netcdf.create(nc_train,'NETCDF4');
numSeqsId_train = netcdf.defDim(ncid_train,'numSeqs',numSeqs_train);
numTimestepsId_train = netcdf.defDim(ncid_train,'numTimesteps',numTimesteps_train);
inputPattSizeId_train = netcdf.defDim(ncid_train,'inputPattSize',inputPattSize_train);
maxSeqTagLengthId_train = netcdf.defDim(ncid_train,'maxSeqTagLength',maxSeqTagLength_train);
targetPattSizeId_train = netcdf.defDim(ncid_train,'targetPattSize',targetPattSize_train);

seqTagsID_train = netcdf.defVar(ncid_train,'seqTags','char',[maxSeqTagLengthId_train numSeqsId_train]);
seqLengthsID_train = netcdf.defVar(ncid_train,'seqLengths','int',numSeqsId_train);
inputsID_train = netcdf.defVar(ncid_train,'inputs','float',[inputPattSizeId_train numTimestepsId_train]);
targetPatternsID_train = netcdf.defVar(ncid_train,'targetPatterns','float',[targetPattSizeId_train numTimestepsId_train]);
netcdf.endDef(ncid_train);


%   for n=151:len_input_files
for n=151

basename=regexp(inputlist(n).name,'\.input','split');
basename=char(basename(1));
str=sprintf('Writing file: %s',basename);
disp(str)

data_input=importdata([file_input filesep basename '.input']);
data_target=importdata([file_target filesep basename '.target']);

for j=1:size(data_input,1)
data_input(j,:) = (data_input(j,:)-input_mean)./(4*input_std);
data_target(j,:) = (data_target(j,:)-output_mean)./(4*output_std);
end

netcdf.putVar(ncid_train,inputsID_train,[0 frameIndex],[size(data_input,2) size(data_input,1)],data_input');
              netcdf.putVar(ncid_train,targetPatternsID_train,[0 frameIndex],[size(data_target,2) size(data_target,1)],data_target');
                            
                            netcdf.putVar(ncid_train,seqTagsID_train,[0 fileIndex],[length(basename) 1],basename);
                            netcdf.putVar(ncid_train,seqLengthsID_train,fileIndex,1,size(data_target,1));
                            
                            fileIndex = fileIndex + 1;
                            frameIndex = frameIndex + size(data_target,1);
                            end
                            netcdf.close(ncid_train);
                            
                            
                            %val
                            fileIndex=0;
                            frameIndex=0;
                            ncid_val = netcdf.create(nc_val,'NETCDF4');
                            numSeqsId_val = netcdf.defDim(ncid_val,'numSeqs',numSeqs_val);
                            numTimestepsId_val = netcdf.defDim(ncid_val,'numTimesteps',numTimesteps_val);
                            inputPattSizeId_val = netcdf.defDim(ncid_val,'inputPattSize',inputPattSize_val);
                            maxSeqTagLengthId_val = netcdf.defDim(ncid_val,'maxSeqTagLength',maxSeqTagLength_val);
                            targetPattSizeId_val = netcdf.defDim(ncid_val,'targetPattSize',targetPattSize_val);
                            
                            seqTagsID_val = netcdf.defVar(ncid_val,'seqTags','char',[maxSeqTagLengthId_val numSeqsId_val]);
                            seqLengthsID_val = netcdf.defVar(ncid_val,'seqLengths','int',numSeqsId_val);
                            inputsID_val = netcdf.defVar(ncid_val,'inputs','float',[inputPattSizeId_val numTimestepsId_val]);
                            targetPatternsID_val = netcdf.defVar(ncid_val,'targetPatterns','float',[targetPattSizeId_val numTimestepsId_val]);
                            netcdf.endDef(ncid_val);
                            
                            %         for n=51:150
                            for n=51
                            basename=regexp(inputlist(n).name,'\.input','split');
                            basename=char(basename(1));
                            str=sprintf('Writing file: %s',basename);
                            disp(str)
                            
                            data_input=importdata([file_input filesep basename '.input']);
                            data_target=importdata([file_target filesep basename '.target']);
                            
                            for j=1:size(data_input,1)
                            data_input(j,:) = (data_input(j,:)-input_mean)./(4*input_std);
                            data_target(j,:) = (data_target(j,:)-output_mean)./(4*output_std);
                            end
                            
                            netcdf.putVar(ncid_val,inputsID_val,[0 frameIndex],[size(data_input,2) size(data_input,1)],data_input');
                                          netcdf.putVar(ncid_val,targetPatternsID_val,[0 frameIndex],[size(data_target,2) size(data_target,1)],data_target');
                                                        
                                                        netcdf.putVar(ncid_val,seqTagsID_val,[0 fileIndex],[length(basename) 1],basename);
                                                        netcdf.putVar(ncid_val,seqLengthsID_val,fileIndex,1,size(data_target,1));
                                                        
                                                        fileIndex = fileIndex + 1;
                                                        frameIndex = frameIndex + size(data_target,1);
                                                        end
                                                        netcdf.close(ncid_val);
                                                        
                                                        
                                                        
                                                        %test
                                                        fileIndex=0;
                                                        frameIndex=0;
                                                        ncid_test = netcdf.create(nc_test,'NETCDF4');
                                                        numSeqsId_test = netcdf.defDim(ncid_test,'numSeqs',numSeqs_test);
                                                        numTimestepsId_test = netcdf.defDim(ncid_test,'numTimesteps',numTimesteps_test);
                                                        inputPattSizeId_test = netcdf.defDim(ncid_test,'inputPattSize',inputPattSize_test);
                                                        maxSeqTagLengthId_test = netcdf.defDim(ncid_test,'maxSeqTagLength',maxSeqTagLength_test);
                                                        targetPattSizeId_test = netcdf.defDim(ncid_test,'targetPattSize',targetPattSize_test);
                                                        
                                                        seqTagsID_test = netcdf.defVar(ncid_test,'seqTags','char',[maxSeqTagLengthId_test numSeqsId_test]);
                                                        seqLengthsID_test = netcdf.defVar(ncid_test,'seqLengths','int',numSeqsId_test);
                                                        inputsID_test = netcdf.defVar(ncid_test,'inputs','float',[inputPattSizeId_test numTimestepsId_test]);
                                                        targetPatternsID_test = netcdf.defVar(ncid_test,'targetPatterns','float',[targetPattSizeId_test numTimestepsId_test]);
                                                        netcdf.endDef(ncid_test);
                                                        
                                                        %           for n=1:50
                                                        for n=1
                                                        basename=regexp(inputlist(n).name,'\.input','split');
                                                        basename=char(basename(1));
                                                        str=sprintf('Writing file: %s',basename);
                                                        disp(str)
                                                        
                                                        data_input=importdata([file_input filesep basename '.input']);
                                                        data_target=importdata([file_target filesep basename '.target']);
                                                        
                                                        for j=1:size(data_input,1)
                                                        data_input(j,:) = (data_input(j,:)-input_mean)./(4*input_std);
                                                        data_target(j,:) = (data_target(j,:)-output_mean)./(4*output_std);
                                                        end
                                                        
                                                        netcdf.putVar(ncid_test,inputsID_test,[0 frameIndex],[size(data_input,2) size(data_input,1)],data_input');
                                                                      netcdf.putVar(ncid_test,targetPatternsID_test,[0 frameIndex],[size(data_target,2) size(data_target,1)],data_target');
                                                                                    
                                                                                    netcdf.putVar(ncid_test,seqTagsID_test,[0 fileIndex],[length(basename) 1],basename);
                                                                                    netcdf.putVar(ncid_test,seqLengthsID_test,fileIndex,1,size(data_target,1));
                                                                                    
                                                                                    fileIndex = fileIndex + 1;
                                                                                    frameIndex = frameIndex + size(data_target,1);
                                                                                    end
                                                                                    netcdf.close(ncid_test);
                                                                                    
                                                                                    end
                                                                                    function data=getdata(filename)
                                                                                    fid=fopen(filename,'r');
                                                                                    data=fread(fid,'float');
                                                                                    fclose(fid);
                                                                                    end
                                                                                    
                                                                                    