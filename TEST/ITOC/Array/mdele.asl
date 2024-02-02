/* 
 *  @script mdele.asl                                                   
 * 
 *  @comment test multi dimn ele access                                 
 *  @release Boron                                                      
 *  @vers 1.17 Cl Chlorine [asl 5.80 : B Hg]                            
 *  @date 02/02/2024 11:55:29                                           
 *  @cdate 1/1/2001                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 


Str Use_ = "Demo  of MD ele/range selection"


#include "debug"

if (_dblevel >0) {
   debugON()
     
}


// test array indexing
  if (_dblevel > 1) {
  allowDB("spe,opera_,array_parse,rdp_,ds,ic_")
 }


 allowErrors(-1);
 chkIn (_dblevel)


 int HT[10][10]

 HT.pinfo()

<<" $HT \n"

 HT[3][1] = 89

//<<" $HT \n"


 HT.pinfo()

 HT[0][0] = 0

 HT[0][2] = 2 
 HT[0][3] = 3

 HT[1][2] = 12
 HT[2][2] = 13 

<<" $HT \n"

 HT.pinfo()

 ele = HT[3][1]
 <<"%V $ele \n"
 
  chkN(ele,89)

  //chkOut(1)


/////////////////////////////////////////////////////////////////////////


 HT[0][7] = 7
 HT[1][1] = 11
 HT[1][2] = 12 

// TBF 02/02/24 indexing corrupts  bounds ND  

 HT.pinfo()

<<"%V $HT \n"
ans=ask(DB_prompt,0)


 HT[1][1] = 10
 HT[1][5] = 15
 HT[1][7] = 17

 ele = HT[1][7]
 chkN(ele,17)

 ele = HT[0][0]
 chkN(ele,0)



 // chkOut(1)
  

val = 21;
  for (k = 1; k <=7; k++) {
   HT[2][k] = val++;
  }


val = 31;
  for (k = 1; k <=7; k++) {
   HT[3][k] = val++;
  }

val = 41;
  for (k = 1; k <=7; k++) {
   HT[4][k] = val++;
  }

val = 51;
  for (k = 1; k <=7; k++) {
   HT[5][k] = val++;
  }

val = 61;
  for (k = 1; k <=7; k++) {
   HT[6][k] = val++;
  }

val = 71;
  for (k = 1; k <=7; k++) {
   HT[7][k] = val++;
  }

val = 81;
  for (k = 1; k <=7; k++) {
   HT[8][k] = val++;
  }


 HT[9][7] = 47;
 HT[9][8] = 79 ;
<<"$HT \n"

chkN( HT[9][7],47)

chkN( HT[9][8],79)

jt = 0;

DT = HT

DT.pinfo()
<<"$DT \n"

HT.pinfo()

  cele=  HT[1][7]

<<"%V$cele \n"
 //allowDB("spe_exp,rdp_store,array_parse,array_transfer,paramexpand,parrayexpand,ds_sivbounds")
 
//CT= HT
//CT.pinfo()


 CT = HT[1:8:][1:7:]    ;  // TBF not selecting 2D vec correctly

 CT.pinfo()

 ans=ask(DB_prompt,0)

//<<"HT $(Caz(HT)) $(Cab(HT)) \n"
//<<"CT $(Caz(CT)) $(Cab(CT)) \n"

<<"$CT \n"


CT.pinfo()

sz=Caz(CT)

<<"%v $sz\n"

chkN (sz,56)



bnds= Cab(CT)

<<"%v $bnds\n"

val = CT[0][0]

chkN (val,10)
j = 21;

for (k=1; k<=7;k++) {
 val = CT[k][0]

 chkR(val,j)
 j += 10;
 <<"%V $k $val\n"
}
 val = CT[2][0]

chkR(val,31)




R= vgen(INT_,10,0,1)
<<"$R\n"

T= R[2:8]

<<"$T\n"
//<<"T $(Caz(T)) $(Cab(T)) \n"  // xic bug TBF 8/29/21

tsz= Caz(T)
tab = Cab(T)

<<"%V $tsz $tab \n"

chkN (R[1],1)
chkN (T[0],2)



<<" %6.3f$HT[jt][5] \n"	
<<" %6.3f$HT[jt][7] \n"	


//<<" %6.3f$HT[jt][1:8:] "	
jt++


<<" %6.3f$HT[jt][5] \n"	
<<" %6.3f$HT[jt][7] \n"	

jt = 0



<<" %6.3f$HT[jt][5] \n"	

<<"CT %6.3f $CT[jt][5] \n"

// [0][7] is out of range should just warn
<<"CT %6.3f$CT[jt][7] \n"	



//<<" %6.3f$HT[jt][1:8:] "

chkOut ()