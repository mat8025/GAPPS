/* 
 *  @script act.asl 
 * 
 *  @comment class Act 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.18 : C Ar]                                   
 *  @date 05/30/2024 10:36:26 
 *  @cdate 05/30/2024 10:36:26 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2024
 * 
 */ 
//-----------------<V_&_V>------------------------//

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

             <<"Act_Set INT  $_cobj $id k $k\n";
      
             otype = k;

             //otype.pinfo();
            ask("%V$otype  $k\n",1);
            

             return otype;

        }

        int SetO(int k)
        {

             <<"Act_Set INT  $_cobj k $k\n";

             <<"%V$otype\n";

             otype = k;
     //otype.info(1);

             //otype.pinfo();

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

           //  sr.pinfo();

         //    stype.pinfo();

             ask("Set_Str sr  <|$sr|> stype <|$stype|>\n",0);

             return stype;

        }

        int Get()
        {

             <<"$_proc %V $otype\n";

           //  otype.pinfo();

             return otype;

        }

        void Print()
	{

        <<"Act  %V  $id $Act_ocnt  $a_day $mins $otype $stype\n";


        }
	
        int GetWD()
        {

             <<"$_proc  GetWD\n";

             a_day.pinfo();

             <<"getting  $a_day\n";

             return a_day;

        }

      int GetID()
        {

             <<"$_proc  GetID $id\n";


             return id;

        }

        void Act()
        {
// FIXME   <<"cons of Act $_cobj $(_cobj.obid())  $(IDof(&_cobj))\n" 
//   co = _cobj.offset()
//allowDB("spe,oo")

             id= Act_ocnt++ ;

             <<"%V $id\n";

//             stype = "$id xyz";
	     
         //    id.pinfo();

             otype = 1;

             mins = id * 10;

             t = id*2;

          //   t.pinfo();
//ans=ask("Act $t set ?",1)

             a_day = Act_ocnt;

         //    a_day.pinfo();
//<<"Act CONS ID is $id \n"

             <<"Act CONS of %V $_cobj $id $Act_ocnt  $a_day $mins $otype $stype \n";

        }

   }
//==============\_(^-^)_/==================//
