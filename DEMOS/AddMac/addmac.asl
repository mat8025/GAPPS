//%*********************************************** 
//*  @script addmac.asl 
//* 
//*  @comment adding machine 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Wed Oct  2 08:52:24 2019 
//*  @cdate Mon Sep 30 08:58:13 2019 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%
///
///
///

include "debug.asl"
include "gevent.asl"
include "gss.asl";
include "hv.asl"


debugON()


total = 0.0;
cash = 0.0;
i = 1;

////
bill_name = "billA.txt"
 nargs = argc()
 if (nargs >1) {

  bill_name = _clarg[1]
  <<"read in $bill_name\n"

  }

  A=ofr(bill_name)
  ///////////////
  R= readRecord(A,@del,',') ;   // R record created
  cf(A);

  Nrecs = Caz(R);
  Ncols = Caz(R,1);

<<"num of records $Nrecs  num cols $Ncols\n";

   for (i= 0; i < 5; i++) {
       nc = Caz(R,i);
<<"<$i> $nc $R[i] \n";

<<"<$i>  $R[i][0]  $R[i][1]\n";

    }


   for (i= Nrecs-3; i < Nrecs; i++) {
       nc = Caz(R,i);
<<"<$i> $nc $R[i] \n";
    }


  //////////////




  //fname = "billA.txt"

  fname = bill_name ;
  


////

 i = Nrecs;


   rows = Nrecs ;
   cols = Ncols;
   tags_col = 3;

  for (i = 0; i < rows;i++) {
     wrd= eatwhiteEnds(R[i][1]);
     R[i][1] = wrd;
    <<"<${i}> <|$wrd|> $R[i] \n";
   }

///
    R[0][0] = "Item";
    R[0][1] = "Cost";
    R[0][2] = "Date";
<<"$R[0]\n"
///
//exit()
 CheckTotal = 0.0;

N = 40

 for (k= 1; k < rows; k++) {

   cash = atof(R[k][1]);
   cash = Fround(cash,2);
   R[k][1] = "%7.2f$cash";
   CheckTotal += atof(R[k][1]);
    <<"$k  $cash $R[k][1]\n"
 }

 CheckTotal = Fround(CheckTotal,2)

 <<" %V$CheckTotal\n"
  R[rows][0] = "Item"
  R[rows][1] = "0.0"
  



include "graphic.asl"
include "addmac_scrn";
include "addmac_procs";

  sWo(cellwo,@setrowscols,rows+3,cols+1);
  sWo(cellwo,@cellval,R,0,0,rows+1,cols);  
<<"%V$rows \n"



// color rows
    for (i = 0; i< rows+1 ; i++) {
     for (j = 0; j< cols ; j++) {
        if ((i%2)) {
          sWo(cellwo,@cellbhue,i,j,LILAC_);         
	}
	else {
          sWo(cellwo,@cellbhue,i,j,YELLOW_);
	 }
       }
     }



 
  sWo(cellwo,@cellval,R,0,0,rows+3,cols);  
  sWo(cellwo,@selectrowscols,0,rows+1,0,cols);

  sWo(cellwo,@cellval,0,tags_col,"Tags")
  sWi(vp,@redraw);


/{
 while (1) {

  item = iread("$i what?:")
  <<"$item \n"

  if (item @= "done") {
      break;
  }

  R[i][0] = item;
  
  amt = iread(" howmuch\$:")
  <<"$amt \n"

  cash = atof(amt)

  total += cash;
  R[i][1] = "$(Fround(cash,2))";
  <<"$i $R[i][0] $cash $total\n"
   i++;
   
 }

/}

 A=ofw("bill.txt")
 CheckTotal = 0.0;

N = 40

 for (k= 1; k < Nrecs; k++) {
 wrd = R[k][0]
 len = slen(wrd)
if (len < N) {
n= N-len
ws=nsc(n," ")
wrd= scat(wrd,ws)
}
   j= k+1;
//   <<"$j\t <| $R[k][1] |> \n"
   cash = atof(R[k][1]);
   cash = Fround(cash,2);
  <<"$j\t$wrd\t$cash \n"
  <<[A]"$wrd,$cash, \n"
  
 CheckTotal += atof(R[k][1]);
 }

 CheckTotal = Fround(CheckTotal,2)


 <<" %V$CheckTotal\n"

cf(A)

////////////////////////////////////////




 while(1) {

        eventWait();

 <<" $_emsg\n"
 
         mwr = _erow;
	 mwc = _ecol;

     if (_ewoid == cellwo) {



      if (mwr == 0 && (mwc >= 0) && (_ebutton == RIGHT_)) {

         sWo(cellwo,@cellbhue,0,swapcol_a,0,cols,YELLOW_);         	 	 
         swapcol_b = swapcol_a;
 	 swapcol_a = mwc;
         sWo(cellwo,@cellbhue,0,swapcol_a,CYAN_);         	 
<<"%V $swapcol_a $swapcol_b\n"
         }
	 
                      if (_ebutton == LEFT_ && mwr > 0  ) {
                       <<"getCellValue $mwr $mwc\n"
                           getAddMacValue(mwr,mwc);

                      }

     }
     
 if (_eloop > 0) {
      if (_ename @= "PRESS") {

       if (!(_ewoname @= "")) {
              nc=slen(_ewoname);
    //<<"calling script procedure $nc  <|${_ewoname}|> !\n"
            if (nc > 3) {
	      <<"calling script procedure  <$_ewoname> !\n"
              $_ewoname();
	      }
        }
      }
     }
     

  addMacTotal();
  sWo(cellwo,@redraw);
  sWo(totalwo,@redraw);
 }


exit()