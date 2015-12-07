CMU_path='/home/zhaoyi/mywork/tts/HTStry/Demo/CMU_STRAIGHT';

for i=1:7
	prj_name=['cmu',num2str(i)];
	train_path=[CMU_path filesep prj_name filesep 'data' filesep 'DNN_DATA_ALL2' filesep 'TRAIN'];
	train_input_dir=[train_path filesep 'INPUT'];
	train_target_dir=[train_path filesep 'TARGET'];
	mean_input_dir = train_input_dir;
	mean_target_dir = train_target_dir;
	val_path=[CMU_path filesep prj_name filesep 'data' filesep 'DNN_DATA_ALL2' filesep 'VAL'];
	val_input_dir=[val_path filesep 'INPUT'];
	val_target_dir=[val_path filesep 'TARGET'];
	nc_val=[val_path filesep 'val.nc'];

	test_path=[CMU_path filesep prj_name filesep 'data' filesep 'DNN_DATA_ALL2' filesep 'TEST'];
	test_input_dir=[test_path filesep 'INPUT'];
	test_target_dir=[test_path filesep 'TARGET'];
	nc_test=[test_path filesep 'test.nc'];

	test_nc(val_input_dir,val_target_dir,nc_val,mean_input_dir,mean_target_dir);
	test_nc(test_input_dir,test_target_dir,nc_test,mean_input_dir,mean_target_dir);
end
