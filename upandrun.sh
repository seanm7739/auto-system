
cd /home/biohadoop/PUDOCK/1013/jobdir/$1
#echo cp * /mnt/streaming-mod/input/PUDOCK/
cp *.gpf /mnt/streaming-mod/input/PUDOCK/
cp *.dpf /mnt/streaming-mod/input/PUDOCK/
cp *.pdbqt /mnt/streaming-mod/input/PUDOCK/
#echo ok..
#echo cp goodbox.ctf /home/biohadoop/PUDOCK/$1.ctf
cp goodbox.ctf /home/biohadoop/PUDOCK/$1.ctf
#echo ok..
cd /home/biohadoop/PUDOCK/
#echo pwd 
#echo nohup perl sth-bak.pl $1.ctf
nohup perl sth-bak.pl $1.ctf
#nohup perl sth-bak.pl $1.ctf
#nohup perl sth-bak.pl $1.ctf
#nohup perl sth-bak.pl $1.ctf
#nohup perl sth-bak.pl $1.ctf
#nohup perl sth-bak.pl $1.ctf
#nohup perl sth-bak.pl $1.ctf
#nohup perl sth-bak.pl $1.ctf

