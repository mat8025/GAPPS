//WRD1  WRD2  WRD3

//%*********************************************** 
//*  @script svar_read.asl 
//* 
//*  @comment reads file into svar 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Fri Jan  3 11:12:03 2020 
//*  @cdate 1/1/2004 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

/// svar read words
include "debug.asl"


Svar Wd


A= ofr("svar_read.asl")

wline =0;


ln =0
 while (1) {

  //nwords = Wd->readWords(A,wline)
  nwords = Wd->read(A,wline)

//nwords = readWords(A,Wd,wline)


 if (nwords == -1)  {
  <<" EOF ? \n"
  break;
 }

<<"$ln <$nwords>:- \n"
 for (i= 0; i< nwords; i++) {
  <<"<|$Wd[i]|> \n"
}

ln++;
  break;
 }



exit()
