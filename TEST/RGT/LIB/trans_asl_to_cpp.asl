///
///
///


/*

###S50 #L8 #P? #C<|T 17|> {PRSTDOUT} <<"%V $j $k $m $d\n";

1 8 1	[ 42] CAT_STR : <| |>
1 8 2	[ 42] CAT_STR : <| j |>
1 8 3	[ 12] PUSH_SIVP : j INT 213 -1 0
1 8 4	[ 41] CAT_SIV : j  0
1 8 5	[ 42] CAT_STR : <| |>
1 8 6	[ 42] CAT_STR : <| k |>
1 8 7	[ 12] PUSH_SIVP : k INT 215 -1 0
1 8 8	[ 41] CAT_SIV : k  0
1 8 9	[ 42] CAT_STR : <| |>
1 8 10	[ 42] CAT_STR : <| m |>
1 8 11	[ 12] PUSH_SIVP : m INT 219 -1 0
1 8 12	[ 41] CAT_SIV : m  0
1 8 13	[ 42] CAT_STR : <| |>
1 8 14	[ 42] CAT_STR : <| d |>
1 8 15	[ 12] PUSH_SIVP : d DOUBLE 201 -1 0
1 8 16	[ 41] CAT_SIV : d  0
1 8 17	[ 42] CAT_STR : <|\n|>
1 8 18	[ 43] PRT_OUT : ã 
1 8 19	[  7] ENDIC :  ENDIC



translate 
<<"%V $j & $k BAND  $m \n";
to 
cprintf(" j %d & k %d  BAND m %d \n", j,k,m );


###S364 #L326 #P? #C<|T 1252 |> {PRSTDOUT} <<"ca1 <|$fname|> is NULL\n";

1 326 1	[ 42] CAT_STR : <|ca1 <||>
1 326 2	[ 42] CAT_STR : <||>
1 326 3	[ 12] PUSH_SIVP : fname STRV 1554 -1 0
1 326 4	[ 41] CAT_SIV : fname  0
1 326 5	[ 42] CAT_STR : <||> is NULL\n|>
1 326 6	[ 43] PRT_OUT :  
1 326 7	[  7] ENDIC :  ENDIC

#


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
   iv = sstr(ln,"#C<|T");
   if (iv[0] != -1) {
   lnpars=split(ln);
   rwd = lnpars[4];
   //rwd=spat(lnpars[4]," |",-1);
  // <<"<|$lnpars[4]|> ";
   <<"$rwd : ";
   start_cpr = 1;
   cptxt="cprintf(\"";
   args="";
   }
  }
// chk for PRSTDOUT 
   if (start_cpr) {
  //<<"$ln";
    iv= sstr(ln,"CAT_STR");
    if (iv[0] != -1) {
     rwd=spat(ln,"<|",1);
     wd= spat(rwd,"|>",-1,-1)
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
     else if (scmp(wst[1],"DOUBLE")) {
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



