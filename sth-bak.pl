$HADOOP_HOME='/opt/hadoop';
my $time=time();
mkdir "/mnt/streaming-mod/result/PUDOCK/$time";
#mkdir "/home/biohadoop/PUDOCK/$time";
if(@ARGV != 1){
   print "usage: perl submit_to_hadoop.pl [filename]\n";
   exit 0;
}

$filename = $ARGV[0];
system("echo $time $filename >> joblist");
if(!-e $filename){
   warn "error: filename not exist.\n";
   exit 0;
}
if(-e "ControlFile"){
   warn "error: ControlFile exist.\n";
   warn "delete ControlFile?(Y/N):";
 #  while(my $in=<STDIN>){
   while(my $in='y'){
      chomp($in);
      if($in =~ /[Yy]/){
         unlink "ControlFile";
         last;
      }elsif($in =~ /[Nn]/){
         print "program terminate\n";
         exit 0;
      }else{
         print "type Y/N:";
      }
   }
}
open(IN,"$filename");
open(OUT,">ControlFile");
my $i = 1;
while($in=<IN>){
   my @line = '';
   chomp $in;
   @line=split / /,$in;
   if($line[0] ne 'PUDOCK'){
      warn "error in line $i: $in";
   }else{
      print OUT "$line[1] $line[2] $line[3] $line[4] $time\n";
   }

   $i ++;
}
close(IN);
close(OUT);
#hadoop seg
system("$HADOOP_HOME/bin/hadoop fs -rmr pudock");
while(1){
	my $ret = system("$HADOOP_HOME/bin/hadoop fs -mkdir pudock");
	if(!$ret){last;}
        else{sleep 2;}
}
while(1){
        my $ret = system("$HADOOP_HOME/bin/hadoop fs -mkdir pudock/input");
	if(!$ret){last;}
        else{sleep 2;}
}
while(1){
        my $ret = system("$HADOOP_HOME/bin/hadoop fs -put ControlFile pudock/input/ControlFile");
	if(!$ret){last;}
        else{sleep 2;}
}

system("$HADOOP_HOME/bin/hadoop jar $HADOOP_HOME/contrib/streaming/hadoop-streaming-*.jar -D mapred.map.tasks.speculative.execution=false -D mapred.reduce.tasks=0 -D mapred.task.timeout=12000000 -inputformat org.apache.hadoop.mapred.lib.NLineInputFormat -output pudock/output -mapper PUDOCK -file PUDOCK -input pudock/input/ControlFile");
system("$HADOOP_HOME/bin/hadoop fs -rmr pudock");


#system("cat /mnt/streaming-mod/result/PUDOCK/$time/result-* > $time");
#system("cat /mnt/streaming-mod/result/PUDOCK/$time/$time > $time");
#system("cp /mnt/streaming-mod/result/PUDOCK/$time/* /home/biohadoop/PUDOCK/$time");
#system("mv /home/biohadoop/PUDOCK/$time /home/biohadoop/PUDOCK/$filename");
