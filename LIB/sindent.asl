//%*********************************************** 
//*  @script sindent.asl 
//* 
//*  @comment format asl code 
//*  @release CARBON 
//*  @vers 1.17 Cl Chlorine                                                
//*  @date Mon Apr  8 09:49:04 2019 
//*  @cdate 1/1/2015 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
  
  

  sdb(-1)
// use an indent of 2 spaces - for all non-comment lines

//<<"? $_clarg[1]\n"

  fname = _clarg[1];

<<[2]"$fname \n"

  A=ofr(fname);
  if (A ==-1) {
  <<"can't find $fname \n"
   exit()
  }

  B=ofw("${fname}.pp");
  if (B ==-1) {
  <<"can't write $fname .pp \n"
   exit()
  }


  char ns[];
  char c;
  char lc;
  
  int ln = 0;
  
  is_comment = 0;
  is_trailing_comment = 0;
  
  nw = 2;
  
  str NL;
  str NL1;
  svar NL2;
  
  int empty_line_cnt = 0;
  is_empty_line = 0;
  
  while (1) {
    
    is_comment = 0;
    is_empty_line = 1;
    is_trailing_comment = 0;
    needs_semi_colon = 0;
    L = readline(A);
    
    
    if (ferror(A) == EOF_ERROR_) {
          break;
        }
	
    ln++;
    
    NL = L;
    <<"in:$NL\n" ;

//ans=query("2pp")
  
    nc = Caz(NL); 
    sl = Slen(NL);
    
    if (sl >= 1) {
         is_empty_line = 0;   
      scpy(ns,eatWhiteEnds(NL));
      <<[2]"check comment $ns[0] $ns[1] \n"; 
      
      if ((ns[0] == 47) && (ns[1] == '/')) {
        is_comment = 1;
        <<[2]"comment $NL\n"; 
        }
      else if (ns[0] == 35) {
        is_comment = 1;
        <<[2]"comment $NL\n"; 
        }	
      else {
        ws = dewhite(NL); 
        if (slen(ws) == 0) {
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
      ns = sele(NL,ind,1); 
      c= ns[0];
      <<[2]"last char? $ln  $c $sl $ind %s $c \n";
      }

    s1 = ";{}/\\" ;
    
//k = sstr(s1,c,1)
    
    k = sstr(";{}/\\",c,1); 
    
// <<[2]"$L $sl %c$c %d$k\n"

    if (slen(NL) >0) {
      NL=eatWhiteEnds(NL);
      }
    
    is_cbe = 0;
    is_cbs = 0;
    
    
    if (slen(NL) > 0) {
      
      is_cbs = scmp(NL,"{",-1,0,0);
      
      is_cbe = scmp(NL,"}",-1,0,0);
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


    if (len > 60) {
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
      ns = sele(NL,ind,1); 
      c= ns[0];
      <<[2]"last char? $ln  $c $sl $ind %s $c \n";
      }
    
    if (is_empty_line && (empty_line_cnt > 2)) {
      <<[2]"%V $empty_line_cnt\n"; 
      }
    else  if ( !is_comment && !is_proc && !is_if  \
                 && (sl > 0) \
		 && (  sstr(";/{}\\",c,1) == -1) ) { 
//
//    check for trailing comment - if so eol is just before
       mat =0;
       cr =0;
       spat(NL,"//",-1,-1,&mat,&cr);
       
       if (mat) {
         NL = ssub(NL,"//","; //")
	 is_trailing_comment = 1;
       }


	<<"%c $c %d $c \n"
	if (c != 59) {
	   needs_semi_colon = 1;
	   }
	   
      <<[2]" needs ; ? $needs_semi_colon <|$c|>\n";
      <<[2]" needs ; $NL\n";
      
    }



<<"%V $conline $is_empty_line $is_comment \n";

      if (conline) {
        <<[B]"${tws}$NL1		\\\n"; 
        <<[B]"$tws  \t\t$NL2; \n"; 
        }
      else if ((is_empty_line) && (empty_line_cnt < 1)) {
         <<"empty line!\n"
        <<[B]"\n"; 
        }
      else if (is_trailing_comment) {
         <<"trailing comment\n"
         <<[B]"${tws}$NL \n"; 
        }	
      else if (is_comment) {
               <<"comment\n"
      <<[B]"$L\n"; 
      }
      else if (needs_semi_colon) {
                     <<"add ; \n"
          <<[B]"${tws}$NL;\n"; 
      }
      else {
               <<"asis\n"
        <<[B]"${tws}$NL\n"; 
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
//  ans=query("pp correct?")
//  if (ans @="n")
//       break;
  }
  
  cf(B);
  
//==================================//
///--------------  TBDFC ------------------------------
/// TBF  bug split of long lines
/// TBF  bug - puts ; end of if without a brace
/// TBD #define should start @ col 0