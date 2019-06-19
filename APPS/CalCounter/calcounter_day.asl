//%*********************************************** 
//*  @script calcounter_day.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                  
//*  @date Mon Jan  7 17:55:58 2019 
//*  @cdate Fri Jan  4 09:27:43 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
   
   
////      use date to make/get current day's file ///
///       or find it by dd-n  dd-1 == yesterday ///
///       or by  dd_06-18-2019
   
   
  proc getCCday( fname)
   {
     
     the_day = fname;
     
     adjust_day = 0;
     
     nl = slen(fname);
     
//  make up today and check
     
     today = date(2);
     
     jdayn = julian(today); 
     
     yesterday = julmdy(jdayn-1);
     
     dby = julmdy(jdayn-2);
     
     <<"%V  $jdayn $yesterday $today  $dby\n"; 
     <<"<|$fname|> \n"; 
     <<"%V <|$fname|> $nl\n"; 
     
     
     make_day = 0;
     
     if (nl != 0) {
       
       if (scmp(fname,"DD/dd_",6)) {
         adjust_day = 1;
         the_day = fname;
         }
       else {
         if (scmp(fname,"dd-",3)) {
           adjust_day = 1;
     // find the number
           num = atoi(scut(fname,3));
           db4 = julmdy(jdayn-num);
     // compute the day
           ds=ssub(db4,"/","-",0);
           the_day = "DD/dd_${ds}";
           fname = the_day;
           }
         }
       
       A= ofr(fname); 
       if (A == -1) {
         <<"can't find file dd_ day $fname \n";
         adjust_day = 0;
         make_day = 1;
         }
       cf(A); 
       }
     
     if (!adjust_day && !make_day) {
       ds= date(2);
       ds=ssub(ds,"/","-",0);
       the_day = "DD/dd_${ds}";
       }
     
     return the_day;
     }
//==================================================//
   
   
