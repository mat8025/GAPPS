/* 
 *  @script strsplice.asl 
 * 
 *  @comment test str splice vmf 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.5 C-Li-B] 
 *  @date Mon Jan  4 11:50:10 2021 
 *  @cdate Fri May 1 08:42:58 2020 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                             
////

chkIn(_dblevel)

//str S;

//svar S; //TBF   which field

  S= " a  word";
  <<"$S\n"

  S->Splice("missing",3)

<<"$S\n"

  S->Splice("Begin",0)

<<"$S\n"
  len = slen(S)

  S->Splice(" End",len)

<<"$S\n"

Wd = split(S)

<<"$Wd\n"

<<"$Wd[4]\n"
chkStr(Wd[2],"missing")
chkStr(Wd[4],"End")
chkStr(Wd[0],"Begin")

chkOut()