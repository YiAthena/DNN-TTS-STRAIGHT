for cmufile in /home/zhaoyi/mywork/tts/HTStry/Demo/CMU_STRAIGHT/cmu?; do
    cd $cmufile;
    ./configure --with-matlab-search-path=/usr/local/MATLAB/R2015a/bin \
                --with-straight-path=/home/zhaoyi/mywork/tts/HTStry/Source/STRAIGHT_SYN/STRAIGHT \
                --with-fest-search-path=/home/zhaoyi/mywork/tts/HTStry/Source/festival/examples \
                --with-sptk-search-path=/home/zhaoyi/software/bin \
                --with-hts-search-path=/usr/local/HTS-2.2/bin \
                --with-hts-engine-search-path=/usr/local/hts_engine_API-1.07/bin \
                SAMPFREQ=16000 \
                MGCORDER=25 \
                FRAMELEN=400 \
                FRAMESHIFT=80 \
                FFTLEN=1024 \
                LOWERF0=80 \
                UPPERF0=450
done
