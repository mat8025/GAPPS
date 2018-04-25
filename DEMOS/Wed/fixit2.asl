///
///
////////////   SPREAD SHEET  FOR adding daily EX /////////////



// open a tsv/rec file
// read contents and set up a spreadsheet

//  TBD  -- set up current page to this week
//  simple plot for selected col

/
setdebug(1,@keep,@trace,@filter,0);
repeat = 0;
/////////////////////////
proc zoo(m)
{
static int znt = 0;
znt++;
<<"IN $_proc $znt $m\n"


if (znt > 10) {
  <<" repeat call $znt \n"
  exit();
}
  k = m+ znt;
  return k;
}
//=======================//



proc boo(m)
{
static int znt = 0;
znt++;
<<"IN $_proc $znt $m\n"


if (znt > 10) {
  <<" repeat call $znt \n"
  exit();
}

<<"OUT $_proc \n"
  k = m+ znt;
  return k;
}
//=============================

repeat++;
<<"%V $repeat\n"

k = 0;
sz = -1
rows = 1
cols = -1;
Ncols = -1;

pfname = "boo";
<<"TRY indirect call of $pfname !\n"

    $pfname(k);

<<"DONE indirect call of $pfname !\n"
<<"3 %V num of records $sz  $rows $cols  $Ncols\n"



exit()


/{
  fname = _clarg[1];


  if (fname @= "")  {
   fname = "wex.tsv";
  }


<<"%V $fname \n"
A= -1;

A= ofr(fname)
 if (A == -1) {
 <<"can't find file $fname \n";
    exit(-1);
 }

record R[10+];
/}


int rows = 5;
int sz = 0;

do_record = 1;

//Record DF[10];
//today = date(2);
//DF[0] = Split("$today,0,10,0,0,0,0,0,0,0",",");

//<<"$DF[0]\n"


  // R= readRecord(A,@del,',')

   Use_csv_fmt = 0;
   Delc = -1; // WS
//    R= readRecord(A,@del,Delc)
 //   cf(A);



/{
    sz = Caz(R);
    rows = sz;
    cols = Caz(R[0]);
    Ncols = Caz(R[0]);
/}

<<"1 %V num of records $sz  $rows $cols  $Ncols\n"

//////////////////////////////////

int cv = 0;
k = 0;

<<"2 %V num of records $sz  $rows $cols  $Ncols\n"
pfname = "BOO";
<<"TRY indirect call of $pfname !\n"

    $pfname(k);

<<"DONE indirect call of $pfname !\n"
<<"3 %V num of records $sz  $rows $cols  $Ncols\n"

exit()
   