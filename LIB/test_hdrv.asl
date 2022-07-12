/* 
 *  @script test_hdrv.asl 
 * 
 *  @comment  xxx
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.60 C-Li-Nd]                               
 *  @date 11/18/2021 08:36:24 
 *  @cdate 11/18/2021 08:36:24 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

;//----------------------//;

<|Use_= 
Demo  of  hdrv
/////////////////////// 
|>


#include "debug.asl"


if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

chkIn(_dblevel)



///
///

//#include "hdrv"

<<"%V $_script \n"


str h_comment = "hdr comment"

<<"%V $h_comment\n"

A=ofr(_script)

if (A == -1) {
<<"can't fine $_script\n"
exit()
}

BV = vgen(INT_,10,0,1)

<<"$BV\n"

 void hdrv_func()
   {
     Svar L;
     Str val;
     Str val2;
     Str val3;     
     Str fl = "aaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccc";
     int sz;
     int isv = 0;
     int hv_found = 0;
     int rv;
     val = "XYZ";
val3= "@script"


 isv = BV.isvector()
 isv.pinfo();
<<" $isv $fl\n"




     for (wln = 1; wln <= 10; wln++) {

      // fl = getcodeln(wln,0);
       fl = readLine(A);
       
       if (fl == "") {

         break;

         }

isv = BV.isvector()
       <<"$wln $isv <|$fl|>\n";

       if (!(fl == "")) {

         L=split(fl);

         sz=Caz(L);
	 <<"%V $sz\n"
	 <<"%V $L\n"
!a
    if (sz > 2) {

         if (!(L[1] == "")) {

  rv=scmp(L[1],"@",1);
  	 <<"%V $rv\n"
	 rv.pinfo()

  val = spat(fl,L[1],1);
 <<"$rv L[1] <|$L[1]|>  <|$val|>\n"


            rv2=scmp(L[1],"@",1);
	    
       rv2.pinfo()

        }
     }
               if (!hv_found) {

              <<"$val  ? script \n"
                   //hv_found = 1;
		   rv= scmp(val,"script",6);
              <<"$rv $val  ? script \n"
	 rv.pinfo()
	 val.pinfo()
                 if (!scmp(L[1],"@script")) {
                    <<"not script <|$val|>\n";
                 }
		 else {
                    <<"$L[1] header found!\n";
                 }
             }
       

        }


       if (!(fl == "")) {

         L=split(fl);

         sz=Caz(L);


         if (sz > 1) {

   //        if (!(L[1] == "")) {

             //if ((L[0] == "")) {
<<"%V $sz\n"

          if ( sz > 2) {
	   


            rv=scmp(L[1],"@",1);
	    
          rv.pinfo()

           val = spat(fl,L[1],1);

	   <<"OK NOW? $rv L[1] <|$L[1]|>  <|$val|>\n"

//ans= query("->");
              BV.pinfo()
           val.pinfo();


               if (!hv_found) {

              <<"$val  ? script \n"
                   //hv_found = 1;
		   rv= scmp(val,"script",6);
              <<"$rv $val  ? script \n"
               val2 = L[1];
	       
	   // if (!(scmp(val2,"@script"))) {
	      if (!(val2 == "@script")) {
	     //  if (val2 == val3) {	     
	       
              // if ((L[1] == "@script")) {
	     //  if (!(scmp(L[1],"@script"))) {
         //   if (val @= "@script") {
	     //    if ( sz > 3) {
                    <<"script <|$val|>\n";

                }
		 else {
                    <<"$L[1] header found!\n";
                 }


             }

          }

       }

    }


  }
}

/*
 for (i=0; i<3; i++) {

   j=1;

   j.pinfo();

   --j;

   j.pinfo();

   --j;

   j.pinfo();

<<"$i $j\n"
!a
}
*/



   hdrv_func();


<<" Survived !\n"
exit()


/*
             if (scmp(L[1],"@",1)) {

               val2 = spat(fl,L[1],1);
	       
	       val2.pinfo()
!a	       
             }
*/