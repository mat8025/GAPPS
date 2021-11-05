/* 
 *  @script sindent.asl 
 * 
 *  @comment format asl code 
 *  @release CARBON 
 *  @vers 1.18 Ar Argon [asl 6.3.58 C-Li-Ce] 
 *  @date 11/03/2021 12:04:22          
 *  @cdate 1/1/2015 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                 
;

  
#include "debug"



   do_query = 1;
   
// use an indent of 2 spaces - for all non-comment lines

//<<"? $_clarg[1]\n"

  fname = _clarg[1];

<<[2]"$fname \n"

  A=ofr(fname);
  if (A ==-1) {
  <<"can't find $fname \n"
   exit()
  }
  ofname = scut(fname,-4);
  ofname = scat(ofname,"_pp.asl");
  B=ofw(ofname);
  if (B ==-1) {
  <<"can't write $ofname \n"
   exit()
  }


  char nsv[];
  char c;
  char lc;
  
  int ln = 0;
  
  is_comment = 0;
  is_define = 0;
  is_include = 0;    
  is_trailing_comment = 0;
  in_comment_blk = 0  ;
  in_txt_blk = 0  ;
  
  nw = 2;
  
  Str L;
  Str NL;
  Str NL1;

  str tws;
  Svar NL2;
  
  int empty_line_cnt = 0;
  is_empty_line = 0;
  
  while (1) {
    
    is_comment = 0;
    is_empty_line = 1;
    is_define = 0;
    is_include = 0;        
    is_trailing_comment = 0;
    needs_semi_colon = 0;
    L = readline(A,-1,1);
    
    
    if (ferror(A) == EOF_ERROR_) {
          break;
        }
	
    ln++;
    
    NL = L;
    <<[2]"in:$NL\n" ;

//ans=query("2pp")
  
    nc = Caz(NL); 
    sl = Slen(NL);
    
    if (sl >= 1) {
         is_empty_line = 0;   
      scpy(nsv,eatWhiteEnds(NL));
      <<[2]"check comment $nsv[0] $nsv[1] \n"; 

       is_define = scmp(nsv,"#define",7);
       is_include = scmp(nsv,"#include",8);

<<[2]"%s $nsv %v %d $is_define $is_include\n"


      if ((nsv[0] == '/') && (nsv[1] == '/')) {
        is_comment = 1;
        <<[2]"comment $NL\n"; 
        }
      else if ((nsv[0] == '/') && (nsv[1] == '*')) {
        is_comment = 1;
	in_comment_blk = 1
        <<[2]"comment $NL\n"; 
        }
      else if ((nsv[0] == '*') && (nsv[1] == '/')) {
        is_comment = 1;
	in_comment_blk = 0
        <<[2]"comment $NL\n"; 
        }
      else if ((nsv[0] == '<') && (nsv[1] == '|')) {
        is_comment = 1;
	in_txt_blk = 1
        <<[2]"txt blk startcomment $NL\n"; 
        }
      else if ((nsv[0] == '|') && (nsv[1] == '>')) {
        is_comment = 1;
	in_txt_blk = 0;
        <<[2]"txt blk startcomment $NL\n"; 
        }		
      else if (nsv[0] == '#') {
        is_comment = 1;
        <<[2]"comment $NL\n"; 
        }
      else {
        ws = dewhite(NL); 
        if (slen(ws) == 1) {
          <<[2]"empty? $sl  $L\n"; 
          is_empty_line = 1;
          }
        }


      if (!is_empty_line) {
        empty_line_cnt = 0;
        }
      }
   
    
    if (is_empty_line) {
      empty_line_cnt++;
      <<[2]"%V $empty_line_cnt\n"; 
      }
    
    sl = Slen(NL);
    ind = sl -1;
    if (ind >=0) {
      nsv = sele(NL,ind,1); 
      c= nsv[0];
      <<[2]"last char? $ln  $c $sl $ind %s $c \n";
      }

    s1 = ";{}/\\" ;
    
//k = sstr(s1,c,1)
    
    iv = sstr(";{}/\\",c,1); 
    
 <<[2]"$L $sl %c$c $iv[0] \n"

    if (slen(NL) >0) {
      NL=eatWhiteEnds(NL);
      }
    
    is_cbe = 0;
    is_cbs = 0;
    is_equ = 0;


    
    if (slen(NL) > 0) {
      
      is_cbs = scmp(NL,"{",-1,0,0);
      
      is_cbe = scmp(NL,"}",-1,0,0);

      is_equ = scin(NL,"=[]",1);

      }
    <<[2]"<|$L|> <|$NL|> %V $nw $is_cbs $is_cbe \n"; 
    
    is_proc = scmp(NL,"proc",4,0);

    is_if = scmp(NL,"if",2,0);


    tws = nsc(nw," ");
    if (is_cbs) {
      nw += 2;
  //<<[2]"PROC %v$nw \n"
      <<[2]"CBS %v$nw \n"; 
      }
    
    if (is_cbe) {
      
      nw -= 2;
      <<[2]"CBE %v$nw \n"; 
      }
    
    
    len = slen(NL);
    conline = 0;


    if (len > 70) {
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
    
    sl = Slen(NL);
    ind = sl -1;
    if (ind >= 0) {
      nsv = sele(NL,ind,1); 
      c= nsv[0];
      <<[2]"last char? $ln  $c $sl $ind %s $c \n";
      }




    if (is_empty_line && (empty_line_cnt > 1)) {
      <<[2]"%V $empty_line_cnt\n"; 
      }
    else  if ( !is_comment && !is_proc && !is_if  \
                 && (sl > 0) ) {

//
//    check for trailing comment - if so eol is just before
       mat =0;
       cr =0;
       spat(NL,"//",-1,-1,&mat,&cr);
       
       if (mat) {
         NL = ssub(NL,"//","; //")
	 is_trailing_comment = 1;
       }




	<<[2]"%c $c %d $c \n"
	if (c != 59) {
	   needs_semi_colon = 1;
	 

         iv =sstr(";/{}\\",c,1);
<<[2]"$iv\n"
          if (iv[0] != -1) {
            needs_semi_colon = 0;
          if (is_equ) {
         <<[2]" declare St $NL needs ; \n";
             needs_semi_colon = 1;
          }
        }
       }
       if (in_comment_blk) {
             needs_semi_colon = 0;
       }
       if (in_txt_blk) {
             needs_semi_colon = 0;
       }
       
      <<[2]" needs ; ? $needs_semi_colon <|$c|>\n";
      <<[2]" needs ; $NL\n";
      
      }



<<[2]"%V $conline $is_empty_line $is_comment $empty_line_cnt\n";

      if (conline) {
        <<[B]"${tws}$NL1		\\\n"; 
        <<[B]"$tws  \t\t$NL2; \n"; 
        }
      else if ((is_empty_line) && (empty_line_cnt < 1)) {
        <<[2]"adding empty line! $empty_line_cnt\n"
        <<[B]"\n"; 
        }
      else if (is_trailing_comment) {
         <<[2]"trailing comment\n"
         <<[B]"${tws}$NL \n"; 
        }	
      else if (is_define || is_include) {
               <<[2]"define/include\n"
      <<[B]"$NL\n"; 
      }      
      else if (is_comment) {
               <<[2]"comment\n"
      <<[B]"$L\n"; 
      }
      else if (needs_semi_colon) {
                     <<[2]"add ; \n"
      if (empty_line_cnt == 0) {
             <<[B]"\n"; 
       }
          <<[B]"${tws}$NL;\n"; 
      }
      else {
               <<[2]"asis\n"
      if (empty_line_cnt == 0) {
             <<[B]"\n"; 
       }
       if (!is_empty_line) {
         <<[B]"${tws}$NL\n";
	 }
      }




    if (needs_semi_colon) {
   <<"out:${tws}${NL};\n";
   }
   else {
   <<"out:${tws}$NL\n";
   }

//      <<[B]"${tws}$NL\n"; 
  tws = nsc(nw,"x");
 // <<[2]"%V$nw $tws\n";
   fflush();

  if (do_query) {
   ans=query("pp correct?")
    if (ans =="n") {
         break;
	 }
    if (ans == "q") {
         exit();
	 }
    if (ans == "c") {
      do_query = 0;
    }
  }

  }
  
  cf(B);
  
//==================================//
/*--------------  TBDFC ------------------------------

/// TBF  bug split of long lines
/// TBF  bug - puts ; end of if without a brace
/// TBD #define should start @ col 0

*/
