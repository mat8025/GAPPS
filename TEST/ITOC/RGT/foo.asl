begin: ; d=date();  v=4; a= 2; b= 3 ; c= 0; <<"%V$a $b $c\n";
ooc: <<"@ooc\n";
alabel:  c = a+ b; <<"%V$c\n";  
end: <<" put at the end \n"; <<"%V$v\n"; <<"$d\n";

