///
///
///





int PV =0

void pv (int wd, int offset)
{
  PV++;
  <<" %V $PV $wd\n"
  inner_offset =1;
  for ( j = wd+1; j < Nd ; j++) {
	    inner_offset *= bd[j];
	   }


  if (wd < (Nd-1)) {
     for(i=0;i< bd[wd];i++) {
       pv(wd+1, offset)
       offset += inner_offset;
     }
  }
  else {
    k = offset
    m = bd[Nd-1]
    <<"end $offset $wd $m $bd[wd]\n"
    for (i=0;i < m ;i++) {
        
        //<<"$i $k"
	printf(" %d ",k);
         k++;
        }
       printf("\n");
  }
  if (offset > 100) {
       exit(-1)
  } 
}


V = vgen(INT_,100,1,1)

 M= V;
 M.redimn(5,5,4)

  <<"$M\n"

N = 3
Nd =3
int bd[3] = {5,5,4}

<<"bd $bd\n"



 //  00,01,02,03,04
 //  10,11,12,13,14


     for (i=0;i<5;i++) {
         for (j= 0; j <5 ; j++) {
            <<" ${i}$j, "
         }
            <<"\n"
     }
!a

    pv(0,0)
    


///