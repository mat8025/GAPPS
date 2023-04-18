/* 
 *  @script sindent.asl 
 * 
 *  @comment format asl scripts 
 *  @release CARBON 
 *  @vers 1.22 Ti 6.3.83 C-Li-Bi 
 *  @date 02/16/2022 09:49:43          
 *  @cdate 1/1/2015 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                                
                                                              


  
#include "debug"

#define COMMENT 1
#define PROCCALL 2
#define MARGINCALL 3
#define EMPTYLN 5

int match[2];

   allowErrors(-1) ;  // keep going

void doTrailingComment()
{
         sposn = regex(NL,"; *//")

         if (sposn[0] == -1)  {
           NL = ssub(NL,"//","; //")
	 }
	 is_trailing_comment = 1;
}
//=========================//      

void Conline()
{

// TBF - will split  "xxx..." but should leave

      <<[2]"SPLIT $NL \n"; 
      //index =sstr(NL,",",1);
      
// use ,
      iv = sstr(NL,",",1,1);
      <<[2]"found? $iv\n"; 
      index = iv[0];
      if (index == -1) {
        index = -1;
        }
      else {
        sz=Caz(iv);
        wi = sz/2;
        index = iv[wi];
        if (index != -1) 
            index++;
        else
            index = -1;
        }
      
// else use space
      if (index == -1) {
      // but space not quoted !
        iv = sstr(NL," ",1,1);
        <<[2]"found? $iv\n"; 
        index = iv[0];
        if (index == -1) {
          index = -1;
          }
        else {
          sz=Caz(iv);
          wi = sz/2;
          index = iv[wi];
          if (index != -1) 
             index++;
          else 
             index = -1;
          }
        }
      
      if (index != -1) {
        <<[2]"SPLIT  %v $index\n";
        scpy(NL1,NL,index);
        <<[2]"%V $NL1 \n"; 
        scpy(NL2,sele(NL,index,len-index));
        <<[2]"%V $NL2 \n"; 
        conline =1;
        }
}
//=========================//      

int sposn[300];
int ltype = 0;
int last_ltype = 0;
int mat =0;
int cr =0;


   do_query = 1;
   
// use an indent of 2 spaces - for all non-comment lines

//<<"? $_clarg[1]\n"

ESL=';//==============\_(^-^)_/==================//;';


  fname = _clarg[1];

<<[2]"$fname \n"



// xyz.asl ?  - no extension tag on .asl
 int pma[100];

  pma=regex(fname,"\\.asl")

 if (pma[0] == -1) {
   fname = scat(fname,".asl")
 }

  A=ofr(fname);

  if (A == -1) {
  <<"can't find $fname \n"
   exit()
  }
//  ofname = scut(fname,-4);
  ofname = scat("pp_",fname);
  B=ofw(ofname);
  if (B ==-1) {
  <<"can't write $ofname \n"
   exit()
  }


  char nsv[];
  char lastc;
  char lc;
  
  int ln = 0;
  
  is_comment = 0;
  is_define = 0;
  is_include = 0;    
  is_trailing_comment = 0;
  in_comment_blk = 0  ;
  in_txt_blk = 0  ;
  is_margin_call = 0;
  is_case = 0;
  is_public = 0;  
  
  nw = 2;
  
  Str L;
  Str LL;
  Str NL;
  Str NL1;

  Str tws;
  Svar NL2;
  Svar wrds;
  Svar wrds1;
  
  int empty_line_cnt = 0;
  is_empty_line = 0;
  int conline = 0;
  int foldline = 0;
  int ll_fold = 0;
  while (1) {
    
    is_comment = 0;
    is_empty_line = 1;
    is_define = 0;
    is_include = 0;
    is_proc = 0;
    is_cmf = 0;    
    is_trailing_comment = 0;
    needs_semi_colon = 0;
    is_margin_call = 0;    
    L = readline(A,-1,1);
    conline = 0;
    foldline = 0;
     if (ferror(A) == EOF_ERROR_) {

     <<"end @ $L\n"
        break;
        }

    posn = ftell(A);

    L2 = readline(A,-1,1);

    if (ferror(A) == EOF_ERROR_) {

    L2 = " \n";

    }

    fseek(A,posn,0);
    LL= L;

	
    ln++;

    wrds = split(L)
    wrds2 = split(L2);

    NL = L;
    
<<"in: \033[1;32m $NL  \033[0m\n" ;

//<<[2]"in: $NL   \n" ;

//ans=query("2pp")
  
    nc = Caz(NL); 
    sl = Slen(NL);


    if (sl >= 1) {
         is_empty_line = 0;   
      scpy(nsv,eatWhiteEnds(NL));
      //<<[2]"check comment $nsv[0] $nsv[1] \n"; 

       is_define = scmp(nsv,"#define",7);
       is_include = scmp(nsv,"#include",8);
       is_case = scmp(nsv,"case",4);

//<<[2]"%s $nsv %v %d $is_define $is_include $is_case\n"
//<<[2]"nsv[0],[1]  $nsv[0]  $nsv[1]\n"

      if ((nsv[0] == '/') && (nsv[1] == '/')) {
        is_comment = 1;
        //<<[2]"comment $NL\n"; 
        }
      else if ((nsv[0] == '/') && (nsv[1] == '*')) {
        is_comment = 1;
	in_comment_blk = 1;
        //<<[2]"comment $NL\n"; 
        }
      else if ((nsv[0] == '*') && (nsv[1] == '/')) {
        is_comment = 1;
	in_comment_blk = 0
	  empty_line_cnt = -1;
        //<<[2]"end commentblk $empty_line_cnt $NL\n"; 
        }

      else if (scmp(nsv,";//---",6)) {
           is_comment = 1;
      }
      else if ((nsv[0] == '<') && (nsv[1] == '|')) {
        is_comment = 1;
	in_txt_blk = 1
        //<<[2]"txt blk startcomment $NL\n"; 
        }
      else if ((nsv[0] == '|') && (nsv[1] == '>')) {
        is_comment = 1;
	in_txt_blk = 0;
        empty_line_cnt = -1;
        <<[2]"txt blk $empty_line_cnt endcomment $NL\n"; 
        }		
      else if (nsv[0] == '#') {
        is_comment = 1;
        //<<[2]"comment $NL\n"; 
        }
       else if (nsv[0] == '!'  && (scin("apweitz",nsv[1]))) {
        is_margin_call = 1;
        is_comment = 1; // treat as	
        //<<[2]"margin call $NL\n"; 
        }	
      else {
        ws = dewhite(NL); 
        if (slen(ws) == 0) {
          //<<[2]"empty? $sl  $L\n"; 
          is_empty_line = 1;
          }
        }


      if (!is_empty_line && !is_comment) {
        empty_line_cnt = 0;
        }

      }
   
    
    if (is_empty_line) {
      if (!in_txt_blk) {
        empty_line_cnt++;
	}
      //<<[2]"%V $empty_line_cnt\n"; 
      ltype = EMPTYLN;
    }

     if (is_comment) {
        ltype = COMMENT;
    }
    
    sl = Slen(NL);
    ind = sl -1;
    if (ind >=0) {
      nsv = sele(NL,ind,1); 
      lastc= nsv[0];
      <<[2]"last char? $ln  $lastc $sl $ind %s $lastc \n";
      }

<<"testing lastc $lastc   \\ \n";       

      if (lastc == '\\') {
           foldline = 1;
<<"found fold line $foldline \\ \n";       	   
       }

      if (lastc == 92) {
           foldline = 1;
<<"found fold line $foldline 92 \n";       	   
       }

  
    s1 = ";{}/\\" ;
    
//k = sstr(s1,c,1)
    
    iv = sstr(";{}/\\",lastc,1); 
    
 <<[2]"$L $sl %c $lastc $iv[0] \n"

    if (slen(NL) >0) {
      NL=eatWhiteEnds(NL);
      }
    
    is_cbe = 0;
    is_cbs = 0;
    is_equ = 0;


    
    if (slen(NL) > 0) {

      nls=ssub(NL,"str ","Str ",1);
      NL=ssub(nls,"svar ","Svar ",1);


      is_cbs = scmp(NL,"{",-1,0,0);
      
      is_cbe = scmp(NL,"}",-1,0,0);
      is_cbe = scmp(NL,"};",-2,0,0);

      is_equ = scin(NL,"=[]",1);

      }
    //<<[2]"<|$L|> <|$NL|> %V $nw $is_cbs $is_cbe \n"; 
    
    is_proc = scmp(NL,"proc",4,0);
    if (is_proc) {
       nls=ssub(NL,"proc ","void ",1);
       NL=nls;
    }

    is_cmf = scmp(NL,"cmf",3,0);
    if (is_cmf) {
      is_proc = 1;
    }


   if (scmp(wrds[0],"void")) {
       is_proc = 1;
    }

   if ( isaType(wrds[0])) {
     if (scmp(wrds2[0],"{")) {
        is_proc = 1;
	}
    }
    
    if (is_proc) {
       ltype = PROCCALL;
    }

    is_if = scmp(NL,"if",2,0);


    tws = nsc(nw," ");
    if (is_cbs) {
      nw += 2;
  //<<[2]"PROC %v$nw \n"
      //<<[2]"CBS %v$nw \n"; 
      }
    
    if (is_cbe) {
      
      nw -= 2;
      //<<[2]"CBE %v$nw \n"; 
      }
    
    
    len = slen(NL);



    if (len > 500) {
       Conline()
    }
     
    sl = Slen(NL);
    ind = sl -1;
    
    if (ind >= 0) {
      nsv = sele(NL,ind,1); 
      lastc= nsv[0];
      <<[2]"last char? $ln  $lastc $sl $ind %s $lastc \n";
      }




    if (is_empty_line && (empty_line_cnt > 1)) {
      <<[2]"%V $empty_line_cnt\n"; 
      }
    else  if ( !is_comment && !is_proc && !is_if  \
                 && (sl > 0) ) {

//
//    check for trailing comment - if so eol is just before

       spat(NL,"//",0,-1,match);
       
       if (match[0]) {
         // ; before //
         if (!is_case) {	 
           doTrailingComment()
        }
       }

	<<[2]"%c $lastc %d $lastc \n"
	
	if (lastc != 59 && lastc != 123 && lastc != 92 && !ll_fold) {
	   needs_semi_colon = 1;
	 

         iv =sstr(";:/{}\\",lastc,1);
//<<[2]"$iv\n"
          if (iv[0] != -1) {
            needs_semi_colon = 0;
          if (is_equ) {
         //<<[2]" declare St $NL needs ; \n";
             needs_semi_colon = 1;
          }
        }
	<<" %v $needs_semi_colon\n";
       }

     if (is_case || in_comment_blk || in_txt_blk) {
             needs_semi_colon = 0;
       }

       if (lastc == 92) {
<<"found foldline \\ \n";       
           foldline = 1;
       }
     
       
      //<<[2]" needs ; ? $needs_semi_colon <|$lastc|>\n";
      //<<[2]" needs ; $NL\n";
      
      }



<<[2]"%V $nw $conline $foldline $ll_fold  $is_empty_line $is_comment $in_comment_blk $empty_line_cnt $last_ltype\n";

      if (conline) {
        <<[B]"${tws}$NL1		\\\n"; 
        <<[B]"$tws  \t\t$NL2; \n"; 
        }
      else if ((is_empty_line) && (empty_line_cnt < 1) && !in_comment_blk  && !in_txt_blk ) {
        //<<[2]"adding empty line! $empty_line_cnt\n"
        <<[B]"\n"; 
        }
/*
      else if (is_trailing_comment) {
         <<[2]"trailing comment\n"
         <<[B]"${tws}$NL \n"; 
        }
*/	
      else if (is_define || is_include) {
               //<<[2]"define/include\n"
      <<[B]"$NL\n"; 
      }      
      else if (is_comment || in_comment_blk ) {
               //<<[2]"comment\n"
               <<[B]"$L\n"; 
      }
      else if (needs_semi_colon) {
                     //<<[2]"add ; \n"
      if (empty_line_cnt == 0) {
             <<[B]"\n"; 
       }
          <<[B]"${tws}$NL;\n"; 
      }
      else {

     //<<[2]"asis: $NL\n"
	       
      if ((empty_line_cnt < 1)  && !in_comment_blk  \
      && !in_txt_blk  \
      && !foldline  \
      && !ll_fold \
      && (last_ltype != PROCCALL)) {
<<"adding empty line for spacing  %V $foldline $ll_fold \n";      
             <<[B]"\n"; 

      }

         

         if (!is_empty_line || in_txt_blk) {
             <<"${tws}$NL\n";
          <<[B]"${tws}$NL\n";
	 }
	 else {
//<<"empty ? <|$NL|> \n"
          ;
         }
      }

       ll_fold = 0;
    if (foldline) {
       ll_fold = 1;
    }

    if (needs_semi_colon) {
   <<"\033[1;34m out:${tws}${NL};\n \033[0m";
   }
   else {
   <<"\033[1;34m out:${tws}$NL  \033[0m\n";
   }

  //<<"${tws}$NL\n"; 

  //<<[B]"${tws}$NL\n";
  
  tws = nsc(nw,"x");
 // <<[2]"%V$nw $tws\n";
   fflush();

  if (do_query) {
   ans=query("pp correct? [n,q,c]");
   
    if (ans == "n") {
         break;
	 }
    if (ans == "q") {
         exit();
	 }
    if (ans == "c") {
      do_query = 0;
      <<"%V $do_query\n"
    }
  }
  
    last_ltype = ltype;
  }

//<<"LL: <|$LL|>\n"
if (LL != ESL) {
  <<[B]"\n$ESL\n";
  }
  cf(B);
  
//==================================//
/*--------------  TBDFC ------------------------------

/// TBF  bug split of long lines
/// TBF  bug - puts ; end of if without a brace
/// TBD #define should start @ col 0

*/
