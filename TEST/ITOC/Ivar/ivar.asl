//%*********************************************** 
//*  @script ivar.asl 
//* 
//*  @comment test indirect var 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.64 C-He-Gd]                             
//*  @date Sat Aug 15 10:18:03 2020 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
   myScript = getScript();
//
   
   <<"$myScript\n"

include "debug"

if (_dblevel >0) {
   debugON()
}



   chkIn(_dblevel); 

   int v1 = 1;

<<"%V$v1\n"

v1->info(1)

   varname = "v1"; 

   $varname = 2;

<<"%V$v1\n"

   varname = "a1"; 
   
   $varname = 2;

   a1->info(1)
   
   <<"%V $a1 \n"; 

   varname->info(1)
   

   Record R[5];
   
   R[0] = Split("the best things in life are free");
   
   R[1] = Split("but you can give them to the birds and bees");
   
   R[2] = Split("just give me money that's what I want");
   
   R->info(1)
   
   rt0 = R[0];
   rt1 = R[1];
   rt2 = R[2];
   
   <<"R0: $R[0]\n"; 
   <<"R1: $R[1]\n"; 
   <<"R2: $R[2]\n"; 
   
   <<"$rt0 \n"; 
   <<"$rt1 \n"; 
   <<"$rt2 \n"; 
   
   <<"R: $R[::]\n"; 
   
   
   <<"%V$R[0][1]\n"; 
   
   varname = "a2"; 
   
   $varname = R;
   
   
   <<"a2:$a2[::]\n"; 
   
   <<"$a2[1]\n"; 
   
   <<"$(Caz(R)) $(Caz(R,0))  $(Caz(R,1))   \n";

  a2->info(1)
   

   int do_bops = 0; 
   
   do_bops = 3; 
   
   <<"%V$do_bops \n"; 
   
   wt = "do_bops"; 
   
   <<"%V$wt \n"; 
   
   $wt = 2; 
   
   <<" done indirect assignment \n"; 
   
   <<"%V$wt $do_bops \n"; 
   
   chkN (do_bops, 2); 
   
   silver = 47; 
   gold = 79; 
   metal = "silver"; 
   $wt = $metal; 
   
   <<"%V$wt $do_bops \n"; 
   
   chkN (do_bops, 47); 
   
   metal = "gold"; 
   
   $wt = $metal; 
   
   <<"%V$wt $do_bops \n"; 
   
   chkN (do_bops, gold); 
   
   
   n = 1;
   
   <<"%i$n \n"; 
   
   np = "n" ;
   
   $np = 3 ;
   
//    $np = 3
   
   <<"%i$n \n"; 
   
   <<"%V$np $n \n";
   
   <<"%i$n \n"; 
   
   chkN (n, 3); 
   
   
   a = np;
   
   <<"%V $n $a $np\n"; 
   
   b = $np; 
   
   <<"%v $n \n"; 
   
   <<" %v $b \n"; 
   
   <<" %V $a \n"; 
   
   
   <<" %v $b \n"; 
   <<" %v $np \n"; 
   <<"%i $n \n"; 
   
   
// double indirection
   
   ai = "np";
   c = $$ai;
   
   <<"%v $c\n"; 
   
   chkN (c, 3); 
   
//iread()
   d = $ai;
   
   <<"%v $d\n"; 
   
   chkStr (d, "n"); 
   
   <<"%v $c $d\n";
   
   $$ai = 4;
   
   e = $$ai;
   
   <<"%V$e \n"; 
   
   chkN (e, 4); 
   chkOut ();



/////////////////////////// TBD //////////////////////////////////
// 
