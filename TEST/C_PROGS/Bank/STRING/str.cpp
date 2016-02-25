#include <iostream>
#include <ostream>
#include <fstream>
#include <limits.h>
#include <string.h>
#include <iomanip>
#include <stdio.h>
#include <stdlib.h>

using namespace std;

const int chunk_size = 8 ;  // allocation unit for strings



void gs_tolower(char word[])

{
int i,n,k;
        n =strlen(word);
        k = 'A' - 'a';
        for ( i = 0 ; i < n ; i++) {
        if ( word[i] >= 'A' && word[i] <= 'Z' )
        word[i] = word[i] - k;
        }
}

void gs_toupper(char word[])
{
int i,n,k;
        n =strlen(word);
        k = 'A' - 'a';
        for ( i = 0 ; i < n ; i++) {
        if ( word[i] >= 'a' && word[i] <= 'z' )
        word[i] = word[i] + k;
        }
}


class Str
{
    private:
        char *ptr ;          // pointer to allocated space
        unsigned int len ;   // current length of string
        unsigned int size ;  // number of bytes allocated

    public :
        // constructors
        Str() ;                       // zero argument constructor
        Str ( char * ) ;              // one argument constructor
        Str ( char, unsigned int ) ;  // two argument constructor
        Str ( const Str& ) ;       // copy constructor

        ~Str() ;  // destructor

        // assignment operator function
        Str& operator = ( const Str& ) ;

        // conversion function
        operator const char * ( ) ;

        // concatenation methods
        friend Str operator + ( const Str&, const Str& ) ;
        void operator += ( const Str& ) ;
        friend Str operator + ( const Str&, char ) ;
        void operator += ( char ) ;

        // access operator
        char operator [] ( int ) ;

        // function to output the Str object
        friend ostream& operator << ( ostream&, Str& ) ;
        friend istream& operator >> ( istream&, Str& ) ;

        // comparison functions
        int operator == ( const Str& ) const ;
        int operator != ( const Str& ) const ;

        // value return functions
        unsigned int length() const ;
        unsigned int sizeofStr() const ;

        // case conversion functions
        void toLower() ;
        void toUpper() ;
} ;

int main()
{

    Str s1 ( "This is just a test" ) ;  // invokes one-argument constructor

    cout << endl << "s1 = " << s1 ;  // invokes << friend operator function

    cout << endl << "Length of s1 = " << s1.length() ;
    cout << endl << "Size of s1 = " << s1.sizeofStr() ;

    Str s2 ;  // invokes zero-argument constructor

    cout << endl << "Length of s2 = " << s2.length() ;
    cout << endl << "Size of s2 = " << s2.sizeofStr() ;

    s2 = s1 ;  // invokes overloaded assignment operator
    if ( s1 == s2 )  // invokes overloded == operator
        cout << endl << "s1 is same as s2" ;
    else
        cout << endl << "s1 is different than s2" ;

    s1.toUpper() ;
    cout << endl << "s1 = " << s1 ;

    s1.toLower() ;
    cout << endl << "s1 = " << s1 ;

    Str s3 = s1 ;  // invokes copy constructor
    cout << endl << "s3 = " << s3 ;

    Str s4 ( s1 ) ;  // invokes copy constructor
    cout << endl << "s4 = " << s4 << endl ;

    Str s5 ;
    cin >> s5 ;  // invokes >> friend operator function
    cout << "s5 = " << s5 ;

    Str s6 ( "Just for fun" ) ;
    cout << endl << "s6 = " << s6 ;

    Str s7 = s4 + s6 ;
    cout << endl << "s7 = " << s7 ;

    s7 = s1 + '.' ;
    cout << endl << "s7 = " << s7 ;

    Str s8 = "Opportunity knocks" ;
    Str s9 = " only once" ;
    s8 += s9 ;
    cout << endl << "s8 = " << s8 ;

    s8 += '.' ;
    cout << endl << "s8 = " << s8 ;

    cout << endl << "Length of s8 = " << s8.length() ;
    cout << endl << "Size of s8 = " << s8.sizeofStr() ;

    Str s10 ( "Sameer" ) ;
    Str s11 ( "Aditya" ) ;

    if ( s10 == s11 )
        cout << endl << "s10 is equal to s11" ;
    else
        cout << endl << "s10 is not equal to s11" ;
}

Str::Str()  // zero-argument constructor
{
    len = 0 ;
    size = chunk_size ;
    ptr = new char [ size ] ;
    ptr[0] = '\0' ;
}

Str::Str ( char *p )  // one-argument constructor
{
    len = strlen ( p ) ;
    size = chunk_size * ( len / chunk_size + 1 ) ;
    ptr = new char[ size ] ;
    strcpy ( ptr, p ) ;
}

// two-argument constructor
Str::Str ( char filler, unsigned int count )
{
    len = count ;
    size = chunk_size * ( len / chunk_size + 1 ) ;
    ptr = new char[ len ] ;
    ptr[0] = '\0' ;
    memset ( ptr, filler, count ) ;
}

Str::Str ( const Str& x )   // copy constructor
{
    len = x.len ;
    size = x.size ;
    ptr = new char[ size ] ;
    strcpy ( ptr, x.ptr ) ;
}

// destructor
Str::~Str()
{
    delete ptr;
}

// overloaded assignment operator
Str& Str::operator = ( const Str& x )
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
Str::operator const char * ( )
{
    return ptr;
}

// overloaded string addition operator
Str operator + ( const Str& x, const Str& y )
{
    unsigned int totalsize ;
//    unsigned int totallen ;

    char *t ;
    totalsize = x.size + y.size ;
    t = new char [ totalsize ] ;
    strcpy ( t, x.ptr) ;
    strcat ( t, y.ptr ) ;
    Str temp ( t ) ;
    delete t ;
    return temp ;
}

// overloaded Str addition operator +=
void Str::operator += ( const Str& x )
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

// overloaded Str addition operator
Str operator + ( const Str& x, char ch )
{
    unsigned int totallen ;
    char *t ;

    totallen = x.len + 2 ;
    t = new char [ totallen ] ;
    strcpy ( t, x.ptr) ;
    t[x.len] = ch ;
    t[x.len + 1] = '\0' ;
    Str temp ( t ) ;
    delete t ;
    return temp ;
}

// overloaded Str addition operator +=
void Str::operator += ( char ch )
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

// overloaded Str comparison operator
int Str::operator == ( const Str& x ) const
{
    int a ;
    a = strcmp ( ptr, x.ptr ) ;
    return ( !a ) ;
}

// friend function to output objects of Str class
ostream& operator << ( ostream &strm, Str &x )
{
    strm << x.ptr ;
    return strm ;
}

// friend function to input objects of Str class
istream& operator >> ( istream &strm, Str &x )
{
    char *buffer ;
    buffer = new char[256] ;

    if ( strm.get( buffer, 255 ) )
        x = Str ( buffer ) ;

    return strm ;
}

unsigned int Str::length() const
{
    return len ;
}

unsigned int Str::sizeofStr() const
{
    return size ;
}

void Str::toUpper()
{
    gs_toupper ( ptr ) ;
}

void Str::toLower()
{
    gs_tolower ( ptr ) ;
}

char Str::operator [] ( int pos )
{
    if ( pos >= len )
        return '\0' ;
    else
        return ptr[pos] ;
}

/////////////////////////////////////////////

 

