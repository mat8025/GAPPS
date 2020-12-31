//%*********************************************** 
//*  @script define.asl 
//* 
//*  @comment test define  
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.3.2 C-Li-He]                                 
//*  @date Mon Dec 28 21:44:00 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%





chkIn(_dblevel)



#define RED_LIGHT  1
#define ORANGE_LIGHT  2
#define GREEN_LIGHT  3 


#define MAXN 10

hue = GREEN_

<<"$hue GREEN \n"


<<" MAXN defined as $(MAXN) \n"

//FIX MAXN is being substituted via preprocessor not protected

<<"pt $(periodicNumber(\"lead\"))\n"


<<"lead is $(pt(\"lead\"))\n"

//mn = Atoi(" $(MAXN) ")
//<<"%V $mn \n"


//smn = "$(MAXN)"
//<<" $smn \n"

y = MAXN;

//<<"%V $y $mn\n"

//chkN(mn,y)

int I[MAXN]

I[9] = 77

<<" $I\n"
<<" $(Caz(I)) \n"

sz = Caz(I)

 chkN(sz,10)
 chkN(sz,MAXN)

 chkOut()

