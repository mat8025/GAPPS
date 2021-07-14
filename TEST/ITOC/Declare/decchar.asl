//%*********************************************** 
//*  @script dec-char.asl 
//* 
//*  @comment test declare of char vector 
//*  @release CARBON 
//*  @vers 1.4 Be Beryllium                                                
//*  @date Fri Apr 12 16:13:07 2019 
//*  @cdate 1/1/2000 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%



Z="hey"

<<"%V $Z\n"

chkStr(Z,"hey");

S="hey";

<<"%V $S\n"

chkStr(S,"hey");

V="hey"  // gets hey"

<<"%V $V\n"

chkStr(V,"hey");




char c2 = 65;
char p2 = 'q';

<<"%V $c2 $p2 \n"
<<"%V %c$c2 %c$p2 \n"

<<"%V $c2\n"
<<"%V $p2\n"


str s = "abc"

<<"%V $s %s$s \n"

str tease = "a b c "

//FIXIT missing varname


tease->info(1)
<<"<|$tease|> \n"

uchar cv[] = { 65,47,79,0xBA };


 sz= Caz(cv)
 
<<"%V$sz $cv \n"

 cve = cv[0]

<<"%V$cve\n"
<<"%V$cv[0]\n"

 chkN(cve,65)



 cv[0] = 'M';
 
 cve = cv[0]

<<"%V$cve\n"
<<"%V$cv[0]\n"

 chkN(cv[0],77)



 str ls = 'abc'

 chkN(cv[3],0xBA)



<<"%V %hx $cv \n"
<<"%V %s $cv \n"

wc = scnt("G")

<<"%V $wc $(typeof(wc))\n"

int iv[] = { 0,1,2,3,4,5,6,7,8,9, }

iv->info(1)
<<" $iv \n"


char dv[] = { 'G', 84, 85, 78, 'O', 69,  75,76,77,'0' }


<<"$(vinfo(dv))\n"
<<"$dv \n"
<<"%c $dv \n"
sz= Caz(dv)
<<"%V $sz\n"
dv->info(1)

chkN(dv[0], 'G' )
chkN(dv[1], 84 )




chkN(dv[2], 85 )
   chkN(dv[3], 78 )
 chkN(dv[4], 'O' )
 chkN(dv[5], 69 )
 chkN(dv[6], 75 )
  chkN(dv[7], 76 )
 chkN(dv[8], 77 )
 chkN(dv[9], '0' )

char ev[] = { 71, 84, 85, 78, 79, 48, 69, 75,76,77 }

<<"$ev \n"




char a = 'G';

<<" $(vinfo(a)) \n"

<<"%V $dv[0] $a \n"

 chkN(dv[0],a)

 chkN(dv[0], wc )

 chkN(dv[0], 'G' )
<<"%V $dv  \n"

<<"%V $dv[1]  \n"

 chkN(dv[1],84)



  char b = dv[4];

<<"%V $b %d $b\n"
<<"%V $dv[4]\n";

<<"dv %d $dv\n"
<<"dv %c $dv\n"

 printargs(dv[4],'O')
 chkN(dv[4], 'O' )
  chkN(dv[4], 79 )




<<" whaat is happening here $dv[5] \n"

 tc = scnt("0");

<<"%V $tc\n";
<<"%V %d $dv[5]\n";


chkN(dv[4], scnt("O") )
<<" Imm not really cleaaaaaaar \n" 


 chkN(dv[4], 'O' )


char lv[] = { 'ABCDEF MARK$S PERRY NEEDS TO FOCUS ' }

sz = Caz(lv)
<<"%v $sz \n"
<<"%V $lv \n"

<<" $lv[0] \n"
<<" $lv[1] \n"
//iread("->");

char fv[] = { "ABCDEF MARK$S BERRY NEEDS TO FOCUS " }


<<"%V$fv \n"
sz = Caz(fv)
<<"%v $sz \n"

<<"%V %c $fv \n"
<<"%V $fv \n"

//iread("->");

 chkN(fv[0],'A')
 chkN(fv[7],'M')

<<"%V %s $lv \n"

 chkN(lv[0],'A')
 chkN(lv[7],'M')
 chkN(lv[11],'$')


 <<" chardec DONE\n"

for (k=0;k<sz;k++) {

<<"$k $fv[k] %c $fv[k] \n"
}




 chkOut()
