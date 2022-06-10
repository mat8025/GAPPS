


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


  strm << x.dist << " id " << x.id << " ";

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

 

// no args
void showargs()
{
    cout << " \n ";

}

// 1 arg

template <typename T>
void showargs(const T& value)
{
  cout << value << " \n ";

}

// main function recurses until 1,0 arg
template <typename T, typename... Args>
void showargs (const T& value, const Args&... args)
{
  cout << " " << value << ", ";
  showargs (args...) ;
}


// develop  to pull out pairs  tag,value
// restriction - have to be pairs (or check for tag - tag_args left
//  redo glines cpp version so  supplied vectors are references (not ptrs, or values)





// Driver code
int main()
{
  float f = 66.79;
  Tleg R;
  Tleg W;

  int k = 7;

  R.dist = 67.0;
  R.show();
  W.dist = 14.0;
  
  print(1, 2, 3.14,f,R,
	"I will print my args\n"); //doing a copy const?


  print(1,R,&W,
          "I will print my args\n");
  showargs(f,k,R,W);
   return 0;
}
