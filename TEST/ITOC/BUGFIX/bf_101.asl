///
///
///
/{/*
#num 102 10/07/17 5.91 4 PENDING
descr:
  tpi =10+t ;  !=  tpi = t + 10;
  XIC ? order ?
fix: 
 
tbd: 
//==========================
/}*/

chkIn();

proc fooey()
{
int p = 47;

  pa = 10+p ;

  pb = p + 10;

chkN(pa,pb);

}

int t = 47;

  tpa = 10+t ;

  tpb = t + 10;

chkN(tpa,tpb);

fooey()

chkOut();
