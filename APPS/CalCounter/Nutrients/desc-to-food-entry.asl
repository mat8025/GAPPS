//%*********************************************** 
//*  @script desc-to-food-entry.asl 
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


Food = "xxx"
Wt = ""
Cals = ""
Carbs = ""
Fat = "";
Prot = ""
Chol = "";
SatFat = "";
vA = "0"
vC = "0"
Ca="0";
Fe="0";
Na="0";
K="";
vB1=""
vB6=""
vB2Rb=""
vB12=""
Amt="ITM"

// if vitamin or element and  unit is mg - convert to daily %

// look for Wt

i=0
while (1) {

 S= readline(A)

 if (feof(A)) {
     break
 }
i++
<<"$i $S\n"

L = Split(S)

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
   Ca = L[1]
}
else if (L[0] @= "Sodium") {
  if (L[2] @= "mg") {

    dv= atof(L[1]) / 2300.0  * 100.0

    Na = ftoa(dv)

  }
  else {

   Na = L[1]
   }
}
else if (L[0] @= "Potassium") {
  if (L[2] @= "mg") {

    dv= atof(L[1]) / 4500.0  * 100.0

    K = ftoa(dv)

  }
  else {
   K = L[1]
   }
}
else if (L[0] @= "Iron") {

   Fe = L[1]

}
else if (L[0] @= "Riboflavin") {

   vB2Rb = L[1]

}
else if (L[0] @= "Vitamin") {
   if (L[1] @= "A") {
       vA= L[2];
   }
   if (L[1] @= "C") {
       vC= L[2];
   }
   if (L[1] @= "B-12") {
       vB12= L[2];
   }
   if (L[1] @= "B-6") {
       vB6= L[2];
   }      

}
else if (L[0] @= "Total") {
  if (L[1] @= "Fat") {
   Fat = scut(L[2],-1)
  }
  else if (L[1] @= "Carbohydrate") {
   Carbs = scut(L[2],-1)
  }
}

  PL = L;
}


<<"Food,Amt,Unit,Cals,Carbs,Fat,Protein,Chol(mg),SatFat,Wt,vA,vC,Ca,Fe,Na,K,vB1,vB12,vB2Rb\n"

<<"$Food 1,$Amt, $Cals, $Carbs, $Fat, $Prot, $Chol, $SatFat,$Wt,$vA,$vC,$Ca,$Fe,$Na,$K,$vB1,$vB12,$vB2Rb \n"


<<"%V $Ca\n"
<<"%V $Fe\n"
<<"%V $Na\n"
<<"%V $K\n"

