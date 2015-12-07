data_path1='/home/zhaoyi/mywork/tts/DeepLearning/net/id/average_voice/test_average';
data_path2='/home/zhaoyi/mywork/tts/DeepLearning/net/id/average_voice/val_average';
data_path3='/home/zhaoyi/mywork/tts/DeepLearning/net/id/average_voice/train_average';
mean_file='/home/zhaoyi/mywork/tts/DeepLearning/file_matlab/ID_write/ID_G';
%for i=1:7
%	 file_name=['cmu',num2str(i)];
     file_name='cmu1';

	 file_input1=[data_path1 filesep file_name];
     file_input2=[data_path2 filesep file_name];
    file_input3=[data_path3 filesep file_name];
	 file_output1=[file_input1 filesep 'INPUT'];
     mkdir(file_output1);
file_output2=[file_input2 filesep 'INPUT'];
mkdir(file_output2);
file_output3=[file_input3 filesep 'INPUT'];
mkdir(file_output3);
	 csv2txt(file_input1,file_output1,mean_file);
    csv2txt(file_input2,file_output2,mean_file);
csv2txt(file_input3,file_output3,mean_file);
%end
