///
///  auto_dec_via_func
/// 




  ignoreErrors()



 S= functions() ;
 

 S.sort();

 <<"%(1, , ,\n)$S[0:10]\n"

// S.pinfo()
/*
 F= search(S," atan (");
 <<"%(1, , ,\n)$F\n"


 F= search(S," sin (");
 <<"%(1, , ,\n)$F\n"


 F= search(S," search (");
 <<"%(1, , ,\n)$F\n"

 F= search(S," functions (");
 <<"%(1, , ,\n)$F\n"
*/
///////////////////////////////////////



 x= 1.5;

 y = atan(x)

 p = sin(4* x);



<<"%V $x $p $y \n"


 //  navi exp


 lata = dmstodd("40,09,75,N")

 latb = dmstodd("40,09,75S")

 latc = dmstodd("35,39,10")

<<"%V $lata $latb $latc\n"

 lnga = dmstodd("139,50,22")

 lngb = dmstodd("105,16,13.9")

lngc = dmstodd("0,7,5.13")
 

<<"%V $lnga $lngb $lngc\n"

 sydlat = dmstodd("33,51,54.5 S")

 sydlng = dmstodd("151,12,35.6 E")


<<"SYDNEY $sydlat $sydlng \n"
 bldlat = dmstodd("40,02,53.9 N")

 bldlng = dmstodd("105,16,13.9 W")


<<"BOULDER $bldlat $bldlng \n"


 toklat = dmstodd("35,39,10 N")

 //toklng = dmstodd("139,50,22 E")

toklng = dmstodd("139,50,22 E")


<<"TOKYO $toklat $toklng \n"

 lndlat = dmstodd("51,30,35.5 N")

 //toklng = dmstodd("139,50,22 E")

 lndlng = dmstodd("0,07,5.13 W")


<<"LONDON $lndlat $lndlng \n"


ldn_tok =  howfar(lndlng,lndlat,toklng,toklat)

<<"LND to TOK $ldn_tok km\n"


///////////////////////////    END OF SCRIPT ///////////////////////////////