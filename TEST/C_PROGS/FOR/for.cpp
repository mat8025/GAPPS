#include <iostream>

using namespace std;


main()
{
  int in;
  float ave = 0.0;
  int pin =0;
  for ( int nin = 0; nin < 5; nin++) {
    std::cout << "enter number ";
    std::cin >> in;
    cout << in << endl; 
  ave += in; 
  pin++;
  cout << pin << " : " << in  << " ave " << (ave/ pin) << endl;
  }

  ave /= pin;

  cout <<"ave "<< ave << endl; 




}
