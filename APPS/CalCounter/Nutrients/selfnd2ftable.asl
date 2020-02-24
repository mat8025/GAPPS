//%*********************************************** 
//*  @script selfnd2ftable.asl 
//* 
//*  @comment extract cal/vit/min data  
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Wed Apr 10 11:32:55 2019 
//*  @cdate 12/25/2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


setdebug(1,@keep);

// usage asl selfnd2ftable.asl mussels 2>junk > foodname.csv
// spits out entry for foodtable - with vits,minerals from USDA data base 
// input is cut&paste data in file
// obtain data from
// https://nutritiondata.self.com/facts/
// default display or full details
// ? script to drive and extract
// input is from webpage   https://nutritiondata.self.com/
// cut & paste using search for desired food on that page
// can this be done automagically - with web data mining command ?


_DB=2;
/{/*
Kale
Amounts per 1 cup, chopped (67g)

Calorie Information
Amounts Per Selected Serving%DV
Calories33.5(140 kJ)2%
  From Carbohydrate24.2(101 kJ) 
  From Fat3.9(16.3 kJ) 
  From Protein5.4(22.6 kJ) 
  From Alcohol0.0(0.0 kJ) 
Carbohydrates
Amounts Per Selected Serving%DV
Total Carbohydrate6.7g2%
Dietary Fiber1.3g5%
Starch~  
Sugars~  
Sucrose~  
Glucose~  
Fructose~  
Lactose~  
Maltose~  
Galactose~  ￼
Fats & Fatty Acids
Amounts Per Selected Serving%DV
Total Fat0.5g1%
Saturated Fat0.1g0%
4:000.0mg 
6:000.0mg 
8:000.0mg 
10:000.0mg 
12:001.3mg 
13:00~  
14:002.0mg 
15:00~  
16:0050.9mg 
17:00~  
18:002.7mg 
19:00~  
20:00~  
22:00~  
24:00:00~  
Monounsaturated Fat0.0g 
14:01~  
15:01~  
16:1 undifferentiated0.7mg 
16:1 c~  
16:1 t~  
17:01~  
18:1 undifferentiated32.8mg 
18:1 c~  
18:1 t~  
20:010.0mg 
22:1 undifferentiated0.0mg 
22:1 c~  
22:1 t~  
24:1 c~  
Polyunsaturated Fat0.2g 
16:2 undifferentiated~  
18:2 undifferentiated92.4mg 
18:2 n-6 c,c~  
18:2 c,t~  
18:2 t,c~  
18:2 t,t~  
18:2 i~  
18:2 t not further defined~  
18:03121mg 
18:3 n-3, c,c,c~  
18:3 n-6, c,c,c~  
18:4 undifferentiated0.0mg 
20:2 n-6 c,c~  
20:3 undifferentiated~  
20:3 n-3~  
20:3 n-6~  
20:4 undifferentiated1.3mg 
20:4 n-3~  
20:4 n-6~  
20:5 n-30.0mg 
22:02~  
22:5 n-30.0mg 
22:6 n-30.0mg 
Total trans fatty acids~  
Total trans-monoenoic fatty acids~  
Total trans-polyenoic fatty acids~  
Total Omega-3 fatty acids121mg 
Total Omega-6 fatty acids92.4mg 
Learn more about these fatty acids
and their equivalent names
￼	
Protein & Amino Acids
Amounts Per Selected Serving%DV
Protein2.2g4%
Tryptophan26.8mg 
Threonine98.5mg 
Isoleucine132mg 
Leucine155mg 
Lysine132mg 
Methionine21.4mg 
Cystine29.5mg 
Phenylalanine113mg 
Tyrosine78.4mg 
Valine121mg 
Arginine123mg 
Histidine46.2mg 
Alanine111mg 
Aspartic acid198mg 
Glutamic acid251mg 
Glycine107mg 
Proline131mg 
Serine93.1mg 
Hydroxyproline~  ￼
Vitamins
Amounts Per Selected Serving%DV
Vitamin A10302IU206%
Retinol0.0mcg 
Retinol Activity Equivalent515mcg 
Alpha Carotene0.0mcg 
Beta Carotene6182mcg 
Beta Cryptoxanthin0.0mcg 
Lycopene0.0mcg 
Lutein+Zeaxanthin26499mcg 
Vitamin C80.4mg134%
Vitamin D~ ~
Vitamin E (Alpha Tocopherol)~ ~
Beta Tocopherol~  
Gamma Tocopherol~  
Delta Tocopherol~  
Vitamin K547mcg684%
Thiamin0.1mg5%
Riboflavin0.1mg5%
Niacin0.7mg3%
Vitamin B60.2mg9%
Folate19.4mcg5%
Food Folate19.4mcg 
Folic Acid0.0mcg 
Dietary Folate Equivalents19.4mcg 
Vitamin B120.0mcg0%
Pantothenic Acid0.1mg1%
Choline~  
Betaine~  ￼
Minerals
Amounts Per Selected Serving%DV
Calcium90.5mg9%
Iron1.1mg6%
Magnesium22.8mg6%
Phosphorus37.5mg4%
Potassium299mg9%
Sodium28.8mg1%
Zinc0.3mg2%
Copper0.2mg10%
Manganese0.5mg26%
Selenium0.6mcg1%
Fluoride~  
Sterols
Amounts Per Selected Serving%DV
Cholesterol0.0mg0%
Phytosterols~  
Campesterol~  
Stigmasterol~  
Beta-sitosterol~  ￼
Other
Amounts Per Selected Serving%DV
Alcohol0.0g 
Water56.6g 
Ash1.0g 
Caffeine~  
Theobromine~  

Footnotes for Kale, raw
/}*/


the_food = _clarg[1]

 sz= fexist(the_food,RW_,0);
 
 A= ofr(the_food)

 if (A == -1) {
<<" can't find $the_food \n"
  exit()
 }

  S=readfile(A)

  sz = Caz(S)

<<[_DB]"$sz $S[0] $S[1] \n"
  ok = 0;




Food = "xxx"
Wt = "0"
Cals = "0"
Carbs = "0"
Fat = "0";
Prot = "0"
Chol = "0";
SatFat = "0";
vA = "0"
vC = "0"
vB1Th="0";
vB2Rb="0";
vB3Ni="0";
vB5Pa="0";
vB9Fo="0";
vB12 = "0";
vB6 = "0"
vK = "0"
vE = "0"
Cho="0";
Ca="0";
Fe="0";
Na="0";
K="0";
Zn="0";


Amt="ITM"
Unit = ""
wrd="";

for (i = 0 ; i < sz; i++) {

<<[_DB]"$i $S[i]"
 L = Split(S[i]);
 lsz = Caz(L)
 <<[_DB]"$lsz $L[0] <|$L[1]|>\n";
 if ((L[0] @= "Amounts") && (L[1]@="per")) {
  Amt = L[2];
  Unit = L[3];  
  wrd = L[lsz-1];
  if (scmp(wrd,"(",1)) {
    Wt = sob(wrd,"(");
    Wt = spat(Wt,"g",-1);
  }
  Unit = ssub(Unit,",","")
  

}
 
 if (scmp(L[0],"Calories",8)) {
      wrd= spat(L[0],"Calories",1)
      //<<[_DB]"%V$wrd\n"
      Cals = spat(wrd,"(",-1)
 }
 else if (scmp(L[0],"Protein",7)) {
 //<<[_DB]"Prot\n"
      if (lsz <= 2) {
      wrd= spat(L[0],"Protein",1)
      Prot = spat(wrd,"g",-1)
      }
 }
 else if (scmp(L[0],"Saturated",9)) {
      if ((lsz <= 2) && (scmp(L[1],"Fat",3))) {
      wrd= spat(L[1],"Fat",1)
      SatFat = spat(wrd,"g",-1)
      }
 }
 else if (scmp(L[0],"Cholesterol",11)) {
      if (lsz <= 2) {
      wrd= spat(L[0],"Cholesterol",1)
      Chol = spat(wrd,"mg",-1)
      }
 }
 else if (scmp(L[0],"Calcium",7)) {
      wrd= spat(L[0],"Calcium",1)
      wrd =spat(wrd,"mg",1)
      Ca = spat(wrd,"\%",-1)      
 <<[_DB]"%V $Ca\n"
 }
 else if (scmp(L[0],"Choline",7)) {
      wrd= spat(L[0],"Choline",1)
      Cho =spat(wrd,"mg",-1)
 }
 else if (scmp(L[0],"Iron",4)) {
      wrd= spat(L[0],"Iron",1)
      wrd = spat(wrd,"mg",1)
      Fe = spat(wrd,"\%",-1)
  <<[_DB]"%V $Fe\n"
 }
 else if (scmp(L[0],"Zinc",4)) {
      wrd= spat(L[0],"Zinc",1)
      wrd = spat(wrd,"mg",1)
      Zn = spat(wrd,"\%",-1)
 } 
 else if (scmp(L[0],"Sodium",6)) {
      wrd= spat(L[0],"Sodium",1)
      wrd = spat(wrd,"mg",1)
      Na = spat(wrd,"\%",-1)
 } 
 else if (scmp(L[0],"Potassium",9)) {
      wrd= spat(L[0],"Potassium",1)
      wrd = spat(wrd,"mg",1)
      K = spat(wrd,"\%",-1)
 }
 else if (scmp(L[0],"Thiamin",7)) {
        wrd= spat(L[0],"Thiamin",1)
        wrd = spat(wrd,"mg",1)
        vB1Th = spat(wrd,"\%",-1)
 }
 else if (scmp(L[0],"Riboflavin",10)) {
        wrd= spat(L[0],"Riboflavin",1)
        wrd = spat(wrd,"mg",1)
        vB2Rb = spat(wrd,"\%",-1)
 }
 else if (scmp(L[0],"Niacin",6)) {
        wrd= spat(L[0],"Niacin",1)
        wrd = spat(wrd,"mg",1)
        vB3Ni = spat(wrd,"\%",-1)
 }
 else if (scmp(L[0],"Pantothenic",7)) {
        wrd= spat(L[1],"Acid",1)
        wrd = spat(wrd,"g",1)
	nv = spat(wrd,"\%",-1)
	if (! (nv @="")) {
         vB5Pa = nv
	}
 }   
 else if (scmp(L[0],"Folate",6)) {
        wrd= spat(L[0],"Folate",1)
        wrd = spat(wrd,"mcg",1)
        vB9Fo = spat(wrd,"\%",-1)
 }  
 else if (scmp(L[0],"Vitamin",7)) {
 <<[_DB]"Vitamin\n"
      if (scmp(L[1],"A",1)) {
         wrd= spat(L[1],"A",1)
         wrd= spat(wrd,"IU",1)	
         vA= spat(wrd,"\%",-1) 
      }
      else if (scmp(L[1],"C",1)) {
           wrd= spat(L[1],"C",1)
         wrd= spat(wrd,"g",1)
         vC= spat(wrd,"\%",-1)	 
      }

      else if (scmp(L[1],"B12",3)) {
         wrd= spat(L[1],"B12",1)
         wrd= spat(wrd,"g",1)
	 vB12= spat(wrd,"\%",-1)
      }
      else if (scmp(L[1],"B6",2)) {
         wrd= spat(L[1],"B6",1)
         wrd= spat(wrd,"g",1)
	 vB6= spat(wrd,"\%",-1)
      }
      else if (scmp(L[1],"K",1)) {
         wrd= spat(L[1],"K",1)
         wrd= spat(wrd,"g",1)
	 vK= spat(wrd,"\%",-1)
      }
      else if (scmp(L[1],"E",1)) {
         wrd= spat(L[3],")",1)
<<[_DB]"%V  $wrd\n"	 
         wrd= spat(wrd,"g",1)
	 
	 vE= spat(wrd,"\%",-1)
<<[_DB]"%V $vE $wrd\n"
     }      
      
 } 
 else if (L[0] @= "Total") {

   if (scmp(L[1],"Carbohyd",8)) {
      wrd= spat(L[1],"Carbohydrate",1)
      //<<[_DB]"%V$wrd\n"
      Carbs = spat(wrd,"g",-1)
   }
   else if (scmp(L[1],"Fat",3)) {
      wrd= spat(L[1],"Fat",1)
      //<<[_DB]"%V$wrd\n"
      Fat = spat(wrd,"g",-1)
   }
 }
 else if (L[0] @= "Footnotes") {
 
   Food = scat(L[2],L[3])
   Food = supper(ssub(Food,","," ",0));
 }
 

}


<<[_DB]"\n"
<<[_DB]"%V$wrd\n"

<<"Food,Amt,Unit,Cals,Carbs(g),Fat,Prot,Choles(mg),SatFat(g),Wt(g),Choline(mg),vA(dv),vC,vB1Th,vB2Rb,vB3Ni,vB5Pa,vB6,vB9Fo,B12,vE,vK,Ca,Fe,Na,K,Zn(dv),\n"

<<"$Food\t,$Amt,$Unit,$Cals,$Carbs,$Fat,$Prot,$Chol,$SatFat,$Wt,$Cho,$vA,$vC,$vB1Th,$vB2Rb,$vB3Ni,$vB5Pa,$vB6,$vB9Fo,$vB12,$vE,$vK,$Ca,$Fe,$Na,$K,$Zn \n"


//  now produce an entry of 1 Oz

 g_in_oz = 28.35;

  noz = atof(Wt)/ g_in_oz ;

  mf = 1.0 / noz;

//<<"%V $g_in_oz $Wt $noz $mf \n"

<<"%4.2f$Food\t,1,Oz,$(atof(Cals)*mf),$(atof(Carbs)*mf),$(atof(Fat)*mf),$(atof(Prot)*mf),$(atof(Chol)*mf),$(atof(SatFat)*mf),$(atof(Wt)*mf),$(atof(Cho)*mf),$(atof(vA)*mf),$(atof(vC)*mf),$(atof(vB1Th)*mf),$(atof(vB2Rb)*mf),$(atof(vB3Ni)*mf),$(atof(vB5Pa)*mf),$(atof(vB6)*mf),$(atof(vB9Fo)*mf),$(atof(vB12)*mf),$(atof(vE)*mf),$(atof(vK)*mf),$(atof(Ca)*mf),$(atof(Fe)*mf),$(atof(Na)*mf),$(atof(K)*mf),$(atof(Zn)*mf) \n"


