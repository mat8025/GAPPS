/* 
 *  @script paraex.asl 
 * 
 *  @comment test scpy,scat char []  
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.10 C-Li-Ne]                                
 *  @date Thu Jan 14 21:51:08 2021 
 *  @cdate 1/1/2010 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

///
///
///


chkIn(_dblevel)

  void vers2ele(str vstr)
  {
  //<<"%V $vstr\n"
   pmaj = atoi(spat(vstr,".",-1))
   <<[2]"$pmaj $(typeof(pmaj)) $(ptsym(pmaj)) \n"  
   pmin = atoi(spat(vstr,".",1))

//<<[2]"$pmaj $(ptsym(pmaj)) $pmin $(ptsym(pmin))\n"
   elestr = pt(pmin);
   _ele =" ";
   _ele = spat(elestr,",")
 // <<"$ele $(typeof(_ele))\n";
 // <<"$ele\n";
   //return ele;
  }
  //======================


str _ele = "";


vers2ele("1.1")


w="a"

a="Happy New"

<<"$($w) Year \n"

se = "$($w) Year"

<<"$se \n"


B= "A\"B\"C\n"

<<"$B"



chkStr(se,"Happy New Year")

<<" a\ssimple\tstring\n %% \n"


<<" a\ssimple\vstring\v\b\b\a\%\"P \n"

A="internal\sstring\n"

<<"$A"

v="oow.asl"
<<"grep \"DONE: :$v\" "
<<"\n"

char C[]
char E[]


!iC



//C[0] = 47

sz= Caz(C)
<<"C sz $sz\n"

scpy(C,"Mark")



<<"Char array C contains $C[0] %s$C\n"

<<"m %d$C[0]\n"

chkN(C[0],'M')

<<"%d$C\n"



scpy(C,"\tmark\bK\%\b\"EFX\"")

<<"%d$C\n"
<<"%c$C\n"

<<"DQ? %d$C[9] %c$C[9]\n"
<<"tab %d$C[0]\n"

chkN(C[0],'\t')  // FIXIT 

chkN(C[0],9)




//chkN(C[9],'\"')

chkN(C[9],34)

<<"%d$C\n"
<<"%c$C\n"
<<"%s$C\n"

ws = scat("\"Mark\"","\s\"Terry\"")
<<"$ws \n"

ws=scat("\tmark\bK\%\b\"EFX\"","\tterry\bL\%\b\"AMP\"")
<<"$ws \n"



C=scat("\tmark\bK\%\b\"EFX\"","\tterry\bL\%\b\"AMP\"")

<<"%d$C\n"
<<"%c$C\n"
<<"%s$C\n"


E=scat("Happy"," Hols")
<<"%Vs$E\n"

chkOut()




