CMU_path='/home/zhaoyi/mywork/tts/HTStry/Demo/CMU_STRAIGHT';
csv_path='/home/zhaoyi/mywork/tts/DeepLearning/deep_str/id';

%mean_target_dir='/home/zhaoyi/mywork/tts/DeepLearning/deep_str/id/average';

%for i=[2,3,4,7]
	i=6;
	prj_name=['cmu',num2str(i)];
    nc_path=[csv_path filesep prj_name filesep '100sentences/nc'];


	train_input_path=[csv_path filesep prj_name filesep '100sentences/TRAIN'];
	train_target_path=[CMU_path filesep prj_name filesep 'data' filesep 'DNN_DATA_ALL2' filesep 'TRAIN'];
	train_input_dir=[train_input_path filesep 'csv'];
	train_target_dir=[train_target_path filesep 'TARGET'];

	nc_train=[nc_path filesep 'train.nc'];

	%mean_input_dir = train_input_dir;
	%mean_target_dir = train_target_dir;

	val_target_path=[CMU_path filesep prj_name filesep 'data' filesep 'DNN_DATA_ALL2' filesep 'VAL'];
	val_input_path=[csv_path filesep prj_name filesep '100sentences/VAL'];
	val_input_dir=[val_input_path filesep 'csv'];
	val_target_dir=[val_target_path filesep 'TARGET'];
	nc_val=[nc_path filesep 'val.nc'];

	test_input_path=[csv_path filesep prj_name filesep '100sentences/TEST'];
	test_target_path=[CMU_path filesep prj_name filesep 'data' filesep 'DNN_DATA_ALL2' filesep 'TEST'];
	test_input_dir=[test_input_path filesep 'csv'];
	test_target_dir=[test_target_path filesep 'TARGET'];
	nc_test=[nc_path filesep 'test.nc'];

	csv2nc(train_input_dir,train_target_dir,nc_train,train_target_dir);
	csv2nc(val_input_dir,val_target_dir,nc_val,train_target_dir);
	csv2nc(test_input_dir,test_target_dir,nc_test,train_target_dir);
%end
