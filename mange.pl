

#ex perl prepare_joblist.pl xxx.cnf 0

my $pcf = shift;  #parameter config file

my @para;


#my $L=shift;  #ligand
#my $R=shift;  #receptor

#my $init = "perl gogo.pl"." $L"." $R";

my $c=0;  #count
my @plist; #parameter list
my @clist; #Combination list and command

open FILE, "$pcf";
@para=<FILE>;
close FILE;

#my $in;
my @out;

chomp(@para);

my $j=0;

foreach $i(0...$#para){
	if($para[$i]=~/^#/){
		next;
	}
	if($para[$i]=~/^%%/){
		@tmp=split('\s+',$para[$i]);
		$plist[$j]=$para[$i];
		$j++;
		next;
	}
	if($para[$i]=~/^%in/){
                @tmp=split('\s+',$para[$i]);
                #$in=$tmp[1];
		chdir "$tmp[1]";
		#system("pwd");
                next;
        }
	if($para[$i]=~/^%out/){
                @tmp=split('\s+',$para[$i]);
                $out[0]=$tmp[1];
                $out[1]=$tmp[2];
		#print "$out[0] $out[1] \n";
                next;
        }

	#@tmp=split('\s+',$para[$i]);
	#print "$tmp[1]";
	#print "\nt1:$tmp[0] t2:$tmp[1] t3:$tmp[2]";
}

my $tc = 1; #combnation numbers so far

my $k = 0;

combmaker("", 0, 1);

foreach $i(0...$#clist){
	print "$clist[$i] \n";
	system("$clist[$i]");
}

system("cp -R $out[0] $out[1]");
system("rm -R $out[0]");

#print "\n";


sub combmaker{
	my $com = shift; #parameter string
	my $ps = shift; #point to the n-th parameter
	my $continue = shift; #is there still have next parameter?
	my @comd;
	my @tmp=split('\s+',$plist[$ps]);
	if ($ps+1 > $#plist){ $continue = 0;}
	foreach $i(1...$#tmp){

		$comd[$i] = "$com"." $tmp[$i]";
		if ($continue==0){
			$clist[$k] = $comd[$i];
			$k++;
		}
		else{
			combmaker($comd[$i], $ps+1, 1);
		}
	}
}
