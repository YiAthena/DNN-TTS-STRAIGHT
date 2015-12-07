%csv2txt1(file_input,file_output,mean_file)
file_path='/home/zhaoyi/mywork/tts/DeepLearning/deep_str/baseline/cmu3/result3';
file_output=file_path;
file_input=[file_path filesep 'csv'];
mean_file='/home/zhaoyi/mywork/tts/HTStry/Demo/CMU_STRAIGHT/cmu3/data/DNN_DATA_ALL2/TRAIN/TARGET';

csv2txt1(file_input,file_output,mean_file);