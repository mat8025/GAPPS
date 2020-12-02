#include <iostream>
#include <ostream>
#include <fstream>
#include <limits.h>
#include <string.h>
#include <iomanip>
#include <stdio.h>
#include <stdlib.h>

using namespace std;

/// Test Program -- for Array operators
///
///  want to be able to declare int,float,... Arrays
///  vectors - then MDimn
///  set all elements on vector to val     Array = -1;
///  scalar ops on elements    Array *= val , Array /= , +=. -= 
///  
///   Array  = Array1 * Array2   ; // dimn, range the same
///   *, +, - , /

enum datatype {

  NOT_KNOWN_DTYPE = -3,
  UNKNOWN_TYPE	  = -2,  // max siv.h type is char - use -1 as UNSET
  UNSET  = -1,
  NOTANUM  =  0,        
  CHAR   ,
  SHORT  ,
  INT    ,
  FLOAT  ,
  DOUBLE ,
  UCHAR  ,
  SVAR   ,         // array of varchars 
  PAN    ,          // arbitary precision number - default base 256 
  HEX    ,
  UINT    ,
  USHORT  ,
  PTR     ,   // points to an asl variable - index into array */
  LONG    ,
  ULONG,
  CMPLX,
  BOOLEAN,
};

char Floatsz = sizeof (float);
char Cmplxsz = 2 * sizeof (float);
char Dcmplxsz = 2 * sizeof (double);
char Intsz = sizeof (int);
char Doublesz = sizeof (double);
char Shortsz = sizeof (short);
char Charsz = sizeof (char);
char Longsz = sizeof (long);
char LongDoublesz = sizeof (long double);
char S64sz = sizeof (long long);


int
sizeof_type (int type)
{
  switch (type)
    {
    case DOUBLE:
      return Doublesz;
    case FLOAT:
      return Floatsz;
    case CMPLX:
      return (2 * Floatsz);
    case INT:
    case UINT:
      return Intsz;
    case SHORT:
    case USHORT:
      return Shortsz;
    case CHAR:
    case UCHAR:
      return Charsz;
    case LONG:
    case ULONG:
      return sizeof (long long);
    case BOOLEAN:
      return Charsz;		// minimum --- 8 bools
    default:
      return 0;
    }
}
//[EF]===========================================//

long long range(int beg, int end, int setp)
{
  /// partition long long into 4 shorts
  ///  [neg sign mult incr][beg][end][step]
  ///  array operator =
  ///  will recover beg,end,step values - use mult,incr to cover
  ///  larger then ushort value
  long long rindex = beg;

  return beg;
}


class Array
{
    private:
        void *ptr ;          // pointer to allocated space
        uint size ;  // number of elements allocated
        int type;
    public :
        // constructors
  // Array() ;                       // zero argument constructor
  // Array ( char * ) ;              // one argument constructor
        Array ( int, int ) ;  // two argument constructor
        Array ( const Array& ) ;       // copy constructor

        ~Array() ;  // destructor

        // assignment operator function

  int &operator [] ( int i);
  // int operator [] ( uint i);
    int &operator [] ( long long l);
  // int &operator [] ( uint st) int &operator[] (uint k);
  //int &operator [][] ( uint i, uint k);


  
        //Array& operator = ( int pos, int val ) ;
        // scalar ops on all elements in Array
        Array& operator = ( int val );
  
        // conversion function
        operator const void * ( ) ;

  // overload function

       Array operator() (int beg,int end ,int step);
  
        // concatenation methods
        friend Array operator + ( Array&, Array& ) ;
        void operator += ( const Array& ) ;

  //friend Array operator + ( const Array&, char ) ;
  //      void operator += ( char ) ;

        // access operator
  //   int operator [] ( int ) ;

        // function to output the Array object
      friend ostream& operator << ( ostream&, Array& ) ;
  
  //      friend istream& operator >> ( istream&, Array& ) ;

        // comparison functions
  //  int operator == ( const Array& ) const ;
  //int operator != ( const Array& ) const ;

        // value return functions
    
        unsigned int sizeofArray() const ;


} ;

int main()
{
  int val,val2;
  Array a1 (INT,10 ) ;  //  int array size 10

  //    cout << endl << "s1 = " << s1 ;  // invokes << friend operator function
  //  cout << endl << "Size of s1 = " << s1.sizeofArray() ;

  cout << endl <<  sizeof ( long long) << "  " <<  sizeof(int)  << "  " << sizeof (long double) << endl;
  
    Array a2 (INT,10 ) ;  //  int array size 10


    a2 = a1 ;  // invokes overloaded assignment operator
    /*
    if ( s1 == s2 )  // invokes overloded == operator
        cout << endl << "s1 is same as s2" ;
    else
        cout << endl << "s1 is different than s2" ;
    */

    a2 = -80;
    
    val = a2[3];
    val2 = a2[7];
    cout << endl << val << " " << val2 << endl;
    
       cout << endl << a2[3] << endl;
       cout << endl << a2[4] << endl;    
    
    a2[3] = 77;
    a2[7] = 67;
    a2[(2+2)] = 42;
    a2[range(8,9,1)] = 76;
    cout << endl << a2[3] << " " << a2[7] << endl;    
    //    cout << endl << "s1 = " << s1 ;

    Array a3 = a2 ;  // invokes copy constructor
    //    cout << endl << "s3 = " << s3 ;
    cout << endl << a2 << endl ;

        cout << endl << a3 << endl ;
    Array a4 ( a3 ) ;  // invokes copy constructor
    cout << endl << a4 << endl ;


    //cout << endl << "s4 = " << s4 << endl ;
    /*
    Array s5 ;
    cin >> s5 ;  // invokes >> friend operator function
    cout << "s5 = " << s5 ;
    */
    
    Array a7 = a4 + a2 ;
    //cout << endl << "s7 = " << s7 ;

    //cout << endl << "Length of a7 = " << a7.length() ;
    // cout << endl << "Size of a8 = " << a7.sizeofArray() ;
    //    a7[2][3] = 52; // class array would have to int vec[][] 
    cout << endl << a7 << endl ;

    Array a8 = a2(0,5,1);
    
   cout << endl << a8 << endl ;
    
#if 0
    if ( a7 == a4 )
        cout << endl << "a7 is equal to a4" ;
    else
        cout << endl << "a7 is not equal to a4" ;
#endif
}



// constructor
Array::Array ( int wtype, int ne )
{
    size = ne ;
    type = wtype;
    int nb= sizeof_type (type);
    ptr = calloc (ne, sizeof_type (type));
    
    memset ( ptr, 0, ne * nb) ;

}

Array::Array ( const Array& x )   // copy constructor
{
  ///
  /// types have to be the same
  /// or cast/promote 
    size = x.size ;
    int nb= sizeof_type (x.type);
    type = x.type;
    ptr = calloc (size, sizeof_type (type));
    memcpy ( ptr, x.ptr, (size * nb  )) ;
}

// destructor
Array::~Array()
{
  if (ptr != NULL)
    free (ptr);
}

//  set elements to value
Array& Array::operator = ( int val )
{
    {
      int *ip = (int *) ptr;
      for (int i= 0; i < size; i++)
	ip[i] = val;
      
    }
    return ( *this ) ;
}
//=====================


/*
// overloaded assignment operator
Array& Array::operator = ( const Array& x )
{
    if ( this != &x )
    {
        size = x.size ;
         if (ptr != NULL)
	   free (ptr);
	 type = x.type;
    int nb= sizeof_type (type);
    ptr = calloc (size, sizeof_type (type));
    memcpy ( ptr, x.ptr, (size * nb  )) ;
    }
    return ( *this ) ;
}
//===================

*/


// conversion function
Array::operator const void * ( )
{
    return ptr;
}

// overloaded addition operator
Array operator + ( Array& x, Array& y )
{
    Array temp ( x.type, x.size ) ;
    int val;
    for (int i= 0; i <x.size; i++) {
      //temp[i] = x[i] + y[i];
      val = x[i];
    }
    
    return temp ;

    
}

#if 0
// overloaded Array addition operator +=
void Array::operator += ( const Array& x )
{
    unsigned int totallen, totalsize ;
    char *t ;

    totalsize = size + x.size ;
    totallen = len + x.len ;
    t = new char [ totalsize ] ;
    strcpy ( t, ptr) ;
    strcat ( t, x.ptr ) ;
    delete ptr ;
    ptr = t ;
    len = totallen ;
    size = totalsize ;
}

// overloaded Array addition operator
Array operator + ( const Array& x, char ch )
{
    unsigned int totallen ;
    char *t ;

    totallen = x.len + 2 ;
    t = new char [ totallen ] ;
    strcpy ( t, x.ptr) ;
    t[x.len] = ch ;
    t[x.len + 1] = '\0' ;
    Array temp ( t ) ;
    delete t ;
    return temp ;
}

// overloaded Array addition operator +=
void Array::operator += ( char ch )
{
    unsigned int totallen ;
    char *t ;

    totallen = len + 1 ;
    if ( totallen > size )
    {
        size += chunk_size ;
        t = new char [ size ] ;
        strcpy ( t, ptr) ;
        delete ptr ;
        ptr = t ;
    }
    ptr[len]= ch ;
    ptr[len + 1 ] = '\0' ;
    len = totallen ;
}

// overloaded Array comparison operator
int Array::operator == ( const Array& x ) const
{
    int a ;
    a = strcmp ( ptr, x.ptr ) ;
    return ( !a ) ;
}




// friend function to input objects of Array class
istream& operator >> ( istream &strm, Array &x )
{
    char *buffer ;
    buffer = new char[256] ;

    if ( strm.get( buffer, 255 ) )
        x = Array ( buffer ) ;

    return strm ;
}
#endif

uint Array::sizeofArray() const
{
    return size ;
}
#if 0
// N.B. had to use uint else could not overload lhs[] assign and rhs [] access
int Array::operator [] ( uint pos )
{
  int val =0;
    if ( pos >= size )
        return 0 ;
    else {
      int *ip = (int *) ptr;
	val = ip[pos];
      return val ;
    }
}
#endif

int &Array::operator [] (int i)
  {
    //error check
        int *ip = (int *) ptr;
        return ip[i] ;
  }
//==============================
int &Array::operator [] (long long  l)
  {
    //error check
    int i = (int) l;
        int *ip = (int *) ptr;
        return ip[i] ;
  }
//==============================
Array Array::operator () ( int b, int e, int s )
   {
     int ne = (e-b);
     Array temp ( type, ne ) ;
     int *top = (int *) temp.ptr;
     int *from = (int *) ptr;     
     for (int i=0;i< ne; i++) {
       top[i] = from[b+i];
     }
     
     return temp;
   }
//======
/*
// want something like this vec = vec2[(int a,int b,int c)]
//  asl uses vec= vec[beg:end:step]
Array Array::operator = (const Array& x, int b, int e, int s )
   {
     int ne = (e-b);
     Array temp ( x.type, ne ) ;
     int *top = (int *) temp.ptr;
     int *from = (int *) x.ptr;     
     for (int i=0;i< ne; i++) {
        top[i] = from[b+i]
     }
     
     return temp;
   }
//==============================
*/
/*
int &Array::operator [][] (uint i, uint k)
  {
    //error check
        int *ip = (int *) ptr;
        return ip[i+k] ;
  }
*/

// friend function to output objects of Array class
ostream& operator << ( ostream &strm, Array &x )
{
    int *ip = (int *) x.ptr;
    for (int i= 0; i < x.size; i++)
      strm << ip[i] << " " ;
    return strm ;
}

/*
int& Array::operator [] ( int pos )
{
      int *ip = (int *) ptr;

      return ip[pos] ;
}
*/
/////////////////////////////////////////////
/*
 1    declare array type size

 2    print out array values

 3    assign value to all elements

 4    scalar ops on all elements

 5    vector ops  e.g. vec3 = vec1 + vec2

 6    range ops    H[1:5] = 6
 */
/*
template <typename T, unsigned int L>
class VerySimpleArray{
T a[L];
public:
VerySimpleArray(){
for(int i=0; i < L; ++i) a[i] = T();
}
T& Get(unsigned int i){return a[i];}
void Set(unsigned int i, T& v){a[i] = v;}
};
VerySimpleArray<float, 42> vsa;
*/
