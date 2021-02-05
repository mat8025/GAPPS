/* 
 *  @script arch.asl 
 * 
 *  @comment get machine arch 
 *  @release CARBON 
 *  @vers 1.3 Li Lithium [asl 6.3.15 C-Li-P] 
 *  @date Thu Feb  4 09:21:54 2021 
 *  @cdate 1/1/2005 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                         
///
///  getmachinearch
///




chkIn()

wmamion = getMachineArch();

<<"$wmamion\n"

unm = !!"uname -a"

<<"$unm \n"

iv= Sstr(unm,wmamion,1,1);

<<"$iv\n"

 chkN(iv[0],-1,GT_)

chkOut()


//////////////////////////////////////////////
/*

1. Test on chrome, other machines ?

*/
