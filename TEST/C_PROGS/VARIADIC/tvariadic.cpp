


// C++ program to demonstrate working of
// Variadic function Template
#include <iostream>
using namespace std;
 
// To handle base case of below recursive
// Variadic function Template

void print()
{
    cout << "I am empty function and "
            "I am called at last.\n";
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
 



// Driver code
int main()
{
  float f = 66.79;
  print(1, 2, 3.14,f,
          "I will print my args\n");
 
    return 0;
}
