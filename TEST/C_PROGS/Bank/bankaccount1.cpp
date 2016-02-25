    #include <iostream>
    #include <string>
    #include <stdlib.h>
    #include <stdio.h>
    #include <string.h>

// #include <process>

using namespace std;

    class Details
    {

    public:

    char name[32];
    int age;
    int accno;
    char branch[50];
    char city[40];

    void getdetails()
    {

    cout<<endl<<endl<<"**********Customer Details*********** "<<endl;
    cout<<" -------- ------- "<<endl;
    cout<<"Enter Name: ";
    cin>>name;
    cout<<"Enter Age: ";
    cin>>age;
    cout<<"Enter Account Number: ";
    cin>>accno;
    cout<<"Enter Branch: ";
    cin>>branch;
    cout<<"Enter City: ";
    cin>>city;
    cout<<"______________________________________"<<endl<<endl;
    }

    Details() 
    {
	strcpy(name,"xxx");
        age = 20;

    }

    };


    class Bank
    {
    public:
    static int accnumber;

    long balance;
    Details d;
    void getdata();
    Bank transfermoney(Bank);
    void deposit();
    void withdrawal();
    void newaccount();
    void viewaccdetails();
      Bank() {
        
      }
    };




    Bank Bank::transfermoney(Bank a)
    {
    long amt;
    cout<<"Enter amount to be transferred: ";
    cin>>amt;
    a.balance=a.balance+amt;
    if(balance<amt)
    {
    cout<<"\nInsufficient balance! Operation Cannot be performed!"<<endl<<endl;
    }
    else
    {
    balance=balance-amt;
    }
    return a;
    }

    void Bank::withdrawal()
    {
    int amtdrawn;
    cout<<"Enter amount to be withdrawn: ";
    cin>>amtdrawn;
    if(balance<=amtdrawn)
    cout<<"\nInsufficient balance! Operation Cannot be performed!"<<endl<<endl;
    else
    balance=balance-amtdrawn;
    }

    void Bank::deposit()
    {
    int dep;
    cout<<"Enter amount to be deposited: ";
    cin>>dep;
    balance+=dep;
    }

    void Bank::newaccount()

    {
    accnumber++;
    d.getdetails();
    balance=0;
    }

    void Bank::viewaccdetails()
    {
    cout<<endl<<endl<<"*********ASSIGNMENT BANK ACCOUNT DETAILS*********"<<endl;
    cout<<" --- ---- ------- ------- "<<endl;
    cout<<"Account no.: "<<accnumber<<endl;
    cout<<"Name: "<<d.name<<endl;
    cout<<"Branch: "<<d.branch<<endl;
    cout<<"City: "<<d.city<<endl;
    cout<<"Current Balance: "<<balance<<endl;
    cout<<"_________________________________________"<<endl;
    }

//-----------------------------------------------------------------


    int Bank::accnumber=0;

    int main()
    {
    char ch;
    static int i=0;
    Bank *a[10];
    int x,amt,k,j;

    do
    {
    cout<<endl<<endl<<"************MENU************"<<endl;
    cout<<" ---- "<<endl;
    cout<<"1.Create new account\n2.Deposit\n3.Withdraw\n4.Transfer credits\n5.View account details\n\n";
    cout<<"Enter choice no.: ";
    cin>>x;

    switch(x)
    {
    case 1:
    {
    i++;
    a[i]=new Bank;
    a[i]->newaccount();
    break;
    }

    case 2:
    {
    cout<<"Enter account no.: ";
    cin>>k;
    a[k]->deposit();
    break;
    }
    case 3:
    {
    cout<<"Enter account no.: ";
    cin>>k;
    a[k]->withdrawal();
    break;
    }
    case 4:
    {
    cout<<"Enter the source and destination account nos.: ";
    cin>>k>>j;
    *a[j]=a[k]->transfermoney(*a[j]);
    break;
    }

    case 5:
    {
    cout<<"Enter account no.: ";
    cin>>k;
    a[k]->viewaccdetails();
    break;
    }
    }

    cout<<"\nDo you wish to continue[Press 'Y' to continue or 'N' to exit menu]: ";
    cin>>ch;
    }
    while(ch=='y'||ch=='Y');

    }

//////////////////////////////
