for cmufile in /home/zhaoyi/mywork/tts/HTStry/Demo/CMU_STRAIGHT/cmu1; do
#	cd $cmufile;
#prjdir=$cmufile;
#	bash path;
#	make clean;
#	cd data;
#	rm -rf lists;
#	make list;
#	make scp;
   perl H2.pl $cmufile
done
