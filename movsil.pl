#$| = 1;
#
#if ( @ARGV < 1 ) {
#    print "usage: movsil.pl Config_movsil.pm\n";
#    exit(0);
#}
#/private/var/folders/cc/w2j2x_fx4g13zlkgthyr97sr0000gn/T/fz3temp-1/movsil.pl
## load configuration variables
#require( $ARGV[0] );
$prjdir=$ARGV[0];
#$prjdir = "/home/zhaoyi/mywork/tts/HTStry/Demo/HTS-demo_CMU-ARCTIC-SLT";
$datdir = "$prjdir/data";
$DNN_DATA_ALL="$datdir/DNN_DATA_ALL2";

$DNNDATA = "$datdir/DNNDATA2";
$ALIGN = "$datdir/statealign";

$VECDATA = "$DNN_DATA_ALL/labelstatenum";
$VECOUT = "$DNN_DATA_ALL/INPUT_label";

$MGCLF0="$datdir/par_dy";
$MGCOUT="$DNN_DATA_ALL/TARGET";

#$VECDATA="$DNN_DATA_ALL/labelstatenum";



$fileExist = -e $DNN_DATA_ALL;
if ($fileExist==0) {
    mkdir $DNN_DATA_ALL;
};

$fileExist = -e $VECDATA;
if ($fileExist==0) {
mkdir $VECDATA;
};
$fileExist = -e $VECOUT;
if ($fileExist==0) {
mkdir $VECOUT;
};
$fileExist = -e $MGCOUT;
if ($fileExist==0) {
mkdir $MGCOUT;
};

#rmove("$datdir/DNNDATA", "$DNN_DATA_ALL/");
#rmove("$datdir/statealign" , "$DNN_DATA_ALL/");
#rmove("$datdir/par_dy" , "$DNN_DATA_ALL/");

@alignlist = glob("$ALIGN/*.lab");

foreach $aligndata(@alignlist){
	my @PAUSEtime;
	$basename;

	&getbasename($aligndata);
    #	&getPAUSEtime($aligndata,@PAUSEtime);

	$DNNDATAdata = "$DNNDATA/$basename.dnn";
	&getVECdata($aligndata,$DNNDATAdata,$basename);

	$fid_vec = "$VECDATA/$basename.dnn";
	$fid_vecout = "$VECOUT/$basename.input";
    #	&getdata($fid_vec,$fid_vecout,@PAUSEtime);
    &getdata($fid_vec,$fid_vecout);
	$fid_mgc = "$MGCLF0/$basename.target";
	$fid_mgcout = "$MGCOUT/$basename.target";
    &getdata($fid_mgc,$fid_mgcout);
    #&getdata($fid_mgc,$fid_mgcout,@PAUSEtime);
}

sub getVECdata{
	my($align,$DNNDATA,$basename) = @_;
	my $output = "$VECDATA/$basename.dnn";
	my @framenum;
	my @statenum;
	my $count=0;
    
	open(ALIGN, $align) || die "can not open 1 $align \n";
	open(OUT, ">$output") || die "can not open 2 $output\n";
	open(PHONE, $DNNDATA) || die "can not open 3 $DNNDATA\n";
   
	while (my $line=<ALIGN>) {
		$line =~ s/\r\n//g;
		$line =~ s/[^0-9]/\t/g;
#        $line =~ s/\s\t/\t/g;
	    my @temp = split(/[\s\t]+/,$line);
#get frame number -------------------------------------------
		my $num = (@temp[1]-@temp[0])/50000;
		push (@framenum, $num);
        
#get state number -------------------------------------------
#		shift(@temp); 
#		shift(@temp);
#        print "$#temp\n";
       
        push(@statenum,@temp[2]);
#         print "@statenum\n";
#         exit;
#        @statenum=@temp[2];
#		foreach my $tmp (@temp){
#			push(@statenum,$tmp);
#		}
	}
    my $i=0;# total framenumber
	while (my $line = <PHONE>) {
		
		$line =~ s/\r\n//g;
		my @temp = split(/[\s\t]+/,$line);
        #shift(@temp);
        #shift(@temp);
        
		for (my $jj = 0; $jj < 5; $jj++) {
			my @temp2=@temp;
			push(@temp2,shift(@statenum));
			for (my $n = 0; $n < @framenum[$count]; $n++) {
				my @temp3 = @temp2;
				push (@temp3, $n+1);
                $i=$i+1;
				print OUT "$i\t@temp3 \n";
			}
			$count++;
		}
	}
}

# sub getdata{
# 	my($input,$output,@deltime) = @_;
# 	open(IN, $input) || die "can not open 4 $input\n";
# 	open(OUT, ">$output") || die "can not open 5 $output\n";
# 	my $i=0;
#     print @deltime;
#     exit;
#     my $num_del= shift @deltime;
# 	while (my $line=<IN>) {
# 	 	if(!($i!= $num_del)){
#             print OUT "$i\t$line";
#             # 		print OUT "$line";
# 	 	}
#         else{
#             $num_del= shift @deltime;
#         }

# 	 $i=$i+1;
# 	 }
# }
sub getdata{
    my($input,$output) = @_;
    open(IN, $input) || die "can not open 4 $input\n";
    open(OUT, ">$output") || die "can not open 5 $output\n";
    #   binmode(OUT);
    # my $i=1;
   
        while (my $line=<IN>) {
            # print OUT "$i\t$line";
            print OUT "$line";
            #     $i=$i+1;
            #exit;
    }
    
}
sub getbasename{
	my($input)=@_;
	if ($input=~ /([^\/]+)\.lab/) {
		$basename = $1;
		print "$basename\n";
	}else{
		print "err in $input\n";
		exit;
	}
}

sub getPAUSEtime($$){
	(my $input, my @output) = @_;
	open(IN, $input)|| die "can not open 6 $input\n";
	my $num_line=0;
	my $temp3=0;
	my $count=0;
	my @starttime;
	my @endtime;
	while (my $line = <IN>){
		if($line =~ /pau/){
			if(!($temp3 =~ /pau/)){
				my $temp1;
				my $num1;
				my $line1 = $line;
				$line1 =~ s/\r\n//g;
				$line1 =~ s/[^0-9]/ /g;
				@temp1=split(/[\s\t]+/,$line1);
				if (0==$count) {
					$num1=0;
				}else{
					$num1=@temp1[1]/50000-1;
				}
				push(@starttime,$num1);
			}

		}
		if(!($line =~ /pau/)&&($temp3 =~ /pau/)){
			my $temp1;
			my $num1;
			my $line1=$temp3;
			   $line1=~s/\r\n//g;
			   $line1 =~ s/[^0-9]/ /g;
			   @temp1=split(/[\s\t]+/,$line1);
			   $num1=@temp1[1]/50000-1;
			   push(@endtime,$num1);
		}
		$temp3 = $line;
		$count = $count+1;

	}
		$temp3 =~ s/\r\n//g;
		$temp3 =~ s/[^0-9]/ /g;
		my @temp4 = split(/[\s\t]+/,$temp3);
		my $num2 = @temp4[1]/50000-1;
		push(@endtime,$num2);
		for (my $i = 0; $i <=$#starttime; $i++) {
			for (my $j = @starttime[$i]; $j < @endtime[$i]; $j++){
				push(@output,$j);
			}
		}
}




















