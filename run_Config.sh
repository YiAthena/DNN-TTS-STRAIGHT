for cmufile in /home/zhaoyi/mywork/tts/HTStry/Demo/CMU/cmu?; do
	cd $cmufile;
#	make clean;
#	./configure --with-tcl-search-path=/usr/bin/tclsh8.4 \
#--with-fest-search-path=/home/zhaoyi/mywork/tts/HTStry/Source/festival/examples \
#--with-sptk-search-path=/hom/zhaoyi/software/bin \
#--with-hts-search-path=/usr/local/HTS-2.2/bin \
#__--with-hts-engine-search-path=/usr/local/hts_engine_API-1.07/bin \
#SAMPFREQ=16000 \
#MGCORDER=25 \
#FRAMELEN=400 \
#FRAMESHIFT=80 \
#FFTLEN=256 \
#LOWERF0=80 \
#UPPERF0=450 

cd data;

#make analysis;
make labels;

done
