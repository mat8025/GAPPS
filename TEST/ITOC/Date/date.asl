//%*********************************************** 
//*  @script date.asl 
//* 
//*  @comment test date function
//*  @release CARBON 
//*  @vers 1.5 B Boron                                                     
//*  @date Mon Mar 18 10:15:14 2019 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

/*

today= date(form)
returns date string string depends on form parameter
form (1-17)
if form = 1 string is as in UNIX date command
form = 2 month:day:year
form = 5 (ISO8601) year-month-day hour:minute:second
form = 17 week day
(see also getday(),gethour(),...)

*/
   
   
///
///
   
   chkIn(); 
   
   td = date(1,'-'); 
   <<"1 $td\n"; 
   
   dsep = '-'; 
   tsep = ':'; 
   
   for (i = 1; i <20 ; i++) {
     td = date(i,dsep,tsep); 
     <<"[${i}] $td  $(date(i))\n"; 
     }
   
   
   str ud;
   
   td = date(1); 
     
   <<"$(typeof(td)) %V$td\n"; 
   
   ud = !!"date"; 
     
   <<"$(typeof(ud)) %V$ud\n"; 
     
   udt = split(ud); 
   udt->info(1)
   
   <<"%V$udt \n"; 
   
   
   <<"$udt[3]\n"; 
   
   sdt = split(td); 
    sdt->info(1)
   <<"%V$sdt \n"; 

  <<"$sdt[3]\n"; 

   sdt3 = sdt[3]

<<"$sdt3\n"
sdt3->info(1)

   chkStr(sdt[3],sdt[3]); 



    for (i=1; i<=17;i++) {

    ds=date(i)
    <<"<$i> $ds\n"

    }


   chkOut(); 
   
//======================================//