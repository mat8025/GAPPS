//%*********************************************** 
//*  @script calcounter_foods.asl 
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


record FF[>10];

//============== set up favorites  ====================//
// select porridge, eggs scrambled, whole milk , coffee


//  set up probable foods

 favi = 0;
 

 A=  ofr("Foods/foods-breakfast.csv");
// A=  ofr("Foods/foods-fruits.csv");

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


proc foodsDisplay()
{

//   dWo(foodswo); // delete the wo and reconstruct --- buggy!
// ::foodswo=cWo(vp,@sheet,@name,"FoodFavorites",@color,GREEN_,@resize,CFx,0.01,CFX,0.50)

 //sWo(foodswo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"1",@func,"xxx")

 //sWo(foodswo,@bhue,CYAN_,@font,F_TINY_,@clipbhue,SKYBLUE_,@redraw);
//  try reset sheet
  Nfav->info(1)
  <<"%V $foodswo $Nfav  $Fcols $Page_rows \n"

   sWo(foodswo,@setrowscols,Nfav+1,Fcols); // setup sheet rows&cols
   // set sheet to required rows and cols --- before reading in record -
   // otherwise -- too much realloc/resetting of shhet rows -- done per row
   sWo(foodswo,@selectcols,1,3,0); // display size of fav
   sWo(foodswo,@cellval,FF,0,0,Nfav,Fcols-1);  
   curr_row = 0;

    npgs =   Nfav/Page_rows;

    gotoLastPage();

    sWo(foodswo,@redraw);

/{/*


   if (Nfav < Page_rows) {
     sWo(foodswo,@selectrows,0,Nfav-1); // display size of fav
   }
   else {
     sWo(foodswo,@selectrows,0,Page_rows-1); // display size of fav
   }


   sWo(foodswo,@setcolsize,FOODCOLSZ,0,1);

   sWo(foodswo,@cellval,FF,0,0,Nfav,Fcols);  // start & finish row/cols - so Ncols,Nrows must be one more!

   <<"set cell values $FF[0]\n"
 //  sWo(foodswo,@cellval,FF);  // start & finish row/cols - so Ncols,Nrows must be one more!


//   sWo(cellwo,@setcolsize,FOODCOLSZ,0,1) ;

    sWo(foodswo,@redraw);
/}*/

/{
  for (i = 0; i< Page_rows ; i++) {
  if (i > Nfav) break;
     for (j = 0; j< Fcols ; j++) {
        if ((i%2)) {
           sWo(foodswo,@cellbhue,i,j,CYAN_);         
	}
	else {
           sWo(foodswo,@cellbhue,i,j,PINK_);
	 }
       }
     }
/}

<<"loaded new foods\n"
}

//======================================================//

proc FoodType()
{

     wtype =woGetValue(mwo)
 <<"reading  foods type   $wtype;\n"
     wtype = slower(wtype)
  A=  ofr("Foods/foods-${wtype}.csv");
  if (A == -1) { 
<<"ERROR read foods $wtype \n"
  }

  if (A != -1) {
 // delete (FF);
   FF= readRecord(A,@del,',')
   cf(A);  

  Nfav =  Caz(FF);
  <<" $Nfav $FF[0]\n"
    <<" $FF[Nfav-1]\n"

/{/*
  for (i=0;i<Nfav;i++) {
   <<"$i $FF[i]\n"
  }
/}*/

   foodsDisplay()
 }


}
//=======================================