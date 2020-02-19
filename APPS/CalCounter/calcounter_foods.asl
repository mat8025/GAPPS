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


Record FF[>10];

//============== set up favorites  ====================//
// select porridge, eggs scrambled, whole milk , coffee


//  set up probable foods

 favi = 0;
 
// A=  ofr("favfoods.csv");
// A=  ofr("foods-pies.csv");
 A=  ofr("foods-sodas.csv");
// A=  ofr("foods-meats.csv");

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
   dWo(foodswo);


 ::foodswo=cWo(vp,@sheet,@name,"FoodFavorites",@color,GREEN_,@resize,CFx,0.01,CFX,0.50)

 sWo(foodswo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"1",@func,"xxx")

 sWo(foodswo,@bhue,CYAN_,@font,F_TINY_,@clipbhue,SKYBLUE_,@redraw);



   sWo(foodswo,@setrowscols,Nfav+1,Fcols+1); // setup sheet rows&cols
   sWo(foodswo,@cellval,FF,0,0,Nfav,Fcols);  // start & finish row/cols - so Ncols,Nrows must be one more!
   if (Nfav < page_rows) {
      sWo(foodswo,@selectrowscols,0,Nfav,0,Fcols); // display size of fav
   }
   else {
   sWo(foodswo,@selectrowscols,0,page_rows,0,Fcols); // display size of fav
   }
   sWo(foodswo,@setcolsize,FOODCOLSZ,0,1);
//   sWo(cellwo,@setcolsize,FOODCOLSZ,0,1) ;


  for (i = 0; i< page_rows ; i++) {
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

}

//======================================================//



proc FoodType()
{

     wtype =woGetValue(mwo)
 <<"reading  foods type     $wtype;\n"
     wtype = slower(wtype)
  A=  ofr("foods-${wtype}.csv");
  delete (FF);
  if (A != -1) {

   ::FF= readRecord(A,@del,',')
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