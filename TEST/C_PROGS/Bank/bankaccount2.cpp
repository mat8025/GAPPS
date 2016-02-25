//////////////////////////////////////////////////////////////////////
//  this program uses an inheritance hierarchy of bank accounts.
//
//  this version has base and derived class constructors
//////////////////////////////////////////////////////////////////////


#include <iostream>
#include <iomanip>
#include <stdlib.h>
#include <string.h>

//////////////////////////////////////////////////////////////////////
//                        class BankAccount
//  this is the base class for all types of bank accounts
//////////////////////////////////////////////////////////////////////

using namespace std;

class BankAccount
{
public:
  BankAccount(int=0, const char* ="xx", float=0);
  void deposit(float amount)   { bal += amount; }
  int account_num() const      { return acctnum; }
  float balance() const        { return bal; }
  void print();
  int getAccount() { return acctnum ; };
  char * getName() { return name ; };
protected:
  int acctnum;
  float bal;
  char name[32];
};

//////////////////////////////////////////////////////////////////////
//  constructor for BankAccounts; both args can default to zero

BankAccount::BankAccount(int num, const char *nstr, float ibal)
{
  acctnum = num;
  bal = ibal;
  strcpy(name,nstr);
}

///////////////////////////////////////////////////////////////////////
//  print function for BankAccount

void BankAccount::print()
{
  cout << "Bank Account: " << acctnum << " " << getName() << endl;
  cout << "\tBalance: " << bal << endl;
}

//////////////////////////////////////////////////////////////////////
//                        class Checking
//  this class is derived from BankAccount; it represents checking accounts
//  it contains the following additional member functions
//		Checking()	constructor
//		cash_check()    cash check and debit balance
//		transfer()      transfer to another account number
//		print()	  	function to print data members
//  it contains the following additional data members
//		minimum		per check charge added if bal < minbal
//		charge		amount charged per check when bal < minbal
//////////////////////////////////////////////////////////////////////

class Checking : public BankAccount
{
public:
  Checking(int=0, const char* ="xx", float=0,float=1000,float=.25);
  int cash_check(float);
  int transfer(float amount, Checking& other );
  void print();
protected:
  float minimum;
  float charge;
};

//////////////////////////////////////////////////////////////////////
//  constructor for checking accounts -- all parms can default

Checking::Checking(int num, const char *nstr, float ibal, float min, float chg)
  : BankAccount(num, nstr, ibal)
{
  minimum = min;
  charge = chg;
}

//////////////////////////////////////////////////////////////////////
//  cash a check
//	return false if there is not enough money to cash the check
//	otherwise cash the check, deduct per check fee if below
//      the minimum balance

int Checking::cash_check(float amount)
{
  char pause;

//  check for insufficient funds, write message and exit false
  if (amount >= bal)
    {
      cout << endl << "Cannot cash check for $" << amount << " on account "
	   << acctnum << "; insufficient funds." << endl;
      cout << "Press enter to continue." << endl;
      cin.get(pause);
      return 0;
    }

//  cash check and deduct per check charge if necessary
  if (bal < minimum)
    bal -= amount + charge;
  else
    bal -= amount;
  return 1;
}
///////////////////////////////////////////////////////////////////////
int Checking::transfer(float amount, Checking& other )
{
  // transfer from checking to another persons checking account
  char pause;
  if (amount >= bal)
    {
      cout << endl << "Cannot transfer   $" << amount << " on account "
	   << acctnum << "; insufficient funds." << endl;
      cout << "Press enter to continue." << endl;
      cin.get(pause);
      return 0;
    }
  else {
    bal -= amount;
    other.deposit(amount);
   cout << endl << " Transferring " << amount << " to " << other.getAccount() << " aka " << other.getName() << endl ;
   cout << endl << getName() << "'s Balance is now " << bal  << endl << endl;
  }

}
///////////////////////////////////////////////////////////////////////
//  print function for Checking

void Checking::print()
{
  cout << "Checking Account: " << acctnum  << " " << getName() << endl;
  cout << "\tBalance: " << bal << endl;
  cout << "\tMinimum: " << minimum << endl;
  cout << "\tCharge: " << charge << endl << endl;
}

//////////////////////////////////////////////////////////////////////
//                        class InterestChecking
//  this class is derived from Checking; it represents interest
//  bearing checking accounts
//  it contains the following additional member functions
//		InterestChecking()	constructor
//		interest()      	calculate and add interest if bal > minbal
//		print()		        function to print data members
//  it contains the following additional data members
//		intrate		annual interest rate earned when bal > minbal
//                              credited monthly
//              minint		minimum balance required to receive interest
//		moncharge	monthly fee (only charged if minimum balance 
//                              not met)
//////////////////////////////////////////////////////////////////////

class InterestChecking : public Checking
{
public:
  InterestChecking(int=0, const char* ="xx", float=0,float=1000,float=2500,float=.25,
		   float=2.5,float=10);
  void interest();
  void print();
protected:
  float intrate;
  float minint;
  float moncharge;
};

//////////////////////////////////////////////////////////////////////
//  constructor for interest checking accounts -- all parms can
//  default

InterestChecking::InterestChecking(int num, const char *nstr,float ibal, 
  float cmin, float imin,
		   float chg, float rate,float monchg) : Checking(num, nstr, ibal,cmin,chg)
{
  intrate = rate;
  minint = imin;
  moncharge = monchg;
}

//////////////////////////////////////////////////////////////////////
//  add interest to interest checking account -- interest is earned
//  only when balance is above the minimum; if not, the monthly fee is charged

void InterestChecking::interest()
{
  const int nummths = 12;
  const int cvtpct = 100;
  if (bal >= minimum)
    {
      float intamt = bal * intrate / (nummths * cvtpct);
      bal += intamt;
    }
  else
    bal -= moncharge;
}

///////////////////////////////////////////////////////////////////////
//  print function for InterestChecking

void InterestChecking::print()
{
  cout << "Interest Checking Account: " << acctnum << " " << getName() << endl;
  cout << "\tBalance: " << bal << endl;
  cout << "\tMinimum to Avoid Charges: " << minimum << endl;
  cout << "\tCharge per Check: " << charge << endl;
  cout << "\tMinimum for Interest and No Monthly Fee: " << minint << endl;
  cout << "\tInterest: " << intrate << "%" << endl;
  cout << "\tMonthly Fee: " << moncharge
       << "\n\n";
}

//////////////////////////////////////////////////////////////////////
//                        class Savings
//  this class is derived from BankAccount; it represents savings accounts
//  it contains the following additional member functions
//		Savings()	constructor
//		interest()      caculate and add interest
//		withdraw()	debit account for a withdrawal
//		print()		function to print data members
//  it contains the following additional data members
//		intrate		annual interest rate earned
//                              credited monthly
//////////////////////////////////////////////////////////////////////

class Savings : public BankAccount
{
public:
  Savings(int=0, const char* ="xx", float=0,float = 3.5);
  void interest();
  int withdraw(float);
  void print();
protected:
  float intrate;
};

//////////////////////////////////////////////////////////////////////
//  constructor for savings accounts -- all parms can default

Savings::Savings(int num, const char *nstr, float ibal, float rate) : BankAccount(num, nstr, ibal)
{
  intrate = rate;
}

//////////////////////////////////////////////////////////////////////
//  withdraw from a Savings account -- returns false if the withdrawal
//  was not done because of insufficient funds; otherwise return true

int Savings::withdraw(float amount)
{
  char pause;
  if (bal <= amount)
    {
      cout << endl << "Withdrawal of $" << amount << " from account "
	   << acctnum << " not permitted; insufficient funds." << endl;
      cout << endl << "Press Enter to continue." << endl;
      cin.get(pause);
      return 0;
    }
  bal -= amount;
  return 1;
}

//////////////////////////////////////////////////////////////////////
//  add interest to a savings account

void Savings::interest()
{
  const int nummths = 12;
  const int cvtpct = 100;
  float intamt = bal * intrate / (nummths * cvtpct);
  bal += intamt;
}

///////////////////////////////////////////////////////////////////////
//  print function for Savings

void Savings::print()
{
  cout << "Savings Account: " << acctnum << " " << getName() << endl;
  cout << "\tBalance: " << bal << endl;
  cout << "\tInterest: " << intrate << "%" << endl << endl;
}

//////////////////////////////////////////////////////////////////////
//
//  main program to test our classes




int main()
{

  BankAccount * accounts[4];
  BankAccount ** pba;  
//  define bank accounts
  Checking Ben(1001,"Ben",5000);
  InterestChecking Bill(1005,"Bill",2000);
  Savings Suzy(1022,"Suzy",1000);
  Checking Bob(1014,"Bob",600);

  // accounts[0] = &Ben;

   pba = &accounts[0];
  *pba++ = &Ben;
  *pba++ = &Bill;
  *pba++ = &Suzy;
  *pba++ = &Bob;

//  set up output for dollar amounts
  cout.setf(ios::fixed,ios::floatfield);
  cout.setf(ios::showpoint);
  cout << setprecision(2);

//  checking account transactions
  Ben.deposit(1500);
  Ben.cash_check(250);
  Ben.cash_check(195.99);
  Ben.cash_check(650);
  Ben.cash_check(1195);

  Bob.cash_check(125.50);
  Bob.deposit(1200);
  Bob.cash_check(369.99);

//  interest checking account transactions
  Bill.cash_check(365.55);
  Bill.deposit(965);

//  savings account transactions
  Suzy.withdraw(450);
  Suzy.deposit(300);
  Suzy.withdraw(400);

//  add interest where appropriate
  Bill.interest();
  Suzy.interest();

// transfer Ben to Bob
  Ben.transfer(1, Bob);

//  print accounts through the array
  cout << endl;

  pba = &accounts[0];
  for (int i = 0 ; i < 4 ; i++) {
    (*pba++)->print();
  }

}


