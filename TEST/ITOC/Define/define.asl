/* 
 *  @script define.asl                                                  
 * 
 *  @comment test define                                                
 *  @release Carbon                                                     
 *  @vers 1.3 Li Lithium [asl 6.37 : C Rb]                              
 *  @date 06/25/2024 23:16:53                                           
 *  @cdate 1/1/2005                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 


   chkIn();
#define RED_LIGHT  1
#define ORANGE_LIGHT  2
#define GREEN_LIGHT  3
#define STRV str
#define MAXN 10

   hue = GREEN_LIGHT;

   Str s = " $(ORANGE_LIGHT) ";

   STRV s2 = " $(GREEN_LIGHT) ";

   <<"%V $s $s2\n";

   <<"%V $hue GREEN \n";

   <<" MAXN defined as $(MAXN) \n";
//FIX MAXN is being substituted via preprocessor not protected

   <<"pt $(periodicNumber(\"lead\"))\n";

   <<"lead is $(pt(\"lead\"))\n";
//mn = Atoi(" $(MAXN) ")
//<<"%V $mn \n"
//smn = "$(MAXN)"
//<<" $smn \n"

   y = MAXN;
//<<"%V $y $mn\n"
//chkN(mn,y)

   int I[MAXN];

   I[9] = 77;

   <<" $I\n";

   <<" $(Caz(I)) \n";

   sz = Caz(I);

   chkN(sz,10);

   chkN(sz,MAXN);

   chkOut();

//==============\_(^-^)_/==================//
