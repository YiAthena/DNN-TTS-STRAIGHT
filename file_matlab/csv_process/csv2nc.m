function csv2nc(file_input,file_target,nc_filename,mean_dir)
	inputlist=dir([file_input filesep '*.csv']);
	targetlist=dir([file_target filesep '*.target']);
	len_input_files=length(inputlist);
    len_target_files=length(targetlist);
    assert(len_input_files == len_target_files, 'the number of input_files is not equal to the number of target_files.');
    numSeqs = len_input_files;
    numTimesteps = 0;
    inputPattSize = 0;
    targetPattSize = 0;
    maxSeqTagLength = 0;
    dim_target=54;

    for n=1:len_input_files
    	basename=regexp(inputlist(n).name,'\.csv','split');
        basename=char(basename(1));
        str=sprintf('Reading file: %s',basename);
        disp(str)
        data_input=csvread1([file_input filesep inputlist(n).name]);
        fid=fopen([file_target filesep basename '.target'],'r');
		data_target = fscanf(fid,'%f',[dim_target,inf]);
		fclose(fid);
		data_target=data_target';
        assert(size(data_input,1)==size(data_target,1),'frame error');
        max_abs_tar=max(abs(data_target));
        if(max_abs_tar>9999)
            str=sprintf('target data wrong in %s', find(max_abs_tar));
            disp(str)
        end
		maxSeqTagLength = max(maxSeqTagLength,length(basename));
        numTimesteps = numTimesteps + size(data_input,1);
        inputPattSize = size(data_input,2);
        targetPattSize = size(data_target,2);
    end
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

    output_mean=importdata([mean_dir filesep 'output_mean.mat']);
     output_std=importdata([mean_dir filesep 'output_std.mat']);

    frameIndex = 0;
    fileIndex = 0;
    for n=1 : len_input_files
    	basename=regexp(inputlist(n).name,'\.csv','split');
        basename=char(basename(1));
        str=sprintf('Reading file: %s',basename);
        disp(str)
        data_input=csvread1([file_input filesep inputlist(n).name]);
        fid=fopen([file_target filesep basename '.target'],'r');
		data_target = fscanf(fid,'%f',[dim_target,inf]);
		fclose(fid);
		data_target=data_target';
		for j=1:size(data_input,1)
            data_target(j,:) = (data_target(j,:)-output_mean)./(4*output_std);
        end
		netcdf.putVar(ncid ,inputsID ,[0 frameIndex],[size(data_input,2) size(data_input,1)],data_input');
        netcdf.putVar(ncid ,targetPatternsID ,[0 frameIndex],[size(data_target,2) size(data_target,1)],data_target');

        netcdf.putVar(ncid ,seqTagsID ,[0 fileIndex],[length(basename) 1],basename);
        netcdf.putVar(ncid ,seqLengthsID ,fileIndex,1,size(data_target,1));

        fileIndex = fileIndex + 1;
        frameIndex = frameIndex + size(data_target,1);
    end
    netcdf.close(ncid);
end
