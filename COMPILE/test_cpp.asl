/* 
 *  @script test_cpp.asl  
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
void
Uac::helloWorld()
{

   cout << "hello simple Siv/Str/Svar test  " << endl;

  Siv M(INT_);

  M=14;

 cout << "Siv M " << M << endl;

 Svar W;

   W= "just one feature at a time ";


 Str s;

   s = "try";
   
cout << " str s = "  << s << endl;

cout << " str s = "  << s << endl;

Svar T;

    T.findWords("just one feature at a time ",0);


Str t;

    int uac_id=getUacID();

cout << " my uac_id  = "  << uac_id << endl;

    t= T[2];

Str q;

  q = T[1];

  cout << " str t = "  << t << endl;


Siv S(STRV);

     S = "hey now";

cout << "Siv S " << S << endl;


    S= strmcat( t,q);

cout << "Siv S " << S << endl;




  cout << "Exit cpp HelloWorld " << endl;

}
  
 
 

//==============================//



 extern "C" int test_cpp(Svarg * sarg)  {

    Uac *o_uac = new Uac;

    o_uac->helloWorld();

  }



//================================//






