#include <string>
#include <iostream>

using namespace std;

void string_permutation( std::string& orig, std::string& perm )
{
	if( orig.empty() )
	{
		std::cout<<perm<<std::endl;
		return;
	}

	for(int i=0;i<orig.size();++i)
	{
		std::string orig2 = orig;

		orig2.erase(i,1);

		std::string perm2 = perm;

		perm2 += orig.at(i);

		string_permutation(orig2,perm2);
	}
}

int main()
{
  //std::string orig="ABCDE";
std::string orig="ABC";
	std::string perm;

	string_permutation(orig,perm);

	cout<<"Complete!"<<endl;

	//	system("pause");

	return 0;
}


