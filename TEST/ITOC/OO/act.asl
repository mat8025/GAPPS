///
///
///


  int Act_ocnt = 0;

  class Act {

  public:

  int otype;

  int mins;

  int t;

  int id;

  Svar svtype;

  Str stype;

  int a_day;
 //===================//

  int Set(int k)
  {

  <<"Act_Set INT  $_cobj k $k\n";

  <<"%V$otype\n";
  otype = k;

  otype.pinfo();

  return otype;

  }


  int SetO(int k)
  {

  <<"Act_Set INT  $_cobj k $k\n";

  <<"%V$otype\n";
  otype = k;
     //otype.info(1);

  otype.pinfo();

  return otype;

  }


  Svar Set(Svar sa)
  {

  <<"Act Set SVAR $_cobj \n";
  //allowDB("svar,spe,array,pexpnd,oo");
  
  sa.pinfo();
 ans= ask("svar??",db_ask);

svtype = sa;

  <<"$sa[1] : $sa[2]\n";

  ans= ask("svar??",db_ask);

  val = sa[1];

  <<"%V $val\n";
      //val1 = SV[1]

  cval1 = SV[1];

  <<"%V $cval1\n";

  <<"stype  $sa $svtype\n";

  return svtype;

  }

  Str Set(Str sr)
  {

  <<"Act Set  STR $_cobj <|$sr|> \n";

  stype = sr; // fail?;

  sr.pinfo();

  stype.pinfo();

  <<"sr  <|$sr|> stype <|$stype|>\n";

  return stype;

  }

  int Get()
  {

  <<"$_procGet %V $otype\n";

 // otype.pinfo();

  return otype;

  }

  int GetWD()
  {

  <<"$_proc  GetWD\n";

  a_day.pinfo();

  <<"getting  $a_day\n";

  return a_day;

  }

  void Act()
  {
// FIXME   <<"cons of Act $_cobj $(_cobj.obid())  $(IDof(&_cobj))\n" 
//   co = _cobj.offset()
//allowDB("spe,oo")
  id= Act_ocnt++ ;

<<"%V $id\n"

  id.pinfo()

  otype = 1;

  mins = 10;

  t = id*2;
  t.pinfo()
//ans=ask("Act $t set ?",1)

  a_day = Act_ocnt;

  a_day.pinfo();   

//<<"Act CONS ID is $id \n"

<<"Act CONS of %V $_cobj $id $Act_ocnt  $a_day $mins $otype\n"

  }

  }


//================================//
