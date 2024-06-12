//%*********************************************** 
//*  @script ptr_varvec.asl 
//* 
//*  @comment test ptr and indirect var use 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Wed Jun 26 09:51:56 2019 
//*  @cdate Wed Jun 26 09:51:56 2019 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%
   
   chkIn(); 
   
   i = 1;
   
   vn="i"; 
   
   j = $vn;
   
   chkN (j,i); 
   
   <<"%V $j\n"; 
   
   <<"%V $i\n"; 

   vn = "k"; 
   
   $vn = j+1;
   
   n = $vn; 
   
   <<"%V $vn\n"; 
   <<"%V $n\n"; 
   
   
   <<"%V $k\n"; 
   
   <<"%V ($vn)\n"; 
   <<"%V $($vn)\n"; 
   
   
   avec = vgen(INT_,5,i+1,1); 
   <<"%V $avec  \n"; 
   
   vn = "a_$i"; 
   <<"$vn  \n"; 
   $vn = avec;
   <<"%V $vn    $a_1\n"; 
   
   <<"%V $avec  \n"; 
   chkOut ()   
   i= 2;
   
   vn = "a_$i"; 
   <<"$vn  \n"; 
// $vn= vgen(INT_,5,i+1,1) // BUG
   avec = vgen(INT_,5,i+1,1); 
   <<"%V $avec  \n"; 
   $vn = avec; 
   
   <<"%V $vn    $a_2\n"; 
   a_2->info(1); 
   
   y = $vn; 
   
   <<"%V $y \n"; 
   
   <<"%V $avec \n"; 
   <<"%V $a_2 \n"; 
   a_2->info(1); 
   
   <<" $a_2[3]\n"; 
   
// b = ($vn)[3]
   
//<<"$b\n"
   
   int  c[] = { 0,1,2,3,77 }
  
  <<"$c\n"; 
  int e = 79;
  
  int  d[] = { e, $vn}
  
  <<"$d\n"; 
  d->info(1)
  
  for (i=0; i< 5; i++) {
  vn = "a_$i"; 
  $vn = vgen(INT_,5,i+1,1); 
  y = $vn; 
  <<"%V $y \n"; 
  }
  
  i= 7;
  
  
  ptr z;
  
  <<"%V $(typeof(z)) $z \n"; 
  
  
  z->info(1); 
  
  z= &d;
  
  z->info(1);
  d->info(1)
  
  <<"%V $z \n"; 

  d->info(1);
  f = z[0];
  
  f->info(1); 
  //z = $vn
  
  
  <<"%V $z[0] $z[1] $z[2]\n"; 
  
  
  vn = "nuvec"; 
  $vn = vgen(INT_,10,-5,1);
  
  
  ptr v;
  
  v = &$vn;

  v->info(1)
  
  sz= Caz($vn); 
  
  for (i= 0; i < sz ; i++) {
  k = v[i];
  <<"$i  $k\n"; 
  chkN (k,nuvec[i]); 
  }
  
  
  chkOut(); 
  
  
  S = Variables(); 
  
  <<"%(1,,,\n)$S\n"; 
  
  exit(); 
