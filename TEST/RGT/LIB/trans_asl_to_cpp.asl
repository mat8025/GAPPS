///
///
///


/*


###S62 #L19 #P? {PRSTDOUT} <<"%V $j & $k BAND  $m \n";

0 19 1	[ 42] CAT_STR : <| |>
0 19 2	[ 42] CAT_STR : <| j |>
0 19 3	[ 12] PUSH_SIVP : j INT 213 -1 0
0 19 4	[ 41] CAT_SIV : j  0
0 19 5	[ 42] CAT_STR : <| & |>
0 19 6	[ 42] CAT_STR : <| k |>
0 19 7	[ 12] PUSH_SIVP : k INT 215 -1 0
0 19 8	[ 41] CAT_SIV : k  0
0 19 9	[ 42] CAT_STR : <| BAND  |>
0 19 10	[ 42] CAT_STR : <| m |>
0 19 11	[ 12] PUSH_SIVP : m INT 219 -1 0
0 19 12	[ 41] CAT_SIV : m  0
0 19 13	[ 42] CAT_STR : <|\n|>
0 19 14	[ 43] PRT_OUT :  
0 19 15	[  7] ENDIC :  ENDIC


translate 
<<"%V $j & $k BAND  $m \n";
to 
cprintf(" j %d & k %d  BAND m %d \n", j,k,m );


*/

//A=ofr("asl_pr.txt");
A=ofr("~/lic");

Str ln;

Str args="";
Str cptxt ="";
Str wd="xyz";
Str rwd="xyz";
int iv[256];
int done=0;
Str ws;
Svar wst;
Svar lnpars;
//  spat(w1,w2,{posn,dir, [match[2]}) 
int na =0;
int ncd=0;
//<<"\"a,b);\n";
int start_cpr = 0;

while (!done) {

  ln = readline(A);



  if (ferror(A) == EOF_ERROR_) {
    done = 1;
    break;
   } 

  iv= sstr(ln,"PRSTDOUT");
  if (iv[0] != -1) {
   
   lnpars=split(ln);
   rwd=spat(lnpars[1],"#L",1);
   //<<"$lnpars[1] : ";
   <<"$rwd : ";
   start_cpr = 1;
   cptxt="cprintf(\"";
   args="";
  }
// chk for PRSTDOUT 
   if (start_cpr) {
  //<<"$ln";
    iv= sstr(ln,"CAT_STR");
    if (iv[0] != -1) {
     rwd=spat(ln,"<|",1);
     wd= spat(rwd,"|>")
     cptxt.cat(wd);
    }
     iv= sstr(ln,"PUSH_SIVP");
    if (iv[0] != -1) {
     rwd=spat(ln,": ",1);
     // get ws tokens
     wst=split(rwd);
     args.cat(",");     
     args.cat(wst[0]);
     ncd=scmp(wst[1],"INT"); 

     if (scmp(wst[1],"INT"))  {
    // if (wst[1]=="INT")  {

         cptxt.cat('%d');
     //<<"$ncd <|$wst[1]|> INT $cptxt     \n"
      }
     else if (scmp(wst[1],"FLOAT")) {
        cptxt.cat('%f');
	}
     else if (scmp(wst[1],"ULONG")) {
        cptxt.cat('%ld');
	}	
     else if (scmp(wst[1],"STRV")) { 
        cptxt.cat('%S');
	}

     na++;
    }
    
    iv= sstr(ln,"ENDIC");
     if (iv[0] != -1) {

     //done = 1;
     start_cpr = 0;
      //<<"trying ENDIC \n";
      cptxt.cat( '"' );  // works
    // cptxt.cat( "\");" );  //  works

      //ws=scat(cptxt,'");');
      //cptxt = ws;
         if (na > 0) {
             cptxt.cat(args);  //  works
          }
            cptxt.cat( ");" ); 
           <<"$cptxt \n"      
      }
    }
  
}



