//%*********************************************** 
//*  @script calcounter_fav.asl 
//* 
//*  @comment favorite/common food enteries 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Sat Jun 22 07:43:49 2019 
//*  @cdate Sat Jun 22 07:43:49 2019 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%



Record FF[>10];

//============== set up favorites  ====================//
// select porridge, eggs scrambled, whole milk , coffee


//  set up probable foods

 favi = 0;
 
 A=  ofr("favfoods.csv");

 if (A == -1) {
  <<" can't open food table favfoods \n";
 j  = searchFood("porridge")

 if (j >0) {
   <<"found $favi $j $RF[j] \n"
         FF[favi] = RF[j];
	 favi++;
 }

 j  = searchFood("eggs fried")
 
 if (j >0) {
  <<"found $favi $j $RF[j] \n"
         FF[favi] = RF[j];
	 favi++;
 }



 j  = searchFood("milk whole")

 if (j >0) {
    <<"found $favi $j $RF[j] \n"
         FF[favi++] = RF[j];  
 }

 j  = searchFood("sausage chicken")

 if (j >0) {
    <<"found $favi $j $RF[j] \n"
         FF[favi++] = RF[j];
	 
 }

 j  = searchFood("coffee black")

 if (j >0) {
    <<"found $favi $j $RF[j] \n"
         FF[favi++] = RF[j];  
 }


 }
 else {
 <<"reading favorite foods \n"
  FF= readRecord(A,@del,',')
  cf(A);

  Nfav =  Caz(FF);
  for (i=0;i<Nfav;i++) {
<<"$i $FF[i]\n"
  }

}

//======================================================//

proc favDisplay()
{
   sWo(favorwo,@setrowscols,Nfav+1,cols+1); // setup sheet rows&cols
   sWo(favorwo,@cellval,FF,0,0,Nfav,cols);  
   sWo(favorwo,@selectrowscols,0,10,0,cols); // display size of fav

   sWo(favorwo,@setcolsize,3,0,1);
   sWo(cellwo,@setcolsize,3,0,1) ;


  for (i = 0; i< 10 ; i++) {
     for (j = 0; j< cols ; j++) {
        if ((i%2)) {
           sWo(favorwo,@cellbhue,i,j,CYAN_);         
	}
	else {
           sWo(favorwo,@cellbhue,i,j,PINK_);
	 }
       }
     }

}

//======================================================//
/{
proc SORT()
{

  static int sortdir = 1;
  sortcol = swapcol_a;
  startrow = 1;
  alphasort = 0; // 0 auto alpha or number 1 alpha   2 number

  <<"%V  $sortcol $alphasort $sortdir $startrow $(rows-2)\n"
   sortRows(R,sortcol,alphasort,sortdir,startrow, rows-2)
  sortdir *= -1;

     sWo(cellwo,@cellval,R);
     sWo(cellwo,@redraw);
}
//======================================================//
/}