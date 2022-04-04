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
///  
///


#define ASL 0
#define CPP 1


#if CPP
Svar WM;


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
cout << "s= " << s << endl;
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

  c = s[3];

 printf("c  %c\n",c);

 c='L';

  s[1] ='a';
 s[2] =c;
 s[5] = '_';
 
printf("c  %c\n",c);
//printf("asl s  %s\n",s);
printf("cpp s  %s\n",s.cptr());
cout << "s= " << s << endl;
//<<"asl s  $s \n";

 WM.Split("just one feature at a time ");
 cout << "WM  " << WM << endl;


int do_sop = 1;

if (do_sop )  {
//Siv S(STRV);
cout << " doing sop !!" << endl;
Str  S= "we will attempt just one feature at a time ";



Str q = "at";
Str t = "im";
Str ans ="y";
cout << " t "  << t.pinfo() << endl;

t.pinfo();


Str abc= "abcdefghijklmnopqrstuvwxyz";

Str xyz= "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

cout << "abc[0]  " << abc[0] << endl;

cout << "abc[1]  " << abc[1] << endl;

cout << "abc[12]  " << abc[12] << endl;

cout << "abc[25]  " << abc[25] << endl;

cout << "abc[26]  " << abc[26] << endl;


Str def = abc;

char cval = 'T';
 COUT(abc)

 COUT(def)

 def(4,-1,2) = cval;

 chkChar(def[4],cval);
 chkChar(def[6],cval);

COUT(def)

ans=query("OK?");

def = abc;
COUT(def)
ans=query("OK?");

chkChar(def[4],'e');
chkChar(def[6],'g');


COUT(def)
def[4] = 'e';
COUT(def)

def(20,4,2) = 'X';
COUT(def)
 chkChar(def[20],'X');
  chkChar(def[4],'X');

ans=query("OK?");



Str an = "xyz";
COUT(an);

cout<<"do the subrange copy 1,13\n";
an = abc(1,13,2);


COUT(an);

abc(1,13,2) = xyz(1,13,2);

cout << " abc = " << abc << endl;

ans=query("OK?");


abc = xyz;

COUT(abc);

ans=query("OK?");

abc(1,13,2) = xyz(13,1,-2);

COUT(abc)

ans=query("OK?");

Vec<int> index;

cout << "S " << S << " q " << q << endl;

cout << "   index = regex(S&q); \n";

   index = regex(S,q);
   
//index.pinfo();

COUT(index);

index = 0;

cout << "index zero? " << index <<endl;

   index = regex(S,t);

cout << "index " << index <<endl;

Svar SV("SV");

 cout  << "SV  "  << SV << endl ;

  SV = "esto se esta complicando";

 cout  << "SV  "  << SV << endl ;

  SV.findWsTokens("esto se esta muy complicando");

cout  << "SV  "  << SV << endl ;

Svar VS;

   VS = "esto se esta muy complicando";

 cout  << "VS  "  << VS << endl ;


  VS.split("esto se esta muy complicando");

 cout  << "VS  "  << VS << endl ;

 cout  << "VS  "  << VS[1] << endl ;
chkOut();
  cout << "DONE str tests \n";
}




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






