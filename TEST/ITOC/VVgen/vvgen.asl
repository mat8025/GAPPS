/* 
 *  @script vvgen.asl 
 * 
 *  @comment vector sequence generation 
 *  @release CARBON 
 *  @vers 1.3 Li Lithium [asl ]                                             
 *  @date 11/20/2023 20:17:38 
 *  @cdate 1/1/2005 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 
 * 
 */ 
//-----------------<v_&_v>------------------------//

///
///
///
#include "debug.asl"

  if (_dblevel >0) {

  debugON();

  }

  allowErrors(-1);

  chkIn(_dblevel );

fileDB(ALLOW_,"ds_sivbounds","num_gen","spe_storetype","rdp_store","array_store","spe_exp")

  int vi[2] = {0,0};

  <<"$vi \n";

  vi.pinfo();

  int vs[2] = {1,-1};

  vs.pinfo();

  Table = vvgen(INT_,20,vi,vs);

  <<"%(2,, ,\n)$Table \n";

  j= 0;

  for (i= 0; i< 4; i++) {

  chkN(Table[j],i);

  chkN(Table[j+1],-i);

  j +=2;

  }

  STable = vvgen(SHORT_,20,{0,0},{1,-1}) ; // TBF anon vec as argument;

  <<"%(2,, ,\n)$STable \n";

  chkOut();

  exit();
