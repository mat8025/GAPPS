///
///
///
//filterDebug(1,"declare_type","find_siv","var_ptr","var_index","checkConstantExp");
filterDebug(1,"declare_type","find_siv","~var_ptr","~checkConstantExp");
setDebug(1,"~trace","keep")

Class Cevent
{

 public:
  int  id;
  int button;
  int row;
  int col;
};





int a = 47;

Cevent C;

C->row = 2;

C->col = 3;


I = vgen(INT_,20,0,1)
<<"$I\n"

I->redimn(4,5);


a= C->row;

b = C->col;


c= I[a][b];



<<"%V $C->row $C->col $a $b $c\n"

/{
ans=iread()

d= I[(C->row)][(C->col)];
//d= I[C->row][C->col];

<<"%V $C->col  $d\n"
/}