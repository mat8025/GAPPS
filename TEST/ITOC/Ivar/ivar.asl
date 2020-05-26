//%*********************************************** 
//*  @script ivar.asl 
//* 
//*  @comment test indirect var 15651var 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.50 C-He-Sn]                                
//*  @date Sat May 23 23:30:34 2020 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
   myScript = getScript();
//
// ivar
//
   
   ws= getScript(); 
   <<"$ws\n"; 
   
   
   checkIn(_dblevel); 
   
   Record R[5];
   
   R[0] = Split("the best things in life are free");
   
   R[1] = Split("but you can give them to the birds and bees");
   
   R[2] = Split("just give me money that's what I want");
   
   
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
   
   varname = "a1"; 
   
   $varname = 2;
   
   <<"%V $a1 $(typeof(a1))\n"; 
   
   
//<<"$R[1]\n"
   
   <<"%V$R[0][1]\n"; 
   
   varname = "a2"; 
   
   
   $varname = R;
   
   
   <<"a2:$a2[::]\n"; 
   
   <<"$a2[1]\n"; 
   
   <<"$(Caz(R)) $(Caz(R,0))  $(Caz(R,1))   \n"; 
   
   int do_bops = 0; 
   
   do_bops = 3; 
   
   <<"%V$do_bops \n"; 
   
   wt = "do_bops"; 
   
   <<"%V$wt \n"; 
   
   $wt = 2; 
   
   <<" done indirect assignment \n"; 
   
   <<"%V$wt $do_bops \n"; 
   
   checkNum (do_bops, 2); 
   
   silver = 47; 
   gold = 79; 
   metal = "silver"; 
   $wt = $metal; 
   
   <<"%V$wt $do_bops \n"; 
   
   checkNum (do_bops, 47); 
   
   metal = "gold"; 
   
   $wt = $metal; 
   
   <<"%V$wt $do_bops \n"; 
   
   checkNum (do_bops, gold); 
   
   
   n = 1;
   
   <<"%i$n \n"; 
   
   np = "n" ;
   
   $np = 3 ;
   
//    $np = 3
   
   <<"%i$n \n"; 
   
   <<"%V$np $n \n";
   
   <<"%i$n \n"; 
   
   checkNum (n, 3); 
   
   
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
   
   checkNum (c, 3); 
   
//iread()
   d = $ai;
   
   <<"%v $d\n"; 
   
   checkStr (d, "n"); 
   
   <<"%v $c $d\n";
   
   $$ai = 4;
   
   e = $$ai;
   
   <<"%V$e \n"; 
   
   checkNum (e, 4); 
   checkOut ();
   
