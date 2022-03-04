///
///
///

Vec V(INT_,12,255,0)


  V.pinfo();

<<"$V \n";

  V2 = {1,2,3,4,5,7};

  V2.pinfo()

<<"$V \n";




  List LV(INT_,23);

  LV.pinfo()


// LIEND LIBEG LIHOT
  LV.insert(LIBEG_,1,2,3,4,5);

  LV.pinfo()

<<"%V$LV \n"


 li = LV.getLitem();

<<"%V$li \n";

 li.pinfo();

 li = LV.getLitem(LIBEG_);

<<"%V$li \n";
li = LV.getLitem(LIEND_);

<<"%V$li \n";

 li = LV.getLitem(3);

<<"%V$li \n";

li = LV.getLitem(-3);

<<"%V$li \n";

li = LV.getLitem(-4);

<<"%V$li \n";

for (i = 0; i < 10; i++) {

li = LV.getLitem(LINXT_);

<<"%V$i $li \n";

}
<<"//////////\n"

li = LV.getLitem(LIBEG_);

<<"LIBEG $li \n";

for (i = 0; i < 10; i++) {

li = LV.getLitem(LIPRV_);

<<"%V$i $li \n";

}

<<"//////////\n"
li = LV.getLitem(LIEND_);

<<"LIEND $li \n";




List LVD(DOUBLE_);

  LVD.insert(LIEND_,10.1,20.2,30.3,40.4,50.5);

dli = LVD.getLitem(LIBEG_);

<<"LIBEG $dli \n";

for (i = 0; i < 5; i++) {

dli = LVD.getLitem(i);

<<"%V$i $dli \n";

}

dli = LVD.getLitem(LIEND_);

<<"LIEND $dli \n";
 LVD.insert(3,66.77);
  LVD.insert(4,74.51);
  LVD.insert(1,27.66);
   LVD.insert(2,18.17);
 
for (i = 0; i < 5; i++) {

dli = LVD.getLitem(i);

<<"%V$i $dli \n";

}

<<"//////////LIPRV////\n"
for (i = 0; i < 5; i++) {

dli = LVD.getLitem(LIPRV_);

<<"%V$i $dli \n";

}

<<"//////////LINXT////\n"
for (i = 0; i < 5; i++) {

dli = LVD.getLitem(LINXT_);

<<"%V$i $dli \n";

}

dli = LVD.getLitem(LIEND_);

<<"LIEND $dli \n";

dli = LVD.getLitem(LIBEG_);

<<"LIBEG $dli \n";

dli = LVD.getLitem(3);

<<"3 (4th item) $dli \n";

dli = LVD.getLitem(LIHOT_);

<<"LIHOT $dli \n";

dli = LVD.getLitem(LIEND_);

<<"LIEND $dli \n";

LVD.insert(3,1002.0)
LVD.insert(LIEND_,5005.0)
LVD.insert(LIBEG_,89.0)
sz= LVD.caz();
for (i = 0; i < sz; i++) {

dli = LVD.getLitem(i);

<<"%V$i $dli \n";

}
LVD.pinfo();

LVD.delete(3)
sz= LVD.caz();
for (i = 0; i < sz; i++) {

dli = LVD.getLitem(i);

<<"%V$i $dli \n";

}
LVD.pinfo();

exit()