CMU_path='/home/zhaoyi/mywork/tts/HTStry/Demo/CMU_STRAIGHT';
mgc_dim=25;
for i=4:7
	prj_name=['cmu',num2str(i)];
	prj_dir=[CMU_path filesep prj_name];
	par2vec(prj_dir,mgc_dim);
end
