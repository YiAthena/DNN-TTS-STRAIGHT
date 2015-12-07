function mk_nc_file(file_input,file_target,nc_filename,s,e,numSeqs,numTimesteps,inputPattSize,targetPattSize,maxSeqTagLength)
	% assert(numSeqs == e - s + 1 , 'numSeqs wrong');
	inputlist=dir([file_input filesep '*.input']);
	fileIndex=0;
    frameIndex=0;
   % ncid  = netcdf.create(nc_filename ,'NETCDF4');
ncid  = netcdf.create(nc_filename ,'CLASSIC_MODEL');

    numSeqsId  = netcdf.defDim(ncid ,'numSeqs',numSeqs );
    numTimestepsId  = netcdf.defDim(ncid ,'numTimesteps',numTimesteps );
    inputPattSizeId  = netcdf.defDim(ncid ,'inputPattSize',inputPattSize );
    maxSeqTagLengthId  = netcdf.defDim(ncid ,'maxSeqTagLength',maxSeqTagLength );
    targetPattSizeId  = netcdf.defDim(ncid ,'targetPattSize',targetPattSize );

    seqTagsID  = netcdf.defVar(ncid ,'seqTags','char',[maxSeqTagLengthId  numSeqsId ]);
    seqLengthsID  = netcdf.defVar(ncid ,'seqLengths','int',numSeqsId );
    inputsID  = netcdf.defVar(ncid ,'inputs','float',[inputPattSizeId  numTimestepsId ]);
    targetPatternsID  = netcdf.defVar(ncid ,'targetPatterns','float',[targetPattSizeId  numTimestepsId ]);
    netcdf.endDef(ncid );
 %   input_mean=importdata([file_input 'input_mean.mat']);
 %   input_std=importdata([file_input 'input_std.mat']);
 %   output_mean=importdata([file_target 'output_mean.mat']);
 %   output_std=importdata([file_target 'output_std.mat']);
input_mean=importdata('/home/zhaoyi/mywork/tts/DeepLearning/file_matlab/ID_write/cmu/aver_input_mean');
input_std=importdata('/home/zhaoyi/mywork/tts/DeepLearning/file_matlab/ID_write/cmu/aver_input_std');
output_mean=importdata('/home/zhaoyi/mywork/tts/DeepLearning/file_matlab/ID_write/cmu/aver_output_mean');
output_std=importdata('/home/zhaoyi/mywork/tts/DeepLearning/file_matlab/ID_write/cmu/aver_output_std');

 %   for n=151:len_input_files
for n=s : e

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
        
        netcdf.putVar(ncid ,inputsID ,[0 frameIndex],[size(data_input,2) size(data_input,1)],data_input');
        netcdf.putVar(ncid ,targetPatternsID ,[0 frameIndex],[size(data_target,2) size(data_target,1)],data_target');

        netcdf.putVar(ncid ,seqTagsID ,[0 fileIndex],[length(basename) 1],basename);
        netcdf.putVar(ncid ,seqLengthsID ,fileIndex,1,size(data_target,1));

        fileIndex = fileIndex + 1;
        frameIndex = frameIndex + size(data_target,1);
    end
    netcdf.close(ncid );
end