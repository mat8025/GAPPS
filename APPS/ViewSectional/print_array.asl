///
///
///

int PV = 0
void print_vector( int index , int ne)
{
    PV++
    <<"%V$_proc $PV $index $ne\n"
    for (j = 0; j < ne ; j++) {
       <<" $V[index +j] "
    }
    <<"\n"
    offset = index +4;
}


void print_array(int wd, int kr)
{
<<"$_proc [ $wd ] $kr $Nd\n"
  int nwd = 0;
//     if (wd < Nd-1) {
     if (wd < (Nd-1)) {
    
         offset *= bd[wd]

	
         kr += 1
 <<"recurse %v $wd $offset $kr  \n"
       if (kr <= bd[wd]) {
	 <<"%V $kr   $bd[wd]\n"
           print_array(wd, kr)
         }
	 else {
	  nwd = wd+1
	  <<"%V $nwd $offset  \n"
	   kr = 0
           print_array(nwd, kr)

          }


    }
    else {
      print_vector(offset, bd[Nd-1])
    }

}


 V= vgen(INT_,64,1,1)

 <<" $V \n"



  M = V

  redimn(M,2,2,2,2,2,2)

 Nd =Cnd(M)

 <<" $M \n"

 bd = cab(M)

<<"////////pexpand array ////////////\n"

 <<"$M\n"




  exit();

<<"////////////////////////////\n"

int offset =1

 <<" %V $offset $Nd $bd\n"

  outer_offset =  3 * 4





  for (m = 0; m < bd[0] ; m++) {

   offset = m  ;
  <<"outer 0  rowd $m  $offset\n"
  
   print_array(0,m)

 }


 <<"DONE print_array !?!\n"


///
///
///
