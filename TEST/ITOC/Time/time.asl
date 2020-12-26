//%*********************************************** 
//*  @script time.asl 
//* 
//*  @comment gets Time local,zulu 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.99 C-He-Es]                                
//*  @date Wed Dec 23 21:58:45 2020 
//*  @cdate 1/1/2003 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
/// time/zulu
///

/*

  zulutime  returns GMT - hh:mm:ss


*/

lt=getTime()
<<"$lt\n"

z= zuluTime()

<<"zulu $z\n"


t= Time()

<<"time %s $t\n"

tv= LocalTime()

<<"local  $tv\n"

dt = time2date(lt)

<<"%V %s $dt\n"