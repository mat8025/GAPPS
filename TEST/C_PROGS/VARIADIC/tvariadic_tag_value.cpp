


// C++ program to demonstrate working of
// Variadic function Template
#include <iostream>
using namespace std;
 
// To handle base case of below recursive
// Variadic function Template


enum gltag {

  _GLID=9000,
  _GLHUE,
  _GLDRAW,
  _GLWOID,
  _GLTYPE,
  _GLTYPE_XY,
  _GLTXY,
  _GLTXYP,    
  _GLCURSOR,
  _GLSCALES,
  _GLXSCALES,
  _GLYSCALES,
  _GLRHTSCALES,
  _GLSYMBOL,
  _GLSYMSIZE,
  _GLSYMANG,
  _GLSYMFILL,
  _GLSYMHUE,
  _GLUSESCALES,
  _GLNAME,
  _GLXVEC,
  _GLYVEC,
  _GLZVEC,
  _GLXYVEC,
  _GLMISSING,
  _GLTYPE_Y,
  _GLTYPE_HIST,
  _GLPOINTS,
  _GLLINE,
  _GLSYMLINE,  
  _GLSOLID,
  _GLNOPLOT,      
  _GLTYPE_XYP,
  _GLAUTOSCALE,
  _GLTY,  
  _GLEO,  
  _GLNTAGS,  // keep this at end - used as counter

};


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


  strm << x.dist << " id " << x.id << "  ";

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
template <typename T,  typename... Types>
void print(T var1,  Types... var2)
{
    cout << var1 << endl;
 
    print(var2...);
}

void setGLhue(int hue )
{
  int ghue = hue;

}

int Cglid = 0;
void setGlid(int wtag, int value )
{

  if (wtag == _GLID) {
    Cglid =  value;
    cout << "gl_id " << Cglid << "\n";
    }
  
  else if (wtag == _GLHUE) {
      setGLhue( value);
     cout << "GLhue  " << value << "\n";
  }

}

void setGlid(int wtag, const Tleg& value )
{
  cout <<"Tleg ?? set vector\n";

}

template <int tag , typename T>
void TsetGlid(int tag2, const T& value)
{

  if (tag2 == _GLID) {
    setGlid(tag2,value);
  }
  else if (tag2 == _GLHUE) {
    setGLhue(value);
  }

  
    
}



// no args - final wrap up
void showargs()
{
    cout << " !! END sGl\n ";

}

// 1 pair

template <typename T, typename T2>
void showargs(const T& tag, const T2& value)
{
    int wtag = (int) tag;
  
 if (wtag > _GLID) {
    printf("Wtag %d\n",wtag);

      setGlid(wtag, value);
  }
 else if (wtag == _GLID) {
   //if (typeid(value) == typeid(int)) 
            setGlid(wtag, value );
 }
  
  
  cout << " Tag " << tag << " Value: " << value  << " END sGl tag_values\n ";
  Cglid = 0; 
}


// main function recurses until 1 pair then no args
template < typename T, typename T2 , typename... Args>
void showargs (const T& tag, const T2& value, const Args&... args)
{
  int w_glid = 0;
  cout <<" tag  " << tag << " value: " << value << " , ";
  int wtag = (int) tag;
  w_glid = Cglid;
  if (wtag > _GLID) {
    printf("wtag %d w_glid %d Cglid %d\n",wtag, w_glid, Cglid);
    setGlid(wtag, value);
  }
 else if (wtag == _GLID) {
     setGlid(wtag, value );
     cout << " value "  << Cglid << " Cglid set \n";
   
 }
  
  
  showargs ( args...) ;
}


// develop  to pull out pairs  tag,value
// restriction - have to be pairs (or check for tag - tag_args left
// redo glines cpp version so  supplied vectors are references (not ptrs, or values)

//sGl(int gl, tag, value, tag2, value2, ...) ?

//sGl(_GLID, glid, tag, value, tag2, value2, ...) ?

//sGl(_GLVID, glid[], tag, value, tag2, value2, ...) ?



// Driver code
int main()
{
  float f = 66.79;
  Tleg R;
  Tleg W;

  int k = 7;
  short s = 14;

  long lng = 1234567;

  R.dist = 67.0;
  R.show();
  W.dist = 14.0;
  
  // print(1, 2, 3.14,f,s,lng,R,W, 	"I will print my args\n"); //doing a copy const?


  //print(1,R,&W,           "I will print my args\n");
  
  showargs(_GLID, 3, _GLHUE,f,_GLWOID, k,_GLTYPE, s,_GLTYPE_XY,lng,_GLXVEC,R,_GLYVEC,W);
   return 0;
}
