
@all_prjdir = ("/home/zhaoyi/mywork/tts/HTStry/Demo/CMU_STRAIGHT/cmu1",
    "/home/zhaoyi/mywork/tts/HTStry/Demo/CMU_STRAIGHT/cmu2",
    "/home/zhaoyi/mywork/tts/HTStry/Demo/CMU_STRAIGHT/cmu3",
    "/home/zhaoyi/mywork/tts/HTStry/Demo/CMU_STRAIGHT/cmu4",
    "/home/zhaoyi/mywork/tts/HTStry/Demo/CMU_STRAIGHT/cmu5",
    "/home/zhaoyi/mywork/tts/HTStry/Demo/CMU_STRAIGHT/cmu6",
    "/home/zhaoyi/mywork/tts/HTStry/Demo/CMU_STRAIGHT/cmu7");

$para_N=53;
@all_filelist;
&SetSeqSymbol();
&SetCarte();

$all_list = "/home/zhaoyi/mywork/tts/HTStry/Demo/CMU_STRAIGHT/all_list";
$fileExist=-e $all_list;
if($fileExist==0){
    mkdir $all_list;
};

foreach $prjdir (@all_prjdir){
    @filelist=glob("$prjdir/data/labels/full/*.lab");
    foreach $file (@filelist){
        push (@all_filelist, $file);
    }
}

foreach $file(@all_filelist){
    &getparalist($file);
};


for(my $n=0;$n<$para_N;$n++){
    
    $name="para".$n;
    print "1 @{$name}\n";
    my $listfile="$all_list/$n.list";
    @{$name}=&mysort(@{$name});
    open(OUT,">$listfile");
    $ ,="\n";
    #print "@{$name}\n";
    print OUT "@{$name}\n";
    
    close(OUT);
    #exit;
};

for (my $n=0;$n<$para_N;$n++){
    $name="para".$n;
    $name2="id".$n;
    for (my $m=0;$m<=$#{$name};$m++){
        ${$name2}{${$name}[$m]}=$m;

    }
    #  print "${$name2}\n";
};

foreach $prjdir (@all_prjdir){
    $datadir="$prjdir/data";
    $PHONE="$datadir/labels/full";
    $DNNDATA="$datadir/DNNDATA2";
    @filelist=glob("$PHONE/*.lab");

    $fileExist=-e $DNNDATA;
    if($fileExist==0){
        mkdir $DNNDATA;
    };
    foreach $file (@filelist){
        my $basename;
        if ($file=~/([^\/]+)\.lab/){
            $basename=$1;
         }
        $file2="$DNNDATA/$basename.dnn";
        print "$file -> $file2 \n";
        &hts2dnn($file,$file2);
}
   
}

sub getparalist($){
    (my $input, my $output)=@_;
    open (IN, $input)||die "can not open $input \n";
    while ($line=<IN>){
        @para;
        #        print "$line \n";
#        exit;
        $line =~ s/\r//g;
        $line =~ s/\n//g;
        @temp=split(/[\s\t]+/,$line);
        shift(@temp);
        shift(@temp);
        shift(@temp);
        # print "1@temp\n";
        for ($mm=0;$mm<$para_N-1;$mm++){
            $isSeq = isSeqSymbol($mm);
            $temp[0]=~ s/$isSeq/\t/;
            @temp=split(/\t/,$temp[0]);
            $para[$mm]=$temp[0];
            #   print "$para[$m]\n";
            shift(@temp);
            # print "2@temp\n";
            #print "$para[$m]\n";
            
        }
        $para[52]=$temp[0];
        #        print "@para\n";
        #         print "$#para\n";
#        exit;
        if ($#para!=$para_N-1){
            print "err in 1\n";
        }
        for ($n=0;$n<=$#para;$n++){
            $name="para".$n;
            push(@{$name}, $para[$n]);
        }
    }
}

sub mysort(@){
    my @array=@_;
    my $X="_";
    my @sort;
    my $n;
    @array=sort @array;
    for (my $n = 0; $n < $#array; $n++) {
        if ($X ne $array[$n]) {
            push(@sort, $array[$n]);
            $X=$array[$n];
            # body...
        }
    }
    return @sort;
}

sub hts2dnn($$){
    (my $input, my $output)=@_;
    open(IN, $input) || die"can not open $input";
    open(OUT,">$output") || die "can not open $output";
    while ($line=<IN>){
        @para;
        #       print "$line \n";
        #        exit;
        $line =~ s/\r//g;
        $line =~ s/\n//g;
        @temp=split(/[\s\t]+/,$line);
        shift(@temp);
        shift(@temp);
        shift(@temp);
        # print "1@temp\n";
        for ($mm=0;$mm<$para_N-1;$mm++){
            $isSeq = isSeqSymbol($mm);
            $temp[0]=~ s/$isSeq/\t/;
            @temp=split(/\t/,$temp[0]);
            $para[$mm]=$temp[0];
            #   print "$para[$m]\n";
            shift(@temp);
            
        }
        $para[52]=$temp[0];
        # print "@para\n";
        #   print "$#para\n";
        #       exit;
        if ($#para!=$para_N-1){
            print "err in 2\n";
        }
        for ($n=0;$n<=$#para;$n++){
            $isCarte = isCategory($n);
            if ($isCarte==1) {
                $name="para".$n;
                $name2="id".$n;
                for($m=0;$m<=$#{$name};$m++){
                    if (${$name2}{$para[$n]}==$m) {
                        print OUT "1 ";
                    }
                    else {
                        print OUT "0 ";
                    }

                }
                # body...
            }
            else{
                if ($para[$n]eq "x"){
                    print OUT "0 ";

                }else {
                    my $vec=$para[$n]+1;
                    print OUT "$vec ";
                }

            }


        }
        print OUT "\n";
    }
        close(IN);
        close(OUT);
}

sub isSeqSymbol($){
    $m =$_[0];
    return @sep[$m];
}

sub isCategory($){
    my $i =$_[0];
    return @category[$n];
}

sub SetSeqSymbol{
@sep=(
    '\^',
    '\-',
    '\+',
    '\=',
    '\@',
    '\_',
    '\/A\:',
    '\_',
    '\_',
    '\/B\:',
    '\-',
    '\-',
    '\@',
    '\-',
    '\&',
    '\-',
    '\#',
    '\-',
    '\$',
    '\-',
    '\!',
    '\-',
    '\;',
    '\-',
    '\|',
    '\/C\:',
    '\+',
    '\+',
    '\/D\:',
    '\_',
    '\/E\:',
    '\+',
    '\@',
    '\+',
    '\&',
    '\+',
    '\#',
    '\+',
    '\/F\:',
    '\_',
    '\/G\:',
    '\_',
    '\/H\:',
    '\=',
    '\^',
    '\=',
    '\|',
    '\/I\:',
    '\=',
    '\/J\:',
    '\+',
    '\-'
    );
};

sub SetCarte {
    @category=(
    1,#    p1 the phoneme identity before the previous phoneme
    1,#    p2 the previous phoneme identity
    1,#    p3 the current phoneme identity
    1,#    p4 the next phoneme identity
    1,#    p5 the phoneme after the next phoneme identity
    0,#    p6 position of the current phoneme identity in the current syllable (forward)
    0,#    p7 position of the current phoneme identity in the current syllable (backward)
    0,#    a1 whether the previous syllable stressed or not (0: not stressed, 1: stressed)
    0,#    a2 whether the previous syllable accented or not (0: not accented, 1: accented)
    0,#    a3 the number of phonemes in the previous syllable
    0,#    b1 whether the current syllable stressed or not (0: not stressed, 1: stressed)
    0,#    b2 whether the current syllable accented or not (0: not accented, 1: accented)
    0,#    b3 the number of phonemes in the current syllable
    0,#    b4 position of the current syllable in the current word (forward)
    0,#    b5 position of the current syllable in the current word (backward)
    0,#    b6 position of the current syllable in the current phrase (forward)
    0,#    b7 position of the current syllable in the current phrase (backward)
    0,#    b8 the number of stressed syllables before the current syllable in the current phrase
    0,#    b9 the number of stressed syllables after the current syllable in the current phrase
    0,#    b10 the number of accented syllables before the current syllable in the current phrase
    0,#    b11 the number of accented syllables after the current syllable in the current phrase
    0,#    b12 the number of syllables from the previous stressed syllable to the current syllable
    0,#    b13 the number of syllables from the current syllable to the next stressed syllable
    0,#    b14 the number of syllables from the previous accented syllable to the current syllable
    0,#    b15 the number of syllables from the current syllable to the next accented syllable
    1,#    b16 name of the vowel of the current syllable
    0,#    c1 whether the next syllable stressed or not (0: not stressed, 1: stressed)
    0,#    c2 whether the next syllable accented or not (0: not accented, 1: accented)
    0,#    c3 the number of phonemes in the next syllable
    1,#    d1 gpos (guess part-of-speech) of the previous word
    0,#    d2 the number of syllables in the previous word
    1,#    e1 gpos (guess part-of-speech) of the current word
    0,#    e2 the number of syllables in the current word
    0,#    e3 position of the current word in the current phrase (forward)
    0,#    e4 position of the current word in the current phrase (backward)
    0,#    e5 the number of content words before the current word in the current phrase
    0,#    e6 the number of content words after the current word in the current phrase
    0,#    e7 the number of words from the previous content word to the current word
    0,#    e8 the number of words from the current word to the next content word
    1,#    f1 gpos (guess part-of-speech) of the next word
    0,#    f2 the number of syllables in the next word
    0,#    g1 the number of syllables in the previous phrase
    0,#    g2 the number of words in the previous phrase
    0,#    h1 the number of syllables in the current phrase
    0,#    h2 the number of words in the current phrase
    0,#    h3 position of the current phrase in this utterance (forward)
    0,#    h4 position of the current phrase in this utterance (backward)
    1,#    h5 TOBI endtone of the current phrase
    0,#    i1 the number of syllables in the next phrase
    0,#    i2 the number of words in the next phrase
    0,#    j1 the number of syllables in this utterance
    0,#    j2 the number of words in this utterance
    0#    j3 the number of phrases in this utterance
    )
    # body...
}
