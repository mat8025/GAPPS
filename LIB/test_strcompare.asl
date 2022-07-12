///
///
#include "debug.asl"

   if (_dblevel >0) {
     debugON();
     }

   chkIn(_dblevel);
   A=ofr(_script);
   if (A == -1) {
     <<"can't finf $_script\n";
     exit();

     }

   BV = vgen(INT_,10,0,1);

void goo()
   {
     Svar L;
     Str val;
     Str val2;
     Str val3;
     int isv = 0;
     Str fl = "abc";

     int hv_found = 0;

     val3= "@script";

     val2= "weird";

     for (i = 0; i < 20; i++) {

       fl = readLine(A);

       if (fl == "") {

         break;

         }

       <<" $i <|$fl|>\n";

       if (!(fl == "")) {

         L=split(fl);

         sz=Caz(L);

         <<"%V $sz $fl\n";

         <<"%V $L\n";

         isv = BV.isvector();

         isv.pinfo();

         <<" $isv $fl\n";

         if (sz > 2) {

           rv= scmp(val2,"@script",6);

           if (val2 == "@script") {

             <<" $val2 is script \n";

             }

           rv.pinfo();

           if (i == 3) {

             val2 = val3;

             }

           if (!(L[1] == "")) {

             <<"%V $L[1]\n";

             rv2=scmp(L[1],"@",1);

             rv2.pinfo();

             val = spat(fl,L[1],1);

             <<"$rv2 L[1] <|$L[1]|>  <|$val|>\n";

             val.pinfo();

             }

           BV.pinfo();

           if (!hv_found) {

             <<"$val  ? script \n";
                   //hv_found = 1;

             rv= scmp(val,"script",6);

             <<"$rv $val  ? script \n";

             rv.pinfo();

             val.pinfo();
!a	     
             // if (!(scmp(val2,"@script"))) {
          if ( !(val2 == "ascript")) {
	//  if ( !(val2 == val3 )) {

               <<"not script <|$val|>\n";

               }

             else {

               <<"$L[1] header found!\n";
		    

               }

             }

           }

         }

       }

     }

   <<"before goo\n";

   goo();

   <<" Survived !\n";

   exit();

//===***===//
