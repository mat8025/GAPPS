#include <iostream>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>


class Base
{
protected:
    int m_nValue;
 
public:
    Base(int nValue)
        : m_nValue(nValue)
    {
    }
 
    virtual const char* GetName() { return "Base"; }
    int GetValue() { return m_nValue; }
};
 
class Derived: public Base
{
public:
    Derived(int nValue)
        : Base(nValue)
    {
    }
 
    const char* GetName() { return "Derived"; }
    int GetValueDoubled() { return m_nValue * 2; }
};


int main()

{
    using namespace std;
    Derived cDerived(5);
 
    // These are both legal!
    Base &rBase = cDerived;
    Base *pBase = &cDerived;
 
    cout << "cDerived is a " << cDerived.GetName() << " and has value " << cDerived.GetValue() << endl;
    cout << "rBase is a " << rBase.GetName() << " and has value " << rBase.GetValue() << endl;
    cout << "pBase is a " << pBase->GetName() << " and has value " << pBase->GetValue() << endl;
 
    return 0;
}
