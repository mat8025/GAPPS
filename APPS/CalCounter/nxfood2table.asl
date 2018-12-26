//%*********************************************** 
//*  @script nxfood2table.asl 
//* 
//*  @comment  convert nx food desc to table entry 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                  
//*  @date Mon Dec 24 08:06:32 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%
///
setdebug(1,@keep);

// superfood kale ?
/{
Kale
Serving Size:
cup, chopped (130g grams)
Amount Per Serving
Calories from Fat 4.7
Calories 36
% Daily Value*
1%
Total Fat 0.5g grams
0%
Saturated Fat 0.1g grams
Trans Fat 0g grams
Polyunsaturated Fat 0.3g grams
Monounsaturated Fat 0g grams
0%
Cholesterol 0mg milligrams
1%
Sodium 30mg milligrams
8%
Potassium 296mg milligrams
2%
Total Carbohydrates 7.3g grams
10%
Dietary Fiber 2.6g grams
Sugars 1.6g grams
Protein 2.5g grams
354%
Vitamin A
89%
Vitamin C
7.2%
Calcium
6.5%
Iron
/}
// into foodtable row
// Food,Amt,Unit,Cals,Carbs,Fat,Protein,Chol(mg),SatFat,Wt,vA,vC,Ca,Fe,Na,K,vB1,vB12,

 the_food = _clarg[1]
 sz= fexist(the_food,RW_,0);
 
 A= ofr(the_food)

 if (A == -1) {
<<" can't find $the_food \n"
  exit()
 }

 S=readfile(A)

  sz = Caz(S)

<<"$sz $S[1] \n"
  ok = 0;
  
  
  if (S[1] @= "Serving Size:\n") {
   ok =1;
  }
  else {
<<" $the_food not right format \n"
  exit()
  }

Food = scut(S[0],-1)
Wt = ""
Cals = ""
Carbs = ""
Fat = "";
Prot = ""
Chol = "";
SatFat = "";
vA = ""
vC = ""
Ca="";
Fe="";
Na="";
K="";
Amt="ITM"


// look for Wt
L = Split(S[2])
lsz= Caz(L);
wi = lsz-2;
if ( scmp(L[wi],"(",1)) {
 Wt = scut(L[wi],-1);
 Wt= scut(Wt,1);
}

for (i = 0 ; i < sz; i++) {

<<"$i $S[i]"

L = Split(S[i])
L2 = Split(S[i+1]);
if (scmp("cup",L[0],3)) {
 Amt = "cup"
}
else if (L[0] @= "Calories") {
   Cals = L[1]
}
else if (L[0] @= "Protein") {
   Prot = scut(L[1],-1)
}
else if (L[0] @= "Cholesterol") {
   Chol = scut(L[1],-2)
}
else if (L[0] @= "Saturated") {
   SatFat = scut(L[2],-1)
}
else if (L[0] @= "Calcium") {
   Ca = scut(PL[0],-1)
}
else if (L[0] @= "Sodium") {
   Na = scut(PL[0],-1)
}
else if (L[0] @= "Potassium") {
   K = scut(PL[0],-1)
}
else if (L[0] @= "Iron") {
   Fe = scut(PL[0],-1)
}
else if (L[0] @= "Vitamin") {
   if (L[1] @= "A") {
       vA= scut(PL[0],-1);
   }
   if (L[1] @= "C") {
       vC= scut(PL[0],-1);
   }

}
else if (L[0] @= "Total") {
  if (L[1] @= "Fat") {
   Fat = scut(L[2],-1)
  }
  else if (L[1] @= "Carbohydrates") {
   Carbs = scut(L[2],-1)
  }
}

  PL = L;
}


<<"Food,Amt,Unit,Cals,Carbs,Fat,Protein,Chol(mg),SatFat,Wt,vA,vC,Ca,Fe,Na,K,vB1,vB12,\n"

<<"$Food 1,$Amt, $Cals, $Carbs, $Fat, $Prot, $Chol, $SatFat,$Wt,$vA,$vC,$Ca,$Fe,$Na,$K \n"




