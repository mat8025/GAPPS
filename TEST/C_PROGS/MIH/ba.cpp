 	
     	#include <iostream>
     	#include <string>
     	#include <map>
	 
     	using namespace std;
     	 
     	class BankAccountManager
     	{
    	    public:
    	
    	        void addAccount(string primaryOwner, int accountNumber, int startingBalance)
    	        {
    	            bankAccounts[accountNumber] = new BankAccount(primaryOwner, accountNumber, startingBalance);
    	        }
    	
    	        void addAccount(string primaryOwner, string secondaryOwner, int accountNumber, int startingBalance)
    	        {
        bankAccounts[accountNumber] = new JointBankAccount(primaryOwner, secondaryOwner, accountNumber, startingBalance);
    	        }
    	
    	        void removeAccount(int accountNumber)
    	        {
    	            std::map<int, BankAccount*>::iterator iter;
    	            iter = bankAccounts.find(accountNumber);
    	            if (iter != bankAccounts.end())
    	            {
    	                bankAccounts.erase(iter);
    	            }
    	        }
    	
    	        int getBalance(int accountNumber)
    	        {
    	            if (bankAccounts.find(accountNumber) != bankAccounts.end())
    	            {
    	                BankAccount* thisBankAccount = bankAccounts[accountNumber];
    	                return thisBankAccount->getBalance();
    	            }
    	            else
    	            {
    	                return 0;
    	            }
    	        }
    	
    	        bool makeWithdrawl(int accountNumber, string accountOwner, int withdrawlAmount)
    	        {
    	            if (bankAccounts.find(accountNumber) != bankAccounts.end())
    	            {
    	                BankAccount* thisBankAccount = bankAccounts[accountNumber];
    	                return thisBankAccount->makeWithdrawl(accountOwner, withdrawlAmount);
    	            }
    	            else
    	            {
    	                return false;
    	            }
    	        }
    	
    	
    	
    	        void makeDeposit(int accountNumber, int depositAmount)
    	        {
    	            if (bankAccounts.find(accountNumber) != bankAccounts.end())
    	            {
    	                BankAccount* thisBankAccount = bankAccounts[accountNumber];
    	                thisBankAccount->makeDeposit(depositAmount);
    	            }
    	        }
    	
    	        static BankAccountManager& getBankAccountManager()
    	        {
    	          static BankAccountManager m_bankAccountManager;
                  return m_bankAccountManager;
    	        }
    	
    	    private:
    	        std::map<int, BankAccount*> bankAccounts;
    	
    	        BankAccountManager()
    	        {
    	        }
    	};
    	 
    	int main()
    	{
    	    BankAccountManager bankAccountManager = BankAccountManager::getBankAccountManager();
    	    int balance;
    	
    	    bankAccountManager.addAccount("Paul", 314159, 2500);
    	    bankAccountManager.addAccount("George", 1954, 3000);
    	    bankAccountManager.addAccount("Ringo", 56, 4500);
    	    bankAccountManager.addAccount("John", "Yoko", 42, 1500);
    	
    	    balance = bankAccountManager.getBalance(42);
    	    printf("Starting balance %d\n", balance);
    	    bool withdrawlSuccesful = bankAccountManager.makeWithdrawl(42, "Yoko", 501);
    	    balance = bankAccountManager.getBalance(42);
    	    printf("After Yoko 501 withdrawl balance %d\n", balance);
    	    withdrawlSuccesful = bankAccountManager.makeWithdrawl(42, "Yoko", 400);
    	    balance = bankAccountManager.getBalance(42);
   	    printf("After Yoko 400 withdrawl balance %d\n", balance);
   	    withdrawlSuccesful = bankAccountManager.makeWithdrawl(42, "John", 501);
   	    balance = bankAccountManager.getBalance(42);
   	    printf("After John 501 withdrawl balance %d\n", balance);
   	    bankAccountManager.makeDeposit(42, 100);
   	    balance = bankAccountManager.getBalance(42);
   	    printf("After 100 deposit balance %d\n", balance);
   	
   	    bankAccountManager.removeAccount(314159);
   	    bankAccountManager.removeAccount(1954);
   	    bankAccountManager.removeAccount(56);
   	    bankAccountManager.removeAccount(42);
   	 
   	}
