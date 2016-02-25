#include <iostream>
#include <ostream>
#include <fstream>
#include <limits.h>
//#include <string.h>
#include <iomanip>
#include <stdio.h>
#include <stdlib.h>

using namespace std;

const int chunk_size = 8 ;  // allocation unit for strings



class string
{
    private:
        char *ptr ;          // pointer to allocated space
        unsigned int len ;   // current length of string
        unsigned int size ;  // number of bytes allocated

    public :
        // constructors
        string() ;                       // zero argument constructor
        string ( char * ) ;              // one argument constructor
        string ( char, unsigned int ) ;  // two argument constructor
        string ( const string& ) ;       // copy constructor

        ~string() ;  // destructor

        // assignment operator function
        string& operator = ( const string& ) ;

        // conversion function
        operator const char * ( ) ;

        // concatenation methods
        friend string operator + ( const string&, const string& ) ;
        void operator += ( const string& ) ;
        friend string operator + ( const string&, char ) ;
        void operator += ( char ) ;

        // access operator
        char operator [] ( int ) ;

        // function to output the string object
        friend ostream& operator << ( ostream&, string& ) ;
        friend istream& operator >> ( istream&, string& ) ;

        // comparison functions
        int operator == ( const string& ) const ;
        int operator != ( const string& ) const ;

        // value return functions
        unsigned int length() const ;
        unsigned int sizeofstring() const ;

        // case conversion functions
        void tolower() ;
        void toupper() ;
} ;

int main()
{

    string s1 ( "This is just a test" ) ;  // invokes one-argument constructor

    cout << endl << "s1 = " << s1 ;  // invokes << friend operator function

    cout << endl << "Length of s1 = " << s1.length() ;
    cout << endl << "Size of s1 = " << s1.sizeofstring() ;

    string s2 ;  // invokes zero-argument constructor

    cout << endl << "Length of s2 = " << s2.length() ;
    cout << endl << "Size of s2 = " << s2.sizeofstring() ;

    s2 = s1 ;  // invokes overloaded assignment operator
    if ( s1 == s2 )  // invokes overloded == operator
        cout << endl << "s1 is same as s2" ;
    else
        cout << endl << "s1 is different than s2" ;

    s1.toupper() ;
    cout << endl << "s1 = " << s1 ;

    s1.tolower() ;
    cout << endl << "s1 = " << s1 ;

    string s3 = s1 ;  // invokes copy constructor
    cout << endl << "s3 = " << s3 ;

    string s4 ( s1 ) ;  // invokes copy constructor
    cout << endl << "s4 = " << s4 << endl ;

    string s5 ;
    cin >> s5 ;  // invokes >> friend operator function
    cout << "s5 = " << s5 ;

    string s6 ( "Just for fun" ) ;
    cout << endl << "s6 = " << s6 ;

    string s7 = s4 + s6 ;
    cout << endl << "s7 = " << s7 ;

    s7 = s1 + '.' ;
    cout << endl << "s7 = " << s7 ;

    string s8 = "Opportunity knocks" ;
    string s9 = " only once" ;
    s8 += s9 ;
    cout << endl << "s8 = " << s8 ;

    s8 += '.' ;
    cout << endl << "s8 = " << s8 ;

    cout << endl << "Length of s8 = " << s8.length() ;
    cout << endl << "Size of s8 = " << s8.sizeofstring() ;

    string s10 ( "Sameer" ) ;
    string s11 ( "Aditya" ) ;

    if ( s10 == s11 )
        cout << endl << "s10 is equal to s11" ;
    else
        cout << endl << "s10 is not equal to s11" ;
}

string::string()  // zero-argument constructor
{
    len = 0 ;
    size = chunk_size ;
    ptr = new char [ size ] ;
    ptr[0] = '\0' ;
}

string::string ( char *p )  // one-argument constructor
{
    len = strlen ( p ) ;
    size = chunk_size * ( len / chunk_size + 1 ) ;
    ptr = new char[ size ] ;
    strcpy ( ptr, p ) ;
}

// two-argument constructor
string::string ( char filler, unsigned int count )
{
    len = count ;
    size = chunk_size * ( len / chunk_size + 1 ) ;
    ptr = new char[ len ] ;
    ptr[0] = '\0' ;
    memset ( ptr, filler, count ) ;
}

string::string ( const string& x )   // copy constructor
{
    len = x.len ;
    size = x.size ;
    ptr = new char[ size ] ;
    strcpy ( ptr, x.ptr ) ;
}

// destructor
string::~string()
{
    delete ptr;
}

// overloaded assignment operator
string& string::operator = ( const string& x )
{
    if ( this != &x )
    {
        len = x.len ;
        size = x.size ;
        delete ptr ;
        ptr = new char[ size ] ;
        strcpy ( ptr, x.ptr ) ;
    }
    return ( *this ) ;
}

// conversion function
string::operator const char * ( )
{
    return ptr;
}

// overloaded string addition operator
string operator + ( const string& x, const string& y )
{
    unsigned int totalsize ;
//    unsigned int totallen ;

    char *t ;
    totalsize = x.size + y.size ;
    t = new char [ totalsize ] ;
    strcpy ( t, x.ptr) ;
    strcat ( t, y.ptr ) ;
    string temp ( t ) ;
    delete t ;
    return temp ;
}

// overloaded string addition operator +=
void string::operator += ( const string& x )
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

// overloaded string addition operator
string operator + ( const string& x, char ch )
{
    unsigned int totallen ;
    char *t ;

    totallen = x.len + 2 ;
    t = new char [ totallen ] ;
    strcpy ( t, x.ptr) ;
    t[x.len] = ch ;
    t[x.len + 1] = '\0' ;
    string temp ( t ) ;
    delete t ;
    return temp ;
}

// overloaded string addition operator +=
void string::operator += ( char ch )
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

// overloaded string comparison operator
int string::operator == ( const string& x ) const
{
    int a ;
    a = strcmp ( ptr, x.ptr ) ;
    return ( !a ) ;
}

// friend function to output objects of string class
ostream& operator << ( ostream &strm, string &x )
{
    strm << x.ptr ;
    return strm ;
}

// friend function to input objects of string class
istream& operator >> ( istream &strm, string &x )
{
    char *buffer ;
    buffer = new char[256] ;

    if ( strm.get( buffer, 255 ) )
        x = string ( buffer ) ;

    return strm ;
}

unsigned int string::length() const
{
    return len ;
}

unsigned int string::sizeofstring() const
{
    return size ;
}

void string::toupper()
{
    strupr ( ptr ) ;
}

void string::tolower()
{
    strlwr ( ptr ) ;
}

char string::operator [] ( int pos )
{
    if ( pos >= len )
        return '\0' ;
    else
        return ptr[pos] ;
}

/////////////////////////////////////////////

 

