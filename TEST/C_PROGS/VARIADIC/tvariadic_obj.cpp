


// C++ program to demonstrate working of
// Variadic function Template
#include <iostream>
using namespace std;
 
// To handle base case of below recursive
// Variadic function Template



int Tleg_id = 0;

class Tleg 
 {

 public:

   int id;
  int tpA;
  int tpB;
  
  float dist;
  float pc;
  float fga;
  float msl;

   //  methods

   void show() {

     cout << "dist " << dist << " id " << endl;

   }

 friend ostream& operator << ( ostream&, const Tleg& ) ;
   
Tleg()
 {
 //<<"Starting cons \n"
  dist = 0.0;
  pc = 0.0;
  fga =0;
  msl = 0.0;
  Tleg_id++;
  id = Tleg_id;
  cout << "cons tleg id " << id << endl;
 }
   ~Tleg() { cout << "destruct tleg " << id << endl; };
};  




ostream& operator << ( ostream &strm, const  Tleg&x )
{

  strm << x.dist ;
    return strm ;
}
//[EF]==========================================//


void print()
{
  cout << "empty function last \n ";

}
 
// Variadic function Template that takes
// variable number of arguments and prints
// all of them.
template <typename T, typename... Types>
void print(T var1, Types... var2)
{
    cout << var1 << endl;
 
    print(var2...);
}
 
template <typename ...Args>
int myfunc(Args & ... args)
{
  cout << "here ref\n";
  cout << "here " << Args[0] << endl;
  return 1;
}



// Driver code
int main()
{
  float f = 66.79;

  Tleg R;
  Tleg W;

  R.dist = 7.0;
  R.show();
  W.dist = 14.0;
  
  print(1, 2, 3.14,f,R,
	"I will print my args\n"); //doing a copy const?


  print(1,R,&W,
          "I will print my args\n");

  
   myfunc(R,W);
  

   return 0;
}
