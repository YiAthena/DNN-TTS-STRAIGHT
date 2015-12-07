file_input='/home/zhaoyi/mywork/tts/DeepLearning/net/net_syn_each/4/result';
%file_input='/home/zhaoyi/mywork/tts/DeepLearning/net/id/average_voice/test_average/cmu1';
%file_input='/home/zhaoyi/mywork/tts/DeepLearning/net/net_syn_each/7/result';
file_target='/home/zhaoyi/mywork/tts/HTStry/Demo/CMU/cmu4/data/DNN_DATA_ALL2/TEST/TARGET';
mean_file='/home/zhaoyi/mywork/tts/DeepLearning/file_matlab/ID_write/ID_G';
csv2wav(file_input,file_target,mean_file)