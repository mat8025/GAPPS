///
///    work out the layout of inner-matrix positions
///    in a final (outer)  RowCol format for display
///    then output using tab and line spacing the original MDA 
///

///   e.g  a MDA  with dimensions [2][2][2][3][4][3]
///    has an inner-matrix  of [4][3]  and each on inner-matrix 'cells'
/// should be laid out like :
///
///     0  1  2   | 6 7 8
///     3  4  5   | 9 10 11
///     -   -   -   |  -    -    -
///     12 13 14 | 18 19 20
///     15 16 17 |  21 22 23

///   each succeeding dimension would 'duplicate' the current matrix
///   either in cols or rows

//    sequence is    RC RC [RC]
//    so the example has 6 cols and 4 rows


//   but has to work for arbitary  number -- upto  and > than 100 dimns
//   will fail at some limit ?





void askit(int ask)
{
Str ans;
	  if (ask) {
       ans = query("ok? : [y,n,q]")
       if (ans @= "q") {
            exit(-1)
        }

       }
}



    chkIn()

    chkT(1) 

     C= ofw("mda_inner_matrix")

    V = vgen(INT_,648,1,1)



    M = V;

    redimn(M,3,2,3,3,4,3)


    <<" $M \n"

     nd= Cnd(M)

     bd = Cab(M)

int be[nd]

<<"%V $nd $bd \n"

     if (nd > 2) {
     nrows = 1;
     ncols = 1
     for (i = nd-3 ; i>=0; i -=2) {
        ncols *= bd[i];
     }
     for (i = nd-4 ; i>=0; i -=2) {
        nrows *= bd[i];
     }     

<<"%V $nrows $ncols \n"

 int RC[nrows][ncols]

//int index[nd] = 0;  // bug

int index[nd]
int click[nd]

  index =0;
  index.pinfo()

<<"%V $index\n"


<<" $bd\n"
<<" work out ele spec %V $bd[3] $bd[nd-3] *  $bd[nd-4]  $bd[nd-5] \n"

   k = bd[nd-3] * bd[nd-4]
     

<<"%V $k\n"

     click =0

     w= nd-3;

    b3= (bd[nd-3])
     b4 = (bd[nd-4])
     b5 = (bd[nd-5])
     b6 = (bd[nd-6])          
     c3= bd[3]
     d3= bd[w]

  int w1,w2,w3,w4,w5,w6,w7 = 0;

<<"%V $w $b3 $c3 $d3 $bd[nd-3] \n"

    chkN(b3,c3)
<<"%V $index[0] $index[1] $index[2]\n"

     index[1] = 0;
     index[0] = 0;     
askit(1)

     int tick = 0;
     for (i=0; i< nrows; i++) {

       for (j=0; j< ncols; j++) {

           click = 0

	  <<"%V $index \n"

//    make this loop for nd-3  dimns
           be[nd-3] = index[0] % b3
           be[nd-4] = index[1] % (bd[nd-4])
           be[nd-5] = index[2] % (bd[nd-5])
           be[nd-6] = index[3] % (bd[nd-6])	   

           <<"%V $i $j  $index[0] $be[nd-6] $be[nd-5] $be[nd-4] $be[nd-3] \n"
	   
          RC[i][j] = index[0]

//<<"%V $index[0] $index[1] $index[2] \n"
<<"%V $index  \n"
          w1= index[1]
	  
	
          index.pinfo()
	  <<"%V $index \n"
          //<<"%V $index[0] $index[1] $w1 $index[2] \n"

chkN(w1,index[1])


  // bug?
         // if ((index % bd[nd-3]) == 0) 
//          if ((index % bd[w]) == 0) 

         w1= (index[0] % bd[nd-3]);
       w2= (index[0] % bd[w]);	   
       w3 = (index[0] % b3);
<<" %V $w1 $w2 $w3 \n"
askit(0)


                     index[0] += 1;


              if ((index[0] %  bd[nd-3]  ) == 0) {
                click[0] =1;
		<<"%V $index \n"		
                <<"click0 %V $click \n"		
            }

        // do this for nd-3 ? dimns
        for (m = 0; m < 3; m++) {

         if ( click[m] ) {

                 index[m+1] += 1;
<<"doing click $m %V $index \n"				 
         wd = m+4
         bchk =  bd[nd-wd]
	 // bug using bd[nd-wd] in if eval    TBF 
	 
         if ((index[m+1] % bchk ) == 0)  {

                 click[m+1]= 1;
		 
           <<"click $m happened %V $index \n"				 
           <<"click %V $click \n"
	        }
<<"after  click $m %V $index \n"				 		
           }

        }


           <<"(${tick}) %V $index \n"
           <<"(${tick}) %V $click \n"
           <<"(${tick}) $be[0:nd-3:1]\n"

           <<[C]"(${tick}) $be[0:nd-3:1]"
	  
askit(0)

          tick++;
  


    }
  }
}

<<"$RC \n"

  chkN(be[0],bd[0]-1)
  chkN(be[1],bd[1]-1)
  chkN(be[2],bd[2]-1)
  chkN(be[3],bd[3]-1)

 chkOut(1)

////
///
///




