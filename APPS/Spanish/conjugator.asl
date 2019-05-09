//%*********************************************** 
//*  @script conjugator.asl 
//* 
//*  @comment simple verb conjugator for spanish 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Tue May  7 10:35:03 2019 
//*  @cdate Tue May  7 10:35:03 2019 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%


Svar SV; // verb table
tsz=500
nplace =2

SV->table("HASH",tsz,nplace) // makes Svar a hash type -- could extend table

key = "poder"
val = "puedo"
index=SV->addkeyval(key,val) // returns index
<<"%V$key $val $index\n"

key = "ser"
val = "soy"
index=SV->addkeyval(key,val) // returns index
<<"%V$key $val $index\n"

key = "estar"
val = "estoy"
index=SV->addkeyval(key,val) // returns index
<<"%V$key $val $index\n"

key = "ir"
val = "voy"
index=SV->addkeyval(key,val) // returns index
<<"%V$key $val $index\n"


///

  verb = _clarg[1];

   infinitive = verb
//  ar, er,ir

// regular?
tsz = 100;
nplace = 2


 val = SV->lookup(verb)

if (!(val @= "")) {
<<"$verb is irregular!")
// if irregular - goto verb lib

}
ans = iread("$index ->")


  end = sele(verb,-1,-2)

  stem = sele(verb,-3)

 <<"$verb $stem $end\n"

// present

 if ((end @= "er")  || (end @= "ir") ) {

   <<"\t${stem}o\n"
   <<"\t${stem}es\n"
   <<"\t${stem}e\n"
   <<"\t${stem}emos\n"
   <<"\t${stem}éis\n"
   <<"\t${stem}en\n"
 }

 if (end @= "ar"  ) {

   <<"\t${stem}o\n"
   <<"\t${stem}as\n"
   <<"\t${stem}a\n"
   <<"\t${stem}amos\n"
   <<"\t${stem}áis\n"
   <<"\t${stem}an\n"
 }




///  past - preterite
<<"\n past - preterite\n"
if ((end @= "er")  || (end @= "ir") ) {

   <<"\t${stem}i\n"
   <<"\t${stem}iste\n"
   <<"\t${stem}ió\n"
   <<"\t${stem}imos\n"
   <<"\t${stem}isteis\n"
   <<"\t${stem}ieron\n"

    preterite_3p = "${stem}ieron"
 }

 if (end @= "ar"  ) {

   <<"\t${stem}é\n"
   <<"\t${stem}aste\n"
   <<"\t${stem}ó\n"
   <<"\t${stem}amos\n"   // same as present!
   <<"\t${stem}asteis\n"
   <<"\t${stem}aron\n"
    preterite_3p = "${stem}aron"
 }


<<"\n past - imperfect\n"
if ((end @= "er")  || (end @= "ir") ) {

   <<"\t${stem}ía\n"
   <<"\t${stem}ías\n"
   <<"\t${stem}ía\n"
   <<"\t${stem}íamos\n"
   <<"\t${stem}íais\n"
   <<"\t${stem}ían\n"
 }

 if (end @= "ar"  ) {

   <<"\t${stem}aba\n"
   <<"\t${stem}abas\n"
   <<"\t${stem}aba\n"
   <<"\t${stem}ábamos\n" 
   <<"\t${stem}abais\n"
   <<"\t${stem}aban\n"
 }

//==========================//
<<"\n future \n"
if ((end @= "er")  || (end @= "ir")  || (end @= "ar") ) {

   <<"\t${infinitive}é\n"
   <<"\t${infinitive}ás\n"
   <<"\t${infinitive}á\n"
   <<"\t${infinitive}emos\n" 
   <<"\t${infinitive}éis\n"
   <<"\t${infinitive}án\n"
 }

//==========================//
<<"\n conditional \n"
if ((end @= "er")  || (end @= "ir")  || (end @= "ar")) {

   <<"\t${infinitive}ía\n"
   <<"\t${infinitive}ías\n"
   <<"\t${infinitive}ía\n"
   <<"\t${infinitive}íamos\n" 
   <<"\t${infinitive}íais\n"
   <<"\t${infinitive}ían\n"
 }
//==========================//

<<"\n subjunctive\n"

// drop o from yo form and add these endings
// ar: -e, -es , -e, -emos, -éis , en

if (end @= "ar"  ) {

   <<"\t${stem}e\n"
   <<"\t${stem}es\n"
   <<"\t${stem}e\n"
   <<"\t${stem}emos\n"
   <<"\t${stem}éis\n"
   <<"\t${stem}en\n"
 }


// er,ir : -a, -as, -a , -amos , -áis, -an

if ((end @= "er")  || (end @= "ir") ) {


  <<"\t${stem}a\n"
   <<"\t${stem}as\n"
   <<"\t${stem}a\n"
   <<"\t${stem}amos\n"
   <<"\t${stem}áis\n"
   <<"\t${stem}an\n"
}


<<"past subjunctive\n"



// drop the ron from the 3rd person preterite
// and add these endings :-
// -ra, -ras, ra, -ramos, -rais, ran
/


 if ((end @= "er")  || (end @= "ir")  || (end @= "ar")) {
   psub_stem = sele( preterite_3p,-4)

   <<"\t${psub_stem}ra\n"
   <<"\t${psub_stem}ras\n"
   <<"\t${psub_stem}ra\n"

   nos_s = sele(psub_stem,-2)
  if (end @= "ar"  ) {
   nos_s = scat(nos_s,"á")
   }
  else {  
   nos_s = scat(nos_s,"é")
  }
   <<"\t${nos_s}ramos\n"
   
   <<"\t${psub_stem}rais\n"
   <<"\t${psub_stem}ran\n"
 }
 
 
