
#sleep 600

#perl mangev2.pl upacet.ptr 0

#perl mangev2.pl lig3.ptr jobdir/0602lig3
#perl mangev2.pl 0602up.ptr 0

/usr/bin/time -o time_0923.txt -a -f "Real time: %e\tUser time: %U\tSys time: %S\tg" perl mangev2.pl 0923all.ptr jobdir/0923all
perl mangev2.pl 0923allup.ptr 0
