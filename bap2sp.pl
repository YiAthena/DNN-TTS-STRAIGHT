# MATLAB & STRAIGHT
$MATLAB   = 'matlab -nodisplay -nosplash -nojvm';
$STRAIGHT = '/home/zhaoyi/software/STRAIGHT_hashib/STRAIGHTV40_006b';

# speech analysis
$sr = 16000;   # sampling rate (Hz)
$fs = 80; # frame period (point)
$fw = 0.42;   # frequency warping
$gm = 0;      # pole/zero representation weight
$FFTLEN=1024;
$software_dir = '/home/zhaoyi/software/bin';
$BCP = "$software_dir/bcp";
$DFS = "$software_dir/dfs";
$INTERPOLATE = "$software_dir/interpolate";
$MERGE = "$software_dir/merge";

$MGC2SP      = "$software_dir/mgc2sp";

#$vudir="/home/zhaoyi/mywork/tts/HTStry/Demo/CMU_STRAIGHT/cmu3/data";

$gendir = '/home/zhaoyi/mywork/tts/DeepLearning/deep_str/baseline/cmu3/result3';

$mgcdir="$gendir/mgc";

$lf0dir="$gendir/lf0";
$vudir="$gendir/vu";
$wavdir="$gendir/wav";
$apdir="$gendir/ap";
$spdir="$gendir/sp";
$f0dir="$gendir/f0";
$bapdir="$gendir/bap";

$fileExist = -e $wavdir;
if ($fileExist==0) {
    mkdir $wavdir;
};
$fileExist = -e $apdir;
if ($fileExist==0) {
    mkdir $apdir;
};
$fileExist = -e $spdir;
if ($fileExist==0) {
    mkdir $spdir;
};
$fileExist = -e $f0dir;
if ($fileExist==0) {
    mkdir $f0dir;
};

@csvlist = glob("$gendir/csv/*.csv");

open( SYN, ">>$gendir/synthesis.m" ) || die "Cannot open $!";
printf SYN "path(path,'%s');\n",                   ${STRAIGHT};
printf SYN "prm.spectralUpdateInterval = %f;\n\n", 1000.0 * $fs / $sr;



foreach $csvdata(@csvlist){
$base;
&getbasename($csvdata);
    #$base = 'arctic_a0001';
$bap = "$bapdir/$base.bap";
$mgc = "$mgcdir/$base.mgc";
shell( "$MGC2SP -a $fw -g 0 -m 25 -l 1024 -o 2 $mgc > $spdir/$base.sp" );
$T = lf02f0( $base, $gendir );
$uv = "$gendir/vu/$base.vu";

shell("$BCP +f -l 26 -L 1 -s  0 -e  0 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p   1 | ${DFS} -a 1 -1 > /$apdir/$base.ap01");
         shell("$BCP +f -l 26 -L 1 -s  1 -e  1 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p   2 | ${DFS} -a 1 -1 > /$apdir/$base.ap02");
         shell("$BCP +f -l 26 -L 1 -s  2 -e  2 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p   2 | ${DFS} -a 1 -1 > /$apdir/$base.ap03");
         shell("$BCP +f -l 26 -L 1 -s  3 -e  3 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p   2 | ${DFS} -a 1 -1 > /$apdir/$base.ap04");
         shell("$BCP +f -l 26 -L 1 -s  4 -e  4 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p   2 | ${DFS} -a 1 -1 > /$apdir/$base.ap05");
         shell("$BCP +f -l 26 -L 1 -s  5 -e  5 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p   2 | ${DFS} -a 1 -1 > /$apdir/$base.ap06");
         shell("$BCP +f -l 26 -L 1 -s  6 -e  6 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p   3 | ${DFS} -a 1 -1 > /$apdir/$base.ap07");
         shell("$BCP +f -l 26 -L 1 -s  7 -e  7 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p   3 | ${DFS} -a 1 -1 > /$apdir/$base.ap08");
         shell("$BCP +f -l 26 -L 1 -s  8 -e  8 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p   3 | ${DFS} -a 1 -1 > /$apdir/$base.ap09");
         shell("$BCP +f -l 26 -L 1 -s  9 -e  9 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p   3 | ${DFS} -a 1 -1 > /$apdir/$base.ap10");
         shell("$BCP +f -l 26 -L 1 -s 10 -e 10 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p   4 | ${DFS} -a 1 -1 > /$apdir/$base.ap11");
         shell("$BCP +f -l 26 -L 1 -s 11 -e 11 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p   4 | ${DFS} -a 1 -1 > /$apdir/$base.ap12");
         shell("$BCP +f -l 26 -L 1 -s 12 -e 12 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p  5 | ${DFS} -a 1 -1 > /$apdir/$base.ap13");
         shell("$BCP +f -l 26 -L 1 -s 13 -e 13 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p  6 | ${DFS} -a 1 -1 > /$apdir/$base.ap14");
         shell("$BCP +f -l 26 -L 1 -s 14 -e 14 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p  7 | ${DFS} -a 1 -1 > /$apdir/$base.ap15");
         shell("$BCP +f -l 26 -L 1 -s 15 -e 15 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p  8 | ${DFS} -a 1 -1 > /$apdir/$base.ap16");
         shell("$BCP +f -l 26 -L 1 -s 16 -e 16 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p  10 | ${DFS} -a 1 -1 > /$apdir/$base.ap17");
         shell("$BCP +f -l 26 -L 1 -s 17 -e 17 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p  12 | ${DFS} -a 1 -1 > /$apdir/$base.ap18");
         shell("$BCP +f -l 26 -L 1 -s 18 -e 18 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p  14 | ${DFS} -a 1 -1 > /$apdir/$base.ap19");
         shell("$BCP +f -l 26 -L 1 -s 19 -e 19 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p  19 | ${DFS} -a 1 -1 > /$apdir/$base.ap20");
         shell("$BCP +f -l 26 -L 1 -s 20 -e 20 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p  25 | ${DFS} -a 1 -1 > /$apdir/$base.ap21");
         shell("$BCP +f -l 26 -L 1 -s 21 -e 21 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p  34 | ${DFS} -a 1 -1 > /$apdir/$base.ap22");
         shell("$BCP +f -l 26 -L 1 -s 22 -e 22 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p  49 | ${DFS} -a 1 -1 > /$apdir/$base.ap23");
         shell("$BCP +f -l 26 -L 1 -s 23 -e 23 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p 80 | ${DFS} -a 1 -1 > /$apdir/$base.ap24");
         shell("$BCP +f -l 26 -L 1 -s 24 -e 24 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p 150 | ${DFS} -a 1 -1 > /$apdir/$base.ap25");
         shell("$BCP +f -l 26 -L 1 -s 25 -e 25 -S 0 $bap | ${DFS} -b 1 -1 | ${INTERPOLATE} -p 63 | ${DFS} -a 1 -1 > /$apdir/$base.ap26");

         $line = "cat                         /$apdir/$base.ap01 | ";
         $line .= "$MERGE -s    1 -l     1 -L   2 /$apdir/$base.ap02 | ";
         $line .= "$MERGE -s    3 -l     3 -L   2 /$apdir/$base.ap03 | ";
         $line .= "$MERGE -s    5 -l     5 -L   2 /$apdir/$base.ap04 | ";
         $line .= "$MERGE -s    7 -l     7 -L   2 /$apdir/$base.ap05 | ";
         $line .= "$MERGE -s    9 -l     9 -L   2 /$apdir/$base.ap06 | ";
         $line .= "$MERGE -s   11 -l    11 -L   3 /$apdir/$base.ap07 | ";
         $line .= "$MERGE -s   14 -l    14 -L   3 /$apdir/$base.ap08 | ";
         $line .= "$MERGE -s   17 -l    17 -L   3 /$apdir/$base.ap09 | ";
         $line .= "$MERGE -s   20 -l    20 -L   3 /$apdir/$base.ap10 | ";
         $line .= "$MERGE -s   23 -l    23 -L   4 /$apdir/$base.ap11 | ";
         $line .= "$MERGE -s   27 -l    27 -L   4 /$apdir/$base.ap12 | ";
         $line .= "$MERGE -s   31 -l    31 -L  5 /$apdir/$base.ap13 | ";
         $line .= "$MERGE -s   36 -l    36 -L  6 /$apdir/$base.ap14 | ";
         $line .= "$MERGE -s   42 -l    42 -L  7 /$apdir/$base.ap15 | ";
         $line .= "$MERGE -s   49 -l    49 -L  8 /$apdir/$base.ap16 | ";
         $line .= "$MERGE -s   57 -l    57 -L  10 /$apdir/$base.ap17 | ";
         $line .= "$MERGE -s   67 -l    67 -L  12 /$apdir/$base.ap18 | ";
         $line .= "$MERGE -s   79 -l    79 -L  14 /$apdir/$base.ap19 | ";
         $line .= "$MERGE -s   93 -l    93 -L  19 /$apdir/$base.ap20 | ";
         $line .= "$MERGE -s  112 -l   112 -L  25 /$apdir/$base.ap21 | ";
         $line .= "$MERGE -s  137 -l   137 -L  34 /$apdir/$base.ap22 | ";
         $line .= "$MERGE -s  171 -l   171 -L  49 /$apdir/$base.ap23 | ";
         $line .= "$MERGE -s  220 -l   220 -L 80 /$apdir/$base.ap24 | ";
         $line .= "$MERGE -s  300 -l   300 -L 150 /$apdir/$base.ap25 | ";
         $line .= "$MERGE -s  450 -l   450 -L 63 /$apdir/$base.ap26 > /$apdir/$base.ap";
         shell($line);
    
  printf SYN "fprintf(1,'Synthesizing %s');\n", "$wavdir/$base.wav";

         printf SYN "fid1 = fopen('%s','r','%s');\n",  "$spdir/$base.sp", "ieee-le";
         printf SYN "fid2 = fopen('%s','r','%s');\n",  "/$apdir/$base.ap", "ieee-le";
         printf SYN "fid3 = fopen('%s','r','%s');\n",  "$f0dir/$base.f0", "ieee-le";
         printf SYN "fid4 = fopen('%s','r','%s');\n",  "$vudir/$base.vu", "ieee-le";

         printf SYN "sp = fread(fid1,[%d, %d],'float');\n", $FFTLEN/2+1,  $T;
         printf SYN "ap = fread(fid2,[%d, %d],'float');\n", $FFTLEN/2+1, $T;
         printf SYN "f0 = fread(fid3,[%d, %d],'float');\n", 1,    $T;
	
	printf SYN "vu = fread(fid4,'float');\n";
	
	printf SYN "len_vu = length(vu);\n";

         print SYN "fclose(fid1);\n";
         print SYN "fclose(fid2);\n";
         print SYN "fclose(fid3);\n";
         print SYN "fclose(fid4);\n";

         print SYN "for i=1:${T}\n";
	  print SYN " if (i<=len_vu)\n";
         print SYN "  if(0.4>=vu(i))\n";
         print SYN "     f0(i)=0;\n";
         print SYN "  end\n";
	  print SYN " end\n";
	  print SYN " if (i>len_vu)\n";
	  print SYN "     f0(i)=0;\n";
	  print SYN " end\n";
         print SYN "end\n";

         printf SYN "[sy] = exstraightsynth(f0,sp,ap,%d,prm);\n", $sr;
         printf SYN "wavwrite( sy/max(abs(sy)), %d, '%s');\n\n", $sr, "$wavdir/$base.wav";

    #  print "done\n";
     
 
}
  close(SYN);
   print "Synthesizing waveform from STRAIGHT parameters...\n";
   shell("$MATLAB < $gendir/synthesis.m");
   print "done\n";


sub shell($) {
   my ($command) = @_;
   my ($exit);

   $exit = system($command);

   if ( $exit / 256 != 0 ) {
      die "Error in $command\n";
   }
}
sub lf02f0($$) {
   my ( $base, $gendir ) = @_;
   my ( $t, $T, $data );

   # read log f0 file
   open( IN, "$lf0dir/${base}.lf0" );
   @STAT = stat(IN);
   read( IN, $data, $STAT[7] );
   close(IN);

   # log f0 -> f0 conversion
   $T = $STAT[7] / 4;
   @frq = unpack( "f$T", $data );
   for ( $t = 0 ; $t < $T ; $t++ ) {
      if ( $frq[$t] == -1.0e+10 ) {
         $out[$t] = 0.0;
      }
      else {
         $out[$t] = exp( $frq[$t] );
      }
   }
   $data = pack( "f$T", @out );

   # output data
   open( OUT, ">$f0dir/${base}.f0" );
   print OUT $data;
   close(OUT);
   return $T;
}
sub getbasename{
    my($input)=@_;
    if ($input=~ /([^\/]+)\.csv/) {
        $base = $1;
        print "$base\n";
    }else{
        print "err in $input\n";
        exit;
    }
}
