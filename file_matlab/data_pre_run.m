CMU_path='/home/zhaoyi/mywork/tts/HTStry/Demo/CMU';
mgc_dim=26;
for i=1:7
	prj_name=['cmu',num2str(i)];
	prj_dir=[CMU_path filesep prj_name];
    file_input=[prj_dir '/data/DNN_DATA_ALL2/INPUT_label'];
    file_target=[prj_dir '/data/DNN_DATA_ALL2/TARGET']; 
    nc_train=[prj_dir '/data/DNN_DATA_ALL2/INPUT_label/train.nc'];
    nc_val=[prj_dir '/data/DNN_DATA_ALL2/INPUT_label/val.nc'];
    nc_test=[prj_dir '/data/DNN_DATA_ALL2/INPUT_label/test.nc'];
    data_pre(file_input,file_target,nc_train,nc_val,nc_test);
end
