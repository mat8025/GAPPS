/* 
 *  @script wex_types.asl 
 * 
 *  @comment wex_types.asl 
 *  @release CARBON 
 *  @vers 1.2 He 6.3.97 C-Li-Bk 
 *  @date 03/17/2022 21:59:43          
 *  @cdate   Sat Dec 29 08:54:39 2018 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;

///
///  current fields kept in data file
///


  Str swex = "hey?";
  swex = " really";
  
  Svar Wexcats;

  Wexcats.Split("Date   Weight  Walk    Hike    Run     Bike    Swim      Yard    Gym     Bpress",-1);


//<<[_DB]"$Wexcats[::] \n"


