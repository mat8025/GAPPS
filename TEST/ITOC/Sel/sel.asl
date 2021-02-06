//%*********************************************** 
//*  @script sel.asl 
//* 
//*  @comment  tests SF Sel function 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.47 C-He-Ag]                                
//*  @date Wed May 13 20:59:02 2020 
//*  @cdate Wed May 13 20:59:02 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


/// Sel

/*
Sel(A,condition,val,{1},{justfirst})
compares array values  using "<,>,==,,!=,>=,<=" operations with value
    delivers an integer array which contains indices - where the
    operation was TRUE - else first element is -1 for no valid comparison
optionally delivers integer array where elements are 0 or 1 depending on TRUE/FALSE of element value comparison
If you need just the first element/index where the condition was true set the final optional arg (justfirst) to one,
the default is to work through the vector.
(see Cmp)
*/


chkIn(_dblevel)



I=vgen(INT_,10,0,1);


<<"$I\n"

S=Sel(I,GT_,5)

<<"$S\n"
chkN(S[0],6)
chkN(S[3],9)

S=Sel(I,">",5,1)

<<"$S\n"

S=Sel(I,">",5,0,1)

<<"$S\n"

S=Sel(I,">",50)

<<"$S\n"


F=vgen(INT_,10,0,1);

<<"$F\n"

S=Sel(F,GT_,5)

<<"$S\n"
chkN(S[0],6)
chkN(S[3],9)



chkOut()






/*
/////////// TBD //////////

  option to get justfirst should return array size 1

*/

