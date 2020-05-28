
///
/// want some functionality with labels
/// like once only code
/// or don't compile ?
///
///  but can be used to sort code
///


  setdebug(1)

<<": this is not a label\n";


begin: d=date();  v=4; a= 2; b= 3 ; c= 0; <<"%V$a $b $c\n";
ooc: <<"@ooc\n";
alabel: c = a+ b; <<"%V$c\n";  
end: <<" put at the end \n"; <<"%V$v\n"; <<"$d\n";
int n= 0;
   while (1) {
   n++;

ooc: <<"ooc st sfter just once $n label\n" ; <<"ooc not apply to following st? $n\n"

alabel: <<"alabel st sfter label  " ;<<"here again $n\n"

   if (n > 5) break;
   h = n;
begin: g= n; <<"begin st sfter label  $n\n" ; 

   }


<<"%V$n $h $g \n"