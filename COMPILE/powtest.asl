
///
///
///

#define ASL 0
#define CPP 1

#if CPP
 extern "C" int powtest(Svarg * s)  {
#endif

int n = 1;

#if CPP
 n = s->getArgI() ;
 cout << " para is " <<  n  << endl;
//<<" and have we coded  #if CPP #endif pair?\n";
#endif

#if ASL
n = getArgI();
<<" para is $n\n";
<<" and have we coded  #if ASL #endif pair?\n";
#endif



int pb = 2;

long pexp ;

long pexp2 = pow(2,n);

//long pexp3 = (base^^n);

long pexp3;



double scdeg = 180.0/ pexp2;


long vl;

vl = pow(2,8) ;


#if CPP
cout << " pexp " << pexp << " scdeg "  << scdeg  << endl; 
#endif

int k;
int i;

for (k= 0; k < 10  ; k++) {
  for (i= 1; i< 10; i++) {

   pexp = pow(2,i) ;

   pexp2 = pow(i,2);
   
//<<"$k $i %V $pexp $pexp2   \n"
#if CPP
cout << "k " << k <<  " pexp " << pexp << " pexp2 " << pexp2 <<  endl;
#endif

#if ASL

<<"%V $k $pexp $pexp2 \n"

#endif

  }

}

Siv a(DOUBLE_,4.0);
Siv b(DOUBLE_,5.0);
Siv c(DOUBLE_,0.0);

a.pinfo();

b.pinfo();

c.pinfo();

    c = a * b;
    
#if ASL
<<" %V $c = $a * $b \n";
#endif
    
#if CPP
 cout << " c = " << c << endl;
 //c = a |^ b;
 // cout << " c = " << c << endl;
}
#endif
