#include <iostream>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <map>

using namespace std;





    struct strCmp {
      bool operator()( const char* s1, const char* s2 ) const {
        return strcmp( s1, s2 ) < 0;
      }
    };

int main()
{ 
    map<const char*, int, strCmp> ages;
    ages["Homer"] = 38;
    ages["Marge"] = 37;
    ages["Lisa"] = 8;
    ages["Maggie"] = 1;
    ages["Bart"] = 11;
 
    cout << "Bart is " << ages["Bart"] << " years old" << endl;
 
    cout << "In alphabetical order: " << endl;
    for( map<const char*, int, strCmp>::iterator iter = ages.begin(); iter != ages.end(); ++iter ) {
      cout << (*iter).first << " is " << (*iter).second << " years old" << endl;
    }

}
