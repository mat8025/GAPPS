/* 
 *  @script test_str.asl  
 * 
 *  @comment test cpp compile include and sfunc 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.73 C-Li-Ta]                                
 *  @date 01/16/2022 10:43:41 
 *  @cdate 01/16/2022 10:43:41 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//-----------------<v_&_v>------------------------//

///
///  cinclude  ---  chain of include asl - cpp compile OK?
///

#define ASL 0
#define CPP 1


#if CPP
void
Uac::strWorld(Svarg * sarg)  
{
   cout << "hello simple  test of Str class  " << endl;
#endif
float f= 88.0;
int i= 4;
printf("float f = %f\n",f);
char c;
char cv[32] = "hi char str";

 Str s = "hello Str";

#if ASL
<<"%V $s %s $cv\n";
#endif

// cpp version of asl printf 

printf("cv[%d]  = %c \n",i,cv[i]);

printf("cv %s\n",cv);
//printf("s  %s\n",s.cptr());

//printf("s  %s\n",s);

  c = s[2];

 printf("c  %c\n",c);

 c='L';

 s[2] =c;
 s[5] = '_';
 
printf("c  %c\n",c);
//printf("asl s  %s\n",s);
printf("cpp s  %s\n",s.cptr());

//<<"asl s  $s \n";

#if CPP
printf("str s = %s\n",s.cptr());
}
//==============================//

 extern "C" int test_str(Svarg * sarg)  {

    Uac *o_uac = new Uac;

   // can use sargs to selec uac->method via name
   // so just have to edit in new mathod to uac class definition
   // and recompile uac -- one line change !
   // plus include this script into 


    o_uac->strWorld(sarg);

  }
#endif  


//================================//






